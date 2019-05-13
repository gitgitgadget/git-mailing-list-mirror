Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750D11F461
	for <e@80x24.org>; Mon, 13 May 2019 16:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfEMQrj (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbfEMQri (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id g3so7505588pfi.4
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4QLb3ZrRXepGAxpeLLj422ypaKsBEymgUbJeWP4+zY=;
        b=Vdqu212GT5J2i2dtU0t5wYcBg6E90jLg19quNm0Ht0nBHWDt+YIzItmVfp/nc4mnuT
         VuPdJHXfXOojL9NY6UZQAFTWzUKoWqKNjFiJU2E0X7T4Eu3i8z8LKmbV3d+xPHLdLsfG
         p4WrygW0BZn86WOn2LzmEnnBY6eFWkaOAadcFtRIBnUgRbXyPaptQYkVXVE2HiWu0zUU
         0AcYENsExSek7S0hMRvCbVf1W7ps/ps9XCmgvpkkKguUOX32dUWfP0w5ppNqd4QfGn8W
         TO40zIBYlcEmUXlanyLTRC/HHJHg0AC8Qwk8NHEhOqs4kcZ1+hCuVWlEHjdF/S4Fux/c
         12ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4QLb3ZrRXepGAxpeLLj422ypaKsBEymgUbJeWP4+zY=;
        b=kQA3A+ERUtgdZSnmEl3u0A3DSVp6YZ3p0DQJ2/cPrfhNHLeR4zV+oYuKqXSpmK/rlz
         6e22ap1XYz6EEvJ4OCN2znvixfzdZvbJOX34nm/Zdp+DtOKqmkP8gVBP8SrfwtuRlVmr
         Ro1xLFYHNDiIDPN04eK6q3QGCLq3NXb5ry20PGnvCzBLdN6TngIg4LrpLmhWyJh4WlB1
         KaCQ+rMEeayedIY0nrvacGfmgZaSUHF9Jg77qkjKTtYaJGvhazjweLgmCpEyR+bzvOuO
         F8b+6x7/OJaKH83BMI54SuDowvunKcttQaAe0nMxy8PPnI6b/FOzekc4nRuGdd2IFY8/
         zBzg==
X-Gm-Message-State: APjAAAWpYfNvREQ2tKlNe9ZlmkpJWtlxH9Ks67Y9F5NwYKgd1MdC4X8m
        YEArxfrfkWS1lkHjKiDMFVg=
X-Google-Smtp-Source: APXvYqzY9dfMg4XI4NuFxbUogM7cFXuBmY6VGOCTWqYN8NAOK7tNDVFLzRvzYGBjP44KebU77PjCYA==
X-Received: by 2002:a63:9214:: with SMTP id o20mr32469267pgd.203.1557766057896;
        Mon, 13 May 2019 09:47:37 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:37 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 5/5] fast-export: do automatic reencoding of commit messages only if requested
Date:   Mon, 13 May 2019 09:47:22 -0700
Message-Id: <20190513164722.31534-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
 <20190513164722.31534-1-newren@gmail.com>
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
 t/t9350-fast-export.sh | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 66331fa401..4906b23248 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -33,6 +33,7 @@ static const char *fast_export_usage[] = {
 static int progress;
 static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
 static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
+static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
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
+	else if (!strcmp(arg, "yes") || !strcmp(arg, "true") || !strcmp(arg, "on"))
+		reencode_mode = REENCODE_YES;
+	else if (!strcmp(arg, "no") || !strcmp(arg, "false") || !strcmp(arg, "off"))
+		reencode_mode = REENCODE_NO;
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
+		case REENCODE_YES:
+			reencoded = reencode_string(message, "UTF-8", encoding);
+			break;
+		case REENCODE_NO:
+			break;
+		case REENCODE_ABORT:
+			die("Encountered commit-specific encoding %s in commit "
+			    "%s; use --reencode=[yes|no] to handle it",
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
index 4fd637312a..d21d7bf9a9 100755
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
@@ -118,13 +118,45 @@ test_expect_success 'iso-8859-7' '
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
+		 # bytes.  Re-encoding the Pi character from \xF0 (\360) in
+		 # iso-8859-7 to \xCF\x80 (\317\200) in utf-8 adds a byte.
+		 # Check for the expected size...
+		 test 240 -eq "$(git cat-file -s i18n-no-recoding)" &&
+		 # ...as well as the expected byte.
+		 git cat-file commit i18n-no-recoding >actual &&
+		 grep $(printf "\360") actual &&
+		 # Also make sure the commit has the "encoding" header
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
2.21.0.782.g571613a09e

