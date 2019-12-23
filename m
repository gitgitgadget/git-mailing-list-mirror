Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E969C2D0D6
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41FC2073A
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMe18cza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWSuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33967 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfLWSuK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id l8so16132844edw.1
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lhCCZYi0B8Y5DKm/BdvSQpxajRpqO1GMbHDyvaMtn7g=;
        b=YMe18cza7mPddi0OZs6CyEi5qo9FPfU99XNCPxBZX5Lud+HFT9Xb5shVB3OEBhE1Sp
         r2V33j7cz35uB/nOmqCG8I5FQN0Jyn1wj+r7rXrSJmsNkNlJ7mKGeqpudhIHac4zXZwk
         p9lxYAPMYlZGsG4MnzshEYNUyUWfwZ5tD4DiRdtE8QxnDbPaxt+Vg1RHnk2f0EqQQUMl
         KrcCqRVhyNIBEPATQZbiNngMuZrYG0IgbCyzhl80eaCNTJOtX57YFESiAonmj8GNmrYj
         F44vUymLI3qxz1rCT0c+VZFDECYHV4x5kuQa3eV3MfMUfsyEJ9cgb90jGRIErJOhmdIX
         lpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lhCCZYi0B8Y5DKm/BdvSQpxajRpqO1GMbHDyvaMtn7g=;
        b=Sj9X97tjZd2wN+yYxgttsCzw96AjonB5BAo98NivQJ5kyAyJiUdgRWLv/4OQB2bnZQ
         pSrpfrevKvYSvO+02URJ1csN8aWWIFCLj1ZXMOFwNMpjcC88ffhHFgNizDXyhy4gWx93
         lcVeqXVrYuy2lo7Au5NcILIkfHP3I5OTkOKC8GpZjl3p0KsWdjDZSDrMsPp/IgcFqg9q
         JVaSUlF76SKFpuEL2Fy3xeGJjY+qOy1k5rnfVBBd1NTW71oyiawYfND6vKUv7mDz/6HR
         9drubzRK0BVUjl3IuwdAe43e8AK+w9mFqDhKfYHmIO2OGuJYGlzzVGJQwi/zRlpuMkzU
         kEeA==
X-Gm-Message-State: APjAAAWtgUvv5yby3mTWcv68dRWK53x6wsN+gG4NmX+X2xK4BgJVXPXL
        n6ZvoiXcyAPD4QKUZ+TNsNdt/b18
X-Google-Smtp-Source: APXvYqwrnvI9sqEwFD7BIj9Vxb/bNtVgbcfW/IcejGoBdZJWjvPAo9tAdUKAy/ghU+oYJUbo1DEvLw==
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr34342548eds.183.1577127007114;
        Mon, 23 Dec 2019 10:50:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay8sm2420564ejb.6.2019.12.23.10.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:06 -0800 (PST)
Message-Id: <b307340f7c79c87b2b5a5a2a25d98ef68be4ba4f.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:52 +0000
Subject: [PATCH v2 08/15] git-rebase.txt: add more details about behavioral
 differences of backends
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt            | 102 +++++++++++++++++++++---
 t/t3433-rebase-options-compatibility.sh |   5 +-
 2 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index ff32ca1080..f1ace07c38 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -409,13 +409,10 @@ your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
-	Behaves differently depending on which backend is selected.
-+
-'am' backend: When applying a patch, ignore changes in whitespace in
-context lines if necessary.
-+
-'interactive' backend: Treat lines with only whitespace changes as
-unchanged for the sake of a three-way merge.
+	Ignore whitespace-only changes in the commits being rebased,
+	which may avoid "unnecessary" conflicts.  (Both backends
+	currently have differing edgecase bugs with this option; see
+	BEHAVIORAL DIFFERENCES.)
 
 --whitespace=<option>::
 	This flag is passed to the 'git apply' program
@@ -609,9 +606,94 @@ There are some subtle differences how the backends behave.
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Directory rename heuristics are enabled in the merge and interactive
-backends.  Due to the lack of accurate tree information, directory
-rename detection is disabled in the am backend.
+Due to the lack of accurate tree information (arising from
+constructing fake ancestors with the limited information available in
+patches), directory rename detection is disabled in the am backend.
+Disabled directory rename detection means that if one side of history
+renames a directory and the other adds new files to the old directory,
+then the new files will be left behind in the old directory without
+any warning at the time of rebasing that you may want to move these
+files into the new directory.
+
+Directory rename detection works with the merge and interactive
+backends to provide you warnings in such cases.
+
+Context
+~~~~~~~
+
+The am backend works by creating a sequence of patches (by calling
+`format-patch` internally), and then applying the patches in sequence
+(calling `am` internally).  Patches are composed of multiple hunks,
+each with line numbers, a context region, and the actual changes.  The
+line numbers have to be taken with some fuzz, since the other side
+will likely have inserted or deleted lines earlier in the file.  The
+context region is meant to help find how to adjust the line numbers in
+order to apply the changes to the right lines.  However, if multiple
+areas of the code have the same surrounding lines of context, the
+wrong one can be picked.  There are real-world cases where this has
+caused commits to be reapplied incorrectly with no conflicts reported.
+Setting diff.context to a larger value may prevent such types of
+problems, but increases the chance of spurious conflicts (since it
+will require more lines of matching context to apply).
+
+The interactive backend works with a full copy of each relevant file,
+insulating it from these types of problems.
+
+Labelling of conflicts markers
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When there are content conflicts, the merge machinery tries to
+annotate each side's conflict markers with the commits where the
+content came from.  Since the am backend drops the original
+information about the rebased commits and their parents (and instead
+generates new fake commits based off limited information in the
+generated patches), those commits cannot be identified; instead it has
+to fall back to a commit summary.  Also, when merge.conflictStyle is
+set to diff3, the am backend will use "constructed merge base" to
+label the content from the merge base, and thus provide no information
+about the merge base commit whatsoever.
+
+The interactive backend works with the full commits on both sides of
+history and thus has no such limitations.
+
+--ignore-whitespace
+~~~~~~~~~~~~~~~~~~~
+
+The --ignore-whitespace option is supposed to ignore whitespace-only
+changes if it allows the code to merge cleanly.  Unfortunately, the
+different backends implement this differently, and both have different
+edge case bugs.
++
+'am' backend: When applying a patch, ignore changes in whitespace in
+context lines if necessary.  (Which implies that if the whitespace
+change was not in the context lines but on a line with a real change,
+then the rebase will still fail with "unnecessary" content conflicts.)
++
+'interactive' backend: Treat lines with only whitespace changes as
+unchanged for the sake of a three-way merge.  This means that if one
+side made no changes and the commits being rebased had whitespace-only
+changes, those whitespaces fixups will be discarded despite the fact
+that they present no content conflict.
+
+Miscellaneous differences
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are a few more behavioral differences that most folks would
+probably consider inconsequential but which are mentioned for
+completeness:
+
+* Reflog: The two backends will use different wording when describing
+  the changes made in the reflog, though both will make use of the
+  word "rebase".
+
+* Progress, informational, and error messages: The two backends
+  provide slightly different progress and informational messages.
+  Also, the am backend writes error messages (such as "Your files
+  would be overwritten...") to stdout, while the interactive backend
+  writes them to stderr.
+
+* State directories: The two backends keep their state in different
+  directories under .git/
 
 include::merge-strategies.txt[]
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 5166f158dd..bd4d2d2f63 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -10,9 +10,8 @@ test_description='tests to ensure compatibility between am and interactive backe
 GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
 export GIT_AUTHOR_DATE
 
-# This is a special case in which both am and interactive backends
-# provide the same output. It was done intentionally because
-# both the backends fall short of optimal behaviour.
+# This is a common case in which both am and interactive backends
+# provide the same output with --ignore-whitespace.
 test_expect_success 'setup' '
 	git checkout -b topic &&
 	q_to_tab >file <<-\EOF &&
-- 
gitgitgadget

