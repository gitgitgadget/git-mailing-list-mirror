Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E62C2D0D2
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC946206CB
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdTst/3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLXTzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:20 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfLXTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:14 -0500
Received: by mail-ed1-f68.google.com with SMTP id f8so18700070edv.2
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9sAEBp03VN0hczQ7xTOnrpthh2uvCvr5S6eq/9p4q/4=;
        b=CdTst/3ZMvI9kWyGcdM9uJV7Dd8keHR7ZWdEWf2uCqtWbvuJIgCr9hwqA4rqgxjzOe
         Fg4X35OUc0gLUcL2AprneU5JlNKy7mBzY+OFUUZqtx3/R6gW/HRA4FdbdZfLi/IIWLvV
         KlNpD/fM7fIJaRQlEqNvjgqBywScsO90jR5Ja9S9HitbKwAW/yU0mrQ7MWB/AKNEMmZa
         VFkBQC1MB4CKZuSsWAVNsV1ULtVrvezDN6KVJsEvEqoJbsq0QmCZCTrOXsBQRhtfFk0N
         P4oobvDS78pmRZUUe9kdzq7/wG9SLjgQNfyVxit6Org8JSSoKnE+p50zuQc6vHkRZkkV
         U/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9sAEBp03VN0hczQ7xTOnrpthh2uvCvr5S6eq/9p4q/4=;
        b=FHjIfufS5MzXNBbHmeGMndf2E7ohHyFi9SEhv3J68sCmxkYLtG4HtAn3wSvj1GOrdc
         oPY/CgKzl1mtmxCdAxU1Xg7oEvJ6R+0chzorIlKwdbO8g0t5OD2nEGqgqpOoiuZUSt8U
         6uWJqou7NKeuPn1PC4ktAxowGoKZ4sazWttboZwexMbGZwC3Xw+9eROumUefhe1OJ6Rr
         tpMbv+nbGkIEuRIWCzEw4yCkxmPMzcODQKrQ2a8xhytzd3rHjiX7APXtrWpio+3J8FKL
         Gk5q9P7Lk/5w1H3OEgD2b+d1tWvruVVyWi3MN5XCJtuZJyNXZpnHzJ0P9Wzj7W9fR/LF
         MY7Q==
X-Gm-Message-State: APjAAAX2y7eHdF0+joatC43DQdEdxxO4rTDri6lnBRIvjTKqefTK8Xtw
        mth5zNEEZMFegVnbJsKjFIonUkQF
X-Google-Smtp-Source: APXvYqx6mBUFRZNsZPHQyq6szV23wfXUZU2I2FyTGvxVsHEZbTxkrhodahWF9UhrrTWsPAiccfMCjg==
X-Received: by 2002:a50:d905:: with SMTP id t5mr40692229edj.67.1577217312625;
        Tue, 24 Dec 2019 11:55:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm2862659ejj.25.2019.12.24.11.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:12 -0800 (PST)
Message-Id: <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:59 +0000
Subject: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
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
index d602b2da4c..938a8840b1 100644
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
@@ -1945,7 +1945,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
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
