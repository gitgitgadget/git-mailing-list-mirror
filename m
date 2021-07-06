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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03082C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8289613C8
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhGFSWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhGFSWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:22:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A72C061760
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 11:20:11 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c15so12480733pls.13
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=YTGDrJcWKmXyT+4mTsCUtZ9cYeBFm9Vj3q1ddov9eyX9nItOyswuZfdXHUqqqi4pmU
         w/WPFAMdnNA9b8nuH7t9bnh0oByOC7oB8ROFJ/weeGqcdCdo7H079cCKx387KbOqryj4
         BngMuOO494FOl5GhkfQSYjflaSrGnBk2hf0qcpn7AJHzvbs33mei0nGgAzHz4Es3+g9n
         okKAU1zWOaQF2TYuyPzrMY6j0R2ukxo56Xkm7hu+8nRIMNcgWmuQtzecj4tx55S27V8Z
         LWlm6xTplqX1chZvirEHIgnGkH8IOHF3YfXFs9d107bTdy2S3B+kV1y/aHGGvDF0F5tA
         s+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=elfHe+qeyZzTyccCqXhtTZ5fpU+zd8bscAJvnUk34J63rS70/NMrlpBGrOOVIsWJe8
         cZ0NYA7Sfmr6PC82RzymcZgx9ex8hjfAIvH08zM18EuDLdqREdwpDn/fWGDiOdU+JFjz
         /T45Ax0nlrm5RcqrgSoGIF+mAifCUeSlsxPIp1i4lR5xYClXbm0skMjJaQy6nzFKi6Bs
         LIStS6WQ/PBTYlw6a6dLuhSIhC7HfmykrjyiUvKSYOY23eVeYSzE2gDWWDtJ+g8k/OM7
         8gkb+Giq411fK/FjBwfOQ/B/e7UDCTIKscq/Jwo2SfaHfSh1qa2hzDB+Sb7dq8o1wNFZ
         EC2Q==
X-Gm-Message-State: AOAM531AVi5WV0JlL+m5J20f0yHPmakuoGkfZgw5chVaYMAfgQN8oS/Z
        lOxhz+eIX2OZYpkKfCLYp8pYA+H+R5wnh0Ew
X-Google-Smtp-Source: ABdhPJzyUUJvPW2/jZ3sVeJR4KXAORz6ZlSxiodxEOisS5lCl1gGdPhhpQdRNY+Tadp5a/5J7O9lDQ==
X-Received: by 2002:a17:90b:e94:: with SMTP id fv20mr1696387pjb.162.1625595610542;
        Tue, 06 Jul 2021 11:20:10 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b22sm3779809pje.1.2021.07.06.11.20.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 11:20:10 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 1/3] t7400: test failure to add submodule in tracked path
Date:   Tue,  6 Jul 2021 23:49:34 +0530
Message-Id: <20210706181936.34087-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706181936.34087-1-raykar.ath@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to ensure failure on adding a submodule to a directory with
tracked contents in the index.

As we are going to refactor and port to C some parts of `git submodule
add`, let's add a test to help ensure no regression is introduced.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Based-on-patch-by: Shourya Shukla <periperidip@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 t/t7400-submodule-basic.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a924fdb7a6..7aa7fefdfa 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -196,6 +196,17 @@ test_expect_success 'submodule add to .gitignored path with --force' '
 	)
 '
 
+test_expect_success 'submodule add to path with tracked content fails' '
+	(
+		cd addtest &&
+		echo "'\''dir-tracked'\'' already exists in the index" >expect &&
+		mkdir dir-tracked &&
+		test_commit foo dir-tracked/bar &&
+		test_must_fail git submodule add "$submodurl" dir-tracked >actual 2>&1 &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'submodule add to reconfigure existing submodule with --force' '
 	(
 		cd addtest-ignore &&
-- 
2.32.0

