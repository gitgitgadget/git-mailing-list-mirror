Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C081F404
	for <e@80x24.org>; Tue,  3 Apr 2018 04:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeDCEbi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 00:31:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43055 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751465AbeDCEbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 00:31:38 -0400
Received: by mail-pl0-f66.google.com with SMTP id c21-v6so3631474plz.10
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 21:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DA8aDs9PZivdtaFQ/2CZ0j1KN/agCKFpaHZOqi/KPqU=;
        b=mHB31YPNADETKZuqiclTKPQ3Bp5D9Z9+h5oNRJoOxSt3UuioR++AiRtNGv4Yvcu3nc
         tPX6zIbZ8G/YshDnUaJHLbE4fFiFUy/61TF7DiX9vO1dobEx6R0rZSCfU5xVPOWlhNbC
         ehV+mtPuuBSeHE4dq48oOLmyq1gd6/R0bpznrIhRjKMlc6EE8CIqWurg7BcLlqdt0EfD
         gI2kWAdGrrojwiEzcr3WyuJSUYgjsBRJB8jVfKuFBgPD0gWoI0zIyCnVvi3N3bGSXQMz
         F2c9G1ZSnKyQp6a5XCdT/WxWY48PLMGeguEJxm3T27Yc30gxpDfwFluV3IpBMqUcDq6r
         O6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DA8aDs9PZivdtaFQ/2CZ0j1KN/agCKFpaHZOqi/KPqU=;
        b=WonTVBb1ikTH0Y0FWWyO9hux6aNwhmzsLYBrKm71AGvtMp0R5hdHXQwMIGd6huCNGr
         L2kXbYQF26FTYkf/xp/3fkfbA7AZ1DJDiy3DjMTIn84vmS6LqAGAfDbcP5ftTqrRpvza
         mQTaiBvieYngzsBjlJd8dCbo4vw7rqTOLfNHuYtaZ6/wls0OGDiorN6CHhTNxQOTcdUf
         jUr8rapWh65PhghZ9uFIYeso6fg/HUCNQXWsl9asC+2wFYVKpjBUkBVS7o/+NEIIihzJ
         VWtB152q60QGx/xkI7Oi24sOK4/kyHaB6bsuG96JzzGSJGx/xxMIhxm0WaUZKtvG97k2
         N7HA==
X-Gm-Message-State: AElRT7G1z165i6rCAp+i2gph9sui/poF0Uk+gMhUfxsGheXOkU1+7EaK
        3er7DWB/x2HurYvzGra1rCgAtTXu
X-Google-Smtp-Source: AIpwx4/6Nlgb+ERYoOSeHjPLy4OrxXDmgrgIgDye/Zof7WcFl1ghzX+TOfO9oDcR/w/dzuUayreS4w==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3-v6mr12711472plb.317.1522729897315;
        Mon, 02 Apr 2018 21:31:37 -0700 (PDT)
Received: from localhost.localdomain ([157.50.37.209])
        by smtp.gmail.com with ESMTPSA id q62sm3363163pfd.61.2018.04.02.21.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Apr 2018 21:31:36 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] t3200: verify "branch --list" sanity when rebasing from detached HEAD
Date:   Tue,  3 Apr 2018 10:01:01 +0530
Message-Id: <20180403043101.4072-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f06
In-Reply-To: <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <20180403043101.4072-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

"git branch --list" shows an in-progress rebase as:

  * (no branch, rebasing <branch>)
    master
    ...

However, if the rebase is started from a detached HEAD, then there is no
<branch>, and it would attempt to print a NULL pointer. The previous
commit fixed this problem, so add a test to verify that the output is
sane in this situation.

Note that the "detached HEAD" test case might actually fail in some cases
as the actual output of "git branch --list" might contain remote branch
names which is not considered by the test case as it is rare to happen
in the test environment.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/t3200-branch.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 503a88d02..738b5eb22 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -6,6 +6,7 @@
 test_description='git branch assorted tests'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'prepare a trivial repository' '
 	echo Hello >A &&
@@ -1246,6 +1247,29 @@ test_expect_success '--merged is incompatible with --no-merged' '
 	test_must_fail git branch --merged HEAD --no-merged HEAD
 '
 
+test_expect_success '--list during rebase' '
+	test_when_finished "reset_rebase" &&
+	git checkout master &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	test_i18ngrep "rebasing master" actual
+'
+
+test_expect_success '--list during rebase from detached HEAD' '
+	test_when_finished "reset_rebase && git checkout master" &&
+	git checkout HEAD^0 &&
+	oid=$(git rev-parse --short HEAD) &&
+	FAKE_LINES="1 edit 2" &&
+	export FAKE_LINES &&
+	set_fake_editor &&
+	git rebase -i HEAD~2 &&
+	git branch --list >actual &&
+	test_i18ngrep "rebasing detached HEAD $oid" actual
+'
+
 test_expect_success 'tracking with unexpected .fetch refspec' '
 	rm -rf a b c d &&
 	git init a &&
-- 
2.17.0.rc0.231.g781580f06

