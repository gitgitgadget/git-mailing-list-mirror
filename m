Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12AC28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353092AbiHSQdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353168AbiHSQa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036011CF33
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kb8so9649789ejc.4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bgK/lYD6M/Z8kE+tQYYNuVKJ9a1E7wvnkMFR+uXGYE0=;
        b=XJsU4LyN1MSWz79XJeKzBYOx7tngb1uY+7JLzHMnXgLxrjvRaQdc+/J4zN+uimuaZX
         VMZWW06UVlqBcoZaNBFLlV8zKiO6MMtIq6Q5LLtbZlYjfPzWDToCyj0yDQw3FOzxZJHU
         7QpGKwwRABBC8CnLAqgfkTDH5CfPJH3vcJkO/J5JddDm5pgZByhZAOZpimUde9I0kS7t
         gPVg0RfGHjWlRSyuOCBhveR2gd9cx7eSFntBC+frvo32ESe6mDH1dKrMy0yzDGqG0f3/
         If6TsQQ/czm+/BQK9ohogEwqBiGtGLZO/amMPALAKCriRW+gQjwDjkY9T+ORnw+yW5bj
         5iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bgK/lYD6M/Z8kE+tQYYNuVKJ9a1E7wvnkMFR+uXGYE0=;
        b=XsBIwqTwTA9WnQRB4908MZn8MaIH0dU3aSKp57cglvoIDD+yktoyP4PdwhqJxH2yXs
         qMFBZkZFQMEBBdzk40GUphbcXsBbu7+yKqAXZ73sSS1u1q/7O1BInFadmrhXi1huTCyb
         Nw+xtP0GZ20jMKRjF19XHs1MkR8EDtssJB9RYVnlNulEsdLDCGgUau8cTEFow6jWguRU
         B6166FmTnuqJXkgj+f21PljvPQtCi5lze4j1p1S+8aZAaAm+tTz+M1dnpNPIRL6hya/z
         C/AHAcW2YF2CYf0ct355rkET6uM1QpOo186Nm21iphe3cih/l6b1CEdrcgf4v/MnjyWM
         Fpqg==
X-Gm-Message-State: ACgBeo3GGI4s6sxbkKWM3TACudVOi6gEGzyWUrPAA5SAExGhVkcDjXhx
        c+uyjqLdF8I9pmsSt0v7+GJNeG6gTjc=
X-Google-Smtp-Source: AA6agR576hlMRuQdHUD2o7ngjgOOzxoLUZTU2xOl1wjh50uIeGRLyrybo6GsjEv/AVEvOSzGKh/Obw==
X-Received: by 2002:a17:906:8a57:b0:730:8b50:610a with SMTP id gx23-20020a1709068a5700b007308b50610amr5262018ejc.557.1660925098469;
        Fri, 19 Aug 2022 09:04:58 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id og43-20020a1709071deb00b00732e3d94f4fsm2467864ejc.124.2022.08.19.09.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 14/20] builtin/multi-pack-index.c: let parse-options parse subcommands
Date:   Fri, 19 Aug 2022 18:04:05 +0200
Message-Id: <20220819160411.1791200-15-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220819160411.1791200-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220819160411.1791200-1-szeder.dev@gmail.com>
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
2.37.2.817.g36f84ce71d

