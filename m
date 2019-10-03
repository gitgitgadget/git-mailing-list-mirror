Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9851F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbfJCU1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:25 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39373 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfJCU1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:22 -0400
Received: by mail-pl1-f170.google.com with SMTP id s17so2036313plp.6
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clCxo/v0vvXe0UYUTS3MHzveeiCzVx7QaMSNJOXMc9M=;
        b=XHhiy2ijECniVrXmFJ9XYxYAp+G7qWv/LJP+pAqjpV+vs0EdS6XTNlEUFKCFEEBm1w
         U/ot52Bkts+rWTl6L2yUcYXLJJxJ6kEeN1Ok2VY6+oXOW4Ftxxvywddb2oAQ6YnwVXIQ
         1QXITjQnisu2Zdo9LjHi9OC9q98/7gkC5+OfCqdBOX57WZBsrMP8My8D3L/KbisMcYQq
         dloffQU+Sh7bkGEPWGGnSOFUY5w8eqdzYhp2tBTjQHQzkycDmhHBxHFduFet0V+KfJfB
         RyRdVZdwjq46HnmJLxWKJQb31kWyiqGlkXLQSW1O8+53Po7YAx7Z44lEI7pZSlD/QtdK
         Nf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clCxo/v0vvXe0UYUTS3MHzveeiCzVx7QaMSNJOXMc9M=;
        b=UjztezwWj8fChUQrxVklL1+0OalRtYfwx/HAssqSnP5V1opD08/WQtswlOfYnGLdAq
         uOtTn3dJwxFfyI4YjfZCmolV+7aRZepQAYeYSZ74vrdFwBNvHXUgZkl0TWC3sr739f5l
         7EpB+cMHOWFs37et5fpUryZeXY0CVgRa60Kc9+10oMctA3YTVzkQO7gLZk4emKO2nGni
         LK/gZMO4e6huB97r1ySaEESYez0HBmTF85JN14zPQxoI/1sJimF4SfC/C7W27n0gdNwq
         XLmXJUxV8oRL3T0WQSOkztPlMoI5o3inAdHTMT6Y5DRyM4O3jbcl9ju/coqnN0xWKica
         vyGw==
X-Gm-Message-State: APjAAAVExn5Qu1geZ0faPvfyROayGpFG4GJHDICOzw4NUN1dOMmG6Mvy
        0a3f3QkemocMMmRxY/0+lfw=
X-Google-Smtp-Source: APXvYqylMOsn2uISSMiJ5svUWuzjiHJJuag5hAmNL7NdNa+RABN9n1AUn6272hvWPHLijAOsv6eT8g==
X-Received: by 2002:a17:902:ff18:: with SMTP id f24mr11439664plj.173.1570134441127;
        Thu, 03 Oct 2019 13:27:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 5/8] fast-export: add support for --import-marks-if-exists
Date:   Thu,  3 Oct 2019 13:27:06 -0700
Message-Id: <20191003202709.26279-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fast-import has support for both an --import-marks flag and an
--import-marks-if-exists flag; the latter of which will not die() if the
file does not exist.  fast-export only had support for an --import-marks
flag; add an --import-marks-if-exists flag for consistency.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 23 +++++++++++++++++++----
 t/t9350-fast-export.sh | 10 ++++------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5822271c6b..575e47833b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1052,11 +1052,16 @@ static void export_marks(char *file)
 		error("Unable to write marks file %s.", file);
 }
 
-static void import_marks(char *input_file)
+static void import_marks(char *input_file, int check_exists)
 {
 	char line[512];
-	FILE *f = xfopen(input_file, "r");
+	FILE *f;
+	struct stat sb;
+
+	if (check_exists && stat(input_file, &sb))
+		return;
 
+	f = xfopen(input_file, "r");
 	while (fgets(line, sizeof(line), f)) {
 		uint32_t mark;
 		char *line_end, *mark_end;
@@ -1120,7 +1125,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	struct rev_info revs;
 	struct object_array commits = OBJECT_ARRAY_INIT;
 	struct commit *commit;
-	char *export_filename = NULL, *import_filename = NULL;
+	char *export_filename = NULL,
+	     *import_filename = NULL,
+	     *import_filename_if_exists = NULL;
 	uint32_t lastimportid;
 	struct string_list refspecs_list = STRING_LIST_INIT_NODUP;
 	struct string_list paths_of_changed_objects = STRING_LIST_INIT_DUP;
@@ -1140,6 +1147,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     N_("Dump marks to this file")),
 		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
 			     N_("Import marks from this file")),
+		OPT_STRING(0, "import-marks-if-exists",
+			     &import_filename_if_exists,
+			     N_("file"),
+			     N_("Import marks from this file if it exists")),
 		OPT_BOOL(0, "fake-missing-tagger", &fake_missing_tagger,
 			 N_("Fake a tagger when tags lack one")),
 		OPT_BOOL(0, "full-tree", &full_tree,
@@ -1187,8 +1198,12 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (use_done_feature)
 		printf("feature done\n");
 
+	if (import_filename && import_filename_if_exists)
+		die(_("Cannot pass both --import-marks and --import-marks-if-exists"));
 	if (import_filename)
-		import_marks(import_filename);
+		import_marks(import_filename, 0);
+	else if (import_filename_if_exists)
+		import_marks(import_filename_if_exists, 1);
 	lastimportid = last_idnum;
 
 	if (import_filename && revs.prune_data.nr)
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d32ff41859..ea84e2f173 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -580,17 +580,15 @@ test_expect_success 'fast-export quotes pathnames' '
 '
 
 test_expect_success 'test bidirectionality' '
-	>marks-cur &&
-	>marks-new &&
 	git init marks-test &&
-	git fast-export --export-marks=marks-cur --import-marks=marks-cur --branches | \
-	git --git-dir=marks-test/.git fast-import --export-marks=marks-new --import-marks=marks-new &&
+	git fast-export --export-marks=marks-cur --import-marks-if-exists=marks-cur --branches | \
+	git --git-dir=marks-test/.git fast-import --export-marks=marks-new --import-marks-if-exists=marks-new &&
 	(cd marks-test &&
 	git reset --hard &&
 	echo Wohlauf > file &&
 	git commit -a -m "back in time") &&
-	git --git-dir=marks-test/.git fast-export --export-marks=marks-new --import-marks=marks-new --branches | \
-	git fast-import --export-marks=marks-cur --import-marks=marks-cur
+	git --git-dir=marks-test/.git fast-export --export-marks=marks-new --import-marks-if-exists=marks-new --branches | \
+	git fast-import --export-marks=marks-cur --import-marks-if-exists=marks-cur
 '
 
 cat > expected << EOF
-- 
2.23.0.264.g3b9f7f2fc6

