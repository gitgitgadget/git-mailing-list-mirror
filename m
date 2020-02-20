Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B1FC11D0C
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B8E208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIvq1cuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgBTU2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:28:13 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40455 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbgBTU2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 15:28:13 -0500
Received: by mail-lf1-f66.google.com with SMTP id c23so4154089lfi.7
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 12:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=s1Kgpc9k0Zq69EQpqpxbIfOBIbBUerrnY4/L+njW2u0=;
        b=WIvq1cuM63bmY1QczPrp/20iaxaqxYvmVEti0wFCFUlT+RTNkJJEJUo0ZYgGryUOCV
         EcvHpFD4isyh4yy7KOupYizXPZ/wwIoeOakY/B1/QW2cKCuTa5tw8mpySyBjGz9yYzf/
         zoZakxNMGO30QjFSKaV24WFpkmabaJi17FJUfJQFlpgfzsXTX57bLJhT7Hb04z7rXuUR
         dH2QDgJSz1+WmvzMokv4EmjeWVjUzPwmyfwHvqFbkQz0n16OKZiJ5g6rUCEBlCmvF4WX
         uXRGRVD7dM7bTR3hOaO9mLfx8rnoxQIdVQHPiFdqiGvS/ViaKPC9MasGETm6tXc1ajfl
         UG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=s1Kgpc9k0Zq69EQpqpxbIfOBIbBUerrnY4/L+njW2u0=;
        b=riDBlqSKyGQuUtg6Dppa+yi+HHdlvi5M2kyXF7UexPUcRmGu9XefxPj9V2vuPVuNrS
         DgsvZHr6j2sRhPBrTwCRK0UVZj2iCq33Kb+tAkjptxC0F8aXfTr6Z7ZMox8EaAKTiu/w
         B1r2ichv0dupNQDhLlKCNvyJzZ+tucj61O+giqqv+jde6U+X2Ny5EmMU+t2UiWwCaDRT
         2uv3YyvymhJdJDG6TTLSlDy5QG9MV5LQMcXRpIRWdAF+r6pGty2S+mV29gCbjXZnC9wp
         9PFof9qi5ENYFwqhb56dtmisAxDVbam6B0gad6HDyL/vQEo6PFsanvJAPr35xm6uYbkP
         kWaw==
X-Gm-Message-State: APjAAAVvfrOHb+suWVtDiU3c29qi41Qc9SmrSprSO+bfzd7PE6Bl0jbu
        2G6xkIfJg0hzDns/bvP29kA=
X-Google-Smtp-Source: APXvYqyhgNEMB6MM0FhTv//N9fQNo5vuR37M/eEhPmAmXOtnbvqFxNqyl3vTrSkRa9I9Tn+EjV7m5g==
X-Received: by 2002:ac2:44bc:: with SMTP id c28mr17136528lfm.72.1582230490459;
        Thu, 20 Feb 2020 12:28:10 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u9sm287080lji.49.2020.02.20.12.28.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 12:28:09 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Garima Singh <garimasigit@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 09/11] commit-graph: add --changed-paths option to write subcommand
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
Date:   Thu, 20 Feb 2020 21:28:06 +0100
In-Reply-To: <3d7ee0c96955dc15c87d04982d8cdec8b62750b2.1580943390.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Wed, 05 Feb 2020 22:56:28
        +0000")
Message-ID: <86y2sxdmw9.fsf@gmail.com>
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
> Add --changed-paths option to git commit-graph write. This option will
> allow users to compute information about the paths that have changed
> between a commit and its first parent, and write it into the commit graph
> file. If the option is passed to the write subcommand we set the
> COMMIT_GRAPH_WRITE_BLOOM_FILTERS flag and pass it down to the
> commit-graph logic.

In the manpage you write that this operation (computing Bloom filters)
can take a while on large repositories.  Could you perhaps provide some
numbers: how much longer does it take to write commit-graph file with
and without '--changed-paths' for example for Linux kernel, or some
other large repository?  Thanks in advance.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 5 +++++
>  builtin/commit-graph.c             | 9 +++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

What is missing is some sanity tests: that bloom index and bloom data
chunks are not present without '--changed-paths', and that they are
added with '--changed-paths'.

If possible, maybe also check in a separate test that the size of
bloom_index chunk agrees with the number of commits in the commit graph.


Also, we can now add those tests I have wrote about in my review of
previous patch, that is:

1. If you write commit-graph with --changed-paths, and either add some
   commits later or exclude some commits from the commit graph, then:

   a.) commit(s) in commit-graph have Bloom filter
   b.) commit(s) not in commit-graph do not have Bloom filter

2. If you write commit-graph without --changed-paths as base layer,
   and then write next layer with --changed-paths and --split, then:

   a.) commit(s) in top layer have Bloom filter(s)
   b.) commit(s) in bottom layer don't have Bloom filter(s)

>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commi=
t-graph.txt
> index bcd85c1976..907d703b30 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> +With the `--changed-paths` option, compute and write information about t=
he
> +paths changed between a commit and it's first parent. This operation can
> +take a while on large repositories. It provides significant performance =
gains
> +for getting history of a directory or a file with `git log -- <path>`.
> ++

Should we write about limitation that the topmost layer in the split
commit graph needs to be written with '--changed-paths' for Git to use
this information?  Or perhaps we should try (in the future) to remove
this limitation??

>  With the `--split` option, write the commit-graph as a chain of multiple
>  commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
>  not already in the commit-graph are added in a new "tip" file. This file
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index e0c6fc4bbf..261dcce091 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -9,7 +9,7 @@
>=20=20
>  static char const * const builtin_commit_graph_usage[] =3D {
>  	N_("git commit-graph verify [--object-dir <objdir>] [--shallow] [--[no-=
]progress]"),
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [=
--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options=
>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [=
--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progre=
ss] <split options>"),
>  	NULL
>  };
>=20=20
> @@ -19,7 +19,7 @@ static const char * const builtin_commit_graph_verify_u=
sage[] =3D {
>  };
>=20=20
>  static const char * const builtin_commit_graph_write_usage[] =3D {
> -	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [=
--reachable|--stdin-packs|--stdin-commits] [--[no-]progress] <split options=
>"),
> +	N_("git commit-graph write [--object-dir <objdir>] [--append|--split] [=
--reachable|--stdin-packs|--stdin-commits] [--changed-paths] [--[no-]progre=
ss] <split options>"),
>  	NULL
>  };
>

All right.

> @@ -32,6 +32,7 @@ static struct opts_commit_graph {
>  	int split;
>  	int shallow;
>  	int progress;
> +	int enable_changed_paths;

Bikeshed painting: should this field be called enable_changed_paths or
simply changed_paths?

>  } opts;
>=20=20
>  static int graph_verify(int argc, const char **argv)
> @@ -110,6 +111,8 @@ static int graph_write(int argc, const char **argv)
>  			N_("start walk at commits listed by stdin")),
>  		OPT_BOOL(0, "append", &opts.append,
>  			N_("include all commits already in the commit-graph file")),
> +		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
> +			N_("enable computation for changed paths")),
>  		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")=
),
>  		OPT_BOOL(0, "split", &opts.split,
>  			N_("allow writing an incremental commit-graph file")),

All right.

> @@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
>  		flags |=3D COMMIT_GRAPH_WRITE_SPLIT;
>  	if (opts.progress)
>  		flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
> +	if (opts.enable_changed_paths)
> +		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>=20=20
>  	read_replace_refs =3D 0;

All right.  This actually turns on calculation Bloom filters for changed
paths, thanks to

 	ctx->changed_paths =3D flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;

that was added by the "[PATCH v2 04/11] commit-graph: compute Bloom
filters for changed paths" patch.

Though... should this enabling be split into two separate patches like
this?


Best,
--=20
Jakub Nar=C4=99bski
