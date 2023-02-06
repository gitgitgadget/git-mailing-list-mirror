Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DA9C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBFQxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBFQxf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:53:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81B268C
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:53:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u21so12340721edv.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DCp01/qdqONvrI7aegeU50hzn1yZX5XvvQCqEya7GWY=;
        b=iKwLcxa1P6a/lbPA90QrxKIPX4ozFTB+AyrfuyK+OT4OeaKtm5CwAcKjtoeDUmnbS4
         m3OzYIKYLXaFTTr86VoM8pf1X8cwdrPSfhXiwCxFzCvChMBp8+NVudE+vSsU5ji7sotY
         CgP1P3fpzkNBHf5hbZ5idNXLCT5Ah1O0z4q7cZtvqAKfYYzijAOVMD+Fr0py0vChICm0
         33KWiDqZ0XlZcz3ajJzIrk1XoBU4VIcNeTSfzsTddWKTDfHbMQGAJ/+FLUQCzol6HQfj
         C0vF+L2nB85yrPMHuaQooL1+zqQ+cT3KLb5aT4MWL2YFiXBa90BUha0eCaTqpTU5/eRA
         xeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCp01/qdqONvrI7aegeU50hzn1yZX5XvvQCqEya7GWY=;
        b=PTBmqim2qrlvk6W+ZAOOjCiYvGnaoEy4SDwFg2lHIGNSNXzlE9VGzH2yYI8uTV3OnL
         c855dpG5B/cEAljPKCvjQ/ZSj+dURVIxh+8vm4o7LsPt0dk7YpkXwbeXVHXbJEBWl17H
         9skRzSQ1LYJ7qtQoatxZcWD7n9Fw0hXSFUbAKXwZhUkwA8pB/GhkBatgWyuJ4OVRtk8R
         QOzfcBUTdtj6rqnpRG9pjZh5Z4QxfPObTbShsfGVH0d+slzv03NThFIyPvkO4Zq4bMSV
         qMgVWrek6GzKZPaWqgQO0tiWSYUJkbl81DzRCGkvGq6Keo64XHueF1IaqWPwb2EKMMiZ
         1JKg==
X-Gm-Message-State: AO0yUKXme25CaOakXP2k4Qobj+79xfolAtMbwjmWsNYJHhb6aeNgd4oT
        ZjiNcmq4DRtroZsgxWNy+aH2gXNt0CBfaku+
X-Google-Smtp-Source: AK7set+DmdkYCQodtIWiEYb9L4pPRRhnHY3CJl8HGwXj1GIe+Qzg0hGi7vU1I/YpxnpWRWP2IwMwxQ==
X-Received: by 2002:a50:d7c8:0:b0:492:8c77:7da9 with SMTP id m8-20020a50d7c8000000b004928c777da9mr252731edj.9.1675702412167;
        Mon, 06 Feb 2023 08:53:32 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id ef15-20020a05640228cf00b0046b471596e6sm5320375edb.57.2023.02.06.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:53:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pP4kF-000QE5-0V;
        Mon, 06 Feb 2023 17:53:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Mon, 06 Feb 2023 17:39:30 +0100
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
Message-ID: <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
> [...]
> +
> +		if (!o->xdl_opts_command_line) {
> +			static struct attr_check *check;
> +			const char *one_diff_algo;
> +			const char *two_diff_algo;
> +
> +			check =3D attr_check_alloc();
> +			attr_check_append(check, git_attr("diff-algorithm"));
> +
> +			git_check_attr(the_repository->index, NULL, one->path, check);
> +			one_diff_algo =3D check->items[0].value;
> +			git_check_attr(the_repository->index, NULL, two->path, check);
> +			two_diff_algo =3D check->items[0].value;
> +
> +			if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two_diff_algo) &&
> +				!strcmp(one_diff_algo, two_diff_algo))
> +				set_diff_algorithm(o, one_diff_algo);
> +
> +			attr_check_free(check);

This is a bit nitpicky, but I for one would find this much easier to
read with some shorter variables, here just with "a" rather than
"one_diff_algo", "b" instead of "two_diff_algo", and splitting
"the_repository->index" into "istate" (untested):
=09
	+		if (!o->xdl_opts_command_line) {
	+			static struct attr_check *check;
	+			const char *a;
	+			const char *b;
	+			struct index_state *istate =3D the_repository->index;
	+
	+			check =3D attr_check_alloc();
	+			attr_check_append(check, git_attr("diff-algorithm"));
	+
	+			git_check_attr(istate, NULL, one->path, check);
	+			a =3D check->items[0].value;
	+			git_check_attr(istate, NULL, two->path, check);
	+			b =3D check->items[0].value;
	+
	+			if (!ATTR_UNSET(a) && !ATTR_UNSET(b) && !strcmp(a, b))
	+				set_diff_algorithm(o, a);
	+
	+			attr_check_free(check);
	+		}

That also nicely keeps the line length shorter.

> @@ -333,6 +333,8 @@ struct diff_options {
>  	int prefix_length;
>  	const char *stat_sep;
>  	int xdl_opts;
> +	/* If xdl_opts has been set via the command line. */
> +	int xdl_opts_command_line;
>=20=20
>  	/* see Documentation/diff-options.txt */
>  	char **anchors;
> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
> index 8d1e408bb58..630c98ea65a 100644
> --- a/t/lib-diff-alternative.sh
> +++ b/t/lib-diff-alternative.sh
> @@ -107,8 +107,27 @@ EOF
>=20=20
>  	STRATEGY=3D$1
>=20=20
> +	test_expect_success "$STRATEGY diff from attributes" '
> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index file1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
>  	test_expect_success "$STRATEGY diff" '
> -		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output =
&&
> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" file=
1 file2 > output &&

Nit: The usual style is ">output", not "> output".

> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "$STRATEGY diff command line precedence before attr=
ibutes" '
> +		echo "file* diff-algorithm=3Dmeyers" >.gitattributes &&
> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" file=
1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "$STRATEGY diff attributes precedence before config=
" '
> +		git config diff.algorithm default &&
> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index "--diff-algorithm=3D$STRATEGY" file=
1 file2 > output &&
>  		test_cmp expect output
>  	'
>=20=20
> @@ -166,5 +185,11 @@ EOF
>  		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output =
&&
>  		test_cmp expect output
>  	'
> +
> +	test_expect_success "$STRATEGY diff from attributes" '
> +		echo "file* diff-algorithm=3D$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index uniq1 uniq2 > output &&
> +		test_cmp expect output
> +	'
>  }

For some non-nitpicking, I do worry about exposing this as a DoS vector,
e.g. here's a diff between two distant points in git.git with the
various algorithms:

	$ hyperfine -r 1 -L a patience,minimal,histogram,myers 'git diff --diff-al=
gorithm=3D{a} v2.0.0 v2.28.0'
	Benchmark 1: git diff --diff-algorithm=3Dpatience v2.0.0 v2.28.0
	  Time (abs =E2=89=A1):        42.121 s               [User: 41.879 s, Sys=
tem: 0.144 s]
=09
	Benchmark 2: git diff --diff-algorithm=3Dminimal v2.0.0 v2.28.0
	  Time (abs =E2=89=A1):        35.634 s               [User: 35.473 s, Sys=
tem: 0.160 s]
=09
	Benchmark 3: git diff --diff-algorithm=3Dhistogram v2.0.0 v2.28.0
	  Time (abs =E2=89=A1):        46.912 s               [User: 46.657 s, Sys=
tem: 0.228 s]
=09
	Benchmark 4: git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0
	  Time (abs =E2=89=A1):        33.233 s               [User: 33.072 s, Sys=
tem: 0.160 s]
=09
	Summary
	  'git diff --diff-algorithm=3Dmyers v2.0.0 v2.28.0' ran
	    1.07 times faster than 'git diff --diff-algorithm=3Dminimal v2.0.0 v2.=
28.0'
	    1.27 times faster than 'git diff --diff-algorithm=3Dpatience v2.0.0 v2=
.28.0'
	    1.41 times faster than 'git diff --diff-algorithm=3Dhistogram v2.0.0 v=
2.28.0'

Now, all of those are very slow overall, but some much more than
others. I seem to recall that the non-default ones also had some
pathological cases.

Another thing to think about is that we've so far considered the diff
algorithm to be purely about presentation, with some notable exceptions
such as "patch-id".

I've advocated for us getting to the point of having an in-repo
.gitconfig or .gitattributes before with a whitelist of settings like
diff.context for certain paths, or a diff.orderFile.

But those seem easy to promise future behavior for, v.s. an entire diff
algorithm (which we of course had before, but now we'd have it in
repository data).

Maybe that's not a distinction worth worrying about, just putting that
out there.

I think if others are concerned about the above something that would
neatly side-step those is to have it opt-in via the .git/config somehow,
similar to e.g. how you can commit *.gpg content, put this in
.gitattributes:

	*.gpg diff=3Dgpg

But not have it do anything until this is in the repo's .git/config (or
similar):

	[diff "gpg"]
        	textconv =3D gpg --no-tty --decrypt

For that you could still keep the exact .gitattributes format you have
here, i.e.:

	file* diff-algorithm=3D$STRATEGY

But we to pick it up we'd need either:

	[diff-algorithm]
        	histogram =3D myers

Or:

	[diff-algorithm "histogram"]
        	allow =3D true

The former form being one that would allow you to map the .gitattributes
of the repo (but maybe that would be redundant to
.git/info/attributes)...
