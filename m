Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430CC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 12:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiKSMmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 07:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbiKSMly (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 07:41:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C58DA78
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id gv23so19094287ejb.3
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 04:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3MzBb6i1dbRkOGAq3WpDodouuNlqx43saw6/vaxp/g=;
        b=XT87Hd8q8apReiC/wvESFq9V0ERP4sWwH9spGK1C47zshkoB0u05ZxvWNQfCVK8J44
         P4k3CQXxfpL/Or8SCt/cThSW1S4ayTO0o6rXYnGLKc9XpdyyOgsWFawGWMgmJQrvPgyu
         LLwMIhzhqou3ODrbWg/bNHLH8X2Aww+rVlBDE1zYBQ8+tBmN8UEHlAT8rVav+X1VyuOB
         HoP22KE7fQ13PEjvBaPXMHkfJZbN7LWdmNkIaoilA3ED9ZxSVbHo2aNqO9LlUwbdxcXW
         qKv+FZZiXG8aybRkowaVd5LONuYuTgCoSHBtC0x1NAZEmxtG3iHakeI2aTe1QcaZRv32
         WAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3MzBb6i1dbRkOGAq3WpDodouuNlqx43saw6/vaxp/g=;
        b=Od9BCZctwjbdVReG9aTT0CdlewKn9+VYaU9pnfc+c7kfhgyVBBypEwS08L1Lnw3Klk
         M/dDR3B7Izk8GqcWBHCzaOAJenXBo8eHChj1dVl5NvaGCdwuZ3VmrLaOKbyTqO66D+c1
         bsbXwDjTG44pKvDBTh2yKKw3flBaXKYi75RO8GMunyC2maPPkzsPgy0/7pxCnLpSzgX0
         aBR5d0HaxV0TudnmxHzUcuJEaGrLGEU44F4nsdNdmQbOUzerP5Az13LNOd59K8nzdVE8
         f6GXOwtMB3ZXf3DSdhSeGOU5881IQnr7TVant/xoPB8BHDLFrZKgCuR5r52MN4+JI2go
         fAdA==
X-Gm-Message-State: ANoB5pkNUuf3/H/hRqsHOO0+0ACNMQtxAE9ox5sDIgs55wCsM++SmVqq
        HtYTSt9zZcSX/3Jy8cBY0m4dUAzhjdalvg==
X-Google-Smtp-Source: AA0mqf6DXWYT6erKiKFY2HRVwnPHQ/X7cTMkzAADb3To2liLIeqnCJVUjwVtUEJVuXB7FACCpaVJWg==
X-Received: by 2002:a17:906:4cc1:b0:7ae:50c6:fd0a with SMTP id q1-20020a1709064cc100b007ae50c6fd0amr9137957ejt.184.1668861700187;
        Sat, 19 Nov 2022 04:41:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007b29eb8a4dbsm2909276ejc.13.2022.11.19.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 04:41:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] fetch: rename "--submodule-prefix" to "--super-prefix"
Date:   Sat, 19 Nov 2022 13:41:28 +0100
Message-Id: <patch-v3-9.9-1aa4019527a-20221119T122853Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1509.g9445af83948
In-Reply-To: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
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
index f8497793790..3e0aaaa2af0 100644
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
2.38.0.1509.g9445af83948

