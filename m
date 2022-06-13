Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C48C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiFMWjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiFMWjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:11 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C042715
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso3845093wmc.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iZl/w6xD/PlRBxS9ZFzfgYeC1tgrjeMcaUxkQEdV0c=;
        b=OLpl9I9pXaPXogrjJ815O7x0B4rb8TDex+irSxwBlvIKaWF1k3DOflvw/CR2sBev7W
         OhQEK1wgrwX0Vxa5Rw9qRvm+T7styDf8vvS7IOizr6pObQ4bZkpMegpVrf9wZsHQnueV
         bEf3mSR6OctSr3K8FDogkF2AgwKDP/fmIRjkk2fvBf0+rIibOLiZ1JSeYOdcGjJT69+g
         aoU3In1OhBryqHXVVWnUYNru5HyHNAmiLOCj5Xqiux/QA66W9g0Q9IyDnMhmkevyV56P
         PeY3dzFLJ2kfUHO+NzS+85tluffYREtnqwoHuf36QKjTHDZvM6Dl8okQwzMsN75dKbKC
         ckpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iZl/w6xD/PlRBxS9ZFzfgYeC1tgrjeMcaUxkQEdV0c=;
        b=gwnagPDINyedbsmgoHOtGm+U3UZGGIBaXabfvG8VMUNvgttfcJDmQ2YRKtleb1U+XW
         20NKrPbaVpq0fyHCrhXDdbD+ZbLlBfj6D+YKa4SqY7wLJIsdsSIiuvnwk0mQi5GiTiEd
         V3DZXuslqUURxIoZtmRCLVSvsZMuzYJjvonOX/X2XsJ7S+CHlo5cK9tzbNkNxougyXUA
         y6UjzfTWpOmTMIHc85Q8WByTQVPV42k2C7Qk6f+xzhhVACFEKtDvYKC8m6bzgZsydt+L
         5M73A+HGmwUTmyNErRer9BK2uBY2IK1931CHGX7PopVZwMvFOSnS00Jwk9p+L6TFZlPr
         OkTw==
X-Gm-Message-State: AOAM530q27Rs9a3+aq4Cy7upyZ8q397Ac9jvmdDj3x2ABFATpKVGJh6y
        ZyaXTCpNeKRX2chI8hZ3lzDWxo6kLkq6og==
X-Google-Smtp-Source: ABdhPJzpC9ieYrMSn72sSxSzkYNfskO3HVARD2WL/SVg+FPOGVhuy5jHMzRVkBFM03H3+1Zpm693lw==
X-Received: by 2002:a7b:c456:0:b0:39c:5d1e:661d with SMTP id l22-20020a7bc456000000b0039c5d1e661dmr911590wmi.15.1655159948823;
        Mon, 13 Jun 2022 15:39:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/12] git-submodule.sh: remove unused $prefix var and --super-prefix
Date:   Tue, 14 Jun 2022 00:38:53 +0200
Message-Id: <patch-v2-02.12-e127803d59d-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the $prefix variable which isn't used anymore, and hasn't been
since b3c5f5cb048 (submodule: move core cmd_update() logic to C,
2022-03-15).

Before that we'd use it to invoke "git submodule--helper" with the
"--recursive-prefix" option, but since b3c5f5cb048 that "git
submodule--helper" option is only used when it invokes itself.

Since we haven't used it since then we haven't been passing the
--super-prefix option to "git submodule--helper", and can therefore
remove the handling of it from builtin/submodule--helper.c as well.

Note also that the still-existing code in builtin/submodule--helper.c
to invoke other "git submodule--helper" processes with
"--super-prefix" is not passing the option to
"cmd_submodule__helper()", rather it's an argument to "git" itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 53 +++++++++++++++----------------------
 git-submodule.sh            |  6 ++---
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5c77dfcffee..9d3642290f3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3364,35 +3364,32 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define SUPPORT_SUPER_PREFIX (1<<0)
-
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
-	unsigned option;
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list, 0},
-	{"name", module_name, 0},
-	{"clone", module_clone, 0},
-	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update", module_update, 0},
-	{"resolve-relative-url-test", resolve_relative_url_test, 0},
-	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-	{"init", module_init, SUPPORT_SUPER_PREFIX},
-	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
-	{"deinit", module_deinit, 0},
-	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-	{"push-check", push_check, 0},
-	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"is-active", is_active, 0},
-	{"check-name", check_name, 0},
-	{"config", module_config, 0},
-	{"set-url", module_set_url, 0},
-	{"set-branch", module_set_branch, 0},
-	{"create-branch", module_create_branch, 0},
+	{"list", module_list},
+	{"name", module_name},
+	{"clone", module_clone},
+	{"add", module_add},
+	{"update", module_update},
+	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"foreach", module_foreach},
+	{"init", module_init},
+	{"status", module_status},
+	{"sync", module_sync},
+	{"deinit", module_deinit},
+	{"summary", module_summary},
+	{"push-check", push_check},
+	{"absorb-git-dirs", absorb_git_dirs},
+	{"is-active", is_active},
+	{"check-name", check_name},
+	{"config", module_config},
+	{"set-url", module_set_url},
+	{"set-branch", module_set_branch},
+	{"create-branch", module_create_branch},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
@@ -3401,15 +3398,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage("git submodule--helper <command>");
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (!strcmp(argv[1], commands[i].cmd)) {
-			if (get_super_prefix() &&
-			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
-				die(_("%s doesn't support --super-prefix"),
-				    commands[i].cmd);
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (!strcmp(argv[1], commands[i].cmd))
 			return commands[i].fn(argc - 1, argv + 1, prefix);
-		}
-	}
 
 	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
diff --git a/git-submodule.sh b/git-submodule.sh
index bc436c4ca47..53847bbf6e2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -41,7 +41,6 @@ files=
 remote=
 nofetch=
 update=
-prefix=
 custom_name=
 depth=
 progress=
@@ -127,7 +126,7 @@ cmd_add()
 		usage
 	fi
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper add ${GIT_QUIET:+--quiet} ${force:+--force} ${progress:+"--progress"} ${branch:+--branch "$branch"} ${reference_path:+--reference "$reference_path"} ${dissociate:+--dissociate} ${custom_name:+--name "$custom_name"} ${depth:+"$depth"} -- "$@"
 }
 
 #
@@ -189,7 +188,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -346,7 +345,6 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
-- 
2.36.1.1239.gfba91521d90

