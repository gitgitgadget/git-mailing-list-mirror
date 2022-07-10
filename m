Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D41EC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 16:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGJQ2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGJQ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 12:28:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB863BF6D
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:28:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz17so5167576ejc.9
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kDrzZeJ3hGjevtYMGV2cu1qcV5c9KNe/5Qj1NhX12eg=;
        b=PVZfvLZ6HavDXph5k2G7U8aP4cQRxIaDsBj9NUJ61RQ0ViEtlM55acoFQ1Sv9Ae38t
         L8xKvm+q0WSuJJ+jOZhV/eRYHjluq5WMlJEXiJpg5YfvCqEj/SJw3lH8cb0Dajzyvtzd
         5wmp9HMOwzKWc59CxJiStQAD7GaB6lvUbj9Ql1PZPx86HPsJ0CWsQOAlxBiYT2CNoRKE
         t88Ru9B7JweIXRzn+kTKtJP18UQo5iPSli4CpVw8Vm1Vr19qbkbi2KtCdjyRtpjC7t/C
         oneIOE6BfydVT5+6VZP4j2SQQMxSX4rwzG5DL2hWLt0c1xHOopnoVKvpfa5WDlOmNWXk
         Zd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kDrzZeJ3hGjevtYMGV2cu1qcV5c9KNe/5Qj1NhX12eg=;
        b=qGxKxV47LBjct8D+J6CJHXZY20wm4vIG5lBeqQbjDeuGQDA66ekEYjF8yeEAdhZiVy
         AJDCJkzSjXsTkeYRKEgMGpEFtBUdSQ6LqF9WDb/1QvLrT5QR1qdXLesMXguh3CaPJLqP
         C7hf/o9vVFIiJ2034y0A3wYj7AteDyfRur8d8yUAlhXJ0WCxtCF6kaQ5ytJsP+uqCGKs
         bwKUHmcQVXzBastk/ktNhcRPiqNyRuWLS0oSfIr6X9qogGob1JiIgqOFISLpt3oFOEie
         n16lROM7Sxsc0s5goPwdlUUqoqR4QVKBlvG3CP/wxJWDwoon/tyUi27G48lasYo0NGzq
         gK+Q==
X-Gm-Message-State: AJIora+RipuIEEtnTxnCGxhoWonQDJvv7BLKZnLNGSViv1Bv36JZcxgp
        xLidbuyji3KLJ4ipbfi0tMgZlN39+hA=
X-Google-Smtp-Source: AGRyM1u9ya0nfinR1K9K1FY2XbPfWmrztyWEaV9062EkD4SOH9qjS7l2OckkR0wvJckLelgAI07APA==
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id sa38-20020a1709076d2600b0072b3a72a117mr7362467ejc.280.1657470500164;
        Sun, 10 Jul 2022 09:28:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906311a00b0070e238ff66fsm1704798ejx.96.2022.07.10.09.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 09:28:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAZn8-000E0Z-JW;
        Sun, 10 Jul 2022 18:28:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] multi-pack-index: simplify handling of unknown --options
Date:   Sun, 10 Jul 2022 18:26:13 +0200
References: <20220708202847.662319-1-szeder.dev@gmail.com>
 <xmqqh73ruxc8.fsf@gitster.g> <20220710151645.GA2038@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220710151645.GA2038@szeder.dev>
Message-ID: <220710.86edyt7x0d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 10 2022, SZEDER G=C3=A1bor wrote:

> On Fri, Jul 08, 2022 at 02:08:07PM -0700, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>> > Although parse_options() can handle unknown --options just fine, none
>> > of 'git multi-pack-index's subcommands rely on it, but do it on their
>> > own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
>> > then check whether there are any unparsed arguments left, and print
>> > usage and quit if necessary.
>>=20
>> The existing code check if there are any unparsed arguments or
>> options.=20=20
>>=20
>> Omitting PARSE_OPT_KEEP_UNKNOWN allows parse_options() to deal with
>> unknown options by complaining, but it happily leaves non-options on
>> the command line and reports how many of them there are.
>>=20
>> Doesn't this patch make
>>=20
>> 	$ git multi-pack-index write what-is-this-extra-arg-doing-here
>>=20
>> silently ignore the extra argument instead of barfing on it?
>>=20
>> > Let parse_options() handle unknown options instead, which, besides
>> > simpler code, has the additional benefit that it prints not only the
>> > usage but an "error: unknown option `foo'" message as well.
>>=20
>> Yes, I agree that getting rid of KEEP_UNKNOWN is a very good idea
>> for this reason.  But I suspect that we still need the "did we get
>> an extra argument we do not know what to do with?" check.
>
> Uh, indeed.  I got too trigger-happy with deleting lines.
> Updated patch below.
>
>   ---  >8  ---
>
> Subject: multi-pack-index: simplify handling of unknown --options
>
> Although parse_options() can handle unknown --options just fine, none
> of 'git multi-pack-index's subcommands rely on it, but do it on their
> own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
> then check whether there are any unparsed arguments left, and print
> usage and quit if necessary.
>
> Drop that PARSE_OPT_KEEP_UNKNOWN flag to let parse_options() handle
> unknown options instead, which has the additional benefit that it
> prints not only the usage but an "error: unknown option `foo'" message
> as well.
>
> Do leave the unparsed arguments check to catch any unexpected
> non-option arguments, though, e.g. 'git multi-pack-index write foo'.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/multi-pack-index.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5edbb7fe86..8f24d59a75 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -134,7 +134,7 @@ static int cmd_multi_pack_index_write(int argc, const=
 char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_write_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> +			     0);
>  	if (argc)
>  		usage_with_options(builtin_multi_pack_index_write_usage,
>  				   options);
> @@ -176,7 +176,7 @@ static int cmd_multi_pack_index_verify(int argc, cons=
t char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_verify_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> +			     0);
>  	if (argc)
>  		usage_with_options(builtin_multi_pack_index_verify_usage,
>  				   options);
> @@ -202,7 +202,7 @@ static int cmd_multi_pack_index_expire(int argc, cons=
t char **argv)
>  		opts.flags |=3D MIDX_PROGRESS;
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options, builtin_multi_pack_index_expire_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> +			     0);
>  	if (argc)
>  		usage_with_options(builtin_multi_pack_index_expire_usage,
>  				   options);
> @@ -232,7 +232,7 @@ static int cmd_multi_pack_index_repack(int argc, cons=
t char **argv)
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options,
>  			     builtin_multi_pack_index_repack_usage,
> -			     PARSE_OPT_KEEP_UNKNOWN);
> +			     0);
>  	if (argc)
>  		usage_with_options(builtin_multi_pack_index_repack_usage,
>  				   options);

Looks good, FWIW I've had this in my local tree for a long time (been
meaning to submit it), which manages to delete the "argc" handling for
this & others.

But I think just doing this is good for now (multi-pack-index isn't in
the diff below, but I did it in another commit):
https://github.com/avar/git/commit/17b838ddd5a):

diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index ede7dc32a43..e866057ebcc 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -126,9 +126,8 @@ int cmd_checkout__worker(int argc, const char **argv, c=
onst char *prefix)
=20
 	git_config(git_default_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, checkout_worker_options,
-			     checkout_worker_usage, 0);
-	if (argc > 0)
-		usage_with_options(checkout_worker_usage, checkout_worker_options);
+			     checkout_worker_usage,
+			     PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	if (state.base_dir)
 		state.base_dir_len =3D strlen(state.base_dir);
diff --git a/builtin/column.c b/builtin/column.c
index 158fdf53d9f..a22b4532301 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -43,9 +43,8 @@ int cmd_column(int argc, const char **argv, const char *p=
refix)
=20
 	memset(&copts, 0, sizeof(copts));
 	copts.padding =3D 1;
-	argc =3D parse_options(argc, argv, prefix, options, builtin_column_usage,=
 0);
-	if (argc)
-		usage_with_options(builtin_column_usage, options);
+	parse_options(argc, argv, prefix, options, builtin_column_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
 	if (real_command || command) {
 		if (!real_command || !command || strcmp(real_command, command))
 			die(_("--command must be the first argument"));
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51c4040ea6c..b92774c7fd3 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -80,11 +80,9 @@ static int graph_verify(int argc, const char **argv)
 	trace2_cmd_mode("verify");
=20
 	opts.progress =3D isatty(2);
-	argc =3D parse_options(argc, argv, NULL,
-			     options,
-			     builtin_commit_graph_verify_usage, 0);
-	if (argc)
-		usage_with_options(builtin_commit_graph_verify_usage, options);
+	parse_options(argc, argv, NULL, options,
+		      builtin_commit_graph_verify_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	if (!opts.obj_dir)
 		opts.obj_dir =3D get_object_directory();
@@ -241,11 +239,9 @@ static int graph_write(int argc, const char **argv)
=20
 	git_config(git_commit_graph_write_config, &opts);
=20
-	argc =3D parse_options(argc, argv, NULL,
-			     options,
-			     builtin_commit_graph_write_usage, 0);
-	if (argc)
-		usage_with_options(builtin_commit_graph_write_usage, options);
+	parse_options(argc, argv, NULL, options,
+		      builtin_commit_graph_write_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
 		die(_("use at most one of --reachable, --stdin-commits, or --stdin-packs=
"));
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 07b94195962..4a7452f4b9f 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -103,10 +103,8 @@ int cmd_count_objects(int argc, const char **argv, con=
st char *prefix)
=20
 	git_config(git_default_config, NULL);
=20
-	argc =3D parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
-	/* we do not take arguments other than flags for now */
-	if (argc)
-		usage_with_options(count_objects_usage, opts);
+	parse_options(argc, argv, prefix, opts, count_objects_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
 	if (verbose) {
 		report_garbage =3D real_report_garbage;
 		report_linked_checkout_garbage();
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index f1a8290cba7..df6b210127b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -37,9 +37,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const =
char *prefix)
=20
 	git_config(fmt_merge_msg_config, NULL);
 	argc =3D parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
-			     0);
-	if (argc > 0)
-		usage_with_options(fmt_merge_msg_usage, options);
+			     PARSE_OPT_ERROR_AT_NON_OPTION);
 	if (shortlog_len < 0)
 		shortlog_len =3D (merge_log_config > 0) ? merge_log_config : 0;
=20
diff --git a/builtin/gc.c b/builtin/gc.c
index 021e9256ae2..d3201d8781f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -587,9 +587,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 		pack_refs =3D !is_bare_repository();
=20
 	argc =3D parse_options(argc, argv, prefix, builtin_gc_options,
-			     builtin_gc_usage, 0);
-	if (argc > 0)
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+			     builtin_gc_usage, PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), prune_expire);
@@ -2491,10 +2489,9 @@ static int maintenance_start(int argc, const char **=
argv, const char *prefix)
 		OPT_END()
 	};
=20
-	argc =3D parse_options(argc, argv, prefix, options,
-			     builtin_maintenance_start_usage, 0);
-	if (argc)
-		usage_with_options(builtin_maintenance_start_usage, options);
+	parse_options(argc, argv, prefix, options,
+		      builtin_maintenance_start_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	opts.scheduler =3D resolve_scheduler(opts.scheduler);
 	validate_scheduler(opts.scheduler);
diff --git a/builtin/notes.c b/builtin/notes.c
index a3d0d15a227..35329411f50 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -958,13 +958,8 @@ static int prune(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_END()
 	};
=20
-	argc =3D parse_options(argc, argv, prefix, options, git_notes_prune_usage,
-			     0);
-
-	if (argc) {
-		error(_("too many arguments"));
-		usage_with_options(git_notes_prune_usage, options);
-	}
+	parse_options(argc, argv, prefix, options, git_notes_prune_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	t =3D init_notes_check("prune", NOTES_INIT_WRITABLE);
=20
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 1e34cf2bebd..39708db8b1b 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -42,9 +42,8 @@ int cmd_stripspace(int argc, const char **argv, const cha=
r *prefix)
 		OPT_END()
 	};
=20
-	argc =3D parse_options(argc, argv, prefix, options, stripspace_usage, 0);
-	if (argc)
-		usage_with_options(stripspace_usage, options);
+	parse_options(argc, argv, prefix, options, stripspace_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	if (mode =3D=3D STRIP_COMMENTS || mode =3D=3D COMMENT_LINES) {
 		setup_git_directory_gently(&nongit);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index cd62eef240e..29803379006 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -153,9 +153,8 @@ static int prune(int ac, const char **av, const char *p=
refix)
 	};
=20
 	expire =3D TIME_MAX;
-	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (ac)
-		usage_with_options(worktree_usage, options);
+	parse_options(ac, av, prefix, options, worktree_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
 	prune_worktrees();
 	return 0;
 }
@@ -772,10 +771,9 @@ static int list(int ac, const char **av, const char *p=
refix)
 	};
=20
 	expire =3D TIME_MAX;
-	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
-	if (ac)
-		usage_with_options(worktree_usage, options);
-	else if (verbose && porcelain)
+	parse_options(ac, av, prefix, options, worktree_usage,
+		      PARSE_OPT_ERROR_AT_NON_OPTION);
+	if (verbose && porcelain)
 		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--=
porcelain");
 	else if (!line_terminator && !porcelain)
 		die(_("the option '%s' requires '%s'"), "-z", "--porcelain");
diff --git a/imap-send.c b/imap-send.c
index a50af56b827..f7c4efa3759 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1526,10 +1526,8 @@ int cmd_main(int argc, const char **argv)
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
=20
-	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
-
-	if (argc)
-		usage_with_options(imap_send_usage, imap_send_options);
+	parse_options(argc, (const char **)argv, "", imap_send_options,
+		      imap_send_usage, PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 #ifndef USE_CURL_FOR_IMAP_SEND
 	if (use_curl) {
diff --git a/parse-options.c b/parse-options.c
index 60477156720..368875bb32d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -631,6 +631,8 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->out   =3D argv;
 	ctx->prefix =3D prefix;
 	ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
+	if (flags & PARSE_OPT_ERROR_AT_NON_OPTION)
+		flags |=3D PARSE_OPT_STOP_AT_NON_OPTION;
 	ctx->flags =3D flags;
 	parse_options_alter_flags(ctx);
 	parse_options_check_flags(options, ctx->flags);
@@ -894,6 +896,11 @@ int parse_options(int argc, const char **argv,
 	case PARSE_OPT_COMPLETE:
 		exit(0);
 	case PARSE_OPT_NON_OPTION:
+		if (flags & PARSE_OPT_ERROR_AT_NON_OPTION) {
+			error(_("unknown non-option: `%s'"), ctx.argv[0]);
+			usage_with_options(usagestr, options);
+		}
+		break;
 	case PARSE_OPT_DONE:
 		break;
 	case PARSE_OPT_UNKNOWN:
diff --git a/parse-options.h b/parse-options.h
index 460afb93256..013e539d6cc 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -34,6 +34,7 @@ enum parse_opt_flags {
 	PARSE_OPT_SHELL_EVAL =3D 1 << 6,
 	PARSE_OPT_REV_PARSE_PARSEOPT =3D 1 << 7,
 	PARSE_OPT_INTERNAL_HELP_ON_ONE_ARG =3D 1 << 8,
+	PARSE_OPT_ERROR_AT_NON_OPTION =3D 1 << 9,
 };
=20
 /**
diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
index d680038a780..b96bdc72c1e 100644
--- a/t/helper/test-getcwd.c
+++ b/t/helper/test-getcwd.c
@@ -14,9 +14,8 @@ int cmd__getcwd(int argc, const char **argv)
 	};
 	char *cwd;
=20
-	argc =3D parse_options(argc, argv, "test-tools", options, getcwd_usage, 0=
);
-	if (argc > 0)
-		usage_with_options(getcwd_usage, options);
+	argc =3D parse_options(argc, argv, "test-tools", options, getcwd_usage,
+			     PARSE_OPT_ERROR_AT_NON_OPTION);
=20
 	cwd =3D xgetcwd();
 	puts(cwd);
