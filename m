Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F2C2D0D8
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81371206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZFs4ynH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLTRKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46326 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfLTRKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id m8so8918082edi.13
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d4xgvwXx/l2lMtns8eZj50hTfgC0sHw7/l58fdRvfC8=;
        b=NZFs4ynHD3FZbWGxND3xZVyXYc9s35mSbeHVC2lmutIw6GkfAgF2wZn1M8M533QjvB
         cDuPU0a4uX90SxGk7ei1ftgqTsr76QmjwAPzuewctTsVQBHVE2V057vMYWYfn4JCN7w7
         Agd9ni+idso6HynO9AmFQcyuWMWF7dK5mjdHzty2Nam9KvZ7cgxRR8kA2fdLc0Y0Ma34
         jBfsaaG7taDBCdSXnQe6+8IyGSEE0IJ/8FpSuRhGvzkklRXBqxLZkU+hEOoErePkmFv2
         IBzcPlX8REHZwO+0oCk5nFvI8dDjomg1SiA63ZliCuZcfvrqLkeJLnFpDQzqEfXmu1kZ
         ymGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d4xgvwXx/l2lMtns8eZj50hTfgC0sHw7/l58fdRvfC8=;
        b=LWKJ0R25l6Df98J2r6Idj56YRUb3C+iOkxObu8xkqoK7Hhpai3OQumTrn5r78pMMI6
         XMJ6Z58c2hcJP1nQo2skg8Eq/mU+eUk4DjIRFCE7mFMnohOuVnmWChfnC+UljmC1KQi2
         YiKsT5JEBLIcnXMzV/rj6mQVsw7IjzcFgFkuxV5/l8Vsjd4oLJoeMWB8PpA0dLtOQLJb
         nmMGkYO16gJnR+kgOMo6aupNxHnEDX40IKOY43OjMqA4h7E99ann59Uvhr4RAKxJHR3X
         15rcE4bvkvG3D9E2oZ4DZt+4sp7Fm2nVN6GE8l9mJVhAnXM2bQ0DqbaEv2CEVznkTFsf
         CuSA==
X-Gm-Message-State: APjAAAVpOCJa7TLEYjCEEahOMixjXFLeyMhnnYaQJ4fIr1R/Sc+iff+l
        n+i1sub1kf6m1V28uu6HhS9URz6H
X-Google-Smtp-Source: APXvYqxASQAQLo8n81lFk0+6+f8Eck6VGD8sFmZbwmecBMGl6WvkLWfVe0Fof7hdFdZ+c6jC9vZR9Q==
X-Received: by 2002:a05:6402:153:: with SMTP id s19mr17299972edu.149.1576861801951;
        Fri, 20 Dec 2019 09:10:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm1143399ejp.50.2019.12.20.09.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:10:01 -0800 (PST)
Message-Id: <999587933b2ce52db1687922b7d2b6a55049a7e0.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:48 +0000
Subject: [PATCH 15/15] rebase: change the default backend from "am" to "merge"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The am-backend drops information and thus limits what we can do:

  * lack of full tree information from the original commits means we
    cannot do directory rename detection and warn users that they might
    want to move some of their new files that they placed in old
    directories to prevent their becoming orphaned.[1]
  * reduction in context from only having a few lines beyond those
    changed means that when context lines are non-unique we can apply
    patches incorrectly.[2]
  * lack of access to original commits means that conflict marker
    annotation has less information available.

Also, the merge/interactive backend have far more abilities, appear to
currently have a slight performance advantage[3] and have room for more
optimizations than the am backend[4] (and work is underway to take
advantage of some of those possibilities).

[1] https://lore.kernel.org/git/xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com/
[2] https://lore.kernel.org/git/CABPp-BGiu2nVMQY_t-rnFR5GQUz_ipyEE8oDocKeO+h+t4Mn4A@mail.gmail.com/
[3] https://public-inbox.org/git/CABPp-BF=ev03WgODk6TMQmuNoatg2kiEe5DR__gJ0OTVqHSnfQ@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BGh7yW69QwxQb13K0HM38NKmQif3A6C6UULEKYnkEJ5vA@mail.gmail.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 +-
 builtin/rebase.c                       |  4 ++--
 t/t5520-pull.sh                        | 10 ++++++----
 t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index cf1ac2e359..e819889a31 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -309,7 +309,7 @@ See also INCOMPATIBLE OPTIONS below.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+	upstream side.  This is the default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
diff --git a/builtin/rebase.c b/builtin/rebase.c
index eaa5eac59e..1c3d0b97d5 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -104,7 +104,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "am",	  	\
+		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1949,7 +1949,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			options.type = REBASE_MERGE;
+			imply_interactive(&options, "--merge");
 		else if (!strcmp(options.default_backend, "am"))
 			options.type = REBASE_AM;
 		else
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3fff6a06fa..4f9e7f7ff6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -340,7 +340,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -354,7 +354,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" out
+	test_i18ngrep "Resolve all conflicts manually" err
 '
 
 test_expect_success '--rebase fails with multiple branches' '
@@ -774,8 +774,10 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		find .git/rebase-apply -name "000*" >patches &&
-		test_line_count = 1 patches
+		cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
+		grep -v -e \# -e ^$ work >patches &&
+		test_line_count = 1 patches &&
+		rm -f work
 	)
 '
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index dbe8deac0d..aec45bca3b 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -92,7 +92,8 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 
 test_expect_success 'check that rebase really failed' '
-	test -d .git/rebase-apply
+	git status >output &&
+	grep currently.rebasing output
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
-- 
gitgitgadget
