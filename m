Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D052D20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfBYXRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38242 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728994AbfBYXRO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so561602wmh.3
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pQTfg+rW29M9jsnGSthBknimvtkfGbED28RIePMq+Y=;
        b=R1jxy/DEtCMyNHNZF5iO0GN1KayJVN7/UVjoJrDaQCdMsiRYORx69vDamde/EzTALX
         4mV+gOZeM33NlAEIRljQNt6cEfwyLzEkMHcXZ8ut+jwtIc65d1W74eXkDHGmOQISJMrB
         zauqjqBFHc8wYI6uvAjxAZRbcLmh4SEKNHiJUyWv0Swqb4wbxc50hu6Y7WgEAqYvw+Wo
         qd/SZwzQT3SsDb6VHWVazrvjpqmzIyt/QF7dppZyHnzVGs1yPvYUtK8V22OWQ1wVOuTE
         eI85l/6CJA9JSMVOgNARfe9CmD6x/3jFB/NMhCshPAVfBqTB4TsMd5py1mt/W8uXcrZt
         Um+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pQTfg+rW29M9jsnGSthBknimvtkfGbED28RIePMq+Y=;
        b=dYf/LU/YRU9qKz/z/rBdlewPJbsj+V+CzR6R85oO6rCj2HwQj5a2gBxT64cFFX5bMS
         tyMy4bzGjyIqR2ftjD0qfzwPBZIUpD9EIAJpWENGJ/LcrAnEDiuxFSRaqgOW+T9g2+4T
         4+Z5PDC78PmTyb0qcwFEe0t+yPX7RmlOPl4mDrl9y2kfp4hCE9l7UvebXB0c/gMlPRh+
         l+TWHNPAcARAfMaHc1Z+uQxE/ZENoWeDFtaknH9fcjKU5dfSPpPxx1L34CWUqLYH6eTG
         OvlpByQmPcT2eLlr3VEHrX8jpCise+9ulZmrRsFonkCGqDGHfyDzXEwIqYOBIwvyzCiy
         0Rcw==
X-Gm-Message-State: AHQUAuYbm6IcxdC4YIXshI18JxlJuGf7RTuF0abMpUWgHmhJL0gdxdv+
        4OIeQm87tOHcDdd1aqCv4tlwf4Md
X-Google-Smtp-Source: AHgI3IbqsAW5BbcN+6tt4e/qwZlqa/XLFDjsElJyhXQd1jXfUVTWbSVWK0jOX/JoDhrBVL96sJ/7uA==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr650612wmf.141.1551136631260;
        Mon, 25 Feb 2019 15:17:11 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id k23sm8111495wmj.32.2019.02.25.15.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:10 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 15/27] stash: convert list to builtin
Date:   Mon, 25 Feb 2019 23:16:19 +0000
Message-Id: <20190225231631.30507-16-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Add stash list to the helper and delete the list_stash function
from the shell script.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash--helper.c | 31 +++++++++++++++++++++++++++++++
 git-stash.sh            |  7 +------
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 63e1e84e78..f296224577 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -12,6 +12,7 @@
 #include "rerere.h"
 
 static const char * const git_stash_helper_usage[] = {
+	N_("git stash--helper list [<options>]"),
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
@@ -19,6 +20,11 @@ static const char * const git_stash_helper_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_list_usage[] = {
+	N_("git stash--helper list [<options>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_drop_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
 	NULL
@@ -615,6 +621,29 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int list_stash(int argc, const char **argv, const char *prefix)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_list_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	if (!ref_exists(ref_stash))
+		return 0;
+
+	cp.git_cmd = 1;
+	argv_array_pushl(&cp.args, "log", "--format=%gd: %gs", "-g",
+			 "--first-parent", "-m", NULL);
+	argv_array_pushv(&cp.args, argv);
+	argv_array_push(&cp.args, ref_stash);
+	argv_array_push(&cp.args, "--");
+	return run_command(&cp);
+}
+
 int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -645,6 +674,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "list"))
+		return !!list_stash(argc, argv, prefix);
 
 	usage_msg_opt(xstrfmt(_("unknown subcommand: %s"), argv[0]),
 		      git_stash_helper_usage, options);
diff --git a/git-stash.sh b/git-stash.sh
index 8a9f907aa9..ab3992b59d 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -399,11 +399,6 @@ have_stash () {
 	git rev-parse --verify --quiet $ref_stash >/dev/null
 }
 
-list_stash () {
-	have_stash || return 0
-	git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --
-}
-
 show_stash () {
 	ALLOW_UNKNOWN_FLAGS=t
 	assert_stash_like "$@"
@@ -591,7 +586,7 @@ test -n "$seen_non_option" || set "push" "$@"
 case "$1" in
 list)
 	shift
-	list_stash "$@"
+	git stash--helper list "$@"
 	;;
 show)
 	shift
-- 
2.21.0.rc2.291.g17236886c5

