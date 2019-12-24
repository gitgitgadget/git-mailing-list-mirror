Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F22C2D0D7
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DFF206D3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 19:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbJGGQxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLXTzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:55:12 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44841 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLXTzK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 14:55:10 -0500
Received: by mail-ed1-f68.google.com with SMTP id bx28so18642526edb.11
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lhCCZYi0B8Y5DKm/BdvSQpxajRpqO1GMbHDyvaMtn7g=;
        b=QbJGGQxCOOnJyQDaYy/24GumUGG/nKmwd3WyYa5q9sRhyXYsCVUqckyNNVGRDinjmr
         c7McJaf3/Ug1X/VhrFx+SORKEfPrInW48u9KQBIXGISxiqhAJiBAtv1iXhqcmFPatOY9
         k13p66qcyVFW2UWxlmwP+GisjQbWyrTW5k40ZrvUDhV4PANaB53zayQzUB0znmIkjo1D
         ETYt9CBOecMrUm8nohf/WPpHrI5UqY+sh80eVa23IBhaRNhKcE82ml/mK8cvqLO1YSAw
         yeXNlOV3Ftlra0Gh5mMSyY10u6E4JWRfAs7rwqoIJLQIhEG3WF5ELEqY7Sfc9rCSIFPH
         mKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lhCCZYi0B8Y5DKm/BdvSQpxajRpqO1GMbHDyvaMtn7g=;
        b=gARmEsevQ2j+DNuj/pjaq7LYeAAdSsX1tLWxUnmI/uusy7QhuG3KMMh9n5eQXYjsNg
         dGy5KagT0cGb9HFJaAjZdMj2D/FGWB2PyEb4eWgLXhXJ1zRa+JvAEkeVOpmtPE5VnUxl
         AuMAiDmTwuKY2eZQQ1j1bOKuqo+GiV8BgQ/a8PgCNt9wWXNP+tIHpgJsD+trQPY5xBZz
         2qIoowlnTvdo8JwsEWG91BBKpKX8zVvA/GnUdKXaImE3YIw9OmfSk9eu4egkdR8/1DOv
         Sj/ta0tPE/RdMT2Vg3hs1W83TzFopj+ocNG6XnEOuv60ZD9eFsMnBPLnChR2Y8hb+BO4
         sFnA==
X-Gm-Message-State: APjAAAW6qT+PDNpH3WC0PnmgJfXFnSKI+KfsJpjLSuSXAN0teMMMf1NQ
        Qdrknm5csWgP/1a5Oj4EsHQo2b0g
X-Google-Smtp-Source: APXvYqz4MI/A2x3J2mZj1RjX8Mt3QIiQ1CqRNh8e+qSSg0o17/eVP7CZQ2gU3k/SlVvy40xVofHDdQ==
X-Received: by 2002:a05:6402:797:: with SMTP id d23mr40418986edy.138.1577217307197;
        Tue, 24 Dec 2019 11:55:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25sm2814197ejb.53.2019.12.24.11.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Dec 2019 11:55:06 -0800 (PST)
Message-Id: <b307340f7c79c87b2b5a5a2a25d98ef68be4ba4f.1577217299.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
        <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Dec 2019 19:54:52 +0000
Subject: [PATCH v3 08/15] git-rebase.txt: add more details about behavioral
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

