Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798DC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060660724
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 09:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbhHaJUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbhHaJUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 05:20:24 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B9C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:19:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q21so30505695ljj.6
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qluoBmoqu3e0Fz8h5w3upfzIgBDF9MUqc5Tf2xLdJ9w=;
        b=kMG9Zvz1RJVxGPLiFQUGB9oRyr1/azb+zo0NrNGuHU2y7nQJAkOfnYOSHjvh90iGb3
         WsmHz8t25dNwscZ/rdREypma2/IkvIr2uc+770v4mDofyADjc8mzEl8rPgvT/1mq8Otf
         C8tNqyhNJ0IqSeiIYdUL8+23h6LmwdfEll6k5czcOA16uHMGrSLLgb6+uTQqmNeA8J/4
         I9ACWIZ62iVHO+qNnElel0qQaxfVaE4DlXRBXLZicAq12/RF537LlmlT6lczPcR7F7Q8
         zMAVSOCsD3dnO2XqqZ1Q4k5/xNHGKxBBo5kk7nOWAHFWkPVJIFpnGBvBN8rxqTHIg61t
         MpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=qluoBmoqu3e0Fz8h5w3upfzIgBDF9MUqc5Tf2xLdJ9w=;
        b=Nv6EWdfvoUGlcsBJ7gF6XBCwcw63Dx0sKNzkcqgsRB/clSJWgTv2H3dK3l0HFjUi+y
         0fxwZ/G92iRiwqD/TX69CUtyf0e4xXsuuOO5+vxXWOty2y1hgLBIUEWsKD+9sOj6T1wK
         v3/qiUvrNc16fEARkGVh0fxAjSqmG0hz9SVYgW450iOb0ocoT1tQA7Xe9F+PAqP/29vM
         e0hsCnzRM7yqBU4LI5khBJWFdEdciyzWYeVh7qfrX5vKwOJi2kanlbcihrSlfBtvbZMx
         nA4/BmN8V+bwrSHaAOD0ebVQLhUUPldX4Pu+AVa0GXXZ5X00jync0StyGXX4MwL56jhT
         re6g==
X-Gm-Message-State: AOAM530qyo4QvdojAHU84Xady1n00eMVY4ixCNmtF/CNGvomt37ra55k
        GSj66g1d5G9R04w5snm3Ct9ZYwmrOqg=
X-Google-Smtp-Source: ABdhPJxSzI7CUs+TzXo97opLjgpTzOPcvhag9qaivLm3hw74nkipMCW7SYxn6D21HwPZV1KNbvdHbg==
X-Received: by 2002:a2e:b5dc:: with SMTP id g28mr24219292ljn.96.1630401567835;
        Tue, 31 Aug 2021 02:19:27 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v3sm998304lfr.44.2021.08.31.02.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 02:19:27 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/7] show, log: provide a --remerge-diff capability
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 12:19:26 +0300
In-Reply-To: <b75e73384fde4f23296bd02eb40455263f805706.1630376800.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 31 Aug 2021
        02:26:39 +0000")
Message-ID: <875yvmgee9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>

[...]

> diff --git a/diff-merges.c b/diff-merges.c
> index d897fd8a293..3a24c45b8e5 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -17,6 +17,7 @@ static void suppress(struct rev_info *revs)
>  	revs->combined_all_paths = 0;
>  	revs->merges_imply_patch = 0;
>  	revs->merges_need_diff = 0;
> +	revs->remerge_diff = 0;
>  }
>  
>  static void set_separate(struct rev_info *revs)
> @@ -45,6 +46,12 @@ static void set_dense_combined(struct rev_info *revs)
>  	revs->dense_combined_merges = 1;
>  }
>  
> +static void set_remerge_diff(struct rev_info *revs)
> +{
> +	suppress(revs);
> +	revs->remerge_diff = 1;
> +}
> +
>  static diff_merges_setup_func_t func_by_opt(const char *optarg)
>  {
>  	if (!strcmp(optarg, "off") || !strcmp(optarg, "none"))
> @@ -57,6 +64,8 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
>  		return set_combined;
>  	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
>  		return set_dense_combined;
> +	else if (!strcmp(optarg, "r") || !strcmp(optarg, "remerge"))
> +		return set_remerge_diff;
>  	else if (!strcmp(optarg, "m") || !strcmp(optarg, "on"))
>  		return set_to_default;
>  	return NULL;
> @@ -113,6 +122,9 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  	} else if (!strcmp(arg, "--cc")) {
>  		set_dense_combined(revs);
>  		revs->merges_imply_patch = 1;
> +	} else if (!strcmp(arg, "--remerge-diff")) {
> +		set_remerge_diff(revs);
> +		revs->merges_imply_patch = 1;
>  	} else if (!strcmp(arg, "--no-diff-merges")) {
>  		suppress(revs);
>  	} else if (!strcmp(arg, "--combined-all-paths")) {

The diff-merges options handling looks fine to me.

Thanks,
-- Sergey Organov
