Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909DC432BE
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E346115A
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 01:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhHUBhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 21:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhHUBhb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 21:37:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB8C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:52 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so5161576pjb.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+MXqkEB7gaT/JGgclb/RVeGEojgfSZRg/p88qEgAtE=;
        b=if4O+TSH4FeX/Xx1NGHBgK1zLnrepcg6KMh9wxPKo1IdHhgsnDwyfQCS37WzQkDDJs
         4/c9HwhMBrDnl85l1okmXXgzrcI1ZTm/vHONsnHGZE4J058gtS90/v1qs9HbLr7DZJAo
         7EjQM1lTKGO2B4Mx6cMyETZ8YCLtVvA/LEpSeVmJXOwmx2yjq5EBn9DOXS/PssULcNpz
         7ku6/hkSMdXHJwQmDsRs1XN/hlXV8+uQ/HWXqN/QBxd31QgYXSPGnFSvOOLXy/cb5l2i
         xotxziOJq+E4IerADApZtLyPgXha9wGWEBTdF/IFRB/MSh3YsM+hwovsMRuej7soJNr/
         HMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+MXqkEB7gaT/JGgclb/RVeGEojgfSZRg/p88qEgAtE=;
        b=shTDQzRV5NJJOSDRzUv+S45sNFmo7d6TIEpyDN5DPbY5bg8VaILMSaAadPaPRm09pH
         KUd+G4OOnDF8fvDMlIsQk3TObxppR14wrCREG2dZMyqN815o3PVXW/9ZzC+t2eo16xVf
         T9xa1Mf2XzD3n2gOXdwI/5Zm7zumkgdxXTTtu6g6lReNCUyeTM2dlA+lU24jvmGxUbnE
         i524KZUewEssMq11v/LbnorQNK2fdvkuNRDsxOhbBzHzljmV5feHAbI0iQLRxS4XxA2D
         q8HWmgjIUxR0DyjK83aq3/gwaTyQxFejqeYUNmX0RQRJheiH8dmZkNRiAgpaIV+NfzUe
         uafg==
X-Gm-Message-State: AOAM533wVQB4G7fcPLv60jk6s7FMB008NjJwwCZEsLpYSr7XfGgQ2HJN
        efHv183oIVAjYARDTmKlTPq4fw3/AGeOVg==
X-Google-Smtp-Source: ABdhPJz1tzj1aUIW99WckyMzWW/9Niy2nEnf7h0BHV+c0M5ntF+9V59JiiRRMOXatjyTCQ7bDAuzcw==
X-Received: by 2002:a17:903:22c2:b0:12d:b609:a37e with SMTP id y2-20020a17090322c200b0012db609a37emr18710703plg.68.1629509811896;
        Fri, 20 Aug 2021 18:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id j7sm4132257pjf.39.2021.08.20.18.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:36:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] t6300: don't run cat-file on non-existent object
Date:   Sat, 21 Aug 2021 08:36:33 +0700
Message-Id: <b1b9771913f310829ff142eeb1262a4e8f7e70cb.1629509531.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.254.g68ee769121
In-Reply-To: <cover.1629509530.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com> <cover.1629509530.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6300, some tests are guarded behind some prerequisites.
Thus, objects created by those tests ain't available if those
prerequisites are unsatistified.  Attempting to run "cat-file"
on those objects will run into failure.

In fact, running t6300 in an environment without gpg(1),
we'll see those warnings:

	fatal: Not a valid object name refs/tags/signed-empty
	fatal: Not a valid object name refs/tags/signed-short
	fatal: Not a valid object name refs/tags/signed-long

Let's put those commands into the real tests, in order to:

* skip their execution if prerequisites aren't satistified.
* check their exit status code

The expected value for objects with type: commit needs to be
computed outside the test because we can't rely on "$3" there.
Furthermore, to prevent the accidental usage of that computed
expected value, BUG out on unknown object's type.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6300-for-each-ref.sh | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 0d2e062f79..93126341b3 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -59,18 +59,23 @@ test_atom() {
 	# Automatically test "contents:size" atom after testing "contents"
 	if test "$2" = "contents"
 	then
-		case $(git cat-file -t "$ref") in
-		tag)
-			# We cannot use $3 as it expects sanitize_pgp to run
-			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
-		tree | blob)
-			expect='' ;;
-		commit)
-			expect=$(printf '%s' "$3" | wc -c) ;;
-		esac
-		# Leave $expect unquoted to lose possible leading whitespaces
-		echo $expect >expected
+		# for commit leg, $3 is changed there
+		expect=$(printf '%s' "$3" | wc -c)
 		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
+			type=$(git cat-file -t "$ref") &&
+			case $type in
+			tag)
+				# We cannot use $3 as it expects sanitize_pgp to run
+				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+			tree | blob)
+				expect="" ;;
+			commit)
+				: "use the calculated expect" ;;
+			*)
+				BUG "unknown object type" ;;
+			esac &&
+			# Leave $expect unquoted to lose possible leading whitespaces
+			echo $expect >expected &&
 			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
 			test_cmp expected actual
 		'
-- 
2.33.0.254.g68ee769121

