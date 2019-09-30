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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B3481F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfI3VKa (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732631AbfI3VK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so8072215pgj.2
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBylQdXHDFOeJEXetVuakLucf0tFU0UT7RS+6a+MhRw=;
        b=JmrNJiz7ebbXliEtTO2uwJsCzC3v6imsvdLhxATybX4qDg1Hvt98g695Ym9gnB301l
         tsaVqMjo3m3WQ6wyHPdAu5miyV45jW8dJ4pHiyBPPTeTEQDach+p5k42jQq6/+6LiCvC
         vLKcTRl1ICwDYtgFJxR9924Wqsc/32W/ecFtlpHNnf0ZAsTIsKVic4Dv/c/A4FumZole
         sU0yQwH3ocW7HjPFQvTS71dL5V1NFyOnlEEeGUSPF3oPcDgOewJ3mN+5YS7yVK7/sTCH
         1wCMUKkyYXjH67B/z15wMU7zLXdNVtjurZviy112n/RzPfzKMN68jIiU6yV4fH5mwhuQ
         XzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBylQdXHDFOeJEXetVuakLucf0tFU0UT7RS+6a+MhRw=;
        b=P3Fz+AqtLSXZuAweH8YvKO7LhPpC0CK2ISjY4bsuUFGZLqGDp26mCIG1QE3Rbe1HTl
         1VX0k1nDbL73dnVTRkAcvgz5UMHMNH2e/OKqLZ/lRUDJUHiZBgb91ZpuTprJqwDZIq+r
         0fwuQIJPAj1/8643IxACPy4G8FtRYCImegU91a5QTzIh0UhsM9TX6X6+AsSfwe1Nv/iL
         aT3GyJNza9n3/c3s9mLvb3GZFAJadpzCV2ODHWshGpI54ErcV635kWNRTRHlJqftA1mh
         0vSWs1QkN9toZaVnLtHLzHim6w1ilCAi+Fesy5MQvFzJkeLoUyuiQ06ai2+LYmd3AIQy
         6/ow==
X-Gm-Message-State: APjAAAXlIKP2309+L+Rt1GruuAkBX2WVQWy2tyhHJ81Zv854rwDgC2Mh
        R3S6AWf0JL5KCHHlhwYvSYdD5EsyBOo=
X-Google-Smtp-Source: APXvYqzp1iBRQ9dZs67LlQs6eVS4yujFPmAQssGNBEUzAGdjyojLkFRTyin36u0BVONuFV/kGwI/gQ==
X-Received: by 2002:a17:90a:cb16:: with SMTP id z22mr1449788pjt.70.1569877828484;
        Mon, 30 Sep 2019 14:10:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/8] fast-export: add support for --import-marks-if-exists
Date:   Mon, 30 Sep 2019 14:10:15 -0700
Message-Id: <20190930211018.23633-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
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
2.23.0.264.gac739dbb79

