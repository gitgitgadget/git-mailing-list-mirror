Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7989BC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496F02073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSsE8ZdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgHJW3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgHJW3b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3456C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so9603577wrh.10
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9Lrw6sN2XIQeBtapPHDCsWzdsNThDKuXUCzgi0LJ+k=;
        b=VSsE8ZdC31nQYZZcjqoIdEIJ434cQ4ilbRDaAGGt6nOE+L1o8EBDfVSHoijdOTGTtq
         VALKVFC0Y4WiOA6eRKvq3VwK+ChAdU6S+AcqIoAOf6C61TC2Pvpa9LfreBHxgtjwC7a6
         PVvDvb2VGvatTVzSAMrM5GOJ0h+xsL162sk38j+PQ1Hrape08wP9t8drRdQPHq8zkY0L
         Wiz3CHQcBLcGElO+hYfZGhriTIQxgJtdHOJk/bVqF0A5eEAD3AsfWpTfzfJUV3JAN34i
         YPikbGLlUJP02iHx1p0I6f1hODBCTVP4hq+D2cSciUTJRB0JSOFdeCibWrwew3xzfF91
         2HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+9Lrw6sN2XIQeBtapPHDCsWzdsNThDKuXUCzgi0LJ+k=;
        b=aODhx7XjORLvgHP/QsuG5WEbekYUx55wBmI623kCqgi99zHA+3S7oKUBIEr1ESLeTk
         kJDGbKoIdlmU4NMRq6PuHguof6a8rW2AT0vzZ7mZRuM66yiBRFW92d+IHXh/ghPosVSQ
         eKQQPRj8meheGxGm3KhCK1HYkCkFvJbPwtv3RGU/oBU8vgYa8+TVsYkj6LVv6vdVzUvn
         bbaJZ5+ptPQ59QZyI40v7elcVtTHeQYy/EhThVYfibkv1k8nb+hmqsVMGQnz/rs4ETJa
         E72sXuhJZJzqxBTc0mjs/kLXsflOqRp8mlkekdi07BTObaZAxBnrVHpPF5O6n4mv5BKp
         kb7w==
X-Gm-Message-State: AOAM531n66iC+lRR5DbjtR8f84iPLrqkapAhLe12bGVNwW9AFgWnPc21
        sfErsNkPiq/mfCgQlJXxpq8XTJey
X-Google-Smtp-Source: ABdhPJxs72CiLRMcc/PE9N3oF8dQsR/xREXKgOXCj/TUQ5N58gmtRLD5Jb1XgwMNOREN/P3mPwHINw==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr3576343wrp.198.1597098569401;
        Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m126sm1707452wmf.3.2020.08.10.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:28 -0700 (PDT)
Message-Id: <456160f3a73bf33e3e696405019996efa99ae379.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:18 +0000
Subject: [PATCH v3 10/11] t642[23]: be more flexible for add/add conflicts
 involving pair renames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Much like the last commit accepted 'add/add' and 'rename/add'
interchangably, we also want to do the same for 'add/add' and
'rename/rename'.  This also allows us to avoid the ambiguity in meaning
with 'rename/rename' (is it two separate files renamed to the same
location, or one file renamed on both sides but differently)?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 18 ++++++++++++------
 t/t6423-merge-rename-directories.sh  |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index f3929b65c0..3375eaf4e7 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -583,7 +583,7 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		git checkout B^0 &&
 
 		test_must_fail git merge -s recursive C^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 2 out &&
@@ -959,11 +959,17 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git checkout A^0 &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
 
-		# Not sure whether the output should contain just one
-		# "CONFLICT (rename/rename/delete/delete)" line, or if it
-		# should break it into three: "CONFLICT (rename/rename)" and
-		# two "CONFLICT (rename/delete)" lines; allow for either.
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		# Instead of requiring the output to contain one combined line
+		#   CONFLICT (rename/rename/delete/delete)
+		# or perhaps two lines:
+		#   CONFLICT (rename/rename): ...
+		#   CONFLICT (rename/delete): info about pair 1
+		#   CONFLICT (rename/delete): info about pair 2
+		# and instead of requiring "rename/rename" instead of "add/add",
+		# be flexible in the type of console output message(s) reported
+		# for this particular case; we will be more stringent about the
+		# contents of the index and working directory.
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 		test_i18ngrep "CONFLICT (rename.*delete)" out &&
 		test_must_be_empty err &&
 
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 2b4a482277..f7ecbb886d 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -275,7 +275,7 @@ test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict'
 		git checkout A^0 &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 8 out &&
@@ -1686,7 +1686,7 @@ test_expect_success '7b: rename/rename(2to1), but only due to transitive rename'
 		git checkout A^0 &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 4 out &&
-- 
gitgitgadget

