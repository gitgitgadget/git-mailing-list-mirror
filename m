Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA4C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534AE21835
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJrseV8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgAUTVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:21:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgAUTVR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 14:21:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so4636711wrr.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 11:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A5FZt6zhpum2fPGlq5VLwxnHAu+skHFh7kONhKfc024=;
        b=PJrseV8A+lbgfsF20K/LJcWFJI5otWYmGHAQ2tpIiGOHvYLSOa46E8vvjoEHVEo+1C
         2Ex7i9ImtIaWo7EKiILfWKyBkGm4Nk+ed5QmZIaUPabnNHLASbaJUIXehwVWb3SuMa6w
         uc9JiIFox6CeCeBWS73dWQEoJ9MX5j+rzc6P1t8bU1+P9jg5LitrDJzoQJncKeyF0A5C
         pL1O+6tcg4gTRmy9FVUGXAkM5YumnfpcrDm19NKUqxP/sgn9foFJKuRTGYh1f+gA8kPH
         UH3qTFT6iFZz8UbnT0gI6bKJH/CkVtHOSV0DlYQMiv+gIG6L8a9sfO2FjLbpwObXSKqW
         apqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5FZt6zhpum2fPGlq5VLwxnHAu+skHFh7kONhKfc024=;
        b=lKLrIkY7felyZ1ERch0eyr6L9STK6lTRXxPfvZkw0KJ+NzqyqZUwYeN5cDEd0ndXlO
         1a2sBy//Uc86NTbCi7XAz/381I8X0e41J8C4jb5QcVL1ZvrhlkfB3hHXsuF6ugL5ORnM
         1eFHnzTEHL1ppzPZ12rf1GNaZsbdzgtIi6tazkOnoDJELBI6CZY23q7Dh/kStybqsEvp
         Fk/GoUqoXXCYPc1bdcqyS8sUO11SayZL4PoZQtwqLZuTBTUK5KGpFkOtTZ6ITmN/ot8F
         J5UERrNTSDtwTRGWXClfcNughINBje/oBETZp4OgDi7r1SIys1PlhlNmFBkROzwPgI51
         fuOw==
X-Gm-Message-State: APjAAAVAyN0N3hJIdw8dwMrL0BMRkJz5e+ZDy9tZbZD3FFXozpKW9PQ1
        e5hmuOIjEhbMmJ8KI1KHhV0=
X-Google-Smtp-Source: APXvYqw9hhee+ewbgIG1eTNEMHmOr85qxj/COzrfqxwKDeLi978K+ZXeBMEEFUPCBxp3n+In9fzx4w==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr6673464wrs.113.1579634474757;
        Tue, 21 Jan 2020 11:21:14 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-3-145.w86-222.abo.wanadoo.fr. [86.222.146.145])
        by smtp.googlemail.com with ESMTPSA id f17sm500567wmc.8.2020.01.21.11.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:21:14 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1] rebase -i: stop checking out the tip of the branch to rebase
Date:   Tue, 21 Jan 2020 20:18:57 +0100
Message-Id: <20200121191857.23047-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109150332.GF32750@szeder.dev>
References: <20200109150332.GF32750@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the first things done by the interactive rebase is to make a todo
list.  This requires knowledge of the commit range to rebase.  To get
the oid of the last commit of the range, the tip of the branch to rebase
is checked out with prepare_branch_to_be_rebased(), then the oid of the
HEAD is read.  On big repositories, it's a performance penalty: the user
may have to wait before editing the todo list while git is extracting the
branch silently (because git-checkout is silenced here).  After this,
the head of the branch is not even modified.

Since we already have the oid of the tip of the branch in
`opts->orig_head', it's useless to switch to this commit.

This removes the call to prepare_branch_to_be_rebased() in
do_interactive_rebase(), and adds a `orig_head' parameter to
get_revision_ranges().  prepare_branch_to_be_rebased() is removed as it
is no longer used.

This introduces a visible change: as we do not switch on the tip of the
branch to rebase, no reflog entry is created at the beginning of the
rebase for it.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---

Notes:
    Improvements brought by this patch:
    
    Before:
    
    $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
    
    real    0m8,940s
    user    0m6,830s
    sys     0m2,121s
    
    After:
    
    $ time git rebase -m --onto v4.18 463fa44eec2fef50~ 463fa44eec2fef50
    
    real    0m1,834s
    user    0m0,916s
    sys     0m0,206s
    
    Both tests have been performed on a 5400 RPM SATA III hard drive.

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

