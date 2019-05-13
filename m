Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF1B1F461
	for <e@80x24.org>; Mon, 13 May 2019 23:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEMXRn (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:17:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40999 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfEMXRl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:17:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so7547550pgp.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 16:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j8PUnCn6FXZZXhl10n62GvlgqpHNtp4FRd0UeGI0L0=;
        b=IV2mctCr/gbIMth7R0/2A1cZ34gLwp9VXchR+6le3tl1jbO2Rg10LisT/vsnb0+E8q
         F9SLGx5ZRyHwvqTK00n5DTf8kcDvGmVILjvQ/Nkq55JlnuMwoc7e8ROT1zblbRC5hefl
         UiTQ10I+O58YeDnR2zbzIDeLYykfqbF65kBZWi/ydC0CMhITr03iiFkeCvfEzH2fdsVk
         Y2Ea68VfTaqWBO9jxr/EuuM7WcySL6W9C8qQpAecnOvRIMTwOM109Y2M8Y4kBwg+entI
         MZxGIoSZBu12YsCQsJEgm7A/BmLMj5nsRqAnX3C4EY3dp+xKgF9v0LS1hifO51xUUafd
         P2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j8PUnCn6FXZZXhl10n62GvlgqpHNtp4FRd0UeGI0L0=;
        b=uiQLYrWO6gtAeKFb1FsUBiSrGdMIWiPCS3wtOTKnP/4LkRn0ZnZOGXQGVfXa/oUf/6
         p2zfR/VdBiL1ce1xIM9mvjxL0Ylh/UlWuxDn+p2d2MnNcNJY17P1LXHwm9Am+x8tIOfu
         C1mXTeF95BRCo2r+brgqAFzUFeU02yZRSy9mfpFZSChBqG3mJCmc9iToA7cjyLIkvilF
         FJT1Ufz4zLjWYL0FDxXIYyWzeyIlCYcAPv43r1dBPi8zTm4ObedyHOIM+/Vdy07BkNhs
         KE+6SJLl/GiV8fAMBbcGskXO3E5W6T5OqHh2RdbX8r1E0xkk3gs9whyQWwa7+GD1aOgi
         fuag==
X-Gm-Message-State: APjAAAXSKCKEYL4b2DB2kh25SZne4542IZdSwitHLmh4fpFzBJHfBmBF
        iGmPJW56B4xtO2sF5gEGDsM=
X-Google-Smtp-Source: APXvYqyY7+zObGsFPpLbSRIb2TDak2Cnpf40hf6Fr9o9M9LGpCxV9MN8VtMD5nIdb20+yicW7shDQQ==
X-Received: by 2002:a62:2b4e:: with SMTP id r75mr36766539pfr.131.1557789460644;
        Mon, 13 May 2019 16:17:40 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id g10sm30664307pfg.153.2019.05.13.16.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 16:17:39 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 5/5] fast-export: do automatic reencoding of commit messages only if requested
Date:   Mon, 13 May 2019 16:17:26 -0700
Message-Id: <20190513231726.16218-6-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gd8be4ee826
In-Reply-To: <20190513231726.16218-1-newren@gmail.com>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
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
 Documentation/git-fast-export.txt |  7 +++++
 builtin/fast-export.c             | 46 +++++++++++++++++++++++++++++--
 t/t9350-fast-export.sh            | 38 +++++++++++++++++++++++--
 3 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 64c01ba918..11427acdde 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -129,6 +129,13 @@ marks the same across runs.
 	for intermediary filters (e.g. for rewriting commit messages
 	which refer to older commits, or for stripping blobs by id).
 
+--reencode=(yes|no|abort)::
+	Specify how to handle `encoding` header in commit objects.  When
+	asking to 'abort' (which is the default), this program will die
+	when encountering such a commit object.  With 'yes', the commit
+	message will be reencoded into UTF-8.  With 'no', the original
+	encoding will be preserved.
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 66331fa401..0bb65b3886 100644
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
@@ -77,6 +78,31 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	return 0;
 }
 
+static int parse_opt_reencode_mode(const struct option *opt,
+				   const char *arg, int unset)
+{
+	if (unset) {
+		reencode_mode = REENCODE_ABORT;
+		return 0;
+	}
+
+	switch (git_parse_maybe_bool(arg)) {
+	case 0:
+		reencode_mode = REENCODE_NO;
+		break;
+	case 1:
+		reencode_mode = REENCODE_YES;
+		break;
+	default:
+		if (arg && !strcasecmp(arg, "abort"))
+			reencode_mode = REENCODE_ABORT;
+		else
+			return error("Unknown reencoding mode: %s", arg);
+	}
+
+	return 0;
+}
+
 static struct decoration idnums;
 static uint32_t last_idnum;
 
@@ -633,10 +659,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
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
@@ -1091,6 +1128,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
2.21.0.782.gd8be4ee826

