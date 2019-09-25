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
	by dcvr.yhbt.net (Postfix) with ESMTP id 069141F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439283AbfIYBkU (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39162 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411372AbfIYBkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so2377840pff.6
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYj3rOK3QFnaJZwqKsXF5Oy4FMu8pe+1p3OJvZ6gWCk=;
        b=GeblFhwFvuXo0Ei9afEOJb/UbivdDPglFlakPkCA2dYxhnG5q9tuT4w8w5ZRNh8B50
         P08FqjFno9xx0iuZmUSjiqKsWWljfkuao0ZIXP7V2PCXA9P1mYqd22vdCOzgmvuaLoHj
         DgIUvxfhAc40H1VWTGSpWfkoBz+0d96YDw2jaOPgiGUFDXqR/q1QeDCuj9YvkiOSdaxY
         gAnwgN2iiBdZNCFnOJfsiAWGcpTuNinbCRFH2Uelzjbfp98ejalIoSSrxQTjM/Bc4SI5
         Fpm6EJ2j7+Av6pJIz8ZCyje9gbA3tax+vy5Bbz0GLIfNYK+MK1/qAqiX4I/nSEdz1niu
         IxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYj3rOK3QFnaJZwqKsXF5Oy4FMu8pe+1p3OJvZ6gWCk=;
        b=dHQ25fiNCWrvpp010nVF0UVz/Lox2j1VHjSt00kJ3fH9DiaSnB8Ar3uD7gVESzXzgo
         gFUuHLLO26m6yyXp90hKu/8ISBM5UarTxMAJ1h+SXpv+YvxnQHsLAh6araQ3aw+r4ddC
         N65fCMysFVY9/fiALcYASddDzIGnV7QXFou5v384CctH9ws4ucbTfvARrL+bG3gsSoZ4
         LlqPkNRnT8p+HcMdoTYs1WQKVcPBh2sxM+7CDbDZ8NVFoJo10tgmL4to0PjbTGUVEs8k
         P5j62zvjr8dGlSCPorgAOWVWW684AC1BOF/M+i1tZAjJTmw1OmJjhSkUFVnyBS/cqx6y
         Xtaw==
X-Gm-Message-State: APjAAAVyqc1r6LbAaGhR2QBYy8jjjakaAWFvSUNeGD2yZku8Tt7AHfV9
        72n4spw8iJ7LuOpYTNIGv+x8W+1NKTM=
X-Google-Smtp-Source: APXvYqzzjWcMrBUDxPcsHaxzaSOmkf0as8nWgitBDfqvzMVoOPds35W8XKMxsw2Wy8kW/Tm+w5mfMg==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr6039149pgn.18.1569375617141;
        Tue, 24 Sep 2019 18:40:17 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/8] fast-export: add support for --import-marks-if-exists
Date:   Tue, 24 Sep 2019 18:40:02 -0700
Message-Id: <20190925014005.17056-6-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
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
2.23.0.177.g8af0b3ca64

