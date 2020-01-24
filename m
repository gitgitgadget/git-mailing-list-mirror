Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33FCC3F68F
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A7E2071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDEU3hGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgAXPFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:05:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38446 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgAXPFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 10:05:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so2014065wmc.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ra8mKQevho8hkTBzu9qKzcbhKtBDTU+h1zKtUJ2ivc=;
        b=GDEU3hGLPq5VrH4uGVqINVcQC+WyWfZhN7ksDU2ONU8cpcBfaHsHfyjDgSVAcRF6Jx
         VGx02qrW7795y3cpcU43mIWdtrWtPR3rMj3rHnWWtpQCuh/rRKXVcMkp1VER3p/pk8jD
         UUmXOfzR36fZ4dHFk8tcb/IyB8l3uIR0T7mM7bZF0r8naG6XSg0aoeflvyw+ccIh3MQv
         eMgbRUUJ5fWsb7/ozHowdVGkwDNnabxbDxKaXJ4GCfNPru1pEUWok11sat90RZXgQi3J
         bFxVHz3chLBiM18EM1iqb5opXvbEPj+Dmso0dLwm6xvRTXQw8edGIoWGF4rAj8G3etW1
         EkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ra8mKQevho8hkTBzu9qKzcbhKtBDTU+h1zKtUJ2ivc=;
        b=EbfwbGtUwuAMFaVL2Ja3AQvxqQhv5bwk7TmoAUXkyXLYwqcBCLNhWG9IygaCRSBBHc
         /FTSWyAL1Epg6pCUUXkdTeW1AAhbHcwxQfeqE10orMJuuGA8Sh/HwIwX/UJSafV5N9u3
         UPlPjEiP+8qFOgtqMhXvcrmZOWfU4LaFhPJb5xhuW4qJA7z7PmYl2TDovhT6S/SJSpeW
         WywLR4HrKy/kPLoaWc0MiDsWdTND3w927fkwJ7wReqwedGcu8/xcVyVE1INBoDVMG7e4
         Pjw8Q327ojOySwyy3sHZd5YLmyKOcsOQ2ubYEvxHXMSrTgRztroUgJ4elJvq5LXSfKZw
         KLyg==
X-Gm-Message-State: APjAAAWut8YBI+IqvYir6VfUdk6p/MAjW6HP050XZTDi/WO7ZlrlY48p
        laEyq+LPzd/ygvLEqackpgoV4Fmf
X-Google-Smtp-Source: APXvYqy0k3sYgk1d089IzHRuHQDjvDFs8g6NbcM/7xk3Wusf/xZkrRSLOUcVqMld/AEDyiz0YFIKNA==
X-Received: by 2002:a7b:c622:: with SMTP id p2mr3624648wmk.94.1579878318731;
        Fri, 24 Jan 2020 07:05:18 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id m3sm7466542wrs.53.2020.01.24.07.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 07:05:17 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v3] rebase -i: stop checking out the tip of the branch to rebase
Date:   Fri, 24 Jan 2020 16:05:00 +0100
Message-Id: <20200124150500.15260-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124144545.12984-1-alban.gruin@gmail.com>
References: <20200124144545.12984-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the first things done when using a sequencer-based
rebase (ie. `rebase -i', `rebase -r', or `rebase -m') is to make a todo
list.  This requires knowledge of the commit range to rebase.  To get
the oid of the last commit of the range, the tip of the branch to rebase
is checked out with prepare_branch_to_be_rebased(), then the oid of the
head is read.  After this, the tip of the branch is not even modified.
The `am' backend, on the other hand, does not check out the branch.

On big repositories, it's a performance penalty: with `rebase -i', the
user may have to wait before editing the todo list while git is
extracting the branch silently, and "quiet" rebases will be slower than
`am'.

Since we already have the oid of the tip of the branch in
`opts->orig_head', it's useless to switch to this commit.

This removes the call to prepare_branch_to_be_rebased() in
do_interactive_rebase(), and adds a `orig_head' parameter to
get_revision_ranges().  prepare_branch_to_be_rebased() is removed as it
is no longer used.

This introduces a visible change: as we do not switch on the tip of the
branch to rebase, no reflog entry is created at the beginning of the
rebase for it.

Unscientific performance measurements, performed on linux.git, are as
follow:

  Before this patch:

    $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50

    real    0m8,940s
    user    0m6,830s
    sys     0m2,121s

  After this patch:

    $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50

    real    0m1,834s
    user    0m0,916s
    sys     0m0,206s

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Added a line in the first paragraph to make it clear that the `am'
backend is not affected.

 builtin/rebase.c | 18 +++++-------------
 sequencer.c      | 14 --------------
 sequencer.h      |  3 ---
 3 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8081741f8a..6154ad8fa5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -246,21 +246,17 @@ static int edit_todo_file(unsigned flags)
 }
 
 static int get_revision_ranges(struct commit *upstream, struct commit *onto,
-			       const char **head_hash,
+			       struct object_id *orig_head, const char **head_hash,
 			       char **revisions, char **shortrevisions)
 {
 	struct commit *base_rev = upstream ? upstream : onto;
 	const char *shorthead;
-	struct object_id orig_head;
-
-	if (get_oid("HEAD", &orig_head))
-		return error(_("no HEAD?"));
 
-	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
+	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
 	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
 						   *head_hash);
 
-	shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
+	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
 
 	if (upstream) {
 		const char *shortrev;
@@ -314,12 +310,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 	struct replay_opts replay = get_replay_opts(opts);
 	struct string_list commands = STRING_LIST_INIT_DUP;
 
-	if (prepare_branch_to_be_rebased(the_repository, &replay,
-					 opts->switch_to))
-		return -1;
-
-	if (get_revision_ranges(opts->upstream, opts->onto, &head_hash,
-				&revisions, &shortrevisions))
+	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
+				&head_hash, &revisions, &shortrevisions))
 		return -1;
 
 	if (init_basic_state(&replay,
diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..4dc245d7ec 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3715,20 +3715,6 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 	return ret;
 }
 
-int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
-				 const char *commit)
-{
-	const char *action;
-
-	if (commit && *commit) {
-		action = reflog_message(opts, "start", "checkout %s", commit);
-		if (run_git_checkout(r, opts, commit, action))
-			return error(_("could not checkout %s"), commit);
-	}
-
-	return 0;
-}
-
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const char *orig_head)
diff --git a/sequencer.h b/sequencer.h
index 9f9ae291e3..74f1e2673e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -190,9 +190,6 @@ void commit_post_rewrite(struct repository *r,
 			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
-int prepare_branch_to_be_rebased(struct repository *r, struct replay_opts *opts,
-				 const char *commit);
-
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(struct repository *repo,
-- 
2.24.1

