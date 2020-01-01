Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A93C2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA87207E0
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 20:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQKVwksf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgAAUUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 15:20:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41466 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgAAUUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 15:20:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so38940912ljc.8
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UgN3AgMFNGXJvOEv0UM9eqR1UZbOPArICGRxsk4x6jw=;
        b=hQKVwksfHAePea+alX3EkbiYw5uL4RqAGRiX6KVQUm85zd0wDY5TYjSPr8hj0IY/oN
         SGa2rDKiYtE5sTDr3GW6waVVjYDdDMMq8K/quU04ulpC79+4Y0Sz+pJYyI64KzJmn9nS
         ib/x3XZYt33kQoLasPeuZ5CwkwGzY9jKJhutUjv9+3m/XZbJhZRukg8dJFE3LEbLev5X
         qyE1R6C+hcT2kUb2ML4dnmCCaamRVDq9pTx0910bw8hdMc9JRMTIsx2ryzJXY4rLg9qH
         ++QKnVX+zKFzGA13UMGxRcB3nEiMf2IZmQkFNpL5WexkGvrvfIyAQbOt74GDJ0CFdRgV
         v9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=UgN3AgMFNGXJvOEv0UM9eqR1UZbOPArICGRxsk4x6jw=;
        b=AfqHXmdJCo2SdAfQAQXqDHl0e7xbLPc8ALr7hx6H+ABCDlsq+Iy4ayNbiZRU+FKK1s
         4YjOEFbMdPe0qEQWXfCJymxBVJck6ji+p+Rzx1Bo2kCSjLfnr0KHbKYwwfmw4E2dt704
         Emcq3QKKI1UkWvbBpun/tkrKuXNl56Pws58yYVuCv/Net8r9qD9YrYe4SPZ3X5aANh2F
         8tmnv0LvRhaDnp/W13YGaBuJDcbTQiImNbAVhoVymfR9GfalliMDPYAk24wZkfTqEmmM
         5m0uYEDFBpQ7jr1nIM1GmHQmxnJ+LQyCskPgXMNkZmUTkscjXkCYtMYhDUnWmTBeTHhO
         lccg==
X-Gm-Message-State: APjAAAWdgiCFmFzKWbxriLM1c7QHxG/A50nFsZnyzMliBPkRj9ahTRvw
        iD1Jycd38Y2tW1/XsSkBYqc=
X-Google-Smtp-Source: APXvYqy4DSr+2RekL7h8l4/5pQ4Z5h4/lvnTtoJRht9yx9I9XY3B/2mcrcTbhma3XNF/grDkGaBIrg==
X-Received: by 2002:a2e:810d:: with SMTP id d13mr46757903ljg.113.1577910028236;
        Wed, 01 Jan 2020 12:20:28 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i4sm25573936lji.0.2020.01.01.12.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 12:20:27 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, szeder.dev@gmail.com,
        jonathantanmy@google.com, jeffhost@microsoft.com, me@ttaylorr.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH 1/9] commit-graph: add --changed-paths option to write
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <6bdde5e4f0ceb54546978e3e9cdde00045d45468.1576879520.git.gitgitgadget@gmail.com>
Date:   Wed, 01 Jan 2020 21:20:24 +0100
In-Reply-To: <6bdde5e4f0ceb54546978e3e9cdde00045d45468.1576879520.git.gitgitgadget@gmail.com>
        (Garima Singh via GitGitGadget's message of "Fri, 20 Dec 2019 22:05:12
        +0000")
Message-ID: <86tv5f2ak7.fsf@gmail.com>
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
> soon allow users to compute bloom filters for the paths changed between
> a commit and its first significant parent, and write this information
> into the commit-graph file.

A slightly nitpicky comment.

First, I think it is "Bloom filter", not "bloom filter" (from the name
of the person that discovered them, Burton Howard Bloom).

Second, I would rather that the commit message started with at least one
sentence of describing purpose of this new option, not going straight to
the technical details (i.e. using Bloom filters).  Or in any other way
describe that this option would make Git store some helper data that
would help find out faster if a given path was changed in given commit.

> Note: This commit does not change any behavior. It only introduces
> the option and passes down the appropriate flag to the commit-graph.

All right.

Personally, I don't have strong opinion for or against separating this
change into its own patch.

> RFC Notes:
> 1. We named the option --changed-paths to capture what the option does,
>    instead of how it does it. The current implementation does this
>    using bloom filters. We believe using --changed-paths however keeps
>    the implementation open to other data structures.
>    All thoughts and suggestions for the name and this approach are
>    welcome

It is all right name.  Another option could be for example
`git commit-graph write --changeset-info`, or something like that.

>
> 2. Currently, a subsequent commit in this series will add tests that
>    exercise this option. I plan to split that test commit across the
>    series as appropriate.

There is another thing, but one that could be left for the followup
series, namely the configuration variables for this behavior.  In the
future it should be possible to switch some configuration variable to
have this feature on by default when manually or automatically running
`git commit-graph write`.

>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 5 +++++
>  builtin/commit-graph.c             | 9 +++++++--
>  commit-graph.h                     | 3 ++-
>  3 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commi=
t-graph.txt
> index bcd85c1976..1efe6e5c5a 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt

It is nice to have option documented.

All right, the 'write' subcommand has the following synopsis:

  'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]

so the is no need to adjust it when adding a new option.

> @@ -54,6 +54,11 @@ or `--stdin-packs`.)
>  With the `--append` option, include all commits that are present in the
>  existing commit-graph file.
>  +
> +With the `--changed-paths` option, compute and write information about t=
he
> +paths changed between a commit and it's first parent. This operation can
> +take a while on large repositories. It provides significant performance =
gains
> +for getting file based history logs with `git log`
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This might be not entirely clear for someone that is not familiar with
Git jargon.  Perhaps it would better read as "for getting history of a
directory or a file with `git log <path>`", or something like that.

Side note: the sentence is missing its finishing full stop.

> ++
>  With the `--split` option, write the commit-graph as a chain of multiple
>  commit-graph files stored in `<dir>/info/commit-graphs`. The new commits
>  not already in the commit-graph are added in a new "tip" file. This file
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index e0c6fc4bbf..9bd1e11161 100644
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

I was at first wondering why the duplication (not caused by your patch,
though), and then realized that it is to have usage for command, and for
individual subcommands, separately.

> @@ -32,6 +32,7 @@ static struct opts_commit_graph {
>  	int split;
>  	int shallow;
>  	int progress;
> +	int enable_bloom_filters;

Why the field is called `enable_bloom_filters`, while option is called
`--changed-paths`?  I know it is not user-visible thing, so it would be
easy to change if we ever go beyond Bloom filters, though...

So I am not against keeping it as it is currently.

>  } opts;
>=20=20
>  static int graph_verify(int argc, const char **argv)
> @@ -110,6 +111,8 @@ static int graph_write(int argc, const char **argv)
>  			N_("start walk at commits listed by stdin")),
>  		OPT_BOOL(0, "append", &opts.append,
>  			N_("include all commits already in the commit-graph file")),
> +		OPT_BOOL(0, "changed-paths", &opts.enable_bloom_filters,
> +			N_("enable computation for changed paths")),
>  		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")=
),
>  		OPT_BOOL(0, "split", &opts.split,
>  			N_("allow writing an incremental commit-graph file")),
> @@ -143,6 +146,8 @@ static int graph_write(int argc, const char **argv)
>  		flags |=3D COMMIT_GRAPH_WRITE_SPLIT;
>  	if (opts.progress)
>  		flags |=3D COMMIT_GRAPH_WRITE_PROGRESS;
> +	if (opts.enable_bloom_filters)
> +		flags |=3D COMMIT_GRAPH_WRITE_BLOOM_FILTERS;

Minor nitpick: are we all right having this ordering of options (not for
example having opt.progress last)?

Disregarding this, it looks all right.

>=20=20
>  	read_replace_refs =3D 0;
>=20=20
> diff --git a/commit-graph.h b/commit-graph.h
> index 7f5c933fa2..952a4b83be 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -76,7 +76,8 @@ enum commit_graph_write_flags {
>  	COMMIT_GRAPH_WRITE_PROGRESS   =3D (1 << 1),
>  	COMMIT_GRAPH_WRITE_SPLIT      =3D (1 << 2),
>  	/* Make sure that each OID in the input is a valid commit OID. */
> -	COMMIT_GRAPH_WRITE_CHECK_OIDS =3D (1 << 3)
> +	COMMIT_GRAPH_WRITE_CHECK_OIDS =3D (1 << 3),
> +	COMMIT_GRAPH_WRITE_BLOOM_FILTERS =3D (1 << 4)

I wonder if we should add comment describing the flag, like for the one
above...

>  };
>=20=20
>  struct split_commit_graph_opts {

Best,
--=20
Jakub Nar=C4=99bski
