Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B65FC7EE23
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 18:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBYSE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 13:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBYSEy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 13:04:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCE136E9
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id fd25so1311699pfb.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHTt+xM4pLLZG/70hEfCPK1rPwktY7yMt7HIUXYsp9E=;
        b=WzlZ54KsorEeSOk8XY33/U3sTS0sG+XBwj4ADcKYd6P4DuvOjdkpDN/5/nTudwDe+r
         dctcgQOk6bN2uvQMDAk86wCbf8OCGqqPOhrjbPDi6HMDqMsMWrn3LlW6/Uf44b5TnL8Z
         8vycpYxsBNRiljICkqjX6xIkffml47X/OZ++/q8ntG1qU0FgHSqfUs5poJP5vgon+VY7
         1YB8WK83eL2xjQmWsK3C/Fg/kaR+tofbfrNgLX7FYRaGWXjLRcUrPZvxLD+mmUHilssS
         SLUe3dojaw4nOSFA0smwFM5raDTq+UzGp1qqjdEDMuCzyxhQR8Z4QoZK/+0r8ASsh3Wg
         9A/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHTt+xM4pLLZG/70hEfCPK1rPwktY7yMt7HIUXYsp9E=;
        b=0leze/A8GB9xNoHAXnwk0F35DU9EXZcot3vpEi56bmDa+ydm79++9lGKwnqzljhx1l
         nBVT7HiF35L1Ccj6lvRpnKo79D7rXaP2sMuZgLCWsk629U7lJ4S6Ben23qfhnWqBDlYw
         +Gog16ADGsawZ2s0P2ZToyt+o2ZGBA44x4E2p5CRVIMywCQ9LUeZcOwPVNg1ecEakytw
         K+CpntxarDkR9fgGwP36sKGUO85Z8zIUzaFocnW8zE2oMz4jb+LjGO7dEdiHX/4AqUFA
         3M8B2u2qnTPmCzK7VxVo6sG81Ydp44STrGlPIvsTa6fx+u62SarTxna5gwC661LyoCk8
         6l1w==
X-Gm-Message-State: AO0yUKUzmNvY/BpMa28S5JJBi3o/2QLMnfj3L1+rIWJmUQNtKwpItCWF
        XNWPrlbSwJoT2n3unph55gy9vUxTFIw=
X-Google-Smtp-Source: AK7set/zzmGr2DR8wrhLt/tHibA4L2hE+HN5rixtSBEaPGmb7b45KX2Zn1K7ftTvz7RtiN6MiqRWFQ==
X-Received: by 2002:aa7:96a3:0:b0:5d4:e4c8:23ac with SMTP id g3-20020aa796a3000000b005d4e4c823acmr11765255pfk.21.1677348291980;
        Sat, 25 Feb 2023 10:04:51 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b005cd17607358sm1473547pfm.87.2023.02.25.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:04:51 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Sat, 25 Feb 2023 11:03:23 -0700
Message-Id: <20230225180325.796624-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225180325.796624-1-alexhenrie24@gmail.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
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

