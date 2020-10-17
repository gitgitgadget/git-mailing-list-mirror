Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C1C43457
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A570A2072D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m513KdP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437542AbgJQH4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437534AbgJQH4O (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:14 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1672CC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:14 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j8so2751227pjy.5
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FFSD8VrsC0mgWb6PkiATTATFMdZzcAICEjAXPCadm4s=;
        b=m513KdP8tfnGWt/T0erqKjqaV72gpSP13Isir7qde1auyMW0syH8zi76U9ZsA4Hq0l
         PRzAcIgYE78CMMFP5hwShWpCdr7MYRMzex797E7fSyIG/bXqHWembK+O57+mJ4yTakmR
         rC4gpcG0wP9VAO9fLcTPH85NZVWdLabGBAns/KKT4HIt9vw8GMlSGVzgdfXuBmKtBof5
         TAjaPjxXP0FufZzp3owaDQ1zro3xPhjJlmPKdeacoyFI7j2LQTZp7dVUFAfcm6PgY4wi
         04oeut8YZgY2bcMohtANZ5j7TcnHTURKweCqMZOY1FwozpWy4Bq7U2CgEirWcGH3K20f
         ev0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFSD8VrsC0mgWb6PkiATTATFMdZzcAICEjAXPCadm4s=;
        b=WAyeKAMqlhkHCIMRxvk2NziW39shCn6pHfIad6laq3WYwSmqlNNwptoA/sSB0A16mw
         BRdJV9ikwMWcqTX5GW8SZuWxKMbR+FgrtQQO90361up6jGnvoGBEWnq1ciK1Gisv+r2Z
         7jjviG5GS46Kdw7EcfiPpo7EtIJY97tkfnWLHmqQM1/Lw8XvWFcowRNqtqyH+QVdIRP5
         rpWk5ejz1WGZtqOPOdvEcvV+NRzC2ZpiwzOUerc46B540qJL6MciM3xk0/4niNbQK+tt
         TG59/j/PUSVmqIoLUJGc5+c8ioLwu/n2LApFMEmEmWYfUvvP0S/1a+5pECzgH/y7C1Sx
         w+YQ==
X-Gm-Message-State: AOAM532FEeIPyvWg8TGWTu/Ff36PTnCSlDIe0YlTiU9/OReevz8rcJZ4
        f443oTjIOz/i1zBQD91d+I/60CTQaTfJiA==
X-Google-Smtp-Source: ABdhPJxYdtmr8mV9+XvOJyZXIL7Z7S32p9AX4lL356B/RRGsQfpEoEGHB7pqJ5LkcJDn4S8l7w9nsA==
X-Received: by 2002:a17:90a:aa18:: with SMTP id k24mr7799214pjq.231.1602921373428;
        Sat, 17 Oct 2020 00:56:13 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:56:13 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 5/5][Outreachy] t7201: place each command in its own line
Date:   Sat, 17 Oct 2020 13:24:55 +0530
Message-Id: <20201017075455.9660-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple commands on one line should be split across multiple lines.

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

