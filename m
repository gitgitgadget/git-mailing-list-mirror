Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D880C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiGYMjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiGYMjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008391B79C
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p5so2769368edi.12
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIvSQ3+qH/sZ9UnBWexFem5tqF+ZrumG3GQvD0gLo64=;
        b=gA2URr70lA65Pz25jXN9vC+SstOhfZX41koJgzRqgy4mzvbSpHDOEJiD0TQLhT/Ep4
         dltl6egNHabJm9N6iqwCET6UdQzk5oiGOkMszf1COP62ZuYnBjVQ1BSEKVvg2wDqFhHB
         QtzUUAaGeWEgWLmoTksHQMEN3ukUkCHaNjd3YqjebkvAM/wiWMlgkN7PmXngImwye5gQ
         bQqiIxJUyi6LT7VBwJauZ9T3/jZGU0BobVJgE8JthH5j5dAut4IB1sbaKXF5vMmMvgQx
         asbldXDyVMM9IvYZfxzUHmU1KHPD0Y02oOAl+aQ8dyKspxfH9mNRWVvsMOcwnB2LI3iz
         5chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIvSQ3+qH/sZ9UnBWexFem5tqF+ZrumG3GQvD0gLo64=;
        b=igCWj1yw66Ch8DJHLqbGnojOlUYrhMqj68gpS2SigprB7602i98+Qh7L4haw5CJwH0
         eUsNBUXQe6N/cwk0QPN6mFqedWjIA11ZZpMmxhDxAw475ir6xViDDeVdKe5wa77KDrNF
         FAYr4bSSuW8UkonFtBLw6dZ72KTguaHnVIN1fWccM5mqfd97sQEtqYodfuOeFf183N+I
         dIsen3v0TZpCBslsnzQNnOnnKJmYn61HUi+nVJcDZ8qTDYNC+XqZXTXB/864P1B3CItx
         yMwp33D61HNt8h6YB9Lu0X3RuvVctVrqKSFWMtPetM5baHb5IhmR1bYkxjCt+e//B2wE
         T5kQ==
X-Gm-Message-State: AJIora/z6ptJfdLeAzZJSlpFxsSu+vFg3BQmJe0j9PrD4IEEXlwlz7QF
        ogpqEAD4XcTSQmRA47UXnxC5ADzqzPc=
X-Google-Smtp-Source: AGRyM1s5uL7tJC29eHp8rmSJZuaTX0vg02rBVt/mLCEfOPzJNfTBNNqbrWsMbJtC3BK3y5mMQDSGDA==
X-Received: by 2002:a05:6402:1766:b0:43b:cb78:5c4d with SMTP id da6-20020a056402176600b0043bcb785c4dmr13191099edb.354.1658752765215;
        Mon, 25 Jul 2022 05:39:25 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0043bcd24fffbsm5851960edr.25.2022.07.25.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 14/20] builtin/multi-pack-index.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:51 +0200
Message-Id: <20220725123857.2773963-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git multi-pack-index' parses its subcommands with a couple of if-else
if statements.  parse-options has just learned to parse subcommands,
so let's use that facility instead, with the benefits of shorter code,
handling missing or unknown subcommands, and listing subcommands for
Bash completion.

Note that the functions implementing each subcommand only accept the
'argc' and '**argv' parameters, so add a (unused) '*prefix' parameter
to make them match the type expected by parse-options, and thus avoid
casting function pointers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/multi-pack-index.c | 51 ++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8f24d59a75..b8320d597b 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -104,7 +104,8 @@ static void read_packs_from_stdin(struct string_list *to)
 	strbuf_release(&buf);
 }
 
-static int cmd_multi_pack_index_write(int argc, const char **argv)
+static int cmd_multi_pack_index_write(int argc, const char **argv,
+				      const char *prefix)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_write_options[] = {
@@ -160,7 +161,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 			       opts.refs_snapshot, opts.flags);
 }
 
-static int cmd_multi_pack_index_verify(int argc, const char **argv)
+static int cmd_multi_pack_index_verify(int argc, const char **argv,
+				       const char *prefix)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
@@ -186,7 +188,8 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 	return verify_midx_file(the_repository, opts.object_dir, opts.flags);
 }
 
-static int cmd_multi_pack_index_expire(int argc, const char **argv)
+static int cmd_multi_pack_index_expire(int argc, const char **argv,
+				       const char *prefix)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
@@ -212,7 +215,8 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 	return expire_midx_packs(the_repository, opts.object_dir, opts.flags);
 }
 
-static int cmd_multi_pack_index_repack(int argc, const char **argv)
+static int cmd_multi_pack_index_repack(int argc, const char **argv,
+				       const char *prefix)
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_repack_options[] = {
@@ -247,7 +251,15 @@ int cmd_multi_pack_index(int argc, const char **argv,
 			 const char *prefix)
 {
 	int res;
-	struct option *builtin_multi_pack_index_options = common_opts;
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option builtin_multi_pack_index_options[] = {
+		OPT_SUBCOMMAND("repack", &fn, cmd_multi_pack_index_repack),
+		OPT_SUBCOMMAND("write", &fn, cmd_multi_pack_index_write),
+		OPT_SUBCOMMAND("verify", &fn, cmd_multi_pack_index_verify),
+		OPT_SUBCOMMAND("expire", &fn, cmd_multi_pack_index_expire),
+		OPT_END(),
+	};
+	struct option *options = parse_options_concat(builtin_multi_pack_index_options, common_opts);
 
 	git_config(git_default_config, NULL);
 
@@ -256,31 +268,12 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	    the_repository->objects->odb)
 		opts.object_dir = xstrdup(the_repository->objects->odb->path);
 
-	argc = parse_options(argc, argv, prefix,
-			     builtin_multi_pack_index_options,
-			     builtin_multi_pack_index_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
-
-	if (!argc)
-		goto usage;
-
-	if (!strcmp(argv[0], "repack"))
-		res = cmd_multi_pack_index_repack(argc, argv);
-	else if (!strcmp(argv[0], "write"))
-		res =  cmd_multi_pack_index_write(argc, argv);
-	else if (!strcmp(argv[0], "verify"))
-		res =  cmd_multi_pack_index_verify(argc, argv);
-	else if (!strcmp(argv[0], "expire"))
-		res =  cmd_multi_pack_index_expire(argc, argv);
-	else {
-		error(_("unrecognized subcommand: %s"), argv[0]);
-		goto usage;
-	}
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_multi_pack_index_usage, 0);
+	FREE_AND_NULL(options);
+
+	res = fn(argc, argv, prefix);
 
 	free(opts.object_dir);
 	return res;
-
-usage:
-	usage_with_options(builtin_multi_pack_index_usage,
-			   builtin_multi_pack_index_options);
 }
-- 
2.37.1.633.g6a0fa73e39

