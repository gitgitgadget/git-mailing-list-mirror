Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA30C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F53A613EE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 02:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFCC54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFCC54 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 22:57:56 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD3C06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 19:55:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id fu20-20020a17090ad194b0290163ff5d5867so4526264pjb.2
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KsVgzOwCnjdVJrl/zPAoIomL3ntF+tEWYnPp0hi2gbQ=;
        b=DriMvneyBP3C2R4AX2Y3yUw0fnodEh6hq9push4mnXZLY8jWJJq9aOQw4dWsLH8SMy
         oEW+gySJIifKQeMgc8m9w3aY+7HoCPkTN5aMotCIaCrHUzZcdFJf6HPLZcdfZDFZnqC7
         O77d8r/9QcSH/e662PtdUzpK1O6xQFOobrSnebAekCr9rBI5qv6D3Qcuvul4GTzG7wpH
         sPiHzVHeMFoCcce2FDlw+frWT2yFyvVt40/ww0GFLUzAOHg1k5hggXq4M0jfoXGdEoba
         MTDn7ONSbNveC8irOu99bUGO/egEaTuMM1oKb7PLz0KlpDsANpUQE2SDtd96j74GFEJ9
         6vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KsVgzOwCnjdVJrl/zPAoIomL3ntF+tEWYnPp0hi2gbQ=;
        b=dyZAAfH4F+lX/8BxVJ9OlUbfQD6KGukWyVK6wKee4NJdh3/5zrbAQ+dcvjCQhzplqQ
         ZCzDZRjj2BCMC34xfUeIDn7jKqMc2sppaBPAdS26+0kf5IoAWcsn65WwMnzOQLXktAx1
         N5t1SkYqo2NSZPL5yxSKh6w+DhzOiT36hmEecgTUFlGdyOBrDJB3zDr2ijSmFWp+8gvo
         ImEnb5y0VIreNSSqi+noP+nXNp5QOR1w8OSE3X1mdtbwKGW2ppzGurkzccjHJ9r6CWbW
         5wYoB5scDeGATxRK8txaAfPl1wjLxxGuejh3O/+sVmdtMP9vO1ysJN3zB0TXffHMBWDI
         U55w==
X-Gm-Message-State: AOAM530P1tqcb/WDFcJh+vw+kv7fWOXr8ob/gSjC9CYhb4zUCpcNhHRz
        jIXS7TXCggpTs+gGuvwJlKRMXv89+K0GGKl9rnYu
X-Google-Smtp-Source: ABdhPJyuFhl7FY8D2U9mvfylchvnAyystDlG9CrX1FuxbObbN5OgVF+yQgRkA6lBwouakJyRAS7xG/38JXqvfTtCKybq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:d101:b029:ff:d781:59b9 with
 SMTP id w1-20020a170902d101b02900ffd78159b9mr30965150plw.18.1622688955505;
 Wed, 02 Jun 2021 19:55:55 -0700 (PDT)
Date:   Wed,  2 Jun 2021 19:55:53 -0700
In-Reply-To: <95d64d73353d8689e3928b8c9444490d0cdebfc9.1619710329.git.gitgitgadget@gmail.com>
Message-Id: <20210603025553.349758-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <95d64d73353d8689e3928b8c9444490d0cdebfc9.1619710329.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH 7/8] refs: stop setting EINVAL and ELOOP in symref resolution
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, hanwenn@gmail.com, hanwen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Han-Wen Nienhuys <hanwen@google.com>
> 
> The only caller of refs_resolve_ref_unsafe_with_errno() is in
> refs/files-backend.c, and it only cares about EISDIR and ENOTDIR.
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  refs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 6e746cb01f24..597e4d1f18f9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1706,7 +1706,6 @@ static const char *refs_resolve_ref_unsafe_errno(struct ref_store *refs,
>  	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
>  		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
>  		    !refname_is_safe(refname)) {
> -			errno = EINVAL;
>  			return NULL;
>  		}
>  

I don't think this is related to avoiding errno and conveying error
information through an out param. But besides that, as it is, I'm not
sure that this is correct. Even if EINVAL is not checked by the caller,
setting errno to EINVAL here means avoiding exposing a potential
EISDIR/ENOTDIR that a preceding call set. Same comment for the other
instances.
