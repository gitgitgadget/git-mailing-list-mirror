Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F41C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7D360F44
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhG0Rqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhG0Rqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:46:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A8C061764
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:46:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x7-20020a0569021027b029055b9b68cd3eso19465890ybt.8
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uTMQ9539KA+w6BB4hMDxdqhXXo38+qEBlN/+vaFKxso=;
        b=sBqgcnkww6/K3gyU/C5XN9MsArm6nvgsQD0Xlf0kLawcXGE8dTyZT2pQD2Gh6OajJi
         6mtOP3iTyxkkQlyVdQ83JWssuTRVQtHpAzZCR4SG3czwDvDYYj6IijzpOxxkgcO2xM8Q
         5/gxG30wIe+Z1JKxrl7+xlMIivm/zrWwzgoQpyyjKtNEzBLRrB1UHsoGVOtlfYfvHzkt
         2sEn90pIoFNDUIU08LSrWA31e6Wo6/9HRqSBHDzjCyPmmfLPh6f8Va9avmvNIKZeVDxv
         wzuWfDdp6qAJCqZo40H1RKzgEZYXYEo4Qzzc2rU1i9CGY31livomhyYlWJyzy8FGoXNB
         5VZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uTMQ9539KA+w6BB4hMDxdqhXXo38+qEBlN/+vaFKxso=;
        b=fE2F6woqr2prCDBVWYWZGt9yyK0+SpZTIvTZfory104moEoq32v/LhsTErD9FtiQGs
         0VkqU7cHn7huDYpJYlS5zs+FK1BILbYJlJMLGMZr2qYNaWObWy4afbifSIGpL3P6QrYR
         f/0kmsHUOK43y71+AhFyaNWFWAkHIXgPLWe38AuO+fRpVDhiY2+QT3KsOJjzgq+Q4a47
         U67hvB/tXEFScani/Lpg3hxrxnUji3DJ08/nnrOW9k9zPcue3E02PJ8cRdf0y/HvJNfO
         Qs6V2cATu6mhklvwldStQuIjD0RPDXSBOWVNC8DAElmwjr4jUy9YOXTdHjIwTg3DIYUx
         uQYA==
X-Gm-Message-State: AOAM531bLNTqa/0pRNG3pGiq2f3F8H2e7dWkm+CWeG+xyE4YpFKwcQ3Y
        y9xM9Zs6Vi3TNuCiSDAVWHXqDWE4vB5hupsryfks
X-Google-Smtp-Source: ABdhPJw8J/N4h/0wIquUw5CJdZAgduhrFFU7bHAtXmj0ysPtt1bB7qqsq0Q3/JvWzMb/J0+x3kPEXsdF4o+UM7ipLjzS
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:b706:: with SMTP id
 t6mr34533039ybj.174.1627408013075; Tue, 27 Jul 2021 10:46:53 -0700 (PDT)
Date:   Tue, 27 Jul 2021 10:46:50 -0700
In-Reply-To: <20210616004508.87186-3-emilyshaffer@google.com>
Message-Id: <20210727174650.2462099-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210616004508.87186-3-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: Re: [PATCH v2 2/4] introduce submodule.superprojectGitDir cache
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach submodules a reference to their superproject's gitdir. This allows
> us to A) know that we're running from a submodule, and B) have a
> shortcut to the superproject's vitals, for example, configs.

The first sentence is probably better "Introduce a new config variable
storing a submodule's reference to its superproject's gitdir, and teach
'git submodule add' to write it".

Also, I think there should be more detail about the planned use both
here in the commit message and in the config documentation. Is the plan
just to use it for best-effort explanatory messages? (Using it as a true
cache is probably too performance-intensive, I would think, since in its
absence, we have no idea whether the repo is a submodule and would
always have to search to the root of the filesystem.) If it is just for
best-effort explanatory messages, maybe write:

  If present, commands like "git status" in this submodule may print
  additional information about this submodule's status with respect to
  its superproject.

This would further reinforce that this variable being missing is OK.

> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index d7a63c8c12..7c459cc19e 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -90,3 +90,15 @@ submodule.alternateErrorStrategy::
>  	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
>  	or `info`, and if there is an error with the computed alternate, the
>  	clone proceeds as if no alternate was specified.
> +
> +submodule.superprojectGitDir::
> +	The relative path from the submodule's worktree  to the superproject's
> +	gitdir. This config should only be present in projects which are
> +	submodules, but is not guaranteed to be present in every submodule. It
> +	is set automatically during submodule creation.
> ++
> +	In situations where more than one superproject references the same
> +	submodule worktree, the value of this config and the behavior of
> +	operations which use it are undefined. To reference a single project
> +	from multiple superprojects, it is better to create a worktree of the
> +	submodule for each superproject.

So my suggestion would be:

  The relative path from this repository's worktree to its
  superproject's gitdir. When Git is run in a repository, it usually
  makes no difference whether this repository is standalone or a
  submodule, but if this configuration variable is present, commands
  like "git status" in this submodule may print additional information
  about this submodule's status with respect to its superproject.

(I believe Junio has commented on the second paragraph - I don't have
additional comments on that.)
