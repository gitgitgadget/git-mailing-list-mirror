Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C8C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356095AbiBULVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356234AbiBULUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C957E9B
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q9-20020a1ca709000000b0037fa5c3e5c1so370053wme.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H0xmYX7WTo/eAAmTFmsHnHnOXy0zdouLtD/crs0rORo=;
        b=Pjdw3dhKTcuwbejKCjYTpxBtnigm+jjM1q3gUIUqpCiRLtf0dxHPr3DaijxJaEJhB5
         cA0tnv6sdgM1VUpUs9B19/Y3RU6M9UjbnMVl55LIBjzfBhjxWwc0WSQ7fVTQFLOpGaEI
         1p8cW3L5hLW7uU94fVO8bb3iDkQkYVxSga3i9VG0fUQ3jKxvPrYGEVxnekCc4HcZfLA5
         H0pn3j6yiPPcEBj0C5tYiXymXsDF+2jSyicgeHFuQkWgALpkm1+nhIGSEQq++r2Nq5q1
         YdBZWd/Sd+wLPr9DEnw99KgG7B98a4vIHot/ddzdP1gUvKJJwhVTmj1VPXfnnCUKls+i
         lHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H0xmYX7WTo/eAAmTFmsHnHnOXy0zdouLtD/crs0rORo=;
        b=UkslwIwdGCzmzJVyTBT2WAN8PS28Pvk3yPgzkkk7aRO2FRa9le3RzWIV3xD2IP/EuV
         McSCktbN5vx0xXA4gF5TX+L+kJF9s+kugGZSGrl8VpogIiB00G24DJZHidx2Ib1BjXvG
         B8gZmkytLd+QiyxqgU+vmiNu4SxTDPpjXuibQ2zECj2Tv+9fFwyBLiXwiodG/SJXPeNj
         xaux3m7ZxlcLNzPLLLcfeP2wfWwvMtwyDC5ocO6QB15OsiKP0NXab/yzjhANfYn3XfGp
         0BA/sRP1TlV1HC9z5ZsLxjnyoGC+bi4DZFedw2ObBBCvHAtH/JiKvUTXa6UfmfelB9XL
         lNuw==
X-Gm-Message-State: AOAM532URTM8msX/JdlDzn5mOK6jno7n9fp5vLk28jTQjVk2asuJGEMw
        gDzyvoaP5mzIomh0VA1EHnZucVzdYEo=
X-Google-Smtp-Source: ABdhPJyjKj+92VtSBnw3pKFZoUoh/QusSzGsSCDxWTXyuHBWiB/p1ezyn1bn4EaPhmrp+evAR1LH5g==
X-Received: by 2002:a05:600c:364f:b0:37b:ba9e:2805 with SMTP id y15-20020a05600c364f00b0037bba9e2805mr17269229wmq.119.1645441857467;
        Mon, 21 Feb 2022 03:10:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm31251152wri.38.2022.02.21.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:57 -0800 (PST)
Message-Id: <493254ffbb8b11f325f5995790341d70198b5c97.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:49 +0000
Subject: [PATCH 2/7] rebase --merge: fix reflog when continuing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog message for a conflict resolution committed by "rebase
--continue" looks like

	rebase (continue): commit subject line

Unfortunately the reflog message each subsequent pick look like

	rebase (continue) (pick): commit subject line

Fix this by setting the reflog message for "rebase --continue" in
sequencer_continue() so it does not affect subsequent commits. This
introduces a memory leak similar to the one leaking GIT_REFLOG_ACTION
in pick_commits(). Both of these will be fixed in a future series that
stops the sequencer calling setenv().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |   2 -
 sequencer.c               |   5 ++
 t/t3406-rebase-message.sh | 120 +++++++++++++++++++++++++-------------
 3 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 4832f16e675..cd9a4f3e2f1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1247,8 +1247,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		int fd;
 
 		options.action = "continue";
-		set_reflog_action(&options);
-
 		/* Sanity check */
 		if (get_oid("HEAD", &head))
 			die(_("Cannot read HEAD"));
diff --git a/sequencer.c b/sequencer.c
index bdd66b4b67a..3634ad5baa9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4777,6 +4777,8 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
+		char *previous_reflog_action;
+
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -4787,10 +4789,13 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
+		previous_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
+		setenv(GIT_REFLOG_ACTION, reflog_message(opts, "continue", NULL), 1);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
 		}
+		setenv(GIT_REFLOG_ACTION, previous_reflog_action, 1);
 	} else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick(r, opts);
 	else if ((res = read_populate_todo(r, &todo_list, opts)))
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index d17b450e811..3ca2fbb0d59 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -10,10 +10,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 test_expect_success 'setup' '
 	test_commit O fileO &&
 	test_commit X fileX &&
+	git branch fast-forward &&
 	test_commit A fileA &&
 	test_commit B fileB &&
 	test_commit Y fileY &&
 
+	git checkout -b conflicts O &&
+	test_commit P &&
+	test_commit conflict-X fileX &&
+	test_commit Q &&
+
 	git checkout -b topic O &&
 	git cherry-pick A B &&
 	test_commit Z fileZ &&
@@ -79,54 +85,90 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 	test_i18ngrep "Invalid whitespace option" err
 '
 
-test_expect_success 'GIT_REFLOG_ACTION' '
-	git checkout start &&
-	test_commit reflog-onto &&
-	git checkout -b reflog-topic start &&
-	test_commit reflog-to-rebase &&
-
-	git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	rebase (finish): returning to refs/heads/reflog-topic
-	rebase (pick): reflog-to-rebase
-	rebase (start): checkout reflog-onto
+write_reflog_expect () {
+	if test $mode = --apply
+	then
+		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+	else
+		cat
+	fi >expect
+}
+
+test_reflog () {
+	mode=$1
+	reflog_action="$2"
+
+	test_expect_success "rebase $mode reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout conflicts &&
+	test_when_finished "git reset --hard Q" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		test_must_fail git rebase $mode main &&
+		echo resolved >fileX &&
+		git add fileX &&
+		git rebase --continue
+	) &&
+
+	git log -g --format=%gs -5 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/conflicts
+	${reflog_action:-rebase} (pick): Q
+	${reflog_action:-rebase} (continue): conflict-X
+	${reflog_action:-rebase} (pick): P
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git checkout -b reflog-prefix reflog-to-rebase &&
-	GIT_REFLOG_ACTION=change-the-reflog git rebase reflog-onto &&
-	git log -g --format=%gs -3 >actual &&
-	cat >expect <<-\EOF &&
-	change-the-reflog (finish): returning to refs/heads/reflog-prefix
-	change-the-reflog (pick): reflog-to-rebase
-	change-the-reflog (start): checkout reflog-onto
+	git log -g --format=%gs -1 conflicts >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/conflicts onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'rebase --apply reflog' '
-	git checkout -b reflog-apply start &&
-	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
-
-	git rebase --apply Y &&
+	test_cmp expect actual &&
 
-	git log -g --format=%gs -4 HEAD >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: returning to refs/heads/reflog-apply
-	rebase: Z
-	rebase: checkout Y
-	$old_head_reflog
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev conflicts@{1} Q
+	'
+
+	test_expect_success "rebase $mode fast-forward reflog${reflog_action:+ GIT_REFLOG_ACTION=$reflog_action}" '
+	git checkout fast-forward &&
+	test_when_finished "git reset --hard X" &&
+
+	(
+		if test -n "$reflog_action"
+		then
+			GIT_REFLOG_ACTION="$reflog_action" &&
+			export GIT_REFLOG_ACTION
+		fi &&
+		git rebase $mode main
+	) &&
+
+	git log -g --format=%gs -2 >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): returning to refs/heads/fast-forward
+	${reflog_action:-rebase} (start): checkout main
 	EOF
 	test_cmp expect actual &&
 
-	git log -g --format=%gs -2 reflog-apply >actual &&
-	cat >expect <<-EOF &&
-	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
-	branch: Created from start
+	git log -g --format=%gs -1 fast-forward >actual &&
+	write_reflog_expect <<-EOF &&
+	${reflog_action:-rebase} (finish): refs/heads/fast-forward onto $(git rev-parse main)
 	EOF
-	test_cmp expect actual
-'
+	test_cmp expect actual &&
+
+	# check there is only one new entry in the branch reflog
+	test_cmp_rev fast-forward@{1} X
+	'
+}
+
+test_reflog --merge
+test_reflog --merge my-reflog-action
+test_reflog --apply
+test_reflog --apply my-reflog-action
 
 test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
-- 
gitgitgadget

