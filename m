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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF283C433E9
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6284A229F0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLUV1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgLUV1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:27:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C20DC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:27:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so27031269lfg.10
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb6ddB65gR/nN4TOG9IN8Njt61SVIXovILiSjqzi4T4=;
        b=cpMTq68a9HNdLi3ImCbodBQQJ7CB0GaX1TYIqWCroiAU8pQSGlmKQuIcDCGaO0SG+H
         iMKzO3SrE+O9OilIBDY29z7NojTxWxyxuobKveCdcxDz4Si9sFHEkfsWPKBy3onOxJ4j
         ae752TPAlbd3eUhRTud1sMKM0STmRalyn8Oqs4AgohrkzT/Hi6iM5MZSQNP6V7/e/knP
         TAHhfrv/xFpHR3TJHvVF363MQp5NNpIdxttp/3lo+7nl7AKDd0fsgNu69eYaedaKlLg/
         MoUFnfjZTH9lKjvoRyKFNw9bFrj+YKC0EVAXL1W6Pp067Dgfo5gF1ywDio+08vJnUT+h
         oDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb6ddB65gR/nN4TOG9IN8Njt61SVIXovILiSjqzi4T4=;
        b=ljIxBVQmYgqPQkgGzVVF/tYg1eGcGVROjljq5BdJzu0uPpuIttAyeqEVkRPPM1zhP3
         M05ds2sdiRVZtpYNc9CdKA45Xyc9TYwc9AibohrYME1r9EXSXUZFLNODpFSKi1IUa2OE
         AXh/5EuL2G5c2gWUt0TCTSW1dCKINDet1FU4aq4asXO5ttKl35YLpc6jsU/gfJ4qSjl0
         g7rFWtkj8ODYsQ5/z7XKElxI+lnVy8HQq/lPNt3Vj7FD0o0nZpz0pM19CX9bV2XR0Nry
         YwEPGA8pC33aMuiIhsMiD2+W4K2rqD6LeAgGB5gH4fdG7tec1zBNd8wnqkvXeWpaBvwB
         VBRA==
X-Gm-Message-State: AOAM5317UIyk5yIt59ydAeacSCu30LSieyuFEIpzkyik6a0dfuIJInDv
        o3GWiIf/qL925dBd17DnEvMjDM9ZKsY=
X-Google-Smtp-Source: ABdhPJwuAsPWo9qhXJDJtg+QcReRDdOQD63YavEiXQUJLR8A1T3Hgcw90nT/0nBowMOA3unM1IyfFw==
X-Received: by 2002:a2e:7816:: with SMTP id t22mr7847197ljc.449.1608586020369;
        Mon, 21 Dec 2020 13:27:00 -0800 (PST)
Received: from localhost.localdomain (78-66-223-148-no2204.tbcn.telia.com. [78.66.223.148])
        by smtp.gmail.com with ESMTPSA id t14sm2236100lfl.216.2020.12.21.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:26:59 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 3/3] t7900-maintenance: test for magic markers
Date:   Mon, 21 Dec 2020 22:26:33 +0100
Message-Id: <938ac9a831bacd70e3c3ab7756ed98afa6338554.1608585497.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.rc1
In-Reply-To: <cover.1608585497.git.martin.agren@gmail.com>
References: <cover.1608585497.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we insert our "BEGIN" and "END" markers into the cron table, it's
so that a Git version from many years into the future would be able to
identify this region in the cron table. Let's add a test to make sure
that these markers don't ever change.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7900-maintenance.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4bbfce31e9..99bf0c7582 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -446,6 +446,15 @@ test_expect_success 'start preserves existing schedule' '
 	grep "Important information!" cron.txt
 '
 
+test_expect_success 'magic markers are correct' '
+	grep "GIT MAINTENANCE SCHEDULE" cron.txt >actual &&
+	cat >expect <<-\EOF &&
+	# BEGIN GIT MAINTENANCE SCHEDULE
+	# END GIT MAINTENANCE SCHEDULE
+	EOF
+	test_cmp actual expect
+'
+
 test_expect_success 'stop preserves surrounding schedule' '
 	echo "Crucial information!" >>cron.txt &&
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
-- 
2.30.0.rc1

