Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF86EC77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 16:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjEJQnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjEJQnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 12:43:01 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C321737
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:43:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so6608579a91.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683736980; x=1686328980;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQJpmBd4gUzueanH2IkFSyJ3zK6SOOHpqj1ugppvysM=;
        b=i881uF700JNKjxqO8dCvFJBk1fojnDtkpwIHtz7gh29z0HOdj1FdwBbHDjc1UmOj7S
         +O2a3SOiy7kbG1cJSRJUSa+ONDufW7YpXGy+r37S1jwOUaM6ZtdKbikTRDGZDF+320dC
         1Z3RTkUZtRuBJayqfwFNge4DAJCOXSKrafMjVO6vhhdQ5CUWIUrLbHZspCydxr+rEGX3
         owhQvRvYYSiVb+jSMvAAelCfTFRKEWqLrqYr72+luLJAQeABNaFbdW23u4VWLUc0sELw
         bntcxLdcUAJ4X4kg2qp8u3nW9vrBiPz90GT5lKB4nv3LqlC0q/emL9LQsHbPIXMOCuog
         pSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736980; x=1686328980;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kQJpmBd4gUzueanH2IkFSyJ3zK6SOOHpqj1ugppvysM=;
        b=MXXIda+5Rvl333PLLbv8BC9TWdxXWGQpZIlYb0tgBuQ00Yweo3c/PtgdSFWGuCOYTv
         odnNZ5e/5V1IiMojyPCPGUs7i8W7I5qr4SQ47Vkr6HQMrgFyvD5Wqab3Yo6wGxNWaPQc
         EJTasvRihaD+UrPjwD1XInWN5tXMRhBSs2t8FNOmDUNgyVfxGDx7/LnZeHH4TUkJjk5Y
         /v57N7+rtfkqw6JiT9loM/OsIurW6os7ZGqTwB2JkKgXjAJrgQ2mulpG4B6KeLMu3JSZ
         4au/TpvIrKekhmv+PlALVLsRsxFWnRlFtxQLk/hNt6W1EWVOCPgQXUyMmqKXqh95tFxh
         cdsQ==
X-Gm-Message-State: AC+VfDyAs7AFbzWrETmLGkS1b9+knbQbxJWt2B5fE8Svd0OAraCruUKd
        KjsCnI0knL+DPFBm28JiSIA=
X-Google-Smtp-Source: ACHHUZ4PtJ4YplYVFWZ+i+6HNLiyO+5paLDNfidGT3YSfaXspbl57a0XBxogxHX0/DkIP4hDvLHNfg==
X-Received: by 2002:a17:90b:28b:b0:246:9ef5:3c45 with SMTP id az11-20020a17090b028b00b002469ef53c45mr18796520pjb.13.1683736980001;
        Wed, 10 May 2023 09:43:00 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a318800b00246f9725ffcsm108682pjb.33.2023.05.10.09.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:42:59 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/11] doc: trailer.<token>.command: refer to existing
 example
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <5980432179352054955e602cf97b57e97694a28c.1683566870.git.gitgitgadget@gmail.com>
        <xmqqwn1imwqk.fsf@gitster.g> <owlyh6skmznt.fsf@fine.c.googlers.com>
Date:   Wed, 10 May 2023 09:42:59 -0700
In-Reply-To: <owlyh6skmznt.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Wed, 10 May 2023 00:08:38 -0700")
Message-ID: <xmqqfs845e98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>> At some point we may drop the
>> example, and adding a reference to the example would mean somebody
>> needs to remember removing this when it happens.
>
> Wouldn't we also delete the entire `trailer.<token>.command::` section
> (and therefore the reference to the example) also at the same time?

We could go that way.

It is likely that we'd remove text that helps for those who newly
use the deprecated construct while keeping what helps for those who
have to read and understand the construct that was written in random
scripts they find on the Internet.  So removing the example can come
before the section itself, though.

In a far enough future, we would be without the example and the
section so it would not be too big a deal, either way.

Thanks.
