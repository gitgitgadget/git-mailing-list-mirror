Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4209C77B7F
	for <git@archiver.kernel.org>; Fri,  5 May 2023 17:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjEERZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 13:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjEERZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 13:25:17 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466011A1E4
        for <git@vger.kernel.org>; Fri,  5 May 2023 10:25:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-250175762b8so1551707a91.1
        for <git@vger.kernel.org>; Fri, 05 May 2023 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683307511; x=1685899511;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5pQjMp9IoOIO88Ir5A9UejjSOJ0PQJYVddcqZw9yxjc=;
        b=gLz2gB1qpyazI3ApTbk5YUya106a4njoSjhEhbcEfn0wh53qMF/IKJcowwivDVAvA4
         V/WtYEgnqN+PEpT3Q8aO9vy5WM+ww6xvAJjxKQX9G5W/2NMc8G591Jr0jQfhJerNzGxY
         aDX4H6oHSVjVE1t4ZhtEnD91LZfmltEITtrBVt2F3q8b9ZnDBzoMXLHAqvWw5VUbdnxq
         helBtWjJ241o4YyKfnVbbWQ68nWKrZVqTn9aHRww/NFGFQoEpfPXUF7Eu6wATczgKFc/
         aKPAqOqs5OEeNdpeh8uVg/nC/f3EKNEOa49LXblbtCxN3npm99StmSowxZ/TRB9sKjMS
         nZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307511; x=1685899511;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5pQjMp9IoOIO88Ir5A9UejjSOJ0PQJYVddcqZw9yxjc=;
        b=KaweF0xNMusDkIGNr2Mp1/iERUQb2jOkE4Vi0YQkKo/fqUJqtDvGCZN4ivyP/E+d45
         6+rQ9dAdctN/EdkHTsSgoswMPF8QZDO7izjRmpbxGZVQfk1qys3Dc+y95GUz2ngccvgT
         hIuf+x9JL5gm33dTRJKHLmtQFeCdI94JCHiYJ+r87KVOBRp9Tmnkz/qsUAfhRFhYjWsi
         d1iUkqdK3jGKrit0HbqIduDP7HKc+5MnC4gPBlfsLwEaNdsOTFDIt8kMuYdSZd6BQ7Nd
         mh0pYE1VSdcbo4pBrvTiuFodpVaduZOxyzl8/LGE2/2SsctFNAmfV5Uxqh8/79G7aIHF
         gYdg==
X-Gm-Message-State: AC+VfDxL3/mYVdtk/lJgfxpBhDp+zkylcV0OwibviK4ZGApYe/4N8n6S
        5QiVRQqd940d4Qyx36xpLec=
X-Google-Smtp-Source: ACHHUZ7pCrNqHspUrjG8YTFhXFpFUIp/pQOa1qbzDNAZadIpohOgq8ZSGPohe7E+CcyzWDcI4hP4mw==
X-Received: by 2002:a17:90b:3885:b0:24d:ded3:8b62 with SMTP id mu5-20020a17090b388500b0024dded38b62mr2269603pjb.27.1683307510601;
        Fri, 05 May 2023 10:25:10 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jx12-20020a17090b46cc00b0024e0141353dsm5325628pjb.28.2023.05.05.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:25:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <xmqqcz3netxr.fsf@gitster.g> <ZEwafQmat347la3/@ugly>
Date:   Fri, 05 May 2023 10:25:09 -0700
In-Reply-To: <ZEwafQmat347la3/@ugly> (Oswald Buddenhagen's message of "Fri, 28
        Apr 2023 21:11:57 +0200")
Message-ID: <xmqqa5yielmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>Doesn't t3501 seem a better home for them?
>>
> looking closer at it, i guess it kind of does. the file's contents
> have clearly grown to fulfill the filename's broad promise, but nobody
> bothered to adjust the test description and make the setup title more
> specific. any takers?

Just dropping "with renames" from the test description would be
fine, no?  Existing tests in the early part of the script cover
not just renames but unknown command line option, operating on a
dirty working tree, etc. that are not specific to any renames.

One more thing I forgot was that your test scripts were indented by
4 spaces; please use tabs for indent to match existing ones when you
add tests to an existing script.

Thanks.
