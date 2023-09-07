Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D0EC8743
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 17:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjIGRYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjIGRYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 13:24:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E41716
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 10:23:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so14330667b3.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694107372; x=1694712172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RvvcJZzWpwGYledHiriuTZorS6AOCDZW2vYoe5hhkIw=;
        b=YvD33ie06UZyC4RO2LXnYVZX4c5uWdA+TBBe0PAihMZ9BdCOWTR+J8ENhtQgHppocy
         iyHuoJIxuswqJRgGSmXtTTfi0ElXTdW8NtVXeslrvoXMRMd9qg72gJNBdGYulGcAJt4d
         r19NGX4Zz+VSjX8Gb/WrgPUFbZzbnNOoXl97YZ6ILjHhFbKwFFCITer6h1FrsbagCK5b
         NvATh/Ti4cykogrO8RmtQZFyoMQc5ZB+kSIkyV2ttW7nLh9sF1YNWzBMNEhTJxCSI4+w
         aCS1CnInOeEquYQQ9pJim2ZXPqqIE8EryoZh1qU00UwZuam4hTZrMFHjL49VM/pQ9Hiy
         W2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107372; x=1694712172;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvvcJZzWpwGYledHiriuTZorS6AOCDZW2vYoe5hhkIw=;
        b=atcawg7m/hJC3XYU05d3vqF9kQQSjlpx5UqxdywMGuFOG2cKbL+tjzv4uE84mZJwRb
         In7s8DSdAcLHD7SmNqOGDU6cVzW1VjppiJl04ph705Onf+SWXKzlUcT1dBVlx9WJ8t/Z
         fQhxZVEJ10XEih7jpFf3OSn9R3P8a/gWAZqjZuSQoSQQ/S9FvLSqqjWLtteN96dRB8co
         3sER2Liu74Yh0HLQIGqbvaJn367nZOTU7lIcuURPLO6cLy/tj71GPS2qRFm7V8JQuU+E
         TySN2d1QE/PsjHtICzpQnP8kEfqdVWMUOt4FYp4fA0D2zEmxk+yxlNsBhKkJh/JOYjME
         eHiQ==
X-Gm-Message-State: AOJu0YyNW47/iSek0cXQPMSQZ4s7CFPsqtEChHXhhzYndTxIXaeScIFV
        uDZUgcidfvsjQveoob7j6YMiSSJMuVArCLmHTuwU
X-Google-Smtp-Source: AGHT+IH/tQackM2oZTDlXP9/l6X2lvSCTUwy7GnBlCvTbnQMRv6oLOGBnhucjxwyaSOblnZr9vroG2WWwhixlP8bGYnP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:beee:a01:c6a4:f51e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:4001:0:b0:58c:9371:685e with
 SMTP id l1-20020a814001000000b0058c9371685emr6757ywn.5.1694107372201; Thu, 07
 Sep 2023 10:22:52 -0700 (PDT)
Date:   Thu,  7 Sep 2023 10:22:48 -0700
In-Reply-To: <20230907170119.1536694-1-sokcevic@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907172248.1789451-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2] diff-lib: Fix check_removed when fsmonitor is on
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Josip Sokcevic <sokcevic@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josip Sokcevic <sokcevic@google.com> writes:
> git-diff-index may return incorrect deleted entries when fsmonitor is used in a
> repository with git submodules. This can be observed on Mac machines, but it
> can affect all other supported platforms too.
> 
> If fsmonitor is used, `stat *st` may not be initialized. Since `lstat` calls
> aren't not desired when fsmonitor is on, skip the entire gitlink check using
> the same condition used to initialize `stat *st`.

I think this paragraph is outdated - you'll need to update it to match
the code in this version.

> diff --git a/diff-lib.c b/diff-lib.c
> index d8aa777a73..664613bb1b 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -39,11 +39,22 @@
>  static int check_removed(const struct index_state *istate, const struct cache_entry *ce, struct stat *st)
>  {
>  	assert(is_fsmonitor_refreshed(istate));
> -	if (!(ce->ce_flags & CE_FSMONITOR_VALID) && lstat(ce->name, st) < 0) {
> -		if (!is_missing_file_error(errno))
> -			return -1;
> -		return 1;
> +	if (ce->ce_flags & CE_FSMONITOR_VALID) {
> +		/*
> +		 * Both check_removed() and its callers expect lstat() to have
> +		 * happened and, in particular, the st_mode field to be set.
> +		 * Simulate this with the contents of ce.
> +		 */
> +		memset(st, 0, sizeof(*st));
> +		st->st_mode = ce->ce_mode;
> +	} else {
> +		if (lstat(ce->name, st) < 0) {
> +			if (!is_missing_file_error(errno))
> +				return -1;
> +			return 1;
> +		}
>  	}
> +
>  	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
>  		return 1;
>  	if (S_ISDIR(st->st_mode)) {

I'm on the fence about whether the extra newline is necessary - the "if"
did get bigger, but the code is clear enough without the newline. I lean
towards removing it, to avoid cluttering the diff.
