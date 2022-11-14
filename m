Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B0C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbiKNKKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKNKJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:09:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD4E1EC4D
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so26954153eja.11
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlPodlUPTyNfIApQ/zpQ4+JoZYHQrZgskygTzl4s/Lg=;
        b=pChWh+xF+oUM0uo+oGVm9tHtkTcpN7mglLLtoc9QyIC7U7fpva39n1WugF5xKbuymB
         zfwOcyfDY7L3BMqzMuUNjmUBLbysBMSsVnkDe1fzTx7Ixu/XYXzcVYFy73je3WFzWnSn
         42ra8yCoMm/NPlSoSRNgScw6h90Wd0CAefaUYgFWZxv39pms3O9QUd2F6vn9vYFWrpKd
         AUU4oOxU46hkP2ebiUD8hRfbeqxNCPFtAaZnY8h3NPno82DwoLy3Z9oJ3lo79itrhuHk
         /85fUIZsoBa5t5bctyIpHh0/X+bQQHN1Lt3g78kAKP75nWKWERIIvFpKBj5R5caakMuR
         n+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlPodlUPTyNfIApQ/zpQ4+JoZYHQrZgskygTzl4s/Lg=;
        b=N6T4wM+ewefciF/4bPkwQbZxFhNysNPt2MTF/PnYt+96YYroBC9DzCe2DdEdQsem3/
         AGJWYjolAr6injI1C3ttXSCt8qz9YTS5/7vYa7NWBGuF2ZJ207gtjMydlOL5J/7D1yDU
         AVN0DticTp6OkeEGQ9ABWFxoyilPHYcXMqrBQ4YZBwj7+xqN3Qz4w+MYHNT9DFo4YiLR
         1BU/9rht5pEtXrqEZtBflJAxpCuVuC5NkCMrv5KrRNhusoJY1QhOcA7kgRJjuCyPlvjE
         658Dy4piy0hCgdq3PMuI42W8d0zMIQoE3UndTEimb4J2GMUB77ortBMVNj2kngqix0Iv
         g4cA==
X-Gm-Message-State: ANoB5pnuhH2VpihbaCZ6xugOeXRH1t5l3bUjNkFQFlYn2pk0BNZ2dvLd
        znddMpsezPWo2wvRlxeveh74lDI4FLxmoQ==
X-Google-Smtp-Source: AA0mqf6xenar2YJo+k+Z6DcpSFCoR4wKb2AsQjYzSBCxq8cOUKn6J+M2/rJQExF729sGM7NWpYvyGA==
X-Received: by 2002:a17:907:a683:b0:78c:3042:6919 with SMTP id vv3-20020a170907a68300b0078c30426919mr9091568ejc.377.1668420544795;
        Mon, 14 Nov 2022 02:09:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:09:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] fetch: rename "--submodule-prefix" to "--super-prefix"
Date:   Mon, 14 Nov 2022 11:08:50 +0100
Message-Id: <patch-v2-10.10-100ba36dfb7-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preceding commits we've introduced a command-level "--super-prefix"
option, which unlike the "git --super-prefix" it replaced doesn't rely
on setenv() or getenv(), it's just a normal command-line option that
the command passes down.

Since we've done that, let's rename the "--submodule-prefix" option
added in 7dce19d374a (fetch/pull: Add the --recurse-submodules option,
2010-11-12) to "--super-prefix" for consistency. This:

 * Allows us to use OPT__SUPER_PREFIX().
 * Leaves an unspecified "--super-prefix" with a "NULL" value, rather
   than an empty string, as is the case with the other "--super-prefix"
   users. We coerce the NULL to "" in submodule.c before using it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/fetch-options.txt |  5 -----
 builtin/fetch.c                 |  7 +++----
 submodule.c                     | 23 +++++++++++------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 622bd84768b..20cbd2c2910 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -241,11 +241,6 @@ endif::git-pull[]
 	linkgit:git-config[1].
 
 ifndef::git-pull[]
---submodule-prefix=<path>::
-	Prepend <path> to paths printed in informative messages
-	such as "Fetching submodule foo".  This option is used
-	internally when recursing over submodules.
-
 --recurse-submodules-default=[yes|on-demand]::
 	This option is used internally to temporarily provide a
 	non-negative default value for the --recurse-submodules
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7378cafeec9..353bcd36d24 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -74,7 +74,7 @@ static struct string_list deepen_not = STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-static const char *submodule_prefix = "";
+static const char *super_prefix;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
@@ -195,8 +195,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_SET_INT_F(0, "refetch", &refetch,
 		      N_("re-fetch without negotiating common commits"),
 		      1, PARSE_OPT_NONEG),
-	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
-		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
+	OPT__SUPER_PREFIX(&super_prefix),
 	OPT_CALLBACK_F(0, "recurse-submodules-default",
 		   &recurse_submodules_default, N_("on-demand"),
 		   N_("default for recursive fetching of submodules "
@@ -2300,7 +2299,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		add_options_to_argv(&options);
 		result = fetch_submodules(the_repository,
 					  &options,
-					  submodule_prefix,
+					  super_prefix,
 					  recurse_submodules,
 					  recurse_submodules_default,
 					  verbosity < 0,
diff --git a/submodule.c b/submodule.c
index 5ac4e1b0568..1e4eee3492b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1376,7 +1376,7 @@ struct submodule_parallel_fetch {
 	int changed_count;
 	struct strvec args;
 	struct repository *r;
-	const char *prefix;
+	const char *super_prefix;
 	int command_line_option;
 	int default_option;
 	int quiet;
@@ -1567,7 +1567,7 @@ get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
 		if (task->repo) {
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
-					    spf->prefix, ce->name);
+					    spf->super_prefix, ce->name);
 
 			spf->index_count++;
 			return task;
@@ -1629,7 +1629,7 @@ get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
 		if (!spf->quiet)
 			strbuf_addf(err,
 				    _("Fetching submodule %s%s at commit %s\n"),
-				    spf->prefix, task->sub->path,
+				    spf->super_prefix, task->sub->path,
 				    find_unique_abbrev(cs_data->super_oid,
 						       DEFAULT_ABBREV));
 
@@ -1687,11 +1687,10 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 			strvec_pushv(&cp->args, task->git_args.v);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, task->default_argv);
-		strvec_push(&cp->args, "--submodule-prefix");
+		strvec_push(&cp->args, "--super-prefix");
 
-		strbuf_addf(&submodule_prefix, "%s%s/",
-						spf->prefix,
-						task->sub->path);
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->super_prefix,
+			    task->sub->path);
 		strvec_push(&cp->args, submodule_prefix.buf);
 		*task_cb = task;
 
@@ -1707,7 +1706,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		spf->oid_fetch_tasks_nr--;
 
 		strbuf_addf(&submodule_prefix, "%s%s/",
-			    spf->prefix, task->sub->path);
+			    spf->super_prefix, task->sub->path);
 
 		child_process_init(cp);
 		prepare_submodule_repo_env_in_gitdir(&cp->env);
@@ -1717,7 +1716,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		strvec_init(&cp->args);
 		strvec_pushv(&cp->args, spf->args.v);
 		strvec_push(&cp->args, "on-demand");
-		strvec_push(&cp->args, "--submodule-prefix");
+		strvec_push(&cp->args, "--super-prefix");
 		strvec_push(&cp->args, submodule_prefix.buf);
 
 		/* NEEDSWORK: have get_default_remote from submodule--helper */
@@ -1813,7 +1812,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 
 int fetch_submodules(struct repository *r,
 		     const struct strvec *options,
-		     const char *prefix, int command_line_option,
+		     const char *super_prefix, int command_line_option,
 		     int default_option,
 		     int quiet, int max_parallel_jobs)
 {
@@ -1835,7 +1834,7 @@ int fetch_submodules(struct repository *r,
 	spf.command_line_option = command_line_option;
 	spf.default_option = default_option;
 	spf.quiet = quiet;
-	spf.prefix = prefix;
+	spf.super_prefix = super_prefix ? super_prefix : "";
 
 	if (!r->worktree)
 		goto out;
@@ -1847,7 +1846,7 @@ int fetch_submodules(struct repository *r,
 	for (i = 0; i < options->nr; i++)
 		strvec_push(&spf.args, options->v[i]);
 	strvec_push(&spf.args, "--recurse-submodules-default");
-	/* default value, "--submodule-prefix" and its value are added later */
+	/* default value, "--super-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths(r, &spf.changed_submodule_names);
 	string_list_sort(&spf.changed_submodule_names);
-- 
2.38.0.1471.ge4d8947e7aa

