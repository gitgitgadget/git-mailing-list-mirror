Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C5C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbiBJTPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:15:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239426AbiBJTPn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:15:43 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A688F10BA
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:15:43 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v3-20020a622f03000000b004c412d02ca3so4946253pfv.20
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=Y8USE2onV4M/3Htg2GTyPLWostjdTp9FUeD0YSiCryQ=;
        b=IG2CWA36VRodg24lp/GLAk56+AYbvfHRCXG0cg8lqO1XAWSe23hc2uhBkujSP22Qz2
         PEgwnUssWONn4VYgv5xkRLfb8+kO0FKkcVOFzmYSws19fUWZBguhrYDdkTyITpgT35mD
         p2XEqSL8T2G0jNpwocHTPJVPwMQoH9QlobLWM5yWZ2iOzcgd7TMTYpVVguD8KcQmdtr+
         5XUmqla17hAqL8KpJv4J7/zETr2+CNogDlF1/86ZgcrBa9z+vzk1BbjtnbrRm1xjOYZw
         UVbPzGo7Bqc7sHFUHF5de/l9U5OWN14wUzBKgpJiOoeYMLaQbiRw/m0l+KTvrSOlO5wE
         SkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=Y8USE2onV4M/3Htg2GTyPLWostjdTp9FUeD0YSiCryQ=;
        b=dJz1WBBT4dzFcIrRsYJpVMm0evw4fAQb5pNDd/bMMmeV887HmGpBlyRPmRp/PuM/rw
         rP67e1r6X6b7eb2hnfv9du6qr41BbrpxHe25XVMypHWyJaT7zcLUojcEbObZdoDjueHj
         B2xzfaKUeuLBQmeKcOCxUgDo8tgbLC1LRVL52q6YdVpq4bkeOSHU13HBxr6OWTwSS3aF
         YqAallj135fZSuoWYt5BYSEW4DxLwGSfCFGoYdupwa8SqOY/cEvgbgIA91P2oAIt8Hxj
         0ZXiVeQIKOZ2/+VggTJvn/f0/2LQD9G6dx0XGP6lCtfy3T29G1aKqwpRzcVWjQaCgggu
         v7ew==
X-Gm-Message-State: AOAM5318efzMMstPqRHhca+3Sb40880hYZMk278A3HK/y3I2TE8rwkKG
        GmD9wDndOMpQkzITviIH15ctfk9PQmYEd8CyP3WC
X-Google-Smtp-Source: ABdhPJw2u28+h9jgDNLV1vJs99tkOpT2LEncAZN2GuKXLhFLuPtTUnYKnLNyFFTMzb2nv5zOfNdjX7OpY1PARr/gAWn6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:1d84:: with SMTP id
 pf4mr4355578pjb.106.1644520543211; Thu, 10 Feb 2022 11:15:43 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:15:33 -0800
In-Reply-To: <20220210044152.78352-4-chooglen@google.com>
Message-Id: <20220210191533.659570-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 3/8] submodule: make static functions read submodules from commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> As a result, "git fetch" now reads changed submodules using the
> `.gitmodules` and path from super_oid's tree (which is where "git fetch"
> actually noticed the changed submodule) instead of the filesystem.

Could we have a test showing what has changed?

> @@ -1029,7 +1044,7 @@ static int submodule_needs_pushing(struct repository *r,
>  				   const char *path,
>  				   struct oid_array *commits)
>  {
> -	if (!submodule_has_commits(r, path, commits))
> +	if (!submodule_has_commits(r, path, null_oid(), commits))

This confused me at first, but I see that this code is not for fetching,
but for pushing. This patch set concerns itself with fetching, so
passing null_oid() to preserve existing behavior is good.

> @@ -1414,12 +1429,13 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
>  }
>  
>  static struct fetch_task *fetch_task_create(struct repository *r,
> -					    const char *path)
> +					    const char *path,
> +					    const struct object_id *treeish_name)
>  {
>  	struct fetch_task *task = xmalloc(sizeof(*task));
>  	memset(task, 0, sizeof(*task));
>  
> -	task->sub = submodule_from_path(r, null_oid(), path);
> +	task->sub = submodule_from_path(r, treeish_name, path);

If there is not a good reason to have "path" before "treeish_name",
probably best to maintain the same parameter order as
submodule_from_path().

> @@ -1476,7 +1493,7 @@ static int get_next_submodule(struct child_process *cp,
>  		if (!S_ISGITLINK(ce->ce_mode))
>  			continue;
>  
> -		task = fetch_task_create(spf->r, ce->name);
> +		task = fetch_task_create(spf->r, ce->name, null_oid());

Hmm...is the plumbing incomplete? This code is about fetching, but we're
not passing any superproject commit OID here. If this will be fixed in a
future commit, maybe the distribution of what goes into each commit
needs to be revised.

> @@ -1499,7 +1516,7 @@ static int get_next_submodule(struct child_process *cp,
>  			continue;
>  		}
>  
> -		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
> +		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());

Same comment here.
