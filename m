Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C52C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1AC61102
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 09:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbhIHJvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349618AbhIHJuk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 05:50:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E1C0613A3
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 02:49:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so2353407wrb.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IAn3gxCR2OOhHnqKRU34JUQfN7cZYMLTrJ/pUFwl634=;
        b=i5mbjkqdaS4UXoQQD9vajntki2//kscBguydepQU8RnswcfKI+TAzY7HDobtQ8+MdB
         6GZUmJOFxAfH9ZMYUN7gLM5DIHemUw9sxC9TxsZEtpGYO1uPkLjQLwv7TwPZMQIyT9nF
         tL6WJHfclh1vWiWdW1IPqL/1qSlYI6dh2zo0CUMJ2TWFzZCRQig05HDeYjEnAmksHiKQ
         fkDcROxeDTMaeswP2RGxJ1U5FieOJa0tPOo3kL3b04zrZbfKBiQ8dJ1Wajfwx8PxCHdi
         7OofduaNdro3qmC/RJ+n4OwDHYsRNTOAA2wLlK8ZzgIMSWmzcvhtz0i22+IhNK/GFaRR
         Du1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IAn3gxCR2OOhHnqKRU34JUQfN7cZYMLTrJ/pUFwl634=;
        b=S51jke+GJDYBu1yPhhL5mzUzNk0TG4zJ32Iupsn41ksgtpDYF4eTAkHtUcHUoXMFOZ
         gKcEXoCoc18lMmGZqaExXrFoe0kK8ibiumP6r8mD9zvbWId4SoJm/i4ROj6QWreaHzjq
         C/Ixm4bHeJWMobO+V7kGMyHF/7YP5xpVx13te8q44qOMTDNhiwXnzBIVGwc65PRDLKE9
         VOVoySjFAGTjnX8+vF42s4BBco9gr65T8MmZnGfxsDzyFPy8UeUZwMu8FrerDjUBORJl
         nie1bURmN/U5Af3WKcA0GG10xcV8aDIIeiXFjDG81hUTOiYDhbVgT+ozF76OCcvPhBEs
         2zvw==
X-Gm-Message-State: AOAM531UX0oI4cH9PQUYNEtXIe586FWLuIZhItNInNmHQltUnUJz6QkJ
        m0FjIqjJXl4ag9bnFPKzAZHi64PU0f4=
X-Google-Smtp-Source: ABdhPJyxeuwq56MkP+OtMsFKbWOzjw0CRm5JCwir/4dNS3pslbz4XwyzJTCooK4gHTSKz98Buf84Pg==
X-Received: by 2002:adf:c3c9:: with SMTP id d9mr2988242wrg.339.1631094570127;
        Wed, 08 Sep 2021 02:49:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm1909256wme.14.2021.09.08.02.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 02:49:29 -0700 (PDT)
Message-Id: <e87ce4fe2537fa5ab6cedec43dd8ffb241bfe5ce.1631094563.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 09:49:22 +0000
Subject: [PATCH 11/11] rebase: dereference tags
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

Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
should checkout the commit pointed to by <tag-object>. Instead it gives

    error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
    trying to write non-commit object
    710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'

This is because when we parse the command line arguments although we
check that the tag points to a commit we remember the oid of the tag
and try and checkout that object rather than the commit it points
to. Fix this by using lookup_commit_reference_by_name() when parsing
the command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
---
 builtin/rebase.c        | 18 +++++++++++-------
 t/t3407-rebase-abort.sh | 18 ++++++++++++++----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 93fcc0df2ad..8bf7660a24b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1903,13 +1903,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
 		/* If not is it a valid ref (branch or commit)? */
-		} else if (!get_oid(branch_name, &options.orig_head) &&
-			   lookup_commit_reference(the_repository,
-						   &options.orig_head))
-			options.head_name = NULL;
-		else
-			die(_("fatal: no such branch/commit '%s'"),
-			    branch_name);
+		} else {
+			struct commit *commit =
+				lookup_commit_reference_by_name(branch_name);
+			if (commit) {
+				oidcpy(&options.orig_head, &commit->object.oid);
+				options.head_name = NULL;
+			} else {
+				die(_("fatal: no such branch/commit '%s'"),
+				    branch_name);
+			}
+		}
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2f41b06e028..310cd0c736c 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -11,18 +11,18 @@ test_expect_success setup '
 	test_commit a a a &&
 	git branch to-rebase &&
 
-	test_commit b a b &&
-	test_commit c a c &&
+	test_commit --annotate b a b &&
+	test_commit --annotate c a c &&
 
 	git checkout to-rebase &&
 	test_commit "merge should fail on this" a d d &&
-	test_commit "merge should fail on this, too" a e pre-rebase
+	test_commit --annotate "merge should fail on this, too" a e pre-rebase
 '
 
 # Check that HEAD is equal to "pre-rebase" and the current branch is
 # "to-rebase"
 check_head() {
-	test_cmp_rev HEAD pre-rebase &&
+	test_cmp_rev HEAD pre-rebase^{commit} &&
 	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
 }
 
@@ -67,6 +67,16 @@ testrebase() {
 		test_path_is_missing "$state_dir"
 	'
 
+	test_expect_success "rebase$type --abort when checking out a tag" '
+		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
+		git reset --hard a -- &&
+		test_must_fail git rebase$type --onto b c pre-rebase &&
+		test_cmp_rev HEAD b^{commit} &&
+		git rebase --abort &&
+		test_cmp_rev HEAD pre-rebase^{commit} &&
+		! git symbolic-ref HEAD
+	'
+
 	test_expect_success "rebase$type --abort does not update reflog" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-- 
gitgitgadget
