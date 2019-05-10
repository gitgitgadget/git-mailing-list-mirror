Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029801F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfEJUxz (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:53:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42076 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfEJUxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:53:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so3550281pgg.9
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVblAGhdBPk6BWywR3kZttl4pwLQ6m8e8I8M98s0Xs8=;
        b=ACmk5roHkwdrFJc06TAnpf7jc/QGVO6BPPsuUhZbDiL0fZ/EZdP1KqBhCv81v9EHr6
         AggU4CIS7IPMOMvsWxHj3kXcGKZuEa8gVPmu5T/QSKruk6h5UwaFoCsO3eKwbrE2gP0b
         h8hrc21c76+2dcQqSVhVhaOJ4gH7t8nn+/Qj6SqT6m3eNNsP3ZHPtpHXCw/rE0Csf9sz
         WbO7CHZKNCGQaWLHaR7wX1KGyQi4YHDzFpBJhsk+kybKmdv0x2Up/SDukIWb+KsTadkO
         13QR6OdbgRtMZJOrbYXv7baLUmo8Au4W5K5DT6EVhk+XBLKsPmnfE3LmsoqtjXaw7Pg4
         loSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVblAGhdBPk6BWywR3kZttl4pwLQ6m8e8I8M98s0Xs8=;
        b=r6vWxKbmRfdO9XmGzcX8nuER511nkjDFlUBRD6T/UP3QJxuMgid8rUP13hfFcRBukq
         3LV9JkRA9m683m8IhqvwiX6DJRe83hMPOpVhvO9IbTcjEtAM03cAxZNUxbJkMweqsZIq
         xx30nbIXI2tMh1+7kryT3n1vqqXEXO0Fgykw4SdnFIA9Kp0SAYhX5P/2wp9T8ZM/sW4J
         W0cOkSG6YlBjThWlpBMcl/ZFxCuzDjbrxaLa/06s7ALniqOXkelY1Ta2GsDB6QJ/9gBd
         G9GLLjdQk/+mmc4HonMjydm+syRPhY5bCvMnBKEGx+jiybIQB1Quw8V4OK16W2+SQmmn
         hhHw==
X-Gm-Message-State: APjAAAWD4NlpOUU7Zp0A2hy21MaNb2sbkh2WiIYZTgkufxcuD19QrlgZ
        EA5L5K0LWn/zj+IUEuXkToY=
X-Google-Smtp-Source: APXvYqyqsJQigAuRR2mnyYcOJ2tPBQW13oyzkwkfdAWKHLrOygv5fhgTOWk7Bt5h6cwoiwtDaMGh6A==
X-Received: by 2002:a63:7989:: with SMTP id u131mr7541667pgc.180.1557521632733;
        Fri, 10 May 2019 13:53:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n127sm7305142pga.57.2019.05.10.13.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 May 2019 13:53:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 5/5] fast-export: do automatic reencoding of commit messages only if requested
Date:   Fri, 10 May 2019 13:53:35 -0700
Message-Id: <20190510205335.19968-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g2063122293
In-Reply-To: <20190510205335.19968-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
 <20190510205335.19968-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 37 ++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 6 deletions(-)

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
index fa124f4842..3cf4c7fc0c 100755
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
 	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
@@ -120,13 +120,44 @@ test_expect_success 'iso-8859-7' '
 		 ! grep ^encoding actual)
 '
 
+test_expect_success 'aborting on iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
+	test_must_fail git fast-export --reencode=abort wer^..wer >iso-8859-7.fi
+'
+
+test_expect_success 'preserving iso-8859-7' '
+
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_config i18n.commitencoding iso-8859-7 &&
+	echo rosten >file &&
+	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-message.txt" file &&
+	git fast-export --reencode=no wer^..wer >iso-8859-7.fi &&
+	sed "s/wer/i18n-no-recoding/" iso-8859-7.fi |
+		(cd new &&
+		 git fast-import &&
+		 # The commit object, if not re-encoded, is 240 bytes.
+		 # Removing the "encoding iso-8859-7\n" header would drops 20
+		 # bytes.  Re-encoding the Pi character from \xF0 in
+		 # iso-8859-7 to \xCF\x80 in utf-8 would add a byte.  I would
+		 # grep for the # specific bytes, but Windows lamely does not
+		 # allow that, so just search for the expected size.
+		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
+		 # Also make sure the commit has the "encoding" header
+		 git cat-file commit i18n-no-recoding >actual &&
+		 grep ^encoding actual)
+'
+
 test_expect_success 'encoding preserved if reencoding fails' '
 
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_config i18n.commitencoding iso-8859-7 &&
 	echo rosten >file &&
 	git commit -s -F "$TEST_DIRECTORY/t9350/broken-iso-8859-7-commit-message.txt" file &&
-	git fast-export wer^..wer >iso-8859-7.fi &&
+	git fast-export --reencode=yes wer^..wer >iso-8859-7.fi &&
 	sed "s/wer/i18n-invalid/" iso-8859-7.fi |
 		(cd new &&
 		 git fast-import &&
-- 
2.21.0.782.g2063122293

