Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D5C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841712098B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 11:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWvalAoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393738AbgJTLo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 07:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392939AbgJTLo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 07:44:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D382C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p11so892943pld.5
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=uWvalAoG19n8c6l/R/rHLTsCKmsdG6mMIapV+Bs6hLfh3gCfZfm+ud0GUY+0pAZ1oS
         e2ZKkBZ7d9GLucCGqK+BML9Zx3TjJwF54u3o2vZEJaB80KkU880fCHs8KTJuMx7Ck01W
         r+DSIXwQcIi3z0N7b5YGw5/fMoV7tt/SlESqbM+e8JKikeBLj0DPA2I4T81zVBFOgZ0q
         q9Gsu2Bi3mXShkeVdZB2fRqUi6uIfeC/C8ZjQH+JTc2fOUDxq/02A7SdLA/bqnT3unsg
         D/NJMIGTKcFrZh7XJW8jo3Ngky6A+uw5k24SRCCyC03i1sz2Qi6MReI8xJ+qMBEWSG2n
         LkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6NWybie0Yh+VX1qO8s6tAnf9JU7GOn9SLYT0uupmuA=;
        b=tIbLNO7SAW24KHMtkRKBqUi/zXVA0qxwTGs2M2IJ4A45u90HzSx2x4WknuhmLvLzyN
         PT+OUqoI0l0knQcmDb5TWzHvGcKDvsFeljn/63cjkTtFXRjeTFwHLTHnXypsvjoN0CaV
         /DehsiX71OWueBtGyvX2HWnoUV92YpykLdsQH1867u9oWdCeI7CYPtZhXSow+CLhuxe4
         NSN7v4n2SEFRecRzGkNa/MO7ejai2C+gqX5swE+SPXdkG6w7XV/HNmn+Y6qrEQXOyZZM
         +W5v5ir+NBSUPyl3cJ4rrQxqYnwTTKuvkoDx4PupHO8KE0U9Uwe101s2yvhdIyvGMglq
         qTmg==
X-Gm-Message-State: AOAM530hl0NY4Fxq1ZnSvhCbqzcnu6wu/diUJsJI/5Udqkb+sVTa/zTN
        /MIvkxx/KLyBZaDKwoFhYbiqMypDfSdRPnj0
X-Google-Smtp-Source: ABdhPJx/9a9G1YzdxtIgSZlsDEINVHN3c7cUdi4z4kvKvl7zrdbZmjLTBHS71n+aTzQOBnJjNZigBg==
X-Received: by 2002:a17:90a:ba03:: with SMTP id s3mr901197pjr.106.1603194265714;
        Tue, 20 Oct 2020 04:44:25 -0700 (PDT)
Received: from localhost.localdomain ([106.215.55.55])
        by smtp.gmail.com with ESMTPSA id y22sm2204615pfr.62.2020.10.20.04.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 04:44:24 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, congdanhqx@gmail.com, me@ttaylorr.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v3 5/5][Outreachy] t7201: put each command on a seperate line
Date:   Tue, 20 Oct 2020 17:13:19 +0530
Message-Id: <20201020114319.18245-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201020114319.18245-1-charvi077@gmail.com>
References: <20201017075455.9660-1-charvi077@gmail.com>
 <20201020114319.18245-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modern practice is to avoid multiple commands per line,
and instead place each command on its own line.

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7201-co.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5898182fd2..b36a93056f 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -157,7 +157,8 @@ test_expect_success 'checkout -m with merge conflict' '
 '
 
 test_expect_success 'format of merge conflict from checkout -m' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout -m simple &&
@@ -180,7 +181,9 @@ test_expect_success 'format of merge conflict from checkout -m' '
 '
 
 test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 
 	fill b d >two &&
 	git checkout --merge --conflict=diff3 simple &&
@@ -205,7 +208,9 @@ test_expect_success 'checkout --merge --conflict=diff3 <branch>' '
 '
 
 test_expect_success 'switch to another branch while carrying a deletion' '
-	git checkout -f master && git reset --hard && git clean -f &&
+	git checkout -f master &&
+	git reset --hard &&
+	git clean -f &&
 	git rm two &&
 
 	test_must_fail git checkout simple 2>errs &&
@@ -218,7 +223,8 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 test_expect_success 'checkout to detach HEAD (with advice declined)' '
 	git config advice.detachedHead false &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at $rev" messages &&
 	test_line_count = 1 messages &&
@@ -237,7 +243,8 @@ test_expect_success 'checkout to detach HEAD (with advice declined)' '
 test_expect_success 'checkout to detach HEAD' '
 	git config advice.detachedHead true &&
 	rev=$(git rev-parse --short renamer^) &&
-	git checkout -f renamer && git clean -f &&
+	git checkout -f renamer &&
+	git clean -f &&
 	GIT_TEST_GETTEXT_POISON=false git checkout renamer^ 2>messages &&
 	grep "HEAD is now at $rev" messages &&
 	test_line_count -gt 1 messages &&
@@ -254,7 +261,8 @@ test_expect_success 'checkout to detach HEAD' '
 '
 
 test_expect_success 'checkout to detach HEAD with branchname^' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout renamer^ &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -269,7 +277,8 @@ test_expect_success 'checkout to detach HEAD with branchname^' '
 '
 
 test_expect_success 'checkout to detach HEAD with :/message' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout ":/Initial" &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
@@ -284,7 +293,8 @@ test_expect_success 'checkout to detach HEAD with :/message' '
 '
 
 test_expect_success 'checkout to detach HEAD with HEAD^0' '
-	git checkout -f master && git clean -f &&
+	git checkout -f master &&
+	git clean -f &&
 	git checkout HEAD^0 &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
-- 
2.29.0.rc1

