Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8A0C48BE5
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE06120D
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 04:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhFLEaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 00:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhFLEaT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 00:30:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF050C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v12so3805507plo.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=Emr9WjU17MqK18YWevP1KsweUagn6oTEUMtcbb2jq7JtdbGGWihED0NALXtaAjplyf
         qsr7GWG60pa7eVNnBXQpfSYvCWRu0kmguxYvSwTYGvoK8m/msm6fIdTsQktn482X/Azo
         YTNLiD5k6NjuZxxfD8QgbzVSoh1eA1YBYGmLlwutrpH7DksWjZjJOEbA/038EnaGJlRP
         R8q58oegNewLGYzZDNkvj9l7hpRtuiiG1M4U+Cg9qxKaQW3JkGKT4ga0P4D6E+mLgYlt
         RMJXSTn665xHycuNJ6XdWjFfd/Jg2HkNCWcLAa9MFMr6FC/yL3uFY0T5MFr6Pzlv8tOO
         WaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=PEAWcU9BxmwrSOm4ufUBIw030XOW+1xrq1Ruwrt7rPq9NbPAFApSWAhwrBqNbwi/Fb
         M64dA4giM73KKyThOuXBQ+4IaSIEjZfH4kJYh2l4u3U3PE7kPSr+CHFPo5IGugodbm31
         t59slHQspHPJszeyxA/fTS9y87OfBFQ51ie8rM7uzqkcCYi7xx9CH5o7DWkHvKbib3nt
         HLd1AlLRdym90DTNnPMcsUQIvfgidccSw5yQn0ywWwqBHDYKp2pSb8WOrseJR51Yf6es
         UHAnIQB4nJVJf/suE8sNpidIFa/2Rauflepy0xbJ5RYHWITK4WJTlawfrbUEjctbBFOt
         r6IA==
X-Gm-Message-State: AOAM531nMvXU0+PS1VKvOTUdgwsSOyWy4XnhnPb+1rFp0jXKz9Q9XzfH
        70gMcVdJwNfMwl/hn9rAjhpoa1eHS86FAw==
X-Google-Smtp-Source: ABdhPJwstd8G8bj68sNgSB0Uiar/cFSKchqkQ7lT3XCqDVwicXhkyqctBKOF8X1IXNZ12QQZFxnmKQ==
X-Received: by 2002:a17:90a:e006:: with SMTP id u6mr7708043pjy.132.1623472093794;
        Fri, 11 Jun 2021 21:28:13 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id w19sm11272539pjg.48.2021.06.11.21.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 21:28:13 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] t6402: use find(1) builtin to filter instead of grep
Date:   Sat, 12 Jun 2021 11:27:53 +0700
Message-Id: <20210612042755.28342-3-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210612042755.28342-1-congdanhqx@gmail.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find(1) has a builtin (-prune) to filter its output, save a bit of time
for invoking grep(1).

In addition, in a later change, we will try to use test_line_count_cmd
to count number of lines in stdout and/or stderr of a command, due to
limitation of current implementation, it can handle pipe.

Let's replace grep(1)'s usage with find(1) builtin filter.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..5d76cd6414 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -546,7 +546,7 @@ then
 
 		test_must_fail git diff --quiet &&
 
-		test 3 -eq $(find . | grep -v .git | wc -l) &&
+		test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 		test_path_is_file one &&
 		test_path_is_file two &&
@@ -565,7 +565,7 @@ else
 
 		test_must_fail git diff --quiet &&
 
-		test 4 -eq $(find . | grep -v .git | wc -l) &&
+		test 4 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 		test_path_is_dir one &&
 		test_path_is_file one~rename-two &&
@@ -593,7 +593,7 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	test_must_fail git diff --quiet &&
 
-	test 3 -eq $(find . | grep -v .git | wc -l) &&
+	test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
-- 
2.32.0.278.gd42b80f139

