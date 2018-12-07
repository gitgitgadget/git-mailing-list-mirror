Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B4120A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 22:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLGWsY (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 17:48:24 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:38599 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLGWsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 17:48:24 -0500
Received: by mail-ot1-f73.google.com with SMTP id q16so2589165otf.5
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tRg+/7Rs7WdGCJ+JR7CJnQ1Z9/3VFoHjPC9D0eYfJv0=;
        b=niI9Mk+4yLdHTv3ml3dwxA9cKe2hPyiQC5lFEDIOptWAeChFj0xbRM9dtwoYRvBwkl
         OwN3AX0SWMGpYORqfA0MvhEWsDVMcfJUWbPWZX5ykXpQQEOJ9EKrjl3z9fqQxP0mpMUO
         RsQcjIg2FDiFbceyVRpiVu1dVB+o7hCsj5InnvsUlDhXo29fkEoE+D4fM3F6plrVn+fm
         PKj5jcOsxcQz6UACykP2QNgJWHZr/Px836swg3UisEY6utO/ftjirnUyO3+miKEdHWt+
         tjFyIseSptK6fcxM2u1UMcNjcI1fWAKiLAHC4LngdAOUr5RZtBIaTY5H/84NpD0eK4e1
         G1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tRg+/7Rs7WdGCJ+JR7CJnQ1Z9/3VFoHjPC9D0eYfJv0=;
        b=duOx7PZqnG3ez7/aXdfj1E1WNdr7hLR+TAuNtdUtavKdbJOUMy6NjMiueH0wbsh+kX
         N1A75QQGug81zSKl7MPzOfqHs7YcagKM3Vl/H76Fnft4NZxqaRsdbRb3oVM81DT+i+1A
         eQJrFTucql1e3wQRd+sD+l1hiAAYQ2S7cTwITLvIQzm3obHogd708wjeFdjUpl9xP5nM
         D6I3xQo1IWmLZrTTr5SvmTxDb9Zg/P2+NVGZ0Z1aimNODpHTCeIaKs8XUp4BTB+CyRC0
         TJP+s8tBlKUGl1K7g+SUn7MrGA0aHDbf/GRQIPjZG/6lmrrz3cxbqkPKjY7jxUySpgo0
         XZPw==
X-Gm-Message-State: AA+aEWZYCG9H8N2OXdoz/fEo4BDfvoo0xMjO40Qopt7c92Lv3QS+LNBW
        t4xqctJKadgiQtTHJNLYpDppbi4SyxOtoPv+SqPWI5Z2DJf5pJkpTKZCccqBQkSSx1t7BZpzIgR
        1IXArRQ/JhdyTrAryJDvAiE/IdHo4fjCr19+dp0wzNFRuininZIjrXxPAvS9sbbzapGoP3/wxjg
        +R
X-Google-Smtp-Source: AFSGD/XVWR41mbQCQgAtEH7whVE97hKgGrddzHqLX+sMlh5iAfoieieSSIM8HY6u1h2AHgI9LMv74kleaLez6Uq7sE94
X-Received: by 2002:a9d:5266:: with SMTP id q38mr2860607otg.46.1544222903199;
 Fri, 07 Dec 2018 14:48:23 -0800 (PST)
Date:   Fri,  7 Dec 2018 14:48:17 -0800
Message-Id: <20181207224817.231957-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH] commit: abort before commit-msg if empty message
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a user runs "git commit" without specifying a message, an editor
appears with advice:

    Please enter the commit message for your changes. Lines starting
    with '#' will be ignored, and an empty message aborts the commit.

However, if the user supplies an empty message and has a commit-msg hook
which updates the message to be non-empty, the commit proceeds to occur,
despite what the advice states.

Teach commit to also check the emptiness of the commit message before it
invokes the commit-msg hook if an editor is used and if no_verify is not
set (that is, commit-msg is not suppressed). This makes the advice true.

(The implementation in this commit reads the commit message twice even
if there is no commit-msg hook. I think that this is fine, since this is
for interactive use - an alternative would be to plumb information about
the absence of the hook from run_hook_ve() upwards, which seems more
complicated.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This was noticed with the commit-msg hook that comes with Gerrit, which
basically just calls git interpret-trailers to add a Change-Id trailer.
---
 builtin/commit.c           | 43 ++++++++++++++++++++++++++++----------
 t/t7504-commit-msg-hook.sh | 11 ++++++++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c021b119bb..3681a59af8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -652,6 +652,21 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	comment_line_char = *p;
 }
 
+static void read_and_clean_commit_message(struct strbuf *sb)
+{
+	if (strbuf_read_file(sb, git_path_commit_editmsg(), 0) < 0) {
+		int saved_errno = errno;
+		rollback_index_files();
+		die(_("could not read commit message: %s"), strerror(saved_errno));
+	}
+
+	if (verbose || /* Truncate the message just before the diff, if any. */
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+		strbuf_setlen(sb, wt_status_locate_end(sb->buf, sb->len));
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -970,6 +985,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		argv_array_clear(&env);
 	}
 
+	if (use_editor && !no_verify) {
+		/*
+		 * Abort the commit if the user supplied an empty commit
+		 * message in the editor. (Because the commit-msg hook is to be
+		 * run, we need to check this now, since that hook may change
+		 * the commit message.)
+		 */
+		read_and_clean_commit_message(&sb);
+		if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
+			rollback_index_files();
+			fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+			exit(1);
+		}
+		strbuf_release(&sb);
+	}
+
 	if (!no_verify &&
 	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
 		return 0;
@@ -1608,17 +1639,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	/* Finally, get the commit message */
 	strbuf_reset(&sb);
-	if (strbuf_read_file(&sb, git_path_commit_editmsg(), 0) < 0) {
-		int saved_errno = errno;
-		rollback_index_files();
-		die(_("could not read commit message: %s"), strerror(saved_errno));
-	}
-
-	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	read_and_clean_commit_message(&sb);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 31b9c6a2c1..b44d6fc43e 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -122,6 +122,17 @@ test_expect_success 'with failing hook (editor)' '
 
 '
 
+test_expect_success 'hook is not run if commit message was empty' '
+	echo "yet more another" >>file &&
+	git add file &&
+	echo >FAKE_MSG &&
+	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit 2>err &&
+
+	# Verify that git stopped because it saw an empty message, not because
+	# the hook exited with non-zero error code
+	test_i18ngrep "Aborting commit due to empty commit message" err
+'
+
 test_expect_success '--no-verify with failing hook' '
 
 	echo "stuff" >> file &&
-- 
2.19.0.271.gfe8321ec05.dirty

