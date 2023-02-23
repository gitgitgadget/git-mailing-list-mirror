Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0399FC636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 05:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjBWFes (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBWFer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 00:34:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAD2271D
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:34:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gi3-20020a17090b110300b0023762f642dcso769978pjb.4
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHTt+xM4pLLZG/70hEfCPK1rPwktY7yMt7HIUXYsp9E=;
        b=LUTCU0h1VPP4P7Fuazrpz1ZpclAgeYe1WQ6Co/Wgky9krAJrYehx3KWI2blR8pbV1m
         i2GVjqqZRF2BgbtmMetxucac3yafb1K19cDSTRn8r5T7GyMlzakoKH4+iH9IqcdlFbPz
         esImIFAGBk80hVsgAxtvydAlHMeseWb0D0Uud1WvkCguTwvp+IvlW2XeZkfFSZSMBvJF
         jV9DndCwu+Q3ojBDBJ60DWtl1vLEbiFg741OJbsjfasw6+MzqSSgAa9cBsFxG+25Q47O
         AULXGP2S+xIDReTb8OLXxJM1185VW8Rf3toMhC0RjGEB+djiTKhGK6KWPzC9yVu/V23r
         Q8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHTt+xM4pLLZG/70hEfCPK1rPwktY7yMt7HIUXYsp9E=;
        b=F6zqInd/BVjaSWzWBtmn13uJNo6Dmn0rnqJW+JtEzyPvB5EIrQHghvq9NNfbNoXbft
         nj5OMIaZVFld5D0tVFopPtomk79XXM6NHAQs1jDe6xcY9ubgltJKQgUNJEhxvWFpJrPC
         F1Q9zIccqnB6V5qoZlH7BVYoODRmFsya+81+Fkiv7Y8QpoMKlah5NHKuvp4x8gpsaaFq
         i43JXBNupFc7ejjiUHrKJjw+sqndJEefQRlMg5QS0ZcAPYUj0+tLa7A44rPRAhrm8flS
         nBvN2oSS8DcAtfS10HWqV/LAuSaVGrNZztvloDRgXxq85Zmip/YN8zesD73LE4TS4705
         DxVA==
X-Gm-Message-State: AO0yUKVZWXRBaPA3lg+Y99AqJnv/8PQJplo5A8SiZZ/dU1m/5y1/QPkM
        75I5YWxYcZL+WmW3jatINKDsOuw+qsI=
X-Google-Smtp-Source: AK7set/Ao3ss31mJPAC4flqgh0vHFh1Q9cNuYXwiOaTqdKUbyVJP4YEt67tQeTQndoJ99kbrXaliXQ==
X-Received: by 2002:a17:90b:3e86:b0:234:28ac:ec57 with SMTP id rj6-20020a17090b3e8600b0023428acec57mr12921315pjb.21.1677130484732;
        Wed, 22 Feb 2023 21:34:44 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090a728d00b00233aacab89esm3943608pjg.48.2023.02.22.21.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 21:34:44 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v4 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Wed, 22 Feb 2023 22:34:08 -0700
Message-Id: <20230223053410.644503-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt |  4 +++-
 t/t3430-rebase-merges.sh     | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..c98784a0d2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,13 +529,15 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do not
 have `<upstream>` as direct ancestor will keep their original branch point,
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..d46d9545f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,16 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

