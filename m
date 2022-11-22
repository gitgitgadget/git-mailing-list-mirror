Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0486FC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 04:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKVEW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 23:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiKVEWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 23:22:54 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E2CBC9E
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:22:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id y14-20020a17090a2b4e00b002189a1b84d4so6856934pjc.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuUDsh+ul5R/r9Y9ZFH3GUENmg1TschENQCMtsvZjiE=;
        b=ozERMgrZBTbYwetit3aeYlyrOT3GRp589dZNfoveWt/FDckB8Ppadb7upvITe7lvNV
         jWn33gnVEgjmQ1+ibQ6viYV0vovUlTS8PQTBpowS81Q2g2rQC6q0khbHd+236HkWl4Xg
         QElIKhSzdUuPAhCwdG9asAlH1FfLEgbs2e8tsfuTXql0vn1/HTqB+8UJQ5sBvJgGEWTW
         J5Fr0MG+h7jBrB5IIDwvs4ScNdVpmpBwK29zlnP5yf/9e3d97RGLKSOTzn+LJvY7lHk8
         QFgWz2sE6zPtlCRP0oot/46BeXqAADEWnlDvLa4vRR28hMyHlRiYpvp5VadD5pn/Ulu8
         moAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OuUDsh+ul5R/r9Y9ZFH3GUENmg1TschENQCMtsvZjiE=;
        b=5ajd/EVcmPtRJNPdq2b56o4HX0Coj0CUFQQV3ZabkZ6jtBhXiM+MLhf/chTikAnmrA
         nt0BaWcA+9/I0SERLhn7CC3LAHfTlU65cIJgRYdY58R86BLRPcs/hZ0bjpKotZMGKTi2
         oRS+k232R6znyNEETGtQF/3WV7mb4BsaKVp2aBOye654/Y7rk+Y3iYseisfNCbZFDCyb
         CsXShJNUfRD7PdgQ+DigtHdmu8Go+z+8hkP11wMTWclzhWibJyZ3URGFDBHob6jTgEIW
         xeEW/xPKOzFfq3G7RLARVngqelPDY92odaCBjX6b5Xv5KYjDOf3s0iCCbq70nXoRMEz0
         Zd4g==
X-Gm-Message-State: ANoB5pkyOklJzIDDbNFG6/CjIuxoi9ENbp260ZJLeuqlofXEstYaoRhS
        htFdK8xCl6eQmhg/oqKHx6Im5sriR6H+Pg==
X-Google-Smtp-Source: AA0mqf7B3ATrKyYAMBxs6vGZPK8Hq5qq18o++KtncocXQl+/TmGAENfnTj17YJokyKHc13VaXCjEYg==
X-Received: by 2002:a17:902:8698:b0:188:e255:39af with SMTP id g24-20020a170902869800b00188e25539afmr2249460plo.86.1669090971241;
        Mon, 21 Nov 2022 20:22:51 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b0016d4f05eb95sm10674712plh.272.2022.11.21.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 20:22:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin: submodule--helper: Add allocation check of
 module_cb structure objects may be helpful in case of allocation failure
References: <20221122031739.3440-1-kunyu@nfschina.com>
Date:   Tue, 22 Nov 2022 13:22:49 +0900
In-Reply-To: <20221122031739.3440-1-kunyu@nfschina.com> (Li kunyu's message of
        "Tue, 22 Nov 2022 11:17:39 +0800")
Message-ID: <xmqqh6yrsjmu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Li kunyu <kunyu@nfschina.com> writes:

> The purpose of using temp is unknown, but adding an allocation failure
> report should be helpful.

Yuck.  Use of xmalloc() may be more appropriate.

Use of BUG() in a context like this is never the right thing to do.
BUG() is reserved for cases where the condition should NEVER hold
true in a correctly written program, and even for a correctly
written program, malloc() can fail after you allocated too much
memory from the heap.

>
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  builtin/submodule--helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b63f420ece..2e379623ea 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1077,6 +1077,9 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
>  		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
>  			continue;
>  		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
> +		if (!temp)
> +			 BUG("The module_cb structure object fails to be allocated and the program may terminate abnormally");
> +
>  		temp->mod_src = p->one->mode;
>  		temp->mod_dst = p->two->mode;
>  		temp->oid_src = p->one->oid;
