Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1A220248
	for <e@80x24.org>; Tue,  2 Apr 2019 05:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDBFJY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 01:09:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40110 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfDBFJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 01:09:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so2644813plr.7
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OEBWxzXxcvt9OSJ6SlAxK2rmlOSWUFMqW9Df1FzRWwI=;
        b=gFeb5QkbXWuV1cQrPMBmHrBpi+fJUTmrT4izTfYVgKGAjIbp0y5r1jOy7NPnue9NZa
         UUViYCQJ52yVOJGTJRFCg/12IP6qQerr15TYkJMfbiABRtImACAPZfhtBetw7JgQtS/U
         fcwtJs0isMCdQGbCfLyPeQ3pp+bAaXsYyeXBmJuXsOWlX77t/or0DR0ZnFmR/3oXkARk
         +/9ri24LEK2WgvUAtCcZ51jZ1vs8RedVENK97G9e5r0HUQWRIye2DLfrwtY5OjTl7tr/
         FjloMBYp1/IM3clxS87XRAYuRbnnn3vU5Xpb88ikz199R/vrZNbueNvRj5Ktd+kAOmp4
         y/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OEBWxzXxcvt9OSJ6SlAxK2rmlOSWUFMqW9Df1FzRWwI=;
        b=CvLiN5YMbPFXxbMMGO1KZJKRo+NUxio7j8NlLcSRFdpJqZ0Nr/xk1nLr5vxc8xa/ix
         a/vyr9TT9DcddLbc8uZRH/HosELWinOHe8WUbpZkQAZnRUc88sYiB6ierHm0vrzJz4GW
         gucGZ0tYxhcJxiTQPw5AvwW5TVMVa69ywrEerHajgM4lbnkdAafcTeSxe97/8AeL4Oow
         ffnZWxzESjvPm8uSpLsNEoG7AcIKajDDZayJwSg2OhcvcUqGUmd/4yDGVZgV1k0FiWJO
         iLNOiYt1Bxqg9Ej9riGNhTzofeAj6LmLEqNwjXMwKhAvTGI6nJB/SSuusKR5yqDG4Ckv
         UyWw==
X-Gm-Message-State: APjAAAUlMN9SurhwaQTXifhF22BlawmovRHkcw4d36On1BPMIkt6YUM7
        lxk0MULOzJWMEGT+yEHELJQ2asGL
X-Google-Smtp-Source: APXvYqzQNFBkOT0o+MNLMGFXtbh0+/zeh8qoTPXhRSBT+jyHUnue/SbF3fVHsSEou3J9wZYRrjleAg==
X-Received: by 2002:a17:902:e684:: with SMTP id cn4mr44578236plb.71.1554181763147;
        Mon, 01 Apr 2019 22:09:23 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b2sm10989419pfo.150.2019.04.01.22.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 22:09:22 -0700 (PDT)
Date:   Mon, 1 Apr 2019 22:09:20 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3.5 3/4] rebase: fast-forward --onto in more cases
Message-ID: <7806809c32c8dae96fd7b1c4da6af4d74e2a2783.1554181577.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when we had the following graph,

	A---B---C (master)
	    \
	     D (side)

running 'git rebase --onto master... master side' would result in D
being always rebased, no matter what. However, the desired behavior is
that rebase should notice that this is fast-forwardable and do that
instead.

Add detection to `can_fast_forward` so that this case can be detected
and a fast-forward will be performed. First of all, rewrite the function
to use gotos which simplifies the logic. Next, since the

	options.upstream &&
	!oidcmp(&options.upstream->object.oid, &options.onto->object.oid)

conditions were removed in `cmd_rebase`, we reintroduce a substitute in
`can_fast_forward`. In particular, checking the merge bases of
`upstream` and `head` fixes a failing case in t3416.

The abbreviated graph for t3416 is as follows:

		    F---G topic
		   /
	  A---B---C---D---E master

and the failing command was

	git rebase --onto master...topic F topic

Before, Git would see that there was one merge base (C), and the merge
and onto were the same so it would incorrectly return 1, indicating that
we could fast-forward. This would cause the rebased graph to be 'ABCFG'
when we were expecting 'ABCG'.

With the additional logic, we detect that upstream and head's merge base
is F. Since onto isn't F, it means we're not rebasing the full set of
commits from master..topic. Since we're excluding some commits, a
fast-forward cannot be performed and so we correctly return 0.

Add '-f' to test cases that failed as a result of this change because
they were not expecting a fast-forward so that a rebase is forced.

While we're at it, remove a trailing whitespace from rebase.c.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Hi Junio,

Could you please use this patch instead of v3's 3/4? The code should be
the same but the log message goes into a lot more detail and (hopefully)
addresses the concerns you had earlier.

Thanks,

Denton

 builtin/rebase.c               | 40 +++++++++++++++++++++++-----------
 t/t3400-rebase.sh              |  2 +-
 t/t3404-rebase-interactive.sh  |  2 +-
 t/t3432-rebase-fast-forward.sh |  2 +-
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 77deebc65c..7aa6a090d4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -895,12 +895,12 @@ static int is_linear_history(struct commit *from, struct commit *to)
 	return 1;
 }
 
-static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
-			    struct object_id *merge_base)
+static int can_fast_forward(struct commit *onto, struct commit *upstream,
+			    struct object_id *head_oid, struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases;
-	int res;
+	struct commit_list *merge_bases = NULL;
+	int res = 0;
 
 	if (!head)
 		return 0;
@@ -908,12 +908,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 	merge_bases = get_merge_bases(onto, head);
 	if (merge_bases && !merge_bases->next) {
 		oidcpy(merge_base, &merge_bases->item->object.oid);
-		res = oideq(merge_base, &onto->object.oid);
+		if (!oideq(merge_base, &onto->object.oid))
+			goto done;
 	} else {
 		oidcpy(merge_base, &null_oid);
-		res = 0;
+		goto done;
 	}
+
+	if (!upstream)
+		goto done;
+
 	free_commit_list(merge_bases);
+	merge_bases = get_merge_bases(upstream, head);
+	if (merge_bases && !merge_bases->next) {
+		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
+			goto done;
+	} else
+		goto done;
+
+	res = 1;
+
+done:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
@@ -1682,13 +1699,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Check if we are already based on onto with linear history,
-	 * but this should be done only when upstream and onto are the same
-	 * and if this is not an interactive rebase.
+	 * but this should be done if this is not an interactive rebase.
 	 */
-	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision &&
-	    options.upstream &&
-	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+	if (can_fast_forward(options.onto, options.upstream, &options.orig_head, &merge_base) &&
+	    !is_interactive(&options) && !options.restrict_revision) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
@@ -1782,7 +1796,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
 	if (reset_head(&options.onto->object.oid, "checkout", NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD | 
+		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
 		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
 		       NULL, msg.buf))
 		die(_("Could not detach HEAD"));
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 460d0523be..604d624ff8 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -295,7 +295,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
 		echo two >>init.t &&
 		git commit -a -m two &&
 		git tag two &&
-		test_must_fail git rebase --onto init HEAD^ &&
+		test_must_fail git rebase -f --onto init HEAD^ &&
 		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
 		grep "show.*$(git rev-parse two)" stderr
 	)
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b60b11f9f2..f054186cc7 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1066,7 +1066,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
-	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
+	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
 	test_must_fail git rebase --edit-todo &&
 	git rebase --abort
 '
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 3e6362dd9c..414b4216d6 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -54,6 +54,6 @@ test_expect_success 'add work to upstream' '
 changes='our and their changes'
 test_rebase_same_head success '--onto B B'
 test_rebase_same_head success '--onto B... B'
-test_rebase_same_head failure '--onto master... master'
+test_rebase_same_head success '--onto master... master'
 
 test_done
-- 
2.21.0.199.g48d46b195d.dirty

