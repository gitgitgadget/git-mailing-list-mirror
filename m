Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CCAC7114E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F10220718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glGYku4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgBOVhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56090 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgBOVhA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:37:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so13509678wmj.5
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xco9/GJdaM1g2s37nzZLPJOK/ZgCzgn1n+fpm74iqM8=;
        b=glGYku4VvL8qaFK+pF7IFho3dbnbmXeeCAnsfAHGOvZnTg+X+tWcHrpMYrS3YyH6SQ
         UYZby9+8f4qMzCpaw5XlMWzfYyfNnJKeK0DFbgtaZJ1KyViNhatn2NvN2QFZNwHaMOue
         j/8wcL2CTpbVlolJ1hK41duAZSwFzuC5/DHudKJro5L9ZFus+ITTW06s+mDYqZio0OjT
         fEBqtPy9eNMrXIo+q1Zdsg0UXeZ951EYTnaStJypfKfTQguGUhJQZJWFcUl2mFB+VU8B
         LFvVhftGHyvg5lfzkJB3AhCLBPT7/pz5QMNWLo5PqdR2zaQF64SEKFIiQfdQrY2vqT5C
         7aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xco9/GJdaM1g2s37nzZLPJOK/ZgCzgn1n+fpm74iqM8=;
        b=WYNmHKHYttq36fHsjVmFwB94oD0g60pKrw+hkW7OOBsfc2xaK54XAzUTlnN+jnkG7Y
         y0O6GNsgse/P0Z63qt8nD8Cus5FGKPuEY6qddNxV3Zl2pujrATraWTBn3+N6jOxP0n3O
         iCfyqtlJBODcoSkvwHiKG2K3RpEgfdn9J4Fs1C79nw0D2EXYE4XASapvJk4kvyqQQDjf
         9ryzTQOFfBsZk6DREn6aBnlgt5nH73ib+Ozpwu8sD9xC4wUjD5/4l8HFTE0yLTjL6bFr
         nvuAouT+rFQUua4SyO/YABf5QAsdcRrKSXbEKJCyxamq8gr3OM7tloAj3S+oXYyhUsEa
         758Q==
X-Gm-Message-State: APjAAAWgOc5KgpwKVQH55GoFoSeOfvBD9RHnycYjnXOMkkw14nvUuom5
        M7u9pa9kUZdNhVjOdLoI0norZR4z
X-Google-Smtp-Source: APXvYqxZsOydzWBWPtM2uquLXWhgyVPExFVLUvUMuMm9LZUuDnisjTxJtsgvH6l5UL9ble6TxBeQHw==
X-Received: by 2002:a05:600c:2481:: with SMTP id 1mr7391440wms.120.1581802617442;
        Sat, 15 Feb 2020 13:36:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b67sm13611911wmc.38.2020.02.15.13.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:56 -0800 (PST)
Message-Id: <59faaa2f9201c794d10ee0e14ea52c5360e699ad.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:40 +0000
Subject: [PATCH v5 19/20] rebase: change the default backend from "am" to
 "merge"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
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
  * the am backend has safety problems with an ill-timed interrupt.

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
 Documentation/git-rebase.txt           | 13 ++++++++++++-
 builtin/rebase.c                       |  4 ++--
 t/t5520-pull.sh                        | 10 ++++++----
 t/t9106-git-svn-commit-diff-clobber.sh |  3 ++-
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 93092da3bf6..fbac1cf38dd 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -315,7 +315,7 @@ See also INCOMPATIBLE OPTIONS below.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.
+	upstream side.  This is the default.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
@@ -683,6 +683,17 @@ accident of implementation rather than by design.  Both backends
 should have the same behavior, though it is not clear which one is
 correct.
 
+Interruptability
+~~~~~~~~~~~~~~~~
+
+The am backend has safety problems with an ill-timed interrupt; if the
+user presses Ctrl-C at the wrong time to try to abort the rebase, the
+rebase can enter a state where it cannot be aborted with a subsequent
+`git rebase --abort`.  The interactive backend does not appear to
+suffer from the same shortcoming.  (See
+https://lore.kernel.org/git/20200207132152.GC2868@szeder.dev/ for
+details.)
+
 Miscellaneous differences
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index f0a862f41b5..db8fd699d79 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -101,7 +101,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "am",	  	\
+		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1917,7 +1917,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			options.type = REBASE_MERGE;
+			imply_interactive(&options, "--merge");
 		else if (!strcmp(options.default_backend, "am"))
 			options.type = REBASE_AM;
 		else
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 3fff6a06fa8..4f9e7f7ff6b 100755
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
index dbe8deac0d2..aec45bca3b7 100755
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

