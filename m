Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 21:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhLIV07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhLIV07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 16:26:59 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE9C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 13:23:25 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id 61-20020a17090a09c300b001adc4362b42so4330617pjo.7
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0olpGSqKQY7QZLBvv3hqxLoPfPI43s9ZrNUjn0Vp8bk=;
        b=C4p6tFk9TyFliBEYS9AVhRtD5P1qjWPYAFfzkzKbvUJUmoSTckrrvsEoBy6GVlfeQN
         EY9kSptkhNSEeSjRNDQ+raQAFQP6JOA1rrD6GtkA5/+HiVJDVTwimSqQ/+4FCaOQq8+6
         Z6hfnEJzzBNg5HPXwMxCXRVvUrza8eJQVwSkaA26tJQ8UwgpMZGN4sedm8KgnBtbWAlx
         d1080HOHNswl/se2VoBWkYwr0ImwD5e1VRNfGX3m3zSck598lxLe1pV8KD/F5uXNjnL0
         No6fXhxl+ueFpAwIj2HPIbWITNC2DqaD5YYpzngNqbSLY0+jLUW1mKvovRxdOVvk4MB4
         tC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0olpGSqKQY7QZLBvv3hqxLoPfPI43s9ZrNUjn0Vp8bk=;
        b=JGLu4dFVVOrxOUgHh/Z0DiBXIfn97QeNdMGFcOdkpJlA7X6D0OOu5I8ZR1YQ9qjVc/
         9/rBtXG709047u30Ou519QYQOwhFq5q2EuPBhqAdpPYc8LkdRF5VVQBnxurHT/4NXrHJ
         UZbrvLv63jCtOBbyD1+WTa2Sz0MBZJe1RcitvQO6L3YVHEYrfzSj1hXd9+7hkkC+FcbU
         A40oAjiStcfySqlYZXcZsVGN1LPU/KPiIK7b647ea3Jw82uslfBoVUdC9eyqsqxZFrGh
         AdzcJOnjGd3dUZ/mlwCWm//srUlzY99dVbSFOugN0fZL5+O4GoBRSBElcoWANWhUJPAt
         SLMg==
X-Gm-Message-State: AOAM5332Dq0FVK6T3NGGDGR3E/QcB5ezRYhv+ZjlUfvya8ErhUMMMGkM
        oub6zf3VPsQ4e9gMGr2UHOc18UQjUeXh/zIViI3Q
X-Google-Smtp-Source: ABdhPJzETrg7PB9QhSo6GGikb3bNV5aPWHFW7ExkDRGkLKSphNo247MJHKFPWVh3hvGKyLhD3Al74wYSJlAJ+EnuzZ33
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:a94:b0:44c:ecb2:6018 with
 SMTP id b20-20020a056a000a9400b0044cecb26018mr13895482pfl.57.1639085004800;
 Thu, 09 Dec 2021 13:23:24 -0800 (PST)
Date:   Thu,  9 Dec 2021 13:23:22 -0800
In-Reply-To: <20211209184928.71413-4-chooglen@google.com>
Message-Id: <20211209212322.499217-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211209184928.71413-4-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH v3 3/5] builtin/branch: clean up action-picking logic in cmd_branch()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> Incidentally, fix an incorrect usage string that combined the 'list'
> usage of git branch (-l) with the 'create' usage; this string has been
> incorrect since its inception, a8dfd5eac4 (Make builtin-branch.c use
> parse_options., 2007-10-07).

I think that we implement such incidental fixes only when we're touching
the relevant lines, but this change looks correct.

> -	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
> -	int show_current = 0;
> -	int reflog = 0, edit_description = 0;
> -	int quiet = 0, unset_upstream = 0;
> +	/* possible actions */
> +	int delete = 0, rename = 0, copy = 0, force = 0, list = 0,
> +	    unset_upstream = 0, show_current = 0, edit_description = 0;
> +	int noncreate_actions = 0;
> +	/* possible options */
> +	int reflog = 0, quiet = 0, icase = 0;

[snip]

> -	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
> -	    list + edit_description + unset_upstream > 1)
> +	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
> +			    !!show_current + !!list + !!edit_description +
> +			    !!unset_upstream;
> +	if (noncreate_actions > 1)
>  		usage_with_options(builtin_branch_usage, options);

Overall this change looks good, although if you're going to rearrange
the variable declarations (e.g. the positions of show_current,
edit_description, and unset_upstream have moved), you might as well make
them consistent with the noncreate_actions statement, I guess. Also
maybe move new_upstream closer.
