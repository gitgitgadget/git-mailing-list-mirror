Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF813202BB
	for <e@80x24.org>; Fri, 29 Mar 2019 16:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfC2Qc3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 12:32:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46764 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbfC2Qc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 12:32:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so3295638wrw.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=zQl2ADxgUG2hvY/F8U5dIFlD4nht+A2e+KfeCuAiXgo=;
        b=cpy71XMbTSCA5xCarBMlWNNg79pO4oTEvZZ3/lZKTvJDVVaO7kPq5Qrsl+gXsehAgx
         fmYVFX92riAl1YdqJJwFlPw2zqLBIHyurl+hORNDTOqw+7u6M3O4VpJoMOcliyCXazOA
         cWdSYosIL2PchSNAAVCA8R/Dz9X0br3Zd1mmcbPgvCueE/299hv6XXZwmanXNI3UKWv/
         P8GIDSFJa3wf5IOUw/fB8UIka+DNX8HLr9Z0bjAQAEA5NVBFK7fIJayDHYo5B0qMRiIw
         NHZTLwKybQd+X5GwSouP/eYj9XpANRNVjoug1hGTXRb4l4Y1ENPy3MxyAlr+dgjzv1WI
         7yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=zQl2ADxgUG2hvY/F8U5dIFlD4nht+A2e+KfeCuAiXgo=;
        b=R+zPAqtq+IhOVW4OuMuW09ROOrEJWKOEAHgwORu+DSBdfX3ZBYEw+X7C/4oryBiSY9
         18Pg/JeLClOjCrrMB3bJufqV06A8Tlp7/8FpOtA246RXelN5IoJl96eZp61+lavrrLDW
         mUR22ml2XarxfyYfM//rqDPH+enYfmGWLTU42fx5WvzK+eqT7gUyk2O8PNFb3MbGIrUZ
         zkePcUrSNm2ZcLp7wnpfmDIM+Y/DxPm1yCDLn9804u4jeH5Pkvpollbj8rRCnFjfOEK9
         3DLR2go2OAe3ro+XS6HDTSb70595uyrxMnOsQNFFA/tl5qQQpmM9WEeppcP+CtBKBCNj
         jYyw==
X-Gm-Message-State: APjAAAUKbEWhoAvkWLc8OFmnttlrlyiblI77A4F9kadQXkqxsaV4fl4x
        mx8EraA4XDb3uSrRKc3zyD0D+a9kOpo=
X-Google-Smtp-Source: APXvYqyi6816jnOCyw8p6jfuVn9lR8mxegvn3qwKpl4QoVi6FRyDmI8CsKFYkSTFUX0bx53VEvYT3A==
X-Received: by 2002:a5d:46c9:: with SMTP id g9mr30685239wrs.211.1553877146127;
        Fri, 29 Mar 2019 09:32:26 -0700 (PDT)
Received: from localhost.localdomain (host-89-242-191-183.as13285.net. [89.242.191.183])
        by smtp.gmail.com with ESMTPSA id j64sm3463175wmb.36.2019.03.29.09.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 09:32:25 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] fix cherry-pick/revert status after commit
Date:   Fri, 29 Mar 2019 16:30:09 +0000
Message-Id: <20190329163009.493-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329163009.493-1-phillip.wood123@gmail.com>
References: <20190329163009.493-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user commits a conflict resolution using 'git commit' during a
sequence of picks then 'git status' missed the fact that a
cherry-pick/revert is still in progress.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I'm not user about printing the oid of the commit that was just picked,
    maybe we should just say that a cherry-pick/revert is in progress. That
    will mean auditing all the consumers of wt_status_get_state() to ensure
    they can cope with a null oid.

sequencer.c            | 37 +++++++++++++++++++++++++++++++++++++
 sequencer.h            |  2 ++
 t/t7512-status-help.sh | 19 +++++++++++++++++++
 wt-status.c            | 12 +++++++++++-
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 028699209f..5595cc786f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2142,6 +2142,43 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
 	return !item->commit;
 }
 
+int sequencer_get_last_command(struct repository *r, enum replay_action *action,
+			       struct object_id *oid)
+{
+	struct todo_item item;
+	char *eol;
+	const char *todo_file;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	todo_file = git_path_todo_file();
+	if (strbuf_read_file(&buf, todo_file, 0) < 0) {
+		if (errno == ENOENT)
+			return -1;
+		else
+			return error_errno("unable to open '%s'", todo_file);
+	}
+	eol = strchrnul(buf.buf, '\n');
+	if (buf.buf != eol && eol[-1] == '\r')
+		eol--; /* strip Carriage Return */
+	if (parse_insn_line(r, &item, buf.buf, eol))
+		goto fail;
+	if (item.command == TODO_PICK)
+		*action = REPLAY_PICK;
+	else if (item.command == TODO_REVERT)
+		*action = REPLAY_REVERT;
+	else
+		goto fail;
+
+	oidcpy(oid, &item.commit->object.oid);
+	ret = 0;
+
+ fail:
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 static int parse_insn_buffer(struct repository *r, char *buf,
 			     struct todo_list *todo_list)
 {
diff --git a/sequencer.h b/sequencer.h
index 43548295a1..815c68c4a3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -145,3 +145,5 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts);
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      const char *onto, const char *orig_head);
 void sequencer_post_commit_cleanup(void);
+int sequencer_get_last_command(struct repository* r, enum replay_action *action,
+			       struct object_id *oid);
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 458608cc1e..71d28a50f7 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -780,6 +780,25 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status when cherry-picking after committing conflict resolution' '
+	git reset --hard cherry_branch &&
+	test_when_finished "git cherry-pick --abort" &&
+	test_must_fail git cherry-pick cherry_branch_second one_cherry &&
+	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
+	echo end >main.txt &&
+	git commit -a &&
+	cat >expected <<EOF &&
+On branch cherry_branch
+You are currently cherry-picking commit $TO_CHERRY_PICK.
+  (all conflicts fixed: run "git cherry-pick --continue")
+  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	git status --untracked-files=no >actual &&
+	test_i18ncmp expected actual
+'
+
 test_expect_success 'status showing detached at and from a tag' '
 	test_commit atag tagging &&
 	git checkout atag &&
diff --git a/wt-status.c b/wt-status.c
index 1f564b12d2..355e4cd03d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -17,6 +17,7 @@
 #include "utf8.h"
 #include "worktree.h"
 #include "lockfile.h"
+#include "sequencer.h"
 
 static const char cut_line[] =
 "------------------------ >8 ------------------------\n";
@@ -1563,6 +1564,7 @@ void wt_status_get_state(struct repository *r,
 {
 	struct stat st;
 	struct object_id oid;
+	enum replay_action action;
 
 	if (!stat(git_path_merge_head(r), &st)) {
 		wt_status_check_rebase(NULL, state);
@@ -1580,7 +1582,15 @@ void wt_status_get_state(struct repository *r,
 		state->revert_in_progress = 1;
 		oidcpy(&state->revert_head_oid, &oid);
 	}
-
+	if (!sequencer_get_last_command(r, &action, &oid)) {
+		if (action == REPLAY_PICK) {
+			state->cherry_pick_in_progress = 1;
+			oidcpy(&state->cherry_pick_head_oid, &oid);
+		} else {
+			state->revert_in_progress = 1;
+			oidcpy(&state->revert_head_oid, &oid);
+		}
+	}
 	if (get_detached_from)
 		wt_status_get_detached_from(r, state);
 }
-- 
2.21.0

