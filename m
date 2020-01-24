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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027EC2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D048206D4
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phBJYQLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbgAXOqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:46:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36478 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAXOqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 09:46:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so2296002wru.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 06:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX+xF72Fp9VWiTGXOGKjNXlexMCbBl9vRtckk9Emdww=;
        b=phBJYQLMJw/ywHYmP8mQZijZCBuqWPiKyx01NdM11vC6bFeI0CKw/Ew/qO+BLrcN02
         Wb8UXNj8oIrWCMeNvIZymYX9UVNLDTiLIv8eg6dyP0DIzSaMBnSRy+orbFTECHTE/9ni
         kQO8AGBgMbEfAVaUss3boHIqZsHf1JV6x47rb6f9zXVDLx8HHwp/4E5fQ/OkloayGKIt
         STuJaNhLaFUDbQGmWRRK/4KR3my+BW5pj7aZ21ZzZrlYnNoTX/mG0foSLmUlYoG4p9sx
         +Z6COCjUYunSELaCdQD79ybT+eVK8rodxk5nZZnZPdQJ1YQWFCxl7ggFgKG6UhiVW3Vj
         sfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX+xF72Fp9VWiTGXOGKjNXlexMCbBl9vRtckk9Emdww=;
        b=HnYHoFdm3SspiXeJd0wPw8W+mhI7y5RFDd5685kGeEECff/XLbUm5loTsjiNQH8Do0
         PaH0+Z8q9Lh3XlfGZQ73eYgTroWw9Nkua6Wr4lwVxngVsWd4cRWLRmw3762v4fSexQZV
         jAA+4NP7N4kUx6oh+zt41mKGw6uIOf0y/70eZZU4KedYY3zvdvf+PwMSO+fTQSVJxdbk
         631zNXNCSa1qeGB2kM2lg88fSUJW43YC8C0WdXg3+wpM8gzLCyuPL1xCsftjNaUQj3TQ
         GsTnTEc4LEwh+z3VhBb+Y44cH3Xfe3v4Nly8yutqTz0jTR9y5oPZ9BjcfcqYeDqyJZ1U
         /bpQ==
X-Gm-Message-State: APjAAAUZS71+YGisaBOJUhHlh67EqTMXvSQ4GiOOdCrI4yZus0Qspmpf
        7uuACIkdijXVSkZsXaB1CGg=
X-Google-Smtp-Source: APXvYqybXpbsEMKwMWGX9Yy9hldU4BPfeo69I9X9pPn4hvSEdCNOudik7YeAy8VaG/4FSN8kTK7exw==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr4975695wrc.175.1579877167528;
        Fri, 24 Jan 2020 06:46:07 -0800 (PST)
Received: from localhost.localdomain (atoulouse-551-1-75-233.w92-146.abo.wanadoo.fr. [92.146.226.233])
        by smtp.googlemail.com with ESMTPSA id 18sm6599365wmf.1.2020.01.24.06.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:46:06 -0800 (PST)
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
Subject: [PATCH v2] rebase -i: stop checking out the tip of the branch to rebase
Date:   Fri, 24 Jan 2020 15:45:45 +0100
Message-Id: <20200124144545.12984-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200121191857.23047-1-alban.gruin@gmail.com>
References: <20200121191857.23047-1-alban.gruin@gmail.com>
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

Notes:
    Changes since v1:
    
     - The first version of the commit message talked specifically about
       `rebase -i', but this problem is common to all sequencer-based
       rebases.  The first paragraph has been reworded to clear up the
       confusion.
    
     - Included benchmarks in the commit message, as suggested by Elijah
       Newren.
    
    The code did not change.

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

