Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614C2C433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8B20768
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4gzNa7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgHJW3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgHJW3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD81C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so9625341wrs.8
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TeBHYImu6vdjcaZWV7+LSaua+KBLFMSk/ClK8QtyKF8=;
        b=W4gzNa7drC73pbqnWhQpF5gU3k/gzJDwtjRqBrVA708Ex8wUN67rw9Oyqu3aCYVIqk
         c7ZsBylRZJnVJpohzvehwfNtPENWiJATAjKufAgQxBC8LeL9BiJthf1Kw8gWrugfGw7N
         swELTfF2LuGHpXKQ1Q0EZb81zplcSCgvEQQIb9ffIpNsZY7IYm1BXIVUKViJLczS63qP
         7NmTtXPUICx4isXc6d2NVNMzZgRwDYyvWqFcbDh1JZg891QwlCJgfxqHCLyp22kyF39H
         n/frwvexE3wVnsCcoCjqsioC0bb5KD819ZbN1aMLzPU1Es9mCi3jZk/Qrtt38GvsuDaI
         GnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TeBHYImu6vdjcaZWV7+LSaua+KBLFMSk/ClK8QtyKF8=;
        b=j3VfcNNbKG5NAP36cYGqYipScJHlqTeFsRKh83wp2kwLgc5mZbiYuxqIfzBiXlLyBh
         y96n2OquphHCfPugJezeVM/hj4k92aFMrepIPTN5ApABkaf7SOB2qIwiSe6TbYnvjODN
         spre2/ZK0nh4Fs/HmJon+8z+sQzX70tMPeEO/OrKluCGsVFjmLXgVdUrbNMBgAxSWt7h
         Y8PnSCAdpumncf37cfOhM/X27LLtYj+dby1zRg8aBMWKZcM7z6XF4CHdiTCE7Uyu/A4K
         STH6I+7D+LRrGsTqbEsC0aNNPMyDqqNygmdfHooRAA9cFh22W+wZXoQgcQmqV181f5o0
         H8GQ==
X-Gm-Message-State: AOAM531/vHDDAW3pFxCdR3cI3Mc/bw9MZomQ6i+1t0Q49+tRkBXmh5Qp
        jjHg8vLE1hsWHMGZnR139YaimO2a
X-Google-Smtp-Source: ABdhPJwQVQ0yd9b0VZDLSNsTlpwiD0Lwf9Xn4qrZ8G7JvrHWql2Z2yQVSF9IO4um0o0nGzXSDR+ThQ==
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr25473576wrr.48.1597098568545;
        Mon, 10 Aug 2020 15:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c24sm23117405wrb.11.2020.08.10.15.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:28 -0700 (PDT)
Message-Id: <42e3f699f1c67a8c3d9dbfbf3c79342811d9e9fa.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:17 +0000
Subject: [PATCH v3 09/11] t6422, t6426: be more flexible for add/add conflicts
 involving renames
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

merge-recursive treats an add/add conflict where one of the adds came
from a rename as a separate 'rename/add' type of conflict.  However, if
there is not content conflict after the content merge(s), then the file
is not considered to be conflicted.  That suggests the conflict type is
really just add/add.  Other merge engines might choose to print messages
to the console that just refer to these as add/add conflicts; accept
both types of output.

Note: it could help to notify users if the three-way content merge of
the rename had content conflicts, because when we then go to two-way
merge THAT with the conflicting add we can get nested conflict markers.
merge-recursive, unfortunately, doesn't do that, but other merge engines
could.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh   | 21 +++++++++++++--------
 t/t6426-merge-skip-unneeded-updates.sh |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 2413f517e7..f3929b65c0 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -457,7 +457,7 @@ test_expect_success 'handle rename-with-content-merge vs. add' '
 		git checkout A^0 &&
 
 		test_must_fail git merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/add)" out &&
+		test_i18ngrep "CONFLICT (.*/add)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 2 out &&
@@ -503,7 +503,7 @@ test_expect_success 'handle rename-with-content-merge vs. add, merge other way'
 		git checkout B^0 &&
 
 		test_must_fail git merge -s recursive A^0 >out &&
-		test_i18ngrep "CONFLICT (rename/add)" out &&
+		test_i18ngrep "CONFLICT (.*/add)" out &&
 
 		git ls-files -s >out &&
 		test_line_count = 2 out &&
@@ -886,12 +886,17 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 		git checkout B^0 &&
 		test_must_fail git merge -s recursive A^0 >out 2>err &&
 
-		# Not sure whether the output should contain just one
-		# "CONFLICT (rename/add/delete)" line, or if it should break
-		# it into a pair of "CONFLICT (rename/delete)" and
-		# "CONFLICT (rename/add)"; allow for either.
-		test_i18ngrep "CONFLICT (rename.*add)" out &&
-		test_i18ngrep "CONFLICT (rename.*delete)" out &&
+		# Instead of requiring the output to contain one combined line
+		#   CONFLICT (rename/add/delete)
+		# or perhaps two lines:
+		#   CONFLICT (rename/add): new file collides with rename target
+		#   CONFLICT (rename/delete): rename source removed on other side
+		# and instead of requiring "rename/add" instead of "add/add",
+		# be flexible in the type of console output message(s) reported
+		# for this particular case; we will be more stringent about the
+		# contents of the index and working directory.
+		test_i18ngrep "CONFLICT (.*/add)" out &&
+		test_i18ngrep "CONFLICT (rename.*/delete)" out &&
 		test_must_be_empty err &&
 
 		git ls-files -s >file_count &&
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index 5a2d07e516..699813671c 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -374,7 +374,7 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
 
-		test_i18ngrep "CONFLICT (rename/add): Rename b->c" out &&
+		test_i18ngrep "CONFLICT (.*/add):" out &&
 		test_must_be_empty err &&
 
 		# Make sure c WAS updated
-- 
gitgitgadget

