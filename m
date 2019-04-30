Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A411F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfD3SZk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41377 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfD3SZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so7220963pgs.8
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dMp5MIhDBg7AJQkYnjKDso8E6+iFBTb7OFqk6GK4+Mg=;
        b=LiV06WMCiCzl4MHChv1FAyb/zhjnje19XBHH5llsLj15eirkujnNEJNAgOuqc+D4S2
         2Asp7KcnHO0aLRDrUtDsChEUr/Qfik5GS+V8HG1ELz7nOUc2EB1QKnk9/liTtKhymj5a
         ZA6VzRKfBbFEHiqjs/JsVPni2xZ9fm7FVgtvKNTsLP6/J+0B3+5HqW0VUr0eBI+/MTLG
         IbuqU3Xkl3dJAt5HgQMtOlUud91McFrfiNqIus/CkPOI9N/l2wJDhI5Gv76zamKV35j7
         AfOuPMJUhX4oohvIH2Tsg/3UuIoUJrydymEFgpklqS3mr8+9siqEEK15R7OGTotveG+O
         EHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dMp5MIhDBg7AJQkYnjKDso8E6+iFBTb7OFqk6GK4+Mg=;
        b=ie3xz0mdfaDrHYqS38O0is8egax3/Gm8/Ncp+CS6z0ddDLzM08uE9du0R4CjWgsZT3
         UenTo81w8pxrF1I6+Kdk/bomXCahEoJAwt9k/3+9rYt3i0OeILtV9ktIxLMtROCtrR30
         lIJ4wOKh4aZvZcxuhjlRetCiGG2ne1FJyliui/woOKs43rciRYMjkQMMvfuXP5RiAcmg
         qA8FpnYTdwEWIFjPEyoEF2xgELiujB7XMBqoWF2T2pbVM1ZAfEMMtV4oZHI2vRktnTfu
         p5jMt1FZONa49iCCDmoh5UW5hSjmmeAWWHfpy2lufqYNxhRPNz/sbVcG2RK18UaHVTHI
         QrIA==
X-Gm-Message-State: APjAAAUwiTo/qsexJKbfbI17L/GqFZxzyAAumFSVvEaGUbhSrAG6/CJs
        cvABHHGQADJPOaS50PglAQ8=
X-Google-Smtp-Source: APXvYqxFGMUOfXrTsip/FsaU15uyC5u7NvGPtVrvyrvtonuoOrTEiEqU4m5L6D7qifn/Csvm2lz3nA==
X-Received: by 2002:a63:6cc4:: with SMTP id h187mr55438685pgc.437.1556648735733;
        Tue, 30 Apr 2019 11:25:35 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:35 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 5/5] fast-export: do automatic reencoding of commit messages only if requested
Date:   Tue, 30 Apr 2019 11:25:23 -0700
Message-Id: <20190430182523.3339-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 29 ++++++++++++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

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
index 67dd7ac7f4..92cfeb6cfc 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -94,14 +94,14 @@ test_expect_success 'fast-export --show-original-ids | git fast-import' '
 	test $MUSS = $(git rev-parse --verify refs/tags/muss)
 '
 
-test_expect_success 'iso-8859-7' '
+test_expect_success 'reencoding iso-8859-7' '
 
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_config i18n.commitencoding iso-8859-7 &&
 	test_tick &&
 	echo rosten >file &&
 	git commit -s -m "$(printf "Pi: \360")" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
@@ -109,13 +109,36 @@ test_expect_success 'iso-8859-7' '
 		 grep $(printf "\317\200") actual)
 '
 
+test_expect_success 'aborting on iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -m "$(printf "Pi: \360")" file &&
+	test_must_fail git fast-export --reencode=abort wer^..wer >iso-8859-7.fi
+'
+
+test_expect_success 'preserving iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
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
 	test_config i18n.commitencoding iso-8859-7 &&
 	echo rosten >file &&
 	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
-- 
2.21.0.782.g44aacb1a0b

