Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43DD520248
	for <e@80x24.org>; Mon,  1 Apr 2019 20:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDAUwF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:52:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfDAUwD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:52:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id 188so5164399pfd.8
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sUd3y9OMtjoY6/rLAj0JLnJi4JVVza1pxCbxcQeQvx4=;
        b=rKGWO7BjYkeXqF9/EmdldZmhUW0x/HXajAN49QCnojBrkONCJKc7HmDOdYiiciEOz7
         7cIgskaanqgVzDk5Y8xIl4APldtYeHklxAsTLlVY5vne7od0s9WMB5fIdgSudHviorZT
         Cfzca5ZBvxJckH4oduCbyj0OD5bLcoOiwd+98/ZVc6GaiARBRls5Fw01+Pk7My9w/nR1
         4TtQ+xErTyAtuH/oQA1AwB6umjce8vb8/ltubZBoP9mf5uxkh8el/YpYzrAjwPCiDaSL
         lMn5gL10VcwQFaRUKPqYEuNplsF7VLrAd36HJvukfxgOBHj1Y+liiJ6P74vo6HEuddl3
         dHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sUd3y9OMtjoY6/rLAj0JLnJi4JVVza1pxCbxcQeQvx4=;
        b=uoGPmCw6Vf86z4xvQrsgbixpb8VZmkazXyIkWJHLpDlWqREl28xa5V/WK389A9KrX6
         MofyD2mQqrJvAelzDm4XnYS5fEiy9QDtvmg2v+YxH6jkax6BLHq82e6h1r/jty+nLRYy
         OV3iypKwtiJ8FXzSv1SYvicKU3oyDJ3cWfoxEoTPsqDum2b5Xmlp5JhDl61JeRzbDwZU
         u/5O0uDgZ09uHymC9Jt+V/RXoKzFIDMZaJRiD+O3fQpv+2OrXxgkty3aZ9Gdj1ImGE9t
         cjUquuaIOXAnui2ZTelGgu1U+Q6hRaZn12dy6PTgVWTZb1w7xzSJRxTsxy0ka+gR5SOR
         bDmw==
X-Gm-Message-State: APjAAAVmRKLYHLAzOssLMubMGoYBicgpexOKw2SRDwJ7wGaP7ci3i9Ug
        XVLQWQj036daC5k3tfIhhmrWOZHg
X-Google-Smtp-Source: APXvYqw7KRMcHDgY1aEVHelMjNlR2hqvb1HrSmSGkC3CPDWYFRjLdaVWnuiRLVcZgguwbr/o+ndkGg==
X-Received: by 2002:a63:4e57:: with SMTP id o23mr59359274pgl.368.1554151922534;
        Mon, 01 Apr 2019 13:52:02 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id t24sm8498523pfe.110.2019.04.01.13.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:52:02 -0700 (PDT)
Date:   Mon, 1 Apr 2019 13:52:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 3/4] rebase: fast-forward --onto in more cases
Message-ID: <281443b2ae2dcf6a5a4d5766d4c006a4d0e22c91.1554151449.git.liu.denton@gmail.com>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
and a fast-forward will be performed.

While we're at it, remove a trailing whitespace.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
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
2.21.0.695.gaf8658f249

