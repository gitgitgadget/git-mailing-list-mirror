Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA16C35669
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CE02071E
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 00:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puX6T0K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBVALi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:11:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42428 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBVALi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 19:11:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id d10so3979633ljl.9
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 16:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CQfZ/TI8RwhskWqFJ0m86We8guLOJu21hyDoolxoKvs=;
        b=puX6T0K3nIEaC1jkPlLwwP0PvrJemK6L2nHIwqesi5hjjrf73kyKtBOUDUx5QDXLRG
         Mi5SqK2MjF8/Y77NAwlDtu2j7ZTzGHSEBoIrDuSRwkEIkZAzjaJIiYOfRjmI/wD0JsHu
         pvYd/BMNRxKZ9FCMmFGAdLzSgD8q3DGQn1jNpFGbKZZqaBqqZsIUH8T2Q9KhlOo4YMU8
         J7/zVHa9qG55cMMlDUVeDY5Jcq5EXc0NqV2+ym5XlwuL2O+o5V0l5yo480Z+FI+xKibD
         rYwEmHj4y7LL8Jbb2NB9A1ayrNqMgTnqzcsKDXTeQ5t1yVM9gkAYAAEWd/6szb+hZ/Oz
         m7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=CQfZ/TI8RwhskWqFJ0m86We8guLOJu21hyDoolxoKvs=;
        b=aB3ujSw8WfaW73kP/x2gxXQByzTKpbquNsUYwpHSxIFyUpJdZNksjeZoAK21iF2gwf
         /n0GwYQISbcGstKhSWzhhAi+TBvkk8uSrpFyXVQo1tbw9vQGxy+ujO+wQARq0uZMb2U9
         /UzSPl6/budNt/pdXNeBNshAImpw/OmfGMaevuzdYhPqC9RczuXWcpLaEbiepg15iyUM
         KGubVSUZ/gNz8uzRVm9ZJqefDXbNg+a9xA8z4/Ky9oAvTB9jRulnn9ghuNl+puCnGD08
         IW3Ys2iOyowUo1h+OKhjPcAujXNAdgbG1qTDipcA3UcdtOqpUKwKr2aBFi23tB9OP6dg
         02Hw==
X-Gm-Message-State: APjAAAUV60rje4/XBQMQA8txNDb9G5c6ch9IyAyd31H5WkhgD0E5HxoD
        +4+L6ySoyJn99Z/hBgqLRSg=
X-Google-Smtp-Source: APXvYqxauSrk38GXh5jfyjBkAtZ8nXMPGD6VNTZnM69EL82Z6fBOUh3XyKG4X5kJPsfjvmz0S0Ugyw==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr24567871ljm.58.1582330294011;
        Fri, 21 Feb 2020 16:11:34 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id x29sm2720899lfg.45.2020.02.21.16.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 16:11:33 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, garimasigit@gmail.com, christian.couder@gmail.com,
        emilyshaffer@gmail.com, gitster@pobox.com,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 11/11] commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <e1b076a714d611e59d3d71c89221e41a3427fae4.1580943390.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 01:11:30 +0100
In-Reply-To: <e1b076a714d611e59d3d71c89221e41a3427fae4.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:30
        +0000")
Message-ID: <86lfovbhvx.fsf@gmail.com>
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
> Add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag to the test setup suite
> in order to toggle writing Bloom filters when running any of the git test=
s.
> If set to true, we will compute and write Bloom filters every time a test
> calls `git commit-graph write`, as if the `--changed-paths` option was
> passed in.
>
> The test suite passes when GIT_TEST_COMMIT_GRAPH and
> GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS are enabled.

All right.  Nice.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  builtin/commit-graph.c        | 3 ++-
>  ci/run-build-and-tests.sh     | 1 +
>  commit-graph.h                | 1 +
>  t/README                      | 5 +++++
>  t/t4216-log-bloom.sh          | 3 +++
>  t/t5318-commit-graph.sh       | 2 ++
>  t/t5324-split-commit-graph.sh | 1 +
>  7 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 261dcce091..fc9b234ab0 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -146,7 +146,8 @@ static int graph_write(int argc, const char **argv)
>  		flags |=3D COMMIT_GRAPH_WRITE_SPLIT;
>  	if (opts.progress)
>  		flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
> -	if (opts.enable_changed_paths)
> +	if (opts.enable_changed_paths ||
> +	    git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
>  		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>

Looks good to me.

>  	read_replace_refs =3D 0;
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index ff0ef7f08e..7b4857651d 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -19,6 +19,7 @@ linux-gcc)
>  	export GIT_TEST_OE_SIZE=3D10
>  	export GIT_TEST_OE_DELTA_SIZE=3D5
>  	export GIT_TEST_COMMIT_GRAPH=3D1
> +	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D1
>  	export GIT_TEST_MULTI_PACK_INDEX=3D1
>  	make test
>  	;;

OK, include in continuous integration.

> diff --git a/commit-graph.h b/commit-graph.h
> index 25fefefb3e..4c202ff3d7 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,7 @@
>=20=20
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_=
LOAD"
> +#define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANG=
ED_PATHS"
>

Looks good to me.

>  struct commit;
>  struct bloom_filter_settings;
> diff --git a/t/README b/t/README
> index caa125ba9a..be2f7d7fd2 100644
> --- a/t/README
> +++ b/t/README
> @@ -378,6 +378,11 @@ GIT_TEST_COMMIT_GRAPH=3D<boolean>, when true, forces=
 the commit-graph to
>  be written after every 'git commit' command, and overrides the
>  'core.commitGraph' setting to true.
>=20=20
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D<boolean>, when true, forces
> +commit-graph write to compute and write changed path Bloom filters for
> +every 'git commit-graph write', as if the `--changed-paths` option was
> +passed in.
> +

Good, it is documented in README for tests.

>  GIT_TEST_FSMONITOR=3D$PWD/t7519/fsmonitor-all exercises the fsmonitor
>  code path for utilizing a file system monitor to speed up detecting
>  new or changed files.
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 19eca1864b..7acebb3962 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -3,6 +3,9 @@
>  test_description=3D'git log for a path with bloom filters'
>  . ./test-lib.sh
>=20=20
> +GIT_TEST_COMMIT_GRAPH=3D0
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
> +

All right, we need to ensure that 'git commit-graph write' is not run
automatically, otherwise split / incremental commit-graph tests would
not work.

We also need to ensure that '--changed-paths' is not added
automatically, so that we can test that commit-graph does not include
Bloom filters chunks if not requested.

>  test_expect_success 'setup test - repo, commits, commit graph, log outpu=
ts' '
>  	git init &&
>  	mkdir A A/B A/B/C &&
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 3f03de6018..973020be2d 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -3,6 +3,8 @@
>  test_description=3D'commit graph'
>  . ./test-lib.sh
>=20=20
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
> +

OK, otherwise it would screw up checking the content of commit-graph
with 'test-tool read-graph'.

>  test_expect_success 'setup full repo' '
>  	mkdir full &&
>  	cd "$TRASH_DIRECTORY/full" &&
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index c24823431f..9235db4561 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -4,6 +4,7 @@ test_description=3D'split commit graph'
>  . ./test-lib.sh
>=20=20
>  GIT_TEST_COMMIT_GRAPH=3D0
> +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D0
>=20=20
>  test_expect_success 'setup repo' '
>  	git init &&

Same here.

Looks good to me.
--=20
Jakub Nar=C4=99bski
