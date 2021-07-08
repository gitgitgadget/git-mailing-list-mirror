Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E51C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 09:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D6E619AE
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 09:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGHJ6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhGHJ6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 05:58:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B321C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 02:55:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 37so5428217pgq.0
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=GmHRyFXx1MtG+iScV+w93crett4KSXHLNOiOKA43JWGUahA1MnhRpGzEnCbaWpJb1J
         VXPbV0g5lpzv5Nyj/ysO46IDoLezqpSHICkJOk4mA61FF1WVGM2nsduYbLlZbc5vzR76
         kKf0IfBW4J4eGUwQ9lRpoFrLvqj/Hoz9xjo5YErEs4eRswX6277IrBE+MVEam3UAL8SA
         UUDHL+FSG/ozkpni/qeccfg9lQ+gEnJzxSsR5xCLm7dxOmeBVGdVNHRY/v+DC+y4Dpz1
         T90r0MJKbNjKs9Z/VJYen4E5Gj/C8gNbQgMc6gSmsFGsNl7KNp+gNcefdAJGANVyeHVE
         WahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l73dfhO9syTvpqtI0cAhmOHRLso28OE3PN1TrIXRFI8=;
        b=JrUGT4y0oatoLXVBGToz5Q6pXLOB7yj6DPYZIO68xt65XBFg35yfs3wWtfJZGGl0Aq
         0mBIzuEfhDUZjfVTem0ovTpAYe8UPeIF1AA5TsIwpvU8wyz3P8vZagEFq4c03gLAzCJ3
         bpFOPypwXq8lfT2zXnXP5CvEgy1YtPbwu6BSr1XXBX0Qq9tpzy2kb+UUN9wLk3EKYJGw
         r9hsowAsJw+k0dhwCxJpzs74nhI+Thrd+xh1zGypnq2IRJ/crGn+qN9C9MKmuhwbqKGr
         jnfy3u1dSDKcOo5QeMOhtbEOFzhowVTlM9SV57IxFgM6XyPOLiKbE+YLmK48V6hpP5q5
         TjOw==
X-Gm-Message-State: AOAM532zWuN2PTXpELZvwCnt5tg7K3xK8mM86xE6s5TsBgqjQTYqseug
        zmggrw0Kt8vbf1Dk90wYPmYUYCfOdKdW9ZjK
X-Google-Smtp-Source: ABdhPJz9Cr2YEAEqeVdaoB3e+Lhqu2dKuI9ZA+RoLzscajJmOyDb6quSXYQfln21HfECra6yJI6n2A==
X-Received: by 2002:a65:5c89:: with SMTP id a9mr31223697pgt.207.1625738150706;
        Thu, 08 Jul 2021 02:55:50 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id a9sm2126925pfo.69.2021.07.08.02.55.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jul 2021 02:55:50 -0700 (PDT)
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
Subject: [GSoC] [PATCH v2 1/4] t7400: test failure to add submodule in tracked path
Date:   Thu,  8 Jul 2021 15:25:30 +0530
Message-Id: <20210708095533.26226-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210708095533.26226-1-raykar.ath@gmail.com>
References: <20210706181936.34087-1-raykar.ath@gmail.com>
 <20210708095533.26226-1-raykar.ath@gmail.com>
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

