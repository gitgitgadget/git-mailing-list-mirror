Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D112C55179
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 16:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB3F2087D
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 16:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="THLDONJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502915AbgJUQMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502868AbgJUQMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 12:12:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8328C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 09:12:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m65so2490507qte.11
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZl7lSLqVxcua3uV2lMBzchpUKoLg4tlSqJYh1bd6M0=;
        b=THLDONJ9b83Igl2JXX0X2OAcj1LTc/6HbobR7nPoK+K4nvjMUWFwk3QLP3WQA5ddbS
         vMTf05y0Uo/DEl4Mn43NNVkDO+zp7zB+2fHmoChTNcPHffJ4ofy4fIzz7RjpSDHh8Yku
         81jqVQan+V+wlEEnRg1cY/CjxxDHH+KXbTxpma2q7o1znX8MmApSX9YKt1HlSz9V5EDK
         t2V4b86iuZZSqOOqrH9O077okONgtXfPdfksVh+9tNmSpyVHHS9SwB+HNfSqg2cg0KwM
         LycUzrmHFxkn90kFroNEJMWnqn/rykFsXEmP+8kIIKVSi0ave/seNg1AIIbxI8UwXZSr
         EYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZl7lSLqVxcua3uV2lMBzchpUKoLg4tlSqJYh1bd6M0=;
        b=aUGcHMQfkdjoES7XZq1KdvNCTiMd0D1e4625gdbw3fj2SjBkJ4aSkvmkhhHlxyE72j
         8J6f0SJm9CCtFrvqu6KShjnPRcI4QHJ+b6mtiGFOVrAyXHDdE+0gKFwerByhqzRd14Qm
         TD/Opc+AEj/B04EHtyQHazHcY0GR4fo+UwANvGPh/kgJJkRe1GJ/5hC1ugBoKoIf1OMH
         70ogRimCUaBju9KsnvmTtRMSDHN7NGdq4qp1vcLL0nDciQFZz0ZhatAQVwSLtXqfCUji
         Va99wcSJUheRIDJaHER0E2eC3rfmZ7/EQvHmnDRQ1bDhrbPK1n8zo7Hqg8opOLjH6BwC
         cLTw==
X-Gm-Message-State: AOAM530SKAjfI7tdjSxOOvTGpsYSPCCSnzAWGWOkMxEpFje8ueY8m0N4
        4sLMDy+eprsYZ79gbEEmSl/R7g==
X-Google-Smtp-Source: ABdhPJxRf7arTaaD9vC0l6p2YG1BAJSSa6NWCYbWqsQ1Fgzhc4aJT6lwbRED/XgFDvtMCHPNVn631Q==
X-Received: by 2002:ac8:774e:: with SMTP id g14mr3722366qtu.76.1603296766038;
        Wed, 21 Oct 2020 09:12:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:5440:c3ba:60f:b745])
        by smtp.gmail.com with ESMTPSA id j9sm1501178qtk.89.2020.10.21.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:12:45 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:12:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] sequencer: allow metadata to be saved if using cherry-pick
 --no-commit
Message-ID: <20201021161242.GA111581@nand.local>
References: <20201021062430.2029566-1-eantoranz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021062430.2029566-1-eantoranz@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edmundo,

On Wed, Oct 21, 2020 at 12:24:30AM -0600, Edmundo Carmona Antoranz wrote:
> Currently, if 'git cherry-pick --no-commit' is run _and the cherry-pick
> operation is successful_, the metadata from the original revision is lost and
> to git it's like a cherry-pick operation is not taking place at all. Hence,
> we can't wrap up the cherry-pick operation by calling
> 'git cherry-pick --continue'.

Interesting.

> diff --git a/sequencer.c b/sequencer.c
> index 00acb12496..c1ccbe0faf 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2022,9 +2022,8 @@ static int do_pick_commit(struct repository *r,
>  	 * However, if the merge did not even start, then we don't want to
>  	 * write it at all.
>  	 */
> -	if ((command == TODO_PICK || command == TODO_REWORD ||
> -	     command == TODO_EDIT) && !opts->no_commit &&
> -	    (res == 0 || res == 1) &&
> +	if ((command == TODO_PICK || command == TODO_REWORD || command == TODO_EDIT)
> +		&& ((res == 0 && opts->no_commit) || (res == 1 && !opts->no_commit)) &&
>  	    update_ref(NULL, "CHERRY_PICK_HEAD", &commit->object.oid, NULL,
>  		       REF_NO_DEREF, UPDATE_REFS_MSG_ON_ERR))
>  		res = -1;
> --
> 2.28.0

Hmm. I'm a little confused after reading your patch below. Why does (res
== 0) change to (res == 0 && opts->no_commit)? Wouldn't we still want to
update our CHERRY_PICK_HEAD even if "res == 0 && !opts->no_commit"?

Even still, this patch as it is seems to fail a number of tests. You can
run the tests yourself by running "make && make test", and there is more
information about that in t/README.

Thanks,
Taylor
