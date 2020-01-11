Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2160CC282DD
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD3D2082E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqqTeZ2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgAKT4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 14:56:11 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35089 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730982AbgAKT4L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 14:56:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so4050943lfr.2
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=yQ71+MRwII/oi4sRz1IodMXOiy23nE756uKyNC+NZD4=;
        b=eqqTeZ2XH3gqhMik/ac64jK+MXxUrXra3eY5DZwH4T7cYWx6xszHNJz/Po2vnEUYO7
         ya5svhCgBBDP800kgN+m88L4iPucgX5pnQJBsRAthmOSJd6rDiOH4nb6eIDQIRxM3x0t
         htEnebl8dr6ev47tKVR5hZEpqG4K93p0jbJPzpAmRHoeFzc0WIC73DbeGqcQ5n3r9xsW
         ZvqyD/VSAyXHIIF7u8zU7DRqJJvi24FHsV49g7njXKJ4F39PBxvFPUiKETkaB1Zb5RHm
         +jyyTYsk+CSprzkYEcwIG242Thzad0nrQCYMMM2L435tVi2HzUWgmZquWVUfhAkvNmz2
         VgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=yQ71+MRwII/oi4sRz1IodMXOiy23nE756uKyNC+NZD4=;
        b=pfY5o8c8fjZWAJr0JUVx17lSNG8YWlPhQjaW2Bjd/YKw+WkclTb5s8sEyOOPnoRYym
         OK33j8GP9j0Aq3QVr7SaJ6EhQ1+4aMvPZaaI2/9s1rT66mO80vVKB56S13ZC2t5Ecf4J
         aJKsLqKw3cU4+xzHfW0Q+PI+UU6+qmBPCOHIMaBEIj9xOj7lXDlkzgn+i9YD8gO2tIsj
         XhAvtULFlYPT3BKVNQ+yhvseTe2LJ/h79jm5448t2FQsIbCXDNFTJy48+uwPAGhbY1RK
         jll5h6haSFr/vO03967CVtoSd77TqkwnXE/RPFLlhD2abu7lzMYmdwa1Z7uiL+GfvMeB
         Ib6Q==
X-Gm-Message-State: APjAAAV7a9D3Q7WVOtY5znZ+i2BX+dSxn4OsS5XxKTJFmYiBlQCyi00k
        02Xta0+dPaTodALawwi4/0M=
X-Google-Smtp-Source: APXvYqxRfffIMbpx3LCjmt9T6yZuBQoX1z00mtOsYAuYnNeIZ5ADLNHCAQaiw4B0dB/nDYXdfa3r2A==
X-Received: by 2002:ac2:4476:: with SMTP id y22mr5983704lfl.169.1578772568419;
        Sat, 11 Jan 2020 11:56:08 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id f11sm3670256lfa.9.2020.01.11.11.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jan 2020 11:56:07 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 9/9] commit-graph: add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <e1c315d0a766af147eb4ead41a172f724e90cc34.1576879520.git.gitgitgadget@gmail.com>
Date:   Sat, 11 Jan 2020 20:56:02 +0100
In-Reply-To: <e1c315d0a766af147eb4ead41a172f724e90cc34.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:20
        +0000")
Message-ID: <86v9phrcml.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Garima Singh <garima.singh@microsoft.com>
>
> Add GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS test flag to the test setup suite=
 in
> order to toggle writing bloom filters when running any of the git tests. =
If set
> to true, we will compute and write bloom filters every time a test calls
> `git commit-graph write`.

OK, so it works in addition to GIT_TEST_COMMIT_GRAPH.

>
> The test suite passes when GIT_TEST_COMMIT_GRAPH and
> GIT_COMMIT_GRAPH_BLOOM_FILTERS are enabled.

Good.  Very good.

No errors found by Continuous Integration setup either?

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  builtin/commit-graph.c        | 2 +-
>  ci/run-build-and-tests.sh     | 1 +
>  commit-graph.h                | 1 +
>  t/README                      | 3 +++
>  t/t4216-log-bloom.sh          | 3 +++
>  t/t5318-commit-graph.sh       | 2 ++
>  t/t5324-split-commit-graph.sh | 1 +
>  t/t5325-commit-graph-bloom.sh | 3 +++
>  8 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 9bd1e11161..97167959b2 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -146,7 +146,7 @@ static int graph_write(int argc, const char **argv)
>  		flags |=3D COMMIT_GRAPH_WRITE_SPLIT;
>  	if (opts.progress)
>  		flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
> -	if (opts.enable_bloom_filters)
> +	if (opts.enable_bloom_filters || git_env_bool(GIT_TEST_COMMIT_GRAPH_BLO=
OM_FILTERS, 0))
>  		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>

Very minor nitpick: not to make this line long, I would break it at the
boolean operator, that is write

  -	if (opts.enable_bloom_filters)
  +	if (opts.enable_bloom_filters ||
  +	    git_env_bool(GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS, 0))=20=20
   		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;

I agree that this is a good place to put this check, by pretending that
`--changed-paths` option was given on command line.  Looks good.

>  	read_replace_refs =3D 0;
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e..19d0846d34 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -19,6 +19,7 @@ linux-gcc)
>  	export GIT_TEST_OE_SIZE=3D10
>  	export GIT_TEST_OE_DELTA_SIZE=3D5
>  	export GIT_TEST_COMMIT_GRAPH=3D1
> +	export GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D1
>  	export GIT_TEST_MULTI_PACK_INDEX=3D1
>  	make test
>  	;;

All right, adding this to CI would certainly exercise this feature.

> diff --git a/commit-graph.h b/commit-graph.h
> index 2202ad91ae..d914e6abf1 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,7 @@
>=20=20
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_=
LOAD"
> +#define GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS "GIT_TEST_COMMIT_GRAPH_BLOOM=
_FILTERS"
>

All right (the ordering is a mater of taste).

>  struct commit;
>  struct bloom_filter_settings;
> diff --git a/t/README b/t/README
> index caa125ba9a..399b190437 100644
> --- a/t/README
> +++ b/t/README
> @@ -378,6 +378,9 @@ GIT_TEST_COMMIT_GRAPH=3D<boolean>, when true, forces =
the commit-graph to
>  be written after every 'git commit' command, and overrides the
>  'core.commitGraph' setting to true.
>=20=20
> +GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D<boolean>, when true, forces commi=
t-graph
> +write to compute and write bloom filters for every 'git commit-graph wri=
te'
> +

Thanks for documenting this.

Missing full stop '.' at the end of the sentence.  (Minor nit).

We might want to add ", as if '--changed-paths' option was given.", but
it is not strictly necessary.

>  GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all exercises the fsmonitor
>  code path for utilizing a file system monitor to speed up detecting
>  new or changed files.
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index d42f077998..0e092b387c 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -3,6 +3,9 @@
>  test_description=3D'git log for a path with bloom filters'
>  . ./test-lib.sh
>=20=20
> +GIT_TEST_COMMIT_GRAPH=3D0
> +GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D0
> +

OK, neither of those setting increase the coverage for this test.

On the other hand they won't make tests fail (or at least they
shouldn't, I think).  The t5318-commit-graph.sh doesn't include=20
GIT_TEST_COMMIT_GRAPH=3D0, after all.

>  test_expect_success 'setup repo' '
>  	git init &&
>  	git config core.commitGraph true &&
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 3f03de6018..613228bb12 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -3,6 +3,8 @@
>  test_description=3D'commit graph'
>  . ./test-lib.sh
>=20=20
> +GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D0
> +

All right, adding Bloom filters to commit-graph file would make test
cases utilizing graph_read_expect() fail.

>  test_expect_success 'setup full repo' '
>  	mkdir full &&
>  	cd "$TRASH_DIRECTORY/full" &&
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index c24823431f..181ca7e0cb 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -4,6 +4,7 @@ test_description=3D'split commit graph'
>  . ./test-lib.sh
>=20=20
>  GIT_TEST_COMMIT_GRAPH=3D0
> +GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D0

All right, same here: adding Bloom filters to commit-graph would make
test cases utilizing graph_read_expect() fail.

Sidenote: Here without GIT_TEST_COMMIT_GRAPH=3D0 tests that rely on
precise timing of writing commit-graph to create split commit-graph
would fail.

>=20=20
>  test_expect_success 'setup repo' '
>  	git init &&
> diff --git a/t/t5325-commit-graph-bloom.sh b/t/t5325-commit-graph-bloom.sh
> index d7ef0e7fb3..a9c9e9fef6 100755
> --- a/t/t5325-commit-graph-bloom.sh
> +++ b/t/t5325-commit-graph-bloom.sh
> @@ -3,6 +3,9 @@
>  test_description=3D'commit graph with bloom filters'
>  . ./test-lib.sh
>=20=20
> +GIT_TEST_COMMIT_GRAPH=3D0
> +GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS=3D0
> +

This test also includes some split commit-graph test cases, so the above
is necessary.

All right.

>  test_expect_success 'setup repo' '
>  	git init &&
>  	git config core.commitGraph true &&

Best,
--=20
Jakub Nar=C4=99bski
