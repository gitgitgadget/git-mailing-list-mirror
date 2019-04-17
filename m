Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C74620248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfDQKZZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbfDQKZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so2908287wmi.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=BwO2zXj17ij7qCO8RVrg8IMsn5lasztjC43+neiREXc=;
        b=JfNDTB4ev0/dqXdtdyZJfgjkkIKwHW7FnJUZ6vOv0dYY9aUqs/uflOI/0KD1yPn+n/
         /EhjRvu5my3Q/QxzFGM11AU+j0uwf4YDxzBsGoNvEgqiupKbtLij5m6CiEhq0rIgrstT
         WKuaw79SNsWSkcu/Dol4LKNqT1sybRFMALgEO0fA/pVjRr4lbaHe/JSEUUgDJkH12NHM
         aPKdTrV8PRNuq2dZ6TymWfLKOBWT9yRl4aiIXUL89Zio8AyMRrKquOzATyzKS4ILJl5k
         qcH+/OA3Urz8Y2TXm8js3grXfZdvN51S40SmxdtZBKAwd5KD5w5IP/piOBrMq2lVqM1J
         l3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=BwO2zXj17ij7qCO8RVrg8IMsn5lasztjC43+neiREXc=;
        b=Cm5J0MDJgfbptZkF/rJSV1WGCYMt0RV4n2lE2X+24tmFgFTOG7d6UZJs90gUl5mhD1
         sy07THjLI+rSrJw4RxYZS3toYfecIgI3xgB5+vkj9YnCHoHp867B25JdnEK+bkiSYCuL
         cvSM+Whhou85DIJgPZd8CE1ArhypQUnu5O+1wgOrxKLOQCIEhHn8e8h6878JGMtEpTiv
         OYjXu0i0MGKcIoZ3v6TtoUmdW0rWJ2O9cifyDpAvbQv/bG4qDfdJSVyKLyRlVXCl9iWD
         nqvIvDNdflOoPKm3i1CEbFftxvF1kss6ezhIquqSP6haNSfaBGaW2JJ/nBuFE+W+hbOb
         cwaA==
X-Gm-Message-State: APjAAAVLZHUE1hieaEuQbwGCYdvr+Oc2rvZ8KB//4u60xVGB8Xh3nzUS
        ufS5KsUH9X3VP8wfk5gPffM=
X-Google-Smtp-Source: APXvYqxIIKQQhux5lH3wJcJgvSvoGCEXuYM4wH0FAVGGmFLsGxjusTpYIb2niqduvMiJ8WoQxdqeYQ==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr30967069wmd.36.1555496722016;
        Wed, 17 Apr 2019 03:25:22 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:25:21 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 08/10] merge: add scissors line on merge conflict
Date:   Wed, 17 Apr 2019 11:23:28 +0100
Message-Id: <20190417102330.24434-9-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

This fixes a bug where the scissors line is placed after the Conflicts:
section, in the case where a merge conflict occurs and
commit.cleanup = scissors.

Next, if commit.cleanup = scissors is specified, don't produce a
scissors line in commit if one already exists in the MERGE_MSG file.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/merge-options.txt |  7 +++--
 builtin/commit.c                | 22 ++++++++++++----
 builtin/merge.c                 | 14 ++++++++++
 t/t7600-merge.sh                | 46 +++++++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index bcf0b3e49c..61876dbc33 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -33,8 +33,11 @@ updated behaviour, the environment variable `GIT_MERGE_AUTOEDIT` can be
 set to `no` at the beginning of them.
 
 --cleanup=<mode>::
-	This option determines how the merge message will be cleaned up
-	before commiting. See linkgit:git-commit[1] for more details.
+	This option determines how the merge message will be cleaned up before
+	commiting. See linkgit:git-commit[1] for more details. In addition, if
+	the '<mode>' is given a value of `scissors`, scissors will be appended
+	to `MERGE_MSG` before being passed on to the commit machinery in the
+	case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
diff --git a/builtin/commit.c b/builtin/commit.c
index 8277da8474..5401a60cbe 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -668,6 +668,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -728,6 +729,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -738,8 +741,16 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			hook_arg1 = "squash";
 		} else
 			hook_arg1 = "merge";
+
+		merge_msg_start = sb.len;
 		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
+
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+		    wt_status_locate_end(sb.buf + merge_msg_start,
+					 sb.len - merge_msg_start) <
+				sb.len - merge_msg_start)
+			merge_contains_scissors = 1;
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
@@ -807,7 +818,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -832,10 +844,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
-		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-			 whence == FROM_COMMIT)
-			wt_status_add_cut_line(s->fp);
-		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
+		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
+			if (whence == FROM_COMMIT && !merge_contains_scissors)
+				wt_status_add_cut_line(s->fp);
+		} else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
 				_("Please enter the commit message for your changes."
 				  " Lines starting\n"
diff --git a/builtin/merge.c b/builtin/merge.c
index e1f7b7342d..03b9f7230a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -920,6 +920,20 @@ static int suggest_conflicts(void)
 	filename = git_path_merge_msg(the_repository);
 	fp = xfopen(filename, "a");
 
+	/*
+	 * We can't use cleanup_mode because if we're not using the editor,
+	 * get_cleanup_mode will return COMMIT_MSG_CLEANUP_SPACE instead, even
+	 * though the message is meant to be processed later by git-commit.
+	 * Thus, we will get the cleanup mode which is returned when we _are_
+	 * using an editor.
+	 */
+	if (get_cleanup_mode(cleanup_arg, 1) == COMMIT_MSG_CLEANUP_SCISSORS) {
+	    fputc('\n', fp);
+	    wt_status_add_cut_line(fp);
+	    /* comments out the newline from append_conflicts_hint */
+	    fputc(comment_line_char, fp);
+	}
+
 	append_conflicts_hint(&the_index, &msgbuf);
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2f4c2801fb..7f9c68cbe7 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -246,6 +246,52 @@ test_expect_success 'merge --squash c3 with c7' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge c3 with c7 with commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-\EOF &&
+	Merge tag '"'"'c7'"'"'
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_i18ncmp expect actual
+'
+
+test_expect_success 'merge c3 with c7 with --squash commit.cleanup = scissors' '
+	git config commit.cleanup scissors &&
+	git reset --hard c3 &&
+	test_must_fail git merge --squash c7 &&
+	cat result.9z >file &&
+	git commit --no-edit -a &&
+
+	cat >expect <<-EOF &&
+	Squashed commit of the following:
+
+	$(git show -s c7)
+
+	# ------------------------ >8 ------------------------
+	# Do not modify or remove the line above.
+	# Everything below it will be ignored.
+	#
+	# Conflicts:
+	#	file
+	EOF
+	git cat-file commit HEAD >raw &&
+	sed -e '1,/^$/d' raw >actual &&
+	test_i18ncmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge c1 with c2 and c3' '
-- 
2.21.0

