Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B94C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 06:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAFD2067C
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 06:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI2hlKEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgHXGMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 02:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXGMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 02:12:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6EC061573
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 23:12:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so3729975plr.0
        for <git@vger.kernel.org>; Sun, 23 Aug 2020 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ipo5MtTb/HZjnuZGYlv3w45mnvX/Cf1Z89IBMFDjxHg=;
        b=nI2hlKEfqc4OBSdE/T9J6rP0lAzQ7c5oDeRuQ40QcorabDkq52/NHKv9J5n7E1fchw
         ZYYljsNCKsRKAp0KYsk7/4X049tb/AqidMTidjvQSYsCu6qsWdIA347HxamNjx2KP+bE
         UeseYbEf65gk9wb2X26BhZhXMeRZZ3ntbA1VJNp78T6/fHWrZmz1dbdPn1Dm9fP+xAyV
         xkoM1GC2xzPX5PGDVDKevdYJ0d83VUwUY+McuekKDCg9w8Une9kOnfHSFq26o88L0pR3
         NqeQ619NZPq2Wli/Hrk+/OT7U5P/iXTuDtN9Wxu3t+XlYLFwuI4mc6LpTcOpmoOopeY9
         eijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ipo5MtTb/HZjnuZGYlv3w45mnvX/Cf1Z89IBMFDjxHg=;
        b=iLCDV0YdzVV28fCemyfZ73Ez+wbFkIIDMFPSDOngfzN/9N/sSdZ2V0Q+0+MyiqiIRs
         PPveFky/qcnX0ug+/nJ1XWIqHBmhAjqovGArIom/CDH2pgVKOw7Ug2HZG1FNP5/FsWzl
         ELab4Lp9A2+/YMs30EkmZBpuX+tVI3U5Nmu6AfV2HSislvFV9z2qlORs8JZM/1xKB1W5
         wj67A1M+TeBSZZ8jloxoEqcUQzsq9LytO7vE9+v3Kr5nPjdonclJsKylXg+oXlwMHBER
         MIwoYSm6ry2KoUmkhasL8qd/SHSzjMKH9EFGcEZVy5UqZ6mXWOVTisNyGdxOpgczdrDS
         cymA==
X-Gm-Message-State: AOAM532hari6ci47c+iP07T4l4HVxdDGLH2k6+mg+46r95WKob0jorxg
        9A1xW9NyG/gFfOjGrD5rQJo2/kGb+0UkNQ==
X-Google-Smtp-Source: ABdhPJzuxyfsM57Z+0eZ3GG4fj4nXal3rGx4nsv52k8plNoCBXMwtSzNPJS7av3pOeIgYYOv7n1XeA==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr3563003pje.37.1598249531470;
        Sun, 23 Aug 2020 23:12:11 -0700 (PDT)
Received: from binky.lan ([2600:8802:d04:de02::8a9])
        by smtp.gmail.com with ESMTPSA id o2sm3821222pjh.4.2020.08.23.23.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 23:12:10 -0700 (PDT)
From:   Edwin Peer <espeer@gmail.com>
To:     git@vger.kernel.org
Cc:     Edwin Peer <espeer@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        "David A . Wheeler" <dwheeler@dwheeler.com>,
        Jameson Miller <jamill@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>, kuba@kernel.org
Subject: [PATCH] commit: provide option to add Fixes tags to log
Date:   Sun, 23 Aug 2020 23:11:56 -0700
Message-Id: <20200824061156.1929850-1-espeer@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Linux style Fixes tag has been adopted by many projects and represents
best practice for referring to previous commits which introduce a bug that
has been fixed by the present commit. Creating these tags manually can be
error prone and doing so using git log -1 --format='Fixes: %h ("%s")' is
cumbersome. It's time the commit command learn to perform this popular
pattern natively.

Implement a convenient command line option to add Fixes tags at the end of
the log message during commmit. The tag refers to the commit hash and
subject line of the given commit reference. This option may appear
multiple times on the command line to reference more than one commit. A
new tag will only be added if it does not already exist in the log message
trailer and will otherwise be added in option order to the beginning of
the trailer section. The minimum number of characters comprising the hash
portion of the tag is 12 by default, but the `core.abbrev` configuration
variable will be honored if it is specified.

Signed-off-by: Edwin Peer <espeer@gmail.com>
---
 Documentation/git-commit.txt |  14 +++-
 builtin/commit.c             |  54 ++++++++++++++
 t/t7527-commit-fixes.sh      | 135 +++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100755 t/t7527-commit-fixes.sh

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..4acb4b3ac8 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
-	   [-S[<keyid>]] [--] [<pathspec>...]
+	   [-S[<keyid>]] [(-f | --fixes) <commit>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -172,6 +172,18 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
 	agrees to a Developer Certificate of Origin
 	(see http://developercertificate.org/ for more information).
 
+-f::
+--fixes::
+	Add Linux style Fixes tag at the end of the commit log message. The
+	tag refers to the commit hash and subject line of the given commit
+	reference. This option may appear multiple times on the command
+	line to reference more than one commit. A new tag will only be
+	added if it does not already exist in the log message trailer and
+	will otherwise be added in option order to the beginning of the
+	trailer section. The minimum number of characters comprising the
+	hash portion of the tag is 12 by default, but the `core.abbrev`
+	configuration variable will be honored if it is specified.
+
 -n::
 --no-verify::
 	This option bypasses the pre-commit and commit-msg hooks.
diff --git a/builtin/commit.c b/builtin/commit.c
index 69ac78d5e5..231abe92ff 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -34,6 +34,7 @@
 #include "sequencer.h"
 #include "mailmap.h"
 #include "help.h"
+#include "trailer.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
 
@@ -113,6 +114,7 @@ static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit, *pathspec_from_file;
+static struct string_list fixes = STRING_LIST_INIT_NODUP;
 
 /*
  * The default commit message cleanup mode will remove the lines
@@ -651,6 +653,54 @@ static int author_date_is_interesting(void)
 	return author_message || force_date;
 }
 
+static void tag_fixes(struct strbuf *msg)
+{
+	const struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	struct pretty_print_context pretty = { .abbrev = default_abbrev };
+	const char *format = "Fixes: %h (\"%s\")";
+	const struct string_list_item *fix;
+	struct strbuf tags = STRBUF_INIT;
+	struct trailer_info info;
+	size_t insert_pos;
+
+	/* use at least 12 hash characters unless explicitly configured */
+	if (pretty.abbrev == -1)
+		pretty.abbrev = 12;
+
+	trailer_info_get(&info, msg->buf, &opts);
+
+	for_each_string_list_item(fix, &fixes) {
+		struct strbuf tag = STRBUF_INIT;
+		struct commit *commit;
+		int i;
+
+		commit = lookup_commit_reference_by_name(fix->string);
+		if (!commit)
+			die(_("could not find commit: %s"), fix->string);
+
+		format_commit_message(commit, format, &tag, &pretty);
+
+		/* skip fixes tags that are already present */
+		for (i = 0; i < info.trailer_nr; i++)
+			if (!strncmp(info.trailers[i], tag.buf, tag.len))
+				goto skip;
+
+		strbuf_add(&tags, tag.buf, tag.len);
+		strbuf_addch(&tags, '\n');
+skip:
+		strbuf_release(&tag);
+	}
+
+	insert_pos = info.trailer_start - msg->buf;
+	strbuf_insert(msg, insert_pos, tags.buf, tags.len);
+	if (tags.len != 0 && !info.blank_line_before_trailer) {
+		if (msg->len == tags.len)
+			strbuf_insert(msg, insert_pos, "\n", 1);
+		strbuf_insert(msg, insert_pos, "\n", 1);
+	}
+	strbuf_release(&tags);
+}
+
 static void adjust_comment_line_char(const struct strbuf *sb)
 {
 	char candidates[] = "#;@!$%^&|:";
@@ -829,6 +879,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (signoff)
 		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
 
+	if (fixes.nr)
+		tag_fixes(&sb);
+
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
 
@@ -1510,6 +1563,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
 		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_STRING_LIST('f', "fixes", &fixes, N_("commit"), N_("add Fixes: tag referencing <commit>")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_CLEANUP(&cleanup_arg),
diff --git a/t/t7527-commit-fixes.sh b/t/t7527-commit-fixes.sh
new file mode 100755
index 0000000000..8067cd1ed5
--- /dev/null
+++ b/t/t7527-commit-fixes.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+#
+# Copyright (c) 2020 Edwin Peer <espeer@gmail.com>
+#
+
+test_description="git commit -f"
+. ./test-lib.sh
+
+test_expect_success 'empty message' '
+	>foo && git add foo &&
+	git commit -m "first" &&
+	echo 1 >foo &&
+	git commit -af 3b6336 &&
+	git log -1 --format="%s" >actual &&
+	echo "Fixes: 3b6336cd156f (\"first\")" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'invalid commit' '
+	echo 2>foo &&
+	test_must_fail git commit -af abcdef
+'
+
+test_expect_success 'blank line after message' '
+	git commit --amend -m "second commit with spaces" -f 3b6336 &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		second commit with spaces
+		
+		Fixes: 3b6336cd156f ("first")
+		
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'no duplicate' '
+	git commit --amend -f 3b6336 &&
+	git log -1 --format="%B" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'at start of trailer' '
+	echo 3>foo &&
+	git commit -asm "third
+
+Reviewed-by: John Doe <john@nobody.com>" &&
+	git commit --amend -f HEAD~ &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		third
+		
+		Fixes: a102cd7a0d16 ("second commit with spaces")
+		Reviewed-by: John Doe <john@nobody.com>
+		Signed-off-by: C O Mitter <committer@example.com>
+		
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'multiple' '
+	echo 4 >foo &&
+	git commit -asm "fourth" -f 3b6336 -f 6b4393 &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		fourth
+		
+		Fixes: 3b6336cd156f ("first")
+		Fixes: 6b4393deae7c ("third")
+		Signed-off-by: C O Mitter <committer@example.com>
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'multiple without duplicates' '
+	git commit --amend -f 6b4393 -f a102cd -f 3b6336 &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		fourth
+		
+		Fixes: a102cd7a0d16 ("second commit with spaces")
+		Fixes: 3b6336cd156f ("first")
+		Fixes: 6b4393deae7c ("third")
+		Signed-off-by: C O Mitter <committer@example.com>
+		
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'honors core.abbrev' '
+	git config core.abbrev 8 &&
+	echo 5 >foo &&
+	git commit -asm "fifth" -f b06e7571b56c3fc5ac5151ff1b0651debbdada51 &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		fifth
+		
+		Fixes: b06e7571 ("fourth")
+		Signed-off-by: C O Mitter <committer@example.com>
+		
+	EOF
+	test_cmp expected actual &&
+	git config --unset core.abbrev
+'
+
+test_expect_success 'option order' '
+	echo 6 >foo &&
+	git commit -asm "sixth" -f 3b6336cd -f a102cd7a -f 6b4393de &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		sixth
+		
+		Fixes: 3b6336cd156f ("first")
+		Fixes: a102cd7a0d16 ("second commit with spaces")
+		Fixes: 6b4393deae7c ("third")
+		Signed-off-by: C O Mitter <committer@example.com>
+		
+	EOF
+	test_cmp expected actual &&
+	echo 7 >foo &&
+	git commit -asm "seventh" -f 6b4393de -f a102cd7a -f 3b6336cd &&
+	git log -1 --format="%B" >actual &&
+	cat >expected <<-EOF &&
+		seventh
+		
+		Fixes: 6b4393deae7c ("third")
+		Fixes: a102cd7a0d16 ("second commit with spaces")
+		Fixes: 3b6336cd156f ("first")
+		Signed-off-by: C O Mitter <committer@example.com>
+		
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.28.0

