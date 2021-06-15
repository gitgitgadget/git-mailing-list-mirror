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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727EAC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5798461420
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFORXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhFORXI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:23:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170DEC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:03 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a127so7959606pfa.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9r4EdnoIvZJaayfsuwdZkKnotxZKH4NB/XqE8YK42p8=;
        b=eHEX4AG81fCJBSxJsmngGqMTX4/lMpahcIGkbPKYG9NHi09CA8RYcyz4HqwDESfk21
         xBwhxYOxYYn3uTUUoSMHIV7BNqvpfpONU6rFnyPv+9CyYjsYtJQraRUZZSQTu4cDOJ3z
         qBz6drzMDvK9d7GRtpqmWgUyTV+AqrHm1D9E720jwUNQQawSQ4ANyBRFOxGXRNoMrR5r
         fchD8lImdjBH1gJjkrui2LWRVLWxeeKfCOMHk01m/g/8aKnzkn7qhhYORzHaCcu4BjfS
         6vLTCprdEtzuK/tmvWmbK0jHU1/91GpAPOqy8ZykndTyx4SB2AA9l2s5Bu+EL/Zw5UkK
         Mnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9r4EdnoIvZJaayfsuwdZkKnotxZKH4NB/XqE8YK42p8=;
        b=ZnBUgu2iPpukpsDAXJa017SMdtX/iuK0QZvUaPDcDD5gXUQcqkmKkVtK2FwDFKQ6T0
         gkL+92LaxsrdDsrIr28CMX62BSCJP27p4HPKb+J1fcg95SfmGdJD0ikXTtq1LIqaRKXT
         ZiMBHxcRmt4FQF8ndWC30vQvQEdrd2GAO663f1W8rHO2c4FV4L6pNg/siyYNdcS+6sur
         3j+qcaFdYebhgAC0r3OBQlIc/EirB45sDCvp4kOJ28sfdopL2qbzjkFcggPdibd2W7g/
         0P9p/1cpjUyzfU3R5gDWsgodmW0V0GBpF22NX0KXW/7hskRBNXpb+96vOjZwflzSgb8g
         ZLVQ==
X-Gm-Message-State: AOAM530X9+08MeFTCtlOOxawQP3qBmZAieeQ+imWbMSpK8COqnlLT6UO
        cbQfUSeR6HMfmgK0NLrY4HZOQr9+sDY=
X-Google-Smtp-Source: ABdhPJzn0dMNpZEU6xww/h3giQw9A/UFtQT8p3gJO1Wynd2ptn/SP4x9IE69h1ESZSUhImGFtJGBIA==
X-Received: by 2002:a63:c112:: with SMTP id w18mr523115pgf.375.1623777662352;
        Tue, 15 Jun 2021 10:21:02 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:21:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/5] t0041: use test_line_count_cmd to check std{out,err}
Date:   Wed, 16 Jun 2021 00:20:36 +0700
Message-Id: <20210615172038.28917-4-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t0041-usage.sh | 53 ++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index c4fc34eb18..24e24f698c 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -12,98 +12,79 @@ test_expect_success 'setup ' '
 '
 
 test_expect_success 'tag --contains <existent_tag>' '
-	git tag --contains "v1.0" >actual 2>actual.err &&
-	grep "v1.0" actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --err = 0 git tag --contains v1.0 >actual &&
+	grep "v1.0" actual
 '
 
 test_expect_success 'tag --contains <inexistent_tag>' '
-	test_must_fail git tag --contains "notag" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git tag --contains notag 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'tag --no-contains <existent_tag>' '
-	git tag --no-contains "v1.0" >actual 2>actual.err  &&
-	test_line_count = 0 actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --out = 0 --err = 0 git tag --no-contains v1.0
 '
 
 test_expect_success 'tag --no-contains <inexistent_tag>' '
-	test_must_fail git tag --no-contains "notag" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git tag --no-contains notag 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'tag usage error' '
-	test_must_fail git tag --noopt >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git tag --noopt 2>actual.err &&
 	test_i18ngrep "usage" actual.err
 '
 
 test_expect_success 'branch --contains <existent_commit>' '
-	git branch --contains "main" >actual 2>actual.err &&
-	test_i18ngrep "main" actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --err = 0 git branch --contains main >actual &&
+	test_i18ngrep "main" actual
 '
 
 test_expect_success 'branch --contains <inexistent_commit>' '
-	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git branch --no-contains "nocommit" 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'branch --no-contains <existent_commit>' '
-	git branch --no-contains "main" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --out = 0 --err = 0 git branch --no-contains main
 '
 
 test_expect_success 'branch --no-contains <inexistent_commit>' '
-	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git branch --no-contains "nocommit" 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'branch usage error' '
-	test_must_fail git branch --noopt >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git branch --noopt 2>actual.err &&
 	test_i18ngrep "usage" actual.err
 '
 
 test_expect_success 'for-each-ref --contains <existent_object>' '
-	git for-each-ref --contains "main" >actual 2>actual.err &&
-	test_line_count = 2 actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --out = 2 --err = 0 git for-each-ref --contains main
 '
 
 test_expect_success 'for-each-ref --contains <inexistent_object>' '
-	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git for-each-ref --no-contains "noobject" 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'for-each-ref --no-contains <existent_object>' '
-	git for-each-ref --no-contains "main" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
-	test_line_count = 0 actual.err
+	test_line_count_cmd --out = 0 --err = 0 git for-each-ref --no-contains "main"
 '
 
 test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
-	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git for-each-ref --no-contains "noobject" 2>actual.err &&
 	test_i18ngrep "error" actual.err &&
 	test_i18ngrep ! "usage" actual.err
 '
 
 test_expect_success 'for-each-ref usage error' '
-	test_must_fail git for-each-ref --noopt >actual 2>actual.err &&
-	test_line_count = 0 actual &&
+	test_line_count_cmd --out = 0 test_must_fail git for-each-ref --noopt 2>actual.err &&
 	test_i18ngrep "usage" actual.err
 '
 
-- 
2.32.0.278.gd42b80f139

