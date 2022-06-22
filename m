Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF79CCA481
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 14:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357709AbiFVO31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354824AbiFVO2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 10:28:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7972119035
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so23691475wra.5
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyfIIyL3XrHg12RHH66E4HSozZJt85Rb2NaemzSl8v4=;
        b=OjzW8wpFNG4bb16yhVfVek8GICzizt5K4jVsGpuPqYYd+Hy4fybJCciex9Zucu213d
         yE41QHr/GKgbdNKMwyJosrtK0bgXlO81I2pa2rG6l+Q67JwBim6HPF63f4Jr3XQGCGb8
         Bcjw++/SdN0lXYl/v5as7FmvjLFMiWQINUAR2qQFczKPM9j8XLQE+OUg3ia5cCdLw9ym
         2B/FvLd0eoHsWa9eiIlLvfhTovst3v6MEJ34aW/I303YCaG20Ny8G1Y5TMV+3ULQyU0/
         YBdToVu890EcIyXVNDIz6rTX31+8SOCHib+SWJTL6QvWU2nYwEpGIRKwKrE+JpMI/Yke
         XF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyfIIyL3XrHg12RHH66E4HSozZJt85Rb2NaemzSl8v4=;
        b=1fsBad6zeiaA/KdSOpZLjXcwRNDnIBZPH17crSd/ESKB7/evfImHAWscwTV1MFzlJB
         aeklkDysOSSfbN8Jy23ebb+kW9nlZAPJGzX6jdIsFQlivjVNmUU9rNzFLbWwhTEAdxUw
         Z1GHd7A61saBjUrYeEjNQ9jJ6cyVOGnUcut9V/DHgnuUwYeireMcVQhkZLm2vUebIxQz
         HJUeD+++CEFlR1FPmL7ipV86lvl/eAEc+uRpGlVzjaqqB3TFN3AZrNXE8/8BPoJSYHqc
         xt9+FmjzWrU5gI52t2BJ9ld8QaI6U1P/tKwyUpjqq+I+PVWdR0Dx//GVHl4aWYXXEt+a
         I0nQ==
X-Gm-Message-State: AJIora+0K3Mns/atkLWZ+U6lYvlgePH8YWT96SZm7nAVrvqOm/EEn+Eb
        80JgUzOt6J51/EE9CjfvkM2YXh+MdBCHTg==
X-Google-Smtp-Source: AGRyM1ufdOaOfnNLVL5kxNAhTo+THFyMmMcrYjJmIusXpArloDMYYQLSCAzVGMRU2Ehqo4P41cjscg==
X-Received: by 2002:adf:f7cd:0:b0:21b:a237:6973 with SMTP id a13-20020adff7cd000000b0021ba2376973mr2585343wrq.295.1655908092396;
        Wed, 22 Jun 2022 07:28:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm30468304wmq.41.2022.06.22.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:28:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/12] git-submodule.sh: remove unused $prefix var and --super-prefix
Date:   Wed, 22 Jun 2022 16:27:57 +0200
Message-Id: <patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
References: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com>
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

One way to verify that this is indeed dead code is to try to check out
b3c5f5cb048^ and apply this change to a part of the code being removed
here:

	-#define SUPPORT_SUPER_PREFIX (1<<0)
	+#define SUPPORT_SUPER_PREFIX 0

Doing that will cause t7406-submodule-update.sh to fail with errors
such as:

	-Submodule path '../super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'
	+Submodule path 'super': checked out 'e1c658656b91df52a4634fbffeaa739807ce3521'

I.e. the removal of the --super-prefix handling broke those cases, but
when doing the same ad-hoc test with b3c5f5cb048 all of our tests will
pass, since the "--super-prefix" will now be handled by earlier by
"git" itself.

So this is just one of the things that were overly complex in "git
submodule--helper", because parts of it had to bridge the gap between
*.sh and *.c land, but once we moved more parts to C we ended up
getting that for free.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 53 +++++++++++++++----------------------
 git-submodule.sh            |  6 ++---
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c597df7528e..03181c5ca50 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3365,35 +3365,32 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
@@ -3402,15 +3399,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
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

