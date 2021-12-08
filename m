Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF00C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 01:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhLHBFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 20:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHBFy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 20:05:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E4FC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 17:02:23 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p12-20020a17090b010c00b001a65bfe8054so585897pjz.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 17:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VqDKi9Z8Nt722uvLZdk9cDNVFx4q3UQ5OkoabpkKv/k=;
        b=Sry7h9eldSbobbKXiZROz45BJl1aGom8quYHpG6YNaMeTGOJA6KE8Go0BAgHu1dG/Z
         FYqHg7gYhP+lw957VZJBcfOg/fUYkOVHrGwTaUi2FnoDdx0GLPgku15xNT3qrTyHScin
         T3mE4fUe36Y7f/Oo4i/O/aXmrdJ7LY6d8mhJDMrDOdPediXhLic/f3hwXq+G2P00bW/t
         H5EjsHgp5DhhyXdqPgbPUYJG7zq6e+I4t7DI6TLIdtkP56PvCIgwpXWa0B4Btv34p0Kg
         9IX2PMCGc3TSTMQJYJaMwlWZ1M3Dab0GrQjIYAwTVI8rH906nlPAN8ECgJuqV1tE2eSL
         /u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VqDKi9Z8Nt722uvLZdk9cDNVFx4q3UQ5OkoabpkKv/k=;
        b=FBpjoOWmjmXe8T9dAw1d3uN5JW0GOua8yo4y3xoui6D0bE9mmFmkSH3wsTz/MN2G06
         ndKHSXkYzj+y0tYKx6xoBQeWB2vnneY/MzCsWfw8wPilQQSO58CkHq1NrxLxrqZlseea
         XS+oQrUriSMBjJKiCsPAlmvBg9ybv6euXxgqdEEvDqGtsmR3drMBgI1cVDsio96u36TX
         Yd4GDWE5NwuOJXkzW4djdyKTp82TooT7MtbNvNgdyoP5+nztlnafUOWZKy0FgSnyx9x4
         rXOt7YpwWRl8c3S2T2S0EvEWzkA8RVgMdC4dwo7ed6/d2QMNSRoCyzI/xiraNhcmoQIC
         mpRQ==
X-Gm-Message-State: AOAM53070X2HW3RFnV/hgKs+Ry9sNes+tgM02Ttq6Q9ygKAcjuYnm2N3
        zM2oq+sJwJKHAp1aKwOqLfOdt+4woq11ng==
X-Google-Smtp-Source: ABdhPJyKYqUhIy982RdYdMN4Ogg/IknNTvIFRoJHj6zTDLcMo9nInLpmyX4MTYsDexBhSgeJvsPo2oDWAz0iYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:db01:b0:141:ea12:2176 with SMTP
 id m1-20020a170902db0100b00141ea122176mr56031624plx.44.1638925342683; Tue, 07
 Dec 2021 17:02:22 -0800 (PST)
Date:   Tue, 07 Dec 2021 17:02:20 -0800
In-Reply-To: <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
Message-Id: <kl6lfsr3c3j7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com> <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
> +{
> +	const char *bare_ref;
> +	struct branch *branch;
> +	int i;
> +
> +	bare_ref = orig_ref;
> +	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
> +
> +	branch = branch_get(bare_ref);
> +	if (!branch->remote_name) {
> +		warning(_("asked to inherit tracking from '%s', but no remote is set"),
> +			bare_ref);
> +		return -1;
> +	}
> +
> +	if (branch->merge_nr < 1 || !branch->merge_name || !branch->merge_name[0]) {
> +		warning(_("asked to inherit tracking from '%s', but no merge configuration is set"),
> +			bare_ref);
> +		return -1;
> +	}
> +
> +	tracking->remote = xstrdup(branch->remote_name);
> +	for (i = 0; i < branch->merge_nr; i++)
> +		string_list_append(tracking->srcs, branch->merge_name[i]);
> +	tracking->matches = 1;
> +	return 0;
> +}

tracking->matches is used to keep track of the number of matched remote
refs. I believe we set tracking->matches = 1 to fulfill two specific
conditions in setup_tracking()...

> +
>  /*
>   * This is called when new_ref is branched off of orig_ref, and tries
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> @@ -189,11 +218,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			   enum branch_track track, int quiet)
>  {
>  	struct tracking tracking;
> +	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>  
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
> -	if (for_each_remote(find_tracked_branch, &tracking))
> +	tracking.srcs = &tracking_srcs;
> +	if (track != BRANCH_TRACK_INHERIT)
> +		for_each_remote(find_tracked_branch, &tracking);
> +	else if (inherit_tracking(&tracking, orig_ref))
>  		return;
>  
>  	if (!tracking.matches)

*extra context*
	if (!tracking.matches)
		switch (track) {
		case BRANCH_TRACK_ALWAYS:
		case BRANCH_TRACK_EXPLICIT:
		case BRANCH_TRACK_OVERRIDE:
			break;
		default:
			return;
		}

First, tracking.matches > 0, because we want to do work if there are
branches to track.

Secondly,

*extra context*
	if (tracking.matches > 1)
		die(_("Not tracking: ambiguous information for ref %s"),
		    orig_ref);

tracking.matches <= 1, because we don't want to set up tracking if it's
not obvious what ref we want to track.

But as I understand it, BRANCH_TRACK_INHERIT should be unconditional, so
instead of fudging this behavior by setting the correct value for
tracking.matches (which is meant for matching remote refs), we can just
do what the other unconditional BRANCH_TRACK_* options do, which is to
to break instead of return, i.e.

	if (!tracking.matches)
		switch (track) {
		case BRANCH_TRACK_ALWAYS:
		case BRANCH_TRACK_EXPLICIT:
		case BRANCH_TRACK_OVERRIDE:
+   case BRANCH_TRACK_INHERIT:
			break;
		default:
			return;
		}

and BRANCH_TRACK_INHERIT won't have to pretend that tracking.matches is
meaningful to it.

>@@ -210,11 +243,13 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
> 		die(_("Not tracking: ambiguous information for ref %s"),
> 		    orig_ref);
> 
>-	if (install_branch_config(config_flags, new_ref, tracking.remote,
>-			      tracking.src ? tracking.src : orig_ref) < 0)
>+	if (tracking.srcs->nr < 1)
>+		string_list_append(tracking.srcs, orig_ref);
>+	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
>+			      tracking.srcs) < 0)
> 		exit(-1);
> 
>-	free(tracking.src);
>+	string_list_clear(tracking.srcs, 0);
> }

It looks like install_branch_config_multiple_remotes() can just replace
install_branch_config() in setup_tracking(), nice. This should make it
pretty easy for me to rebase gc/branch-recurse-submodules onto this.
