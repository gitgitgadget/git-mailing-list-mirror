Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD35C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5FB60F44
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbhHTPl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbhHTPlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:41:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6AC061756
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f5so14822533wrm.13
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IXR15OwYOXM9VARAvwO0xzyQu7vSlo+NqQLv3riANsA=;
        b=Gx8yPX5v+wN3Hd7bBsOhgtKSbSGJWapuU/o2DN2emJet3uYtzQ2XMZd/4d7qsm0LND
         Z9K6XJdI2aIcO4V33Ml0rmrF2yBDH95/SjwddkXkM+HQQ4zvHMkgRO69g8ziR5DaolKE
         FCE+GSRJd8wSrMynHs0x65xAwaf27pp9KnRkHkvci3j6Drw31pBBu+Su3vPCqknr2nSh
         HBlLPlwJ6lzG7F3m3LCXWRsvcYWE4dYrcnkGePyHcIMfaSAjm4rPzdZbAnyV6u8Zr0x0
         ccTakW/MYehA5rDPj/ZGp9blRUt4egO+k6wSY/sMM1gT2mLc3qKAYC5DeA3K/omdZFYk
         icYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IXR15OwYOXM9VARAvwO0xzyQu7vSlo+NqQLv3riANsA=;
        b=HtLjAjkPh91fQj7qhq6ifJeduvxxsYo5Ev7ydrR/nFW9tG/IX2j6X+6BzL8mus4a/c
         FlehZqdg/WDUHvvqQBmFWOjnMhZjaX7lXYcmdNOHyhD5Gi4ybuRbwjpvQqyphxXCd2iy
         ieilEGCwFsoVs1OcFWU0bocKgDW5DuK0KPLpNGtP11kjIT83dx9BpqQ6kqaaWxyxaVXw
         9YyiWBkbO35fnSwxBoceL/9RzTK+pc6Mgkmhmr997ECioy8afQy/pjynNxjr4VR7SsSc
         /ZmOrTvdwhWkVxD2n7P/tHiwm1b51IeoCsnNtstxSL7xYPkHUrOg/crY5+13On9sJ9Jr
         kZ2g==
X-Gm-Message-State: AOAM532Bdjyl4h4UZtyzhFFEeuzVEzXE35y3bCtxmae7TW+BwCynY9rv
        mx5DBiv34c0ZSyUQGC2cfzTVZGLQ+wI=
X-Google-Smtp-Source: ABdhPJwMRmzj9FoVWahaS232uPwLDhkpwWbeJIG8J4/CT7H7fQJNOQLphuMaf3OkwxWCJVcvIqnjFA==
X-Received: by 2002:adf:ec81:: with SMTP id z1mr10967479wrn.181.1629474041941;
        Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm12126438wmv.27.2021.08.20.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:40:41 -0700 (PDT)
Message-Id: <080e580e11c10526ae828caec242851c7823c2ce.1629474038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
        <pull.1015.v2.git.1629474038.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Aug 2021 15:40:37 +0000
Subject: [PATCH v2 3/4] rebase -r: don't write .git/MERGE_MSG when
 fast-forwarding
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When fast-forwarding we do not create a new commit so .git/MERGE_MSG
is not removed and can end up seeding the message of a commit made
after the rebase has finished. Avoid writing .git/MERGE_MSG when we
are fast-forwarding by writing the file after the fast-forward
checks. Note that there are no changes to the fast-forward code, it is
simply moved.

Note that the way this change is implemented means we no longer write
the author script when fast-forwarding either. I believe this is safe
for the reasons below but it is a departure from what we do when
fast-forwarding a non-merge commit. If we reword the merge then 'git
commit --amend' will keep the authorship of the commit we're rewording
as it ignores GIT_AUTHOR_* unless --reset-author is passed. It will
also export the correct GIT_AUTHOR_* variables to any hooks and we
already test the authorship of the reworded commit. If we are not
rewording then we no longer call spilt_ident() which means we are no
longer checking the commit author header looks sane. However this is
what we already do when fast-forwarding non-merge commits in
skip_unnecessary_picks() so I don't think we're breaking any promises
by not checking the author here.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c     | 81 +++++++++++++++++++++++++------------------------
 t/lib-rebase.sh | 10 ++++--
 2 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cc8a361cceb..c2cba5ed4b1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -983,7 +983,8 @@ static int run_git_commit(const char *defmsg,
 
 	cmd.git_cmd = 1;
 
-	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
+	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
+	    read_env_script(&cmd.env_array)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 		return error(_(staged_changes_advice),
@@ -3815,6 +3816,45 @@ static int do_merge(struct repository *r,
 		goto leave_merge;
 	}
 
+	/*
+	 * If HEAD is not identical to the first parent of the original merge
+	 * commit, we cannot fast-forward.
+	 */
+	can_fast_forward = opts->allow_ff && commit && commit->parents &&
+		oideq(&commit->parents->item->object.oid,
+		      &head_commit->object.oid);
+
+	/*
+	 * If any merge head is different from the original one, we cannot
+	 * fast-forward.
+	 */
+	if (can_fast_forward) {
+		struct commit_list *p = commit->parents->next;
+
+		for (j = to_merge; j && p; j = j->next, p = p->next)
+			if (!oideq(&j->item->object.oid,
+				   &p->item->object.oid)) {
+				can_fast_forward = 0;
+				break;
+			}
+		/*
+		 * If the number of merge heads differs from the original merge
+		 * commit, we cannot fast-forward.
+		 */
+		if (j || p)
+			can_fast_forward = 0;
+	}
+
+	if (can_fast_forward) {
+		rollback_lock_file(&lock);
+		ret = fast_forward_to(r, &commit->object.oid,
+				      &head_commit->object.oid, 0, opts);
+		if (flags & TODO_EDIT_MERGE_MSG)
+			goto fast_forward_edit;
+
+		goto leave_merge;
+	}
+
 	if (commit) {
 		const char *encoding = get_commit_output_encoding();
 		const char *message = logmsg_reencode(commit, NULL, encoding);
@@ -3864,45 +3904,6 @@ static int do_merge(struct repository *r,
 		}
 	}
 
-	/*
-	 * If HEAD is not identical to the first parent of the original merge
-	 * commit, we cannot fast-forward.
-	 */
-	can_fast_forward = opts->allow_ff && commit && commit->parents &&
-		oideq(&commit->parents->item->object.oid,
-		      &head_commit->object.oid);
-
-	/*
-	 * If any merge head is different from the original one, we cannot
-	 * fast-forward.
-	 */
-	if (can_fast_forward) {
-		struct commit_list *p = commit->parents->next;
-
-		for (j = to_merge; j && p; j = j->next, p = p->next)
-			if (!oideq(&j->item->object.oid,
-				   &p->item->object.oid)) {
-				can_fast_forward = 0;
-				break;
-			}
-		/*
-		 * If the number of merge heads differs from the original merge
-		 * commit, we cannot fast-forward.
-		 */
-		if (j || p)
-			can_fast_forward = 0;
-	}
-
-	if (can_fast_forward) {
-		rollback_lock_file(&lock);
-		ret = fast_forward_to(r, &commit->object.oid,
-				      &head_commit->object.oid, 0, opts);
-		if (flags & TODO_EDIT_MERGE_MSG)
-			goto fast_forward_edit;
-
-		goto leave_merge;
-	}
-
 	if (strategy || to_merge->next) {
 		/* Octopus merge */
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 99d9e7efd2d..ec6b9b107da 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -173,10 +173,16 @@ set_reword_editor () {
 
 	write_script reword-editor.sh <<-EOF &&
 	# Save the oid of the first reworded commit so we can check rebase
-	# fast-forwards to it
+	# fast-forwards to it. Also check that we do not write .git/MERGE_MSG
+	# when fast-forwarding
 	if ! test -s reword-oid
 	then
-		git rev-parse HEAD >reword-oid
+		git rev-parse HEAD >reword-oid &&
+		if test -f .git/MERGE_MSG
+		then
+			echo 1>&2 "error: .git/MERGE_MSG exists"
+			exit 1
+		fi
 	fi &&
 	# There should be no uncommited changes
 	git diff --exit-code HEAD &&
-- 
gitgitgadget

