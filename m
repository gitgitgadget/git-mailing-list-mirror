Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA7C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhLIWQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhLIWQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:16:26 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5179C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 14:12:52 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id h23-20020a635757000000b00338aec76502so553161pgm.6
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HL34ea5e6ZqZn9HsbaJlQQ3vdfhm/kdf/LzWO0PXcNs=;
        b=igcrFai55duX+bbG2JVda/nZ8EGX+GYydlsqxy79tH5Eq1dWI/EL1RFb4oJeHcsKBW
         4ozBnz1Tt4TY714+xUjf7Z38V7UEo1m3UfgGcWzG3mwCvBofkAfJZsQ5E6aRW+cV+Jsi
         l9Ym4BCMO7ChuLmVb2YeOeFu3OOMoIpCxfb+tADuWoZmC4JzwSY6IMz15T5+1sz7NhRb
         UzGAyaG1EQXasgZMilfnrVrbyhZyDp5aRtNoXTCE1sA3ZX/Xz7hv+WYLKDZwFGTIHLHs
         qBWQ9m+D97kZZyk011QfjNkZZo4wbE6mY3IXWGQoC0dv+yar9sNSIIlEqUpSdMQ281e7
         CGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HL34ea5e6ZqZn9HsbaJlQQ3vdfhm/kdf/LzWO0PXcNs=;
        b=W8mBqa+lopF8AnSUjzS3C2sdnMpjJ0AYIw3WkV6pG+OpjX3wvWfeoMCsGVt0Hk+cpB
         2mOxIHuNyjRWz7P5IQb78ZgJ3G70DDEwR2JydcCK3pCvdxV6mvuXBCBzRurLl+gkpXjK
         7waAAab5iSIFqb3fa3sJ46je4jn3sqbRV60UNntXjIpb02silD5ehIflmtR3kUYz4oCv
         N+POtCu7t5tvAHqJ5tz27A5tJak/bAH8ZwybhbdW9vvGYasTI/AW/JmWbSUZyKN6lsI4
         QXeGZllD10L5tt8x5ZuorkDFF8ftln9AmGIfr7fKOd8CC0m2tn+ZZo9EIik75PoSpj5m
         b7vA==
X-Gm-Message-State: AOAM533tpSkGQqQcepKFol96j/097mZYfCjQvdFUSeYABuFaTTEsMXDt
        D0rQ5HL7TMdjTi2oxJDRCo7qUxY8CzF8dF1B8mP0
X-Google-Smtp-Source: ABdhPJwhWkaKHCpUBsCkiymmEiT52r/MevVImAiVmJd/1x5Q1rCPK6cF40rAfvPqq5rvUZeB1Mys2/axYCXOSp7bFFJO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:e852:b0:143:8152:26c7 with
 SMTP id t18-20020a170902e85200b00143815226c7mr71451048plg.75.1639087972387;
 Thu, 09 Dec 2021 14:12:52 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:12:50 -0800
In-Reply-To: <20211207192925.67680-1-chooglen@google.com>
Message-Id: <20211209221250.508257-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: Re: [PATCH] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> `git fetch --negotiate-only` does not fetch objects and thus, it should
> not perform certain auxiliary tasks like updating submodules, updating
> the commit graph, or running gc. Although send_pack() invokes `git fetch
> --negotiate-only` correctly, cmd_fetch() also reads config variables,
> leading to undesirable behavior, like updating submodules if
> `submodule.recurse=true`.
> 
> Make cmd_fetch() return early if --negotiate-only was specified so that
> these auxiliary tasks are skipped.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> `git fetch --negotiate-only` is used during push negotiation to
> determine the reachability of commits. As its name implies, only
> negotiation is performed, not the actual fetching of objects. However,
> cmd_fetch() performs certain tasks with the assumption that objects are
> fetched:
> 
> * Submodules are updated if enabled by recurse.submodules=true, but
>   negotiation fetch doesn't actually update the repo, so this doesn't
>   make sense (introduced in [1]).
> * Commit graphs will be written if enabled by
>   fetch.writeCommitGraph=true. But according to
>   Documentation/config/fetch.txt [2], this should only be done if a
>   pack-file is downloaded
> * gc is run, but according to [3], we only do this because we expect
>   `git fetch` to introduce objects
> 
> Instead of disabling these tasks piecemeal, let's just make cmd_fetch()
> return early if --negotiate-only was given. To accommodate possible
> future options that don't fetch objects, I opted to introduce another
> `if` statement instead of putting the early return in the existing
> `if (negotiate_only)` block.

Some of this probably should be in the commit message too.

> +	if (negotiate_only) {
> +		/*
> +		 * --negotiate-only should never recurse into
> +		 * submodules, so there is no need to read .gitmodules.
> +		 */
> +		recurse_submodules = RECURSE_SUBMODULES_OFF;
> +		if (!negotiation_tip.nr)
> +			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
> +	}

Maybe add a check here that --recurse-submodules was not explicitly
given.

> +	/* skip irrelevant tasks if objects were not fetched  */
> +	if (negotiate_only)
> +		return result;

There are other reasons too why objects were not fetched (e.g. if we
already have all of them). Maybe add a NEEDSWORK explaining this.

Besides these code comments and the fact that the commit message could
be improved, this patch looks good to me.
