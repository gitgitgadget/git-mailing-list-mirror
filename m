Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D6FC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D668920637
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKCSdqEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404128AbgBNRPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:15:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43540 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404039AbgBNRP2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:15:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so5175534pfh.10
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 09:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=260RQthjWPK0/B4FvbYgx6VGzZewXdwHudhZcrlN+V0=;
        b=PKCSdqEn7UyjInihEjUwupXnjjpkYNxfxPNYzbQlAcdWZG25h7/tGFtdhRSlU907P4
         e66vqInV5WA1Kyn+nLMceazhyorMHBuWbpfELLlEMUyV8uiaNmxeVX+hT9vvBxSW/M1b
         qHXJB0/YCRrvzb1f1S7w3uG2W+CphKbAtXbxBSyzRyxzzppvV6e82VCjwdzpLea6D0N1
         83G+1xHipLjde1MoNf8wXGlPEhvReb+o8j7Y0lTbk7mZ6fLzUyraIbUEHMABDy0qaeZ2
         Ctmz8WQKna5CCGx2seXbyz0BL0ns7qqoJ08WTh057IsIiw6bzRgVVPJVhGkiPje9aejR
         fyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=260RQthjWPK0/B4FvbYgx6VGzZewXdwHudhZcrlN+V0=;
        b=i6uxHL2wbCasfZB+0u5xR1Kcx4BtbAM9z6/pktLity4gihF5kkcKO2g00OLmd976YV
         aYdwv19Cc/hY1fP/x5C0MNs/nthbCXXaYW5qvqpV0gZL6kPpYUo4SIcYmf58d7havGPe
         YGM8nxt7v7gFvK2/bh02uAJIF/Pv7KIE8FVpgyKXBak2zS9VIim+mHsnoxP1Q+J4C16P
         mb3IQTN6Q8Ozorkgjn8CxYVFnpH14d50FyxPQzEYciZoknT+H42ohcGxLrCExfPcSEjF
         be8N8puIugoFqpR0wxhtWZbbLDEBwcV4T/E+fCjhz9zC33j7IpRfav2y+zWZdbuxzHCt
         OENg==
X-Gm-Message-State: APjAAAVPiAl0zR46crfB9ev2MzSlmDb2GxBWl3GtAydryitR4l7ZQiMr
        C4jp5yyI0KxV3F9M9fGf2JDsXDcj9mY=
X-Google-Smtp-Source: APXvYqzddvSntHD16Ek3ynWsGsTQFznWpPDH08A8ZbLiYaXyDow+xHSaw2T/dOUG5JkdWH+AWUX2sQ==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr4573287pga.293.1581700527853;
        Fri, 14 Feb 2020 09:15:27 -0800 (PST)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id p18sm13922706pjo.3.2020.02.14.09.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 09:15:27 -0800 (PST)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        pclouds@gmail.com
Subject: [PATCH v4] unpack-trees.c: distinguish ita files from empty files
Date:   Fri, 14 Feb 2020 09:14:59 -0800
Message-Id: <20200214171459.25754-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20190821032100.73917-1-vcnaik94@gmail.com>
References: <20190821032100.73917-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. Several variations of "reset" and "checkout" should
resurrect the file in the index from HEAD. "merge" (non-fast-forward),
"cherry-pick", and "revert" should all fail with an error message. This
patch provides the desired behavior even when the file is empty in HEAD.

Furthermore, "merge --ff-only" should prevent a fast-forward merge if a
file is marked as intent-to-add. This patch provides the desired
behavior even when the file exists with empty contents in the final
commit.

The affected commands all compare two cache entries by calling
unpack-trees.c:same(). Since a cache entry for an ita file and a cache
entry for an empty file have the same oid, if the two files had the same
mode, then the cache entries were previously considered the "same". This
fix checks the intent-to-add bits so if one or both of the cache entries
are marked as ita, then the two cache entries are not considered the
"same".

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
This patch never made it into pu, but I'll try one more time. I decided to
discard [0], so I tweaked the test cases in this patch.

To repeat, I'm ignoring the validity check of the CE_CONFLICTED and
CE_INTENT_TO_ADD bits in this patch.

[0]: https://public-inbox.org/git/20190801161558.12838-1-vcnaik94@gmail.com/

 t/t3030-merge-recursive.sh    | 25 +++++++++++++++---
 t/t3501-revert-cherry-pick.sh | 49 ++++++++++++++++++++++++++++++++++-
 t/t7104-reset-hard.sh         | 11 ++++++++
 t/t7110-reset-merge.sh        | 31 ++++++++++++++++++++++
 t/t7201-co.sh                 | 12 +++++++++
 t/t7607-merge-overwrite.sh    | 23 ++++++++++++++++
 unpack-trees.c                |  2 +-
 7 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 2170758e38..b07153fa14 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -303,13 +303,32 @@ test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -f "$c1" &&
 
 	test_must_fail git merge "$c5" &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "not possible because you have unmerged files" out &&
 	git add -u &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
+'
+
+test_expect_success 'fail if a deleted intent-to-add file exists in the index' '
+	git checkout -f "$c1" &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git merge "$c5" 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out &&
+	git checkout -f "$c1" &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
 '
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 7c1da21df1..88c15466ea 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -91,16 +91,63 @@ test_expect_success 'cherry-pick on stat-dirty working tree' '
 	)
 '
 
-test_expect_success 'revert forbidden on dirty working tree' '
+test_expect_success 'cherry-pick forbidden on dirty working tree' '
 
+	git checkout -b temp &&
 	echo content >extra_file &&
 	git add extra_file &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "your local changes would be overwritten by " errors
+
+'
+
+test_expect_success 'revert forbidden on dirty working tree' '
+
 	test_must_fail git revert HEAD 2>errors &&
 	test_i18ngrep "your local changes would be overwritten by " errors
 
 '
 
+test_expect_success 'cherry-pick fails if a deleted intent-to-add file exists in the index' '
+	git reset --hard rename1 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "your local changes would be overwritten by " errors &&
+	git reset --hard rename1 &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" errors
+'
+
+test_expect_success 'revert fails if a deleted intent-to-add file exists in the index' '
+	git reset --hard rename1 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git revert rename2 2>errors &&
+	test_i18ngrep "your local changes would be overwritten by " errors &&
+	git reset --hard rename1 &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git revert rename2 2>errors &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" errors
+'
+
 test_expect_success 'cherry-pick on unborn branch' '
+	git checkout -f rename1 &&
 	git checkout --orphan unborn &&
 	git rm --cached -r . &&
 	rm -rf * &&
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index 16faa07813..96a0b779e7 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -43,4 +43,15 @@ test_expect_success 'reset --hard did not corrupt index or cached-tree' '
 
 '
 
+test_expect_success 'reset --hard adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git reset --hard &&
+	git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index a82a07a04a..3346759375 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -292,4 +292,35 @@ test_expect_success '--keep fails with added/deleted merge' '
     test_i18ngrep "middle of a merge" err.log
 '
 
+test_expect_success 'reset --merge adds deleted intent-to-add file back to index' '
+    git reset --hard initial &&
+    echo "nonempty" >nonempty &&
+    git add nonempty &&
+    git commit -m "create file to be deleted" &&
+    git rm --cached nonempty &&
+    git add -N nonempty &&
+    test_must_fail git reset --merge HEAD 2>err.log &&
+    grep nonempty err.log | grep "not uptodate" &&
+    git reset --hard initial &&
+    >empty &&
+    git add empty &&
+    git commit -m "create file to be deleted" &&
+    git rm --cached empty &&
+    git add -N empty &&
+    test_must_fail git reset --merge HEAD 2>err.log &&
+    grep empty err.log | grep "not uptodate"
+'
+
+test_expect_success 'reset --keep adds deleted intent-to-add file back to index' '
+    git reset --hard initial &&
+    echo "nonempty" >nonempty &&
+    >empty &&
+    git add nonempty empty &&
+    git commit -m "create files to be deleted" &&
+    git rm --cached nonempty empty &&
+    git add -N nonempty empty &&
+    git reset --keep HEAD &&
+    git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index b696bae5f5..f00c16d615 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -674,4 +674,16 @@ test_expect_success 'custom merge driver with checkout -m' '
 	test_cmp expect arm
 '
 
+test_expect_success 'checkout -f HEAD adds deleted intent-to-add file back to index' '
+	git reset --hard master &&
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git checkout -f HEAD &&
+	git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index dd8ab7ede1..7e6b7b9a07 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -20,6 +20,16 @@ test_expect_success 'setup' '
 	git add sub/f sub2/f &&
 	git commit -m sub &&
 	git tag sub &&
+	git reset --hard c0 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m nonempty &&
+	git tag nonempty &&
+	git reset --hard c0 &&
+	>empty &&
+	git add empty &&
+	git commit -m empty &&
+	git tag empty &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
 
@@ -192,4 +202,17 @@ test_expect_success 'will not clobber WT/index when merging into unborn' '
 	grep bar untracked-file
 '
 
+test_expect_success 'will not overwrite ita file on fast-forward merge' '
+	git reset --hard c0 &&
+	>nonempty &&
+	git add -N nonempty &&
+	test_must_fail git merge --ff-only nonempty 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out &&
+	git reset --hard c0 &&
+	>empty &&
+	git add -N empty &&
+	test_must_fail git merge --ff-only empty 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 2399b6818b..3e63d175f8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1715,7 +1715,7 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 		return 0;
 	if (!a && !b)
 		return 1;
-	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
+	if ((a->ce_flags | b->ce_flags) & (CE_CONFLICTED | CE_INTENT_TO_ADD))
 		return 0;
 	return a->ce_mode == b->ce_mode &&
 	       oideq(&a->oid, &b->oid);
-- 
2.25.0

