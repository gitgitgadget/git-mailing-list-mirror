Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF4CC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 23:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKUXJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 18:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiKUXJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 18:09:10 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39095CB9D0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:09:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so6322842pjc.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Wsanm19ntPXnDp23whfGqmDtAgjUXom0igKxjeBsN8=;
        b=RKmj2sGxBKxDQ4VIcsmtEvBRW+mLjC+fEUZsVKeP98yKnSr1VdfxsAkcNhLDejV45M
         0sUz8gVYXo2uOsDZU/Q5NFzooxpJ+MtQSMgrpFMCD9jn7brIZklyxEj/Y0spTZEUKmLU
         1tX5c9L2t1R03zP6pN7f0ruLo/EyyJz35wGpyNqxzgNb8w98hN8Gd2QAHLnb2kB5OXMF
         bgnzcLD2pqzzISe4L2p18H1V3l+nYfkgfwhEK3EpRcCA+6rUiqk4yNI+jg+ukcg3dIRx
         anJSqktjvbMWbY2yuJCwVoatwi3YhBuvRWRhw9R5ERnno7maXH/IGrav00Kn7efBL82j
         E8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Wsanm19ntPXnDp23whfGqmDtAgjUXom0igKxjeBsN8=;
        b=E1KH5Ed5bOgcbZHPBZU+j7OyKGavmhNtCbNxVANHuB+/HxOoheX7mKpWljZwNOJJKQ
         LvCnO8rEbqZEaZNG+QQitoIxDC0ccikYzBj7Uzgi67iWntToaE0X14FpWjeRhgKvJXG0
         raZ0S7z57FwNb8wUlzWNj3jb6hsPI0vzOp4kdnEfEx70JTRC8m82dQe6DrMosVZRgnZf
         eGLbcYBuf4TmckslffYuNQq9WdYJQUX4PofCd0G2Jo0zomhE6iXG8Qt9vGWBBXAUxqMY
         WeL6/jja64BvUJzsFMa8M8beRwbaR/r9suClw3kRr8bImHzewXWo48Rh6qj4E6sjVupX
         AYRw==
X-Gm-Message-State: ANoB5pm99a1pUV98kCbseD3GarrDzA3PlvFIwQs/gkBVzMCQwbzivVFe
        q7Uw+R50RsT5yDx+w46bcMF8XExwMLfpQA==
X-Google-Smtp-Source: AA0mqf5+0KhNB+J9MFsj9daeatA7+VIbGlc0JpJI28RzBkmsx6J59m7MN2p75nMO38jB1o5JRT1vdA==
X-Received: by 2002:a17:90a:7344:b0:218:a049:cc0f with SMTP id j4-20020a17090a734400b00218a049cc0fmr11062611pjs.176.1669072149606;
        Mon, 21 Nov 2022 15:09:09 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00183c67844aesm10275586plm.22.2022.11.21.15.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:09:09 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: quiet ENOENT on missing directories
References: <20221119201213.2398081-1-e@80x24.org>
        <xmqq5yf8yhe0.fsf@gitster.g> <20221121104427.M268307@dcvr>
        <xmqqpmdgv4it.fsf@gitster.g>
Date:   Tue, 22 Nov 2022 08:09:08 +0900
In-Reply-To: <xmqqpmdgv4it.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        21 Nov 2022 22:08:42 +0900")
Message-ID: <xmqqleo3vraj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
>> -	remove_temporary_files(get_object_directory());
>>  	s = mkpathdup("%s/pack", get_object_directory());
>>  	remove_temporary_files(s);
>>  	free(s);
>
> I actually was hinting at making the remove_temporary_files()
> recurse, so that you do not need the separate invocation in pack/
> subdirectory.
>
> Or make 256 calls for each of the fan-out subdirectory, in which
> case the ENOENT silencing you did would really matter and shine.

But of course, neither is any part of this topic.  They are possible
follow-on works.

Thanks and sorry for making a confusing statement that could be
mistaken as "let's do this too", which wasn't what I meant.
