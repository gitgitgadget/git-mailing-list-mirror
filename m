Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD084C2D0D7
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B864206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXJ+kAge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLTRKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:04 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLTRKC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so8934672eds.8
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=BXJ+kAgeQxHl8Mo/8UQ2+dVlK9e4Q2WUN9DiOH3zEDQA5pRO2uokqT54rgB7cb87LB
         ZOXAauUbbbmfF+0D+yP8svVcQnY1M0z+GvoFzeExxyj9Q3LjkygUI4lyx2TjkTlJQDoD
         H5+M2qmvCJ4tObvepljFOrcAOEKZLvt3K7BLxYV6Pug0zEROUdbz7Xtb5ztyi2+awahY
         qraxsJIIAjfgqOyo2GhaY1wWqjDWMYf4XLVpmj2g14HftNDe4LHKG4azbplzB7d4d0Tm
         RtKv+/sG0bwclgMKVHn/JdP6eKG6JTP09IuFOjLJMX3Ap/fIO4Wbo8eHPO8OVZtjBcc0
         nu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=JG3G7OIUvpDk51wYTmEsKNqVlD1DjdsEc2rvNZ2zN4MBCVyCp0ndMZ23jYFSHTPIZE
         rcuwyRinx62fYWAkL7mQK8Ln8iFBaaHXajdiGI1coJWFIc2sOpMSJAbTBOw3QeBtQEL3
         ibcXwTLoCM8v1+/0cjV4N4kftYJG40XOxUlhd2rOZzx2MdAxNNwMJYmig748E5Fwv+ow
         avzG6QBilo0N9PCw/FPTPP7hN2f6Mvpw7eCyPeESz7maFEZFsQ5FYdg0ViDw7UnjOnqb
         x7b32FTdV261bBbfQDvoeYp/T75J6ee3qCM2T9VfYp5EFthaQRcEXbwxa1J0OUDRHKoe
         bXPw==
X-Gm-Message-State: APjAAAV9alrbRU9kFITIH7cy5j/qhVkrV+p1z6Hi5Vwz1CaCki7owFe8
        aTisiP5Vv9qCXARi03Pxh5ZzSTO2
X-Google-Smtp-Source: APXvYqynXPj+5uoYt+6ieesYC2C/4LE3ubUJWHJj4NRcmGAn7j/nkBPz+Gqs2XGBnKHCLaxtjTmBeA==
X-Received: by 2002:a05:6402:1ac4:: with SMTP id ba4mr16669169edb.201.1576861800593;
        Fri, 20 Dec 2019 09:10:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm1158893ejx.20.2019.12.20.09.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:59 -0800 (PST)
Message-Id: <81d0f18b3e296230b60fddb97720c708e35dce1a.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:46 +0000
Subject: [PATCH 13/15] rebase tests: repeat some tests using the merge backend
 instead of am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to ensure the merge/interactive backend gets similar coverage
to the am one, add some tests for cases where previously only the am
backend was tested.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh                   | 17 +++++++++++++++--
 t/t6047-diff3-conflict-markers.sh | 13 +++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 602d996a33..3fff6a06fa 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -277,14 +277,27 @@ test_expect_success '--rebase' '
 	test_cmp expect actual
 '
 
-test_expect_success '--rebase fast forward' '
+test_expect_success '--rebase (merge) fast forward' '
 	git reset --hard before-rebase &&
 	git checkout -b ff &&
 	echo another modification >file &&
 	git commit -m third file &&
 
 	git checkout to-rebase &&
-	git pull --rebase . ff &&
+	git -c rebase.backend=merge pull --rebase . ff &&
+	test_cmp_rev HEAD ff &&
+
+	# The above only validates the result.  Did we actually bypass rebase?
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
+test_expect_success '--rebase (am) fast forward' '
+	git reset --hard before-rebase &&
+
+	git -c rebase.backend=am pull --rebase . ff &&
 	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 860542aad0..d383ce8130 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,7 +186,7 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
-test_expect_success 'rebase describes fake ancestor base' '
+test_expect_success 'rebase --merge describes parent of commit being picked' '
 	test_create_repo rebase &&
 	(
 		cd rebase &&
@@ -194,7 +194,16 @@ test_expect_success 'rebase describes fake ancestor base' '
 		test_commit master file &&
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge master &&
+		grep "||||||| parent of" file
+	)
+'
+
+test_expect_success 'rebase --am describes fake ancestor base' '
+	(
+		cd rebase &&
+		git rebase --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --am master &&
 		grep "||||||| constructed merge base" file
 	)
 '
-- 
gitgitgadget

