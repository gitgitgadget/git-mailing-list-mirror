Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B205A1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfDYPvf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39820 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfDYPvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:33 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so53167pgj.6
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yT0g1QeYOphu9Z/Dm6VHupxsCEOtGhZlz9HknSR3ko=;
        b=ZzzBhZoNIDq6boSHhUfIRBJIINB6mOzU9lgdUJUrqZU5KfM/43WNybOjMx6Ai1mCg2
         Sbt+uHcrcNR3vHhbXKxgj6yHHiTP8+a1BkeQsCAZ21CAzRNx6bXsBhhaMTVqw4sqJ7/+
         RotcgW19sSYLabKX5TX2SBKqSGhz1PCs1Eiqv6pNxE732+/gsUeOltu9OJ82+aHGG8L5
         UBodmslp5XImaN0AAry0o42JX+lvOhW1d9V7jF/yoco/ZqK4IsnnUsTRaulab99W3sz2
         hDKc6zzSMXnW3W1AlQ1OhJfXKlrC7dHhpZcUxrB3wMPHWr3CLK/Ct3bgu1Sp328LRVPl
         rGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yT0g1QeYOphu9Z/Dm6VHupxsCEOtGhZlz9HknSR3ko=;
        b=bqdv2mxu6fkN7ilapJO541OXUVRBTmsLqHG0POvEPm/7d0zlgk6o15LkQfAtLtgm6F
         MAb3o+jEpO8cFWyaEW/QRO+Ca+xeRyT7kVIzJS7VrHv+kacJ3hInVWCYwPF5qcCgci+9
         6bXUJAlRbBQdalI0W6n+XEIb00/N4nxs+wCUNgH4H8g5yJpbJRdVQXyxgpNdZzR3B3gz
         dhS25Dpb19LfgsvTwEyYeldPGNY2oxZLeiRLyEvbvbQ7UVFueKNJ2cz/XGLU3SI8pFmz
         VizNnCqgy/3CwVW0epjjv1q7cKzAMK4JqqK9gWO9z7aWDa9UR2CvecGqwi9FK41Khfrb
         Z9lg==
X-Gm-Message-State: APjAAAVMD2AiQBiIZogO9w4aKr3A/AjWXB327l+cGL3MslCf/+ljp0dr
        wCJbrVnhQkSij+ak+1w6nBWT50GE
X-Google-Smtp-Source: APXvYqwOp5kGMPNb6SJV51O2IS8nVSHEA7j28gm60DhvJ1bFEKtc2K1k5/tFFc8wHx1EWCT7vKZo3g==
X-Received: by 2002:aa7:8453:: with SMTP id r19mr41147052pfn.44.1556207491708;
        Thu, 25 Apr 2019 08:51:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/5] fast-export: do automatic reencoding of commit messages only if requested
Date:   Thu, 25 Apr 2019 08:51:18 -0700
Message-Id: <20190425155118.7918-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
References: <20190425155118.7918-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Automatic re-encoding of commit messages (and dropping of the encoding
header) hurts attempts to do reversible history rewrites (e.g. sha1sum
<-> sha256sum transitions, some subtree rewrites), and seems
inconsistent with the general principle followed elsewhere in
fast-export of requiring explicit user requests to modify the output
(e.g. --signed-tags=strip, --tag-of-filtered-object=rewrite).  Add a
--reencode flag that the user can use to specify, and like other
fast-export flags, default it to 'abort'.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 35 ++++++++++++++++++++++++++++++++---
 t/t9350-fast-export.sh | 31 ++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 66331fa401..43cc52331c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -33,6 +33,7 @@ static const char *fast_export_usage[] = {
 static int progress;
 static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
 static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
+static enum { REENCODE_ABORT, REENCODE_PLEASE, REENCODE_NEVER } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
@@ -77,6 +78,20 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
+static int parse_opt_reencode_mode(const struct option *opt,
+				   const char *arg, int unset)
+{
+	if (unset || !strcmp(arg, "abort"))
+		reencode_mode = REENCODE_ABORT;
+	else if (!strcmp(arg, "yes"))
+		reencode_mode = REENCODE_PLEASE;
+	else if (!strcmp(arg, "no"))
+		reencode_mode = REENCODE_NEVER;
+	else
+		return error("Unknown reencoding mode: %s", arg);
+	return 0;
+}
+
 static struct decoration idnums;
 static uint32_t last_idnum;
 
@@ -633,10 +648,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	}
 
 	mark_next_object(&commit->object);
-	if (anonymize)
+	if (anonymize) {
 		reencoded = anonymize_commit_message(message);
-	else if (!is_encoding_utf8(encoding))
-		reencoded = reencode_string(message, "UTF-8", encoding);
+	} else if (encoding) {
+		switch(reencode_mode) {
+		case REENCODE_PLEASE:
+			reencoded = reencode_string(message, "UTF-8", encoding);
+			break;
+		case REENCODE_NEVER:
+			break;
+		case REENCODE_ABORT:
+			die("Encountered commit-specific encoding %s in commit "
+			    "%s; use --reencode=<mode> to handle it",
+			    encoding, oid_to_hex(&commit->object.oid));
+		}
+	}
 	if (!commit->parents)
 		printf("reset %s\n", refname);
 	printf("commit %s\nmark :%"PRIu32"\n", refname, last_idnum);
@@ -1091,6 +1117,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
 			     N_("select handling of tags that tag filtered objects"),
 			     parse_opt_tag_of_filtered_mode),
+		OPT_CALLBACK(0, "reencode", &reencode_mode, N_("mode"),
+			     N_("select handling of commit messages in an alternate encoding"),
+			     parse_opt_reencode_mode),
 		OPT_STRING(0, "export-marks", &export_filename, N_("file"),
 			     N_("Dump marks to this file")),
 		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 975c8c4014..4774926bb6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,7 +94,7 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'iso-8859-7' '
+test_expect_success 'reencoding iso-8859-7' '
 
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "git config --unset i18n.commitencoding" &&
@@ -102,7 +102,7 @@ test_expect_success 'iso-8859-7' '
 	test_tick &&
 	echo rosten >file &&
 	git commit -s -m "$(printf "Pi: \360")" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
@@ -110,6 +110,31 @@ test_expect_success 'iso-8859-7' '
 		 grep $(printf "\317\200") actual)
 '
 
+test_expect_success 'aborting on iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "git config --unset i18n.commitencoding" &&
+	git config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -m "$(printf "Pi: \360")" file &&
+	test_must_fail git fast-export --reencode=abort wer^..wer >iso-8859-7.fi
+'
+
+test_expect_success 'preserving iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "git config --unset i18n.commitencoding" &&
+	git config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -m "$(printf "Pi: \360")" file &&
+	git fast-export --reencode=no wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
+		(cd new &&
+		 git fast-import &&
+		 git cat-file commit i18n-no-recoding >actual &&
+		 grep $(printf "\360") actual)
+'
+
 test_expect_success 'encoding preserved if reencoding fails' '
 
 	test_when_finished "git reset --hard HEAD~1" &&
@@ -117,7 +142,7 @@ test_expect_success 'encoding preserved if reencoding fails' '
 	git config i18n.commitencoding iso-8859-7 &&
 	echo rosten >file &&
 	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
-- 
2.21.0.779.g2f4b9c5032

