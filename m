Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A074C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356465AbhLFWga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241471AbhLFWg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:36:29 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F2C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 14:33:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u4-20020a056a00098400b004946fc3e863so7379666pfg.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=revST58V2h+S1XQfHKzvB5b8+HSAUTpd1Ly5HQY8a5g=;
        b=l/Y0kuvLEdIeOer9MDl2X31CiNWj0oh09z6S/MWje6yAiwxCb6/gvtV+juYT4LWn2a
         o8QzN6hGgYPcwj2SP0gsW0OWqSSdi3s57XwuvTEobyM9RlCEm+XOREtWlc+EDyFoYRF1
         meVz517nk2GX2DSJN73u00Ag2wuv25QB+D/vQS9iLpS5cS2HzgCpdKptYPlEQXcHTHkU
         TDNPr8oSlmHfm0Li533AWLaR1myeoaivhHycCzBd4/qrSTctYF92aLDsBvqmvRPXUQz8
         mwDtXJVXyHUs7q9Urnv2AWfFkpTgju96l38dNZtqxVryiWig0XJDb73lid0M9Ma/MatN
         K9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=revST58V2h+S1XQfHKzvB5b8+HSAUTpd1Ly5HQY8a5g=;
        b=Nn2DXMmiS52/e9eRAAlVZLsoO5ody4cQ/0VwWapeXbHpSpPxpK2VUYzuOwg8D1jrLJ
         E0qZfHNBl5MbMNdF8+qqy9Wl9eyFgFid61iT2XKX5Y0DykZcPMEKytWsxPmoj300LXRx
         z2Oq9674wiaiTbdj8UACkJebUv6H8FE5BpYdqxZPN99bmn1UAtq13IW0aAqENgbrDKjF
         CoGdNxZomf78v1KE5LIJcrOoMmbntaLXRZTx/pcOQ9h2Wi8Rc3qiYCal70pwFLXjDcSS
         70LKTl5ckBmRpzQ3OHVKTXjFs+WTk93C8QwmM5ZvTUMesb1b0pf7BD4UsOUrpwjdgd36
         AMvg==
X-Gm-Message-State: AOAM5329n0ac7/hcijyiW12Oub/Egk6p4qt+uZwQOmapFbWJBjgf0c8L
        kRdMRfHl9gfLo0WI8SUVsUF7FgI4R+oXBA==
X-Google-Smtp-Source: ABdhPJxVn+bWQqxlUiMmEZJYtZ5hS85a2ore046YFI+uTjtLmdugDKOM+WWiA09lifwVSkIPa+IjbXrz2sq4gA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e749:b0:141:edaa:fde1 with SMTP
 id p9-20020a170902e74900b00141edaafde1mr47218542plf.72.1638829979716; Mon, 06
 Dec 2021 14:32:59 -0800 (PST)
Date:   Mon, 06 Dec 2021 14:32:57 -0800
In-Reply-To: <d3b8e007177f93b53dcb43d88890228b468b4975.1638487815.git.jonathantanmy@google.com>
Message-Id: <kl6lmtldcqjq.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1638487815.git.jonathantanmy@google.com> <d3b8e007177f93b53dcb43d88890228b468b4975.1638487815.git.jonathantanmy@google.com>
Subject: Re: [PATCH v5 2/2] config: include file if remote URL matches a glob
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>  Documentation/config.txt |  16 +++++
>  config.c                 | 122 +++++++++++++++++++++++++++++++++++----
>  config.h                 |   9 +++
>  t/t1300-config.sh        | 118 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 255 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0c0e6b859f..e0e5ca558e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -159,6 +159,22 @@ all branches that begin with `foo/`. This is useful =
if your branches are
>  organized hierarchically and you would like to apply a configuration to
>  all the branches in that hierarchy.
> =20
> +`hasconfig:remote.*.url:`::
> +	The data that follows this keyword is taken to
> +	be a pattern with standard globbing wildcards and two
> +	additional ones, `**/` and `/**`, that can match multiple
> +	components. The first time this keyword is seen, the rest of
> +	the config files will be scanned for remote URLs (without
> +	applying any values). If there exists at least one remote URL
> +	that matches this pattern, the include condition is met.
> ++
> +Files included by this option (directly or indirectly) are not allowed
> +to contain remote URLs.
> ++
> +This keyword is designed to be forwards compatible with a naming
> +scheme that supports more variable-based include conditions, but
> +currently Git only supports the exact keyword described above.
> +

A reader of this description doesn't have any reason to think that
`hasconfig:remote.*.url` wouldn't respect in-place semantics, so my
concern in [1] is addressed.

`hasconfig:foo.*.bar` seems reasonable from a forwards-compatibility
perspective. Ideally, it would be nice to see a generic implementation
that actually handles config values beyond `remote.*.url`, but unless we
take a closer look at all config values and the conditions we would like
to support, a generic implementation seems like a premature
optimization that won't age well.

So OK to having a forward-compatible name without a forward compatible
implementation.

> +static int include_condition_is_true(struct config_include_data *inc,
>  				     const char *cond, size_t cond_len)
>  {
> +	const struct config_options *opts =3D inc->opts;
> =20
> -	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> +	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len)) {
>  		return include_by_gitdir(opts, cond, cond_len, 0);
> -	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len)=
)
> +	} else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_le=
n)) {
>  		return include_by_gitdir(opts, cond, cond_len, 1);
> -	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len)=
)
> +	} else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_le=
n)) {
>  		return include_by_branch(cond, cond_len);
> +	} else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &=
cond,
> +				   &cond_len)) {
> +		if (inc->opts->unconditional_remote_url)
> +			return 1;
> +		if (!inc->remote_urls)
> +			populate_remote_urls(inc);
> +		return at_least_one_url_matches_glob(cond, cond_len,
> +						     inc->remote_urls);
> +	}
> =20
>  	/* unknown conditionals are always false */
>  	return 0;

Nit: I have a preference for =C3=86var's version [2], which looks more
consistent with the rest of the function i.e. handling the match using a
helper function.

> +test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url=
 in such included files' '
> +	git init hasremoteurlTest &&
> +	test_when_finished "rm -rf hasremoteurlTest" &&
> +
> +	cat >"$(pwd)"/include-with-url <<-\EOF &&
> +	[remote "bar"]
> +		url =3D bar
> +	EOF
> +	cat >>hasremoteurlTest/.git/config <<-EOF &&
> +	[includeIf "hasconfig:remote.*.url:foo"]
> +		path =3D "$(pwd)/include-with-url"
> +	EOF
> +
> +	# test with any Git command
> +	test_must_fail git -C hasremoteurlTest status 2>err &&
> +	grep "fatal: remote URLs cannot be configured in file directly or indir=
ectly included by includeIf.hasconfig:remote.*.url" err
> +'
> +
>  test_done
> --=20
> 2.34.1.400.ga245620fadb-goog

This addresses the test coverage comment in [1]. Great!

[1] https://lore.kernel.org/git/kl6lilwjre3m.fsf@chooglen-macbookpro.roam.c=
orp.google.com
[2] https://lore.kernel.org/git/211206.86zgpdpmyy.gmgdl@evledraar.gmail.com
