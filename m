Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9224FC33CA3
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6980C2075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqEHXhD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgAGExp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:45 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36630 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgAGExl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:41 -0500
Received: by mail-qv1-f67.google.com with SMTP id m14so4110669qvl.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znwb9Sje/8O77iNvWb/cukk/sZqJTNSKosYDU3GOKZk=;
        b=uqEHXhD5kZtz+7/TxUMNqwULSedRVT3/WHzB5yGMd3IhhC3Gi7ptpX3UOfj8ezJ46l
         tMay6y2nJMwp/OzWWx8ti1wLtWSu7BeVojbwZ63FH3k5pOApk0ua+ymrq5HqW38nNq6r
         J+644hdvy4ZAeplkZbbnnRUvKKJqvP8HFKWn5Chua4woAcifV4hGTRcF6AazHSAetACg
         XkaXqVyfjvNORNCncjoTlOwtRTo/o4O43CVPlCyIcC+W9WzbLKmBFWVIqq1YOf4J72GN
         MaMg2aY934PzMhigliWa/hVRLAOwwCcrVjOPTIVjgrXHG6tDyBM1JLtl1Hbzvl0do7r8
         7n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znwb9Sje/8O77iNvWb/cukk/sZqJTNSKosYDU3GOKZk=;
        b=ODVzquTZV84cZz5DSZ7on9aMrDkqXjWGb/q4dowAZ/p64BPUxVkAP4+mTdw8iagsBP
         1FCMLTxY1zj6yM+1UbAcurI4WGFn1iqFBSUjL/hoPnjbIc4dBrcmWRfEf8ZcfDXoh/rc
         UOI5NG/mOGfndEltRdyKv9EDVso6BN8ow+o9nPHveynmlGqjFAY+j57kcEQom4jV8Ho7
         6vaoWDkIutfmZo8+JjXHtZkUtDe5xB+pB6S7xv0BPUzvosWu/l1wyhPi5dlwueItMaTb
         7fF0k+Maz15uGdhm2MqJytLdHMZxv2o4NESQBP7zJHlbXnUvpjvhFoSLrts7X1yf6D2y
         PuJw==
X-Gm-Message-State: APjAAAV6Nw9pR1btQJqpyvbhaJGm3wag2vX4pVip3q08AoApcRWziT46
        BaGdxMBnZ4omZtKfhl3Cs+DZerck
X-Google-Smtp-Source: APXvYqw5sjLsytFfPFZNUj6JDBi0kjwizVnQaiOkQ1IdUAYddLpAcTrssifuduE5pksP1rO9V5fvJA==
X-Received: by 2002:a0c:f24a:: with SMTP id z10mr83577163qvl.33.1578372820606;
        Mon, 06 Jan 2020 20:53:40 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:40 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/16] t3507: use test_path_is_missing()
Date:   Mon,  6 Jan 2020 23:53:12 -0500
Message-Id: <69125b8e2f33e9e538263829b0bcfc08c4812684.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() function should only be used for git commands since
we should assume that external commands work sanely. Replace
`test_must_fail test_path_exists` with `test_path_is_missing` since we
expect these paths to not exist.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 2a0d119c8a..9bd482ce3b 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -168,7 +168,7 @@ test_expect_success 'successful final commit clears cherry-pick state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git commit -a &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears cherry-pick state' '
@@ -178,7 +178,7 @@ test_expect_success 'reset after final pick clears cherry-pick state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git reset &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'failed cherry-pick produces dirty index' '
@@ -387,7 +387,7 @@ test_expect_success 'successful final commit clears revert state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git commit -a &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears revert state' '
@@ -397,7 +397,7 @@ test_expect_success 'reset after final pick clears revert state' '
 	echo resolved >foo &&
 	test_path_is_file .git/sequencer/todo &&
 	git reset &&
-	test_must_fail test_path_exists .git/sequencer
+	test_path_is_missing .git/sequencer
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
-- 
2.25.0.rc1.180.g49a268d3eb

