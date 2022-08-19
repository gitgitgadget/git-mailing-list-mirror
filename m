Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1888C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349988AbiHSSH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349991AbiHSSHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:07:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A92871C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:55:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d5so2588615wms.5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=SBAZD3RZm1sreU845yvrDs7pLfBaNT/GZPF0iOaYDmg=;
        b=ZGNEceoU3EvhznOUziqdmyGLVag3YQ46EH0jYP1lqjS3u+sode+hoVCmr93K4RC3ti
         AT4PQXcf/Dvqm3IWM/hmFSZ+Vk9l69mEjJ5YU66pbKANBcIFb9qHhq7yxmHfsL0GTiqV
         IyxLRWf6nP5XTXCckTMUiUaKouSX55eaCYfo2NGk4bhdWdfPEgKl73qI0McCLdAn8yud
         lMTyQp5d5m50LSFxPmHHAS0mt1Sc6/xEGCsV8QGC9uhmUArZZbRfkVeNeixSK1JfEBAh
         ghcFh+b2U2O1paQ+A/WIzWMfJds73PkpAf6l7SuauTbQPjc5bDjUJQnRhO2pzgdaao6p
         rMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=SBAZD3RZm1sreU845yvrDs7pLfBaNT/GZPF0iOaYDmg=;
        b=a9FbDlvf69r48WlL9YfUJhx+zK2ZSZ3BMY+jMVu7VmxTVuc/1HaWFTXGv3Kv4J4xB2
         c0sw9loBZt0HmudPmkubUiUR49wk4dYPrR7tnDq+v4Exn/EQs8LAN6DZKNz+QBSjrRIB
         ZVlYrnzDTB7MCleoeX4WWSm60oo8l/AX57Ev7Itw0CiF+cN9A1nN4BW3pJPThZlNR94B
         zco+Us1Bs4aH17RrToEKMqzTgTToj9R6mWG4HE7auplSzU5ioLL/Lh5sOGkZB+XztkoK
         nT6mNwOlF28vtKsRYPexHL5bdd0xQVpFlZiBoVg2RjcqPneDFBO3V5SJYMjA3ZtnMP7t
         fVPg==
X-Gm-Message-State: ACgBeo1k9aicWouODh6muSI593eQDZYAZyQ6MSvDL016B/VkFB8RGoFS
        9HWLIF0E9e0lqa2+NWU6RCI=
X-Google-Smtp-Source: AA6agR55AL9lrHpopjWUxPao4SCTrxsIylHqpgfNslRL/CANIdA6uSSTg3ULvYy0oAGMj2AF+9nAfw==
X-Received: by 2002:a7b:cc85:0:b0:3a5:50b2:f9be with SMTP id p5-20020a7bcc85000000b003a550b2f9bemr5328272wma.18.1660931714674;
        Fri, 19 Aug 2022 10:55:14 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021e43b4edf0sm4377029wrn.20.2022.08.19.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 10:55:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP6DB-000pnm-01;
        Fri, 19 Aug 2022 19:55:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/20] builtin/commit-graph.c: let parse-options
 parse subcommands
Date:   Fri, 19 Aug 2022 19:53:08 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
 <20220819160411.1791200-12-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220819160411.1791200-12-szeder.dev@gmail.com>
Message-ID: <220819.8635ds6run.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, SZEDER G=C3=A1bor wrote:

> 'git commit-graph' parses its subcommands with an if-else if
> statement.  parse-options has just learned to parse subcommands, so
> let's use that facility instead, with the benefits of shorter code,
> handling missing or unknown subcommands, and listing subcommands for
> Bash completion.
>
> Note that the functions implementing each subcommand only accept the
> 'argc' and '**argv' parameters, so add a (unused) '*prefix' parameter
> to make them match the type expected by parse-options, and thus avoid
> casting function pointers.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/commit-graph.c  | 30 +++++++++++++-----------------
>  t/t5318-commit-graph.sh |  4 ++--
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 51c4040ea6..1eb5492cbd 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -58,7 +58,7 @@ static struct option *add_common_options(struct option =
*to)
>  	return parse_options_concat(common_opts, to);
>  }
>=20=20
> -static int graph_verify(int argc, const char **argv)
> +static int graph_verify(int argc, const char **argv, const char *prefix)
>  {
>  	struct commit_graph *graph =3D NULL;
>  	struct object_directory *odb =3D NULL;
> @@ -190,7 +190,7 @@ static int git_commit_graph_write_config(const char *=
var, const char *value,
>  	return 0;
>  }
>=20=20
> -static int graph_write(int argc, const char **argv)
> +static int graph_write(int argc, const char **argv, const char *prefix)
>  {
>  	struct string_list pack_indexes =3D STRING_LIST_INIT_DUP;
>  	struct strbuf buf =3D STRBUF_INIT;
> @@ -307,26 +307,22 @@ static int graph_write(int argc, const char **argv)
>=20=20
>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  {
> -	struct option *builtin_commit_graph_options =3D common_opts;
> +	parse_opt_subcommand_fn *fn =3D NULL;
> +	struct option builtin_commit_graph_options[] =3D {
> +		OPT_SUBCOMMAND("verify", &fn, graph_verify),
> +		OPT_SUBCOMMAND("write", &fn, graph_write),
> +		OPT_END(),
> +	};
> +	struct option *options =3D parse_options_concat(builtin_commit_graph_op=
tions, common_opts);

This looks like it'll leak if...

>=20=20
>  	git_config(git_default_config, NULL);
> -	argc =3D parse_options(argc, argv, prefix,
> -			     builtin_commit_graph_options,
> -			     builtin_commit_graph_usage,
> -			     PARSE_OPT_STOP_AT_NON_OPTION);
> -	if (!argc)
> -		goto usage;

We take this goto..

> +	argc =3D parse_options(argc, argv, prefix, options,
> +			     builtin_commit_graph_usage, 0);
> +	FREE_AND_NULL(options);

Why FREE_AND_NULL() over free()?
>=20=20
> -	error(_("unrecognized subcommand: %s"), argv[0]);
> -usage:
> -	usage_with_options(builtin_commit_graph_usage,
> -			   builtin_commit_graph_options);
> +	return fn(argc, argv, prefix);

The leak seems easily solved, let's just do the free() at the end?
