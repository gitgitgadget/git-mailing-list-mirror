Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2F61FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbcKQSqU (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:46:20 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34759 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754584AbcKQSqT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:46:19 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so91272417pgx.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P220r5zF4uQcCBm08aAREzi5E4iI4oL4ZNIP9AQHyNw=;
        b=joWNV/seq6Jop0R+tdcesdT+59s8Gh3sM3xEfBgseHIvljhx9RmynQqFAUe/c8GBrj
         PlZU3/x9uI9mvobCC7KkFsuXbU7l0tnpEQn+xzG7GSwLBsTta63Jagz43vthogZ23l/X
         3S5ajIkBRujYE9UtIIFnR3bI4CLR7I3lbOHe+zkxKGAB67XdZfJk7FmGGuUH1iRrvxRH
         2OmGLKVcOlWE0tVoXRfAYCxqlxEKMpapPhOJh1s3EY4/pcolfB0Hl/YFLgm1Ab3HwRic
         tNLmfdjsFyFD+3jw6gBCRnHuJO/KvGrgAIp+Ey8aWmD6+TzCzHPWUB8C0XZnonv8HM4O
         U6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P220r5zF4uQcCBm08aAREzi5E4iI4oL4ZNIP9AQHyNw=;
        b=l4bg56IbR7jc4UU2FTKExTpAdkSiYP0q/J25oW6Ew/f9tHanKsMSo4oWYhBqck2272
         IzWhp0sLy4Uaw9j1qRvYByuBw35eeWQjN1ITv4gx0ny7l3Amo2SKDGrqNNqV7AfqyY2v
         xIyNu0ckdchVkP3+xabx/M/nRsnsUAlC+RlxWYVQOV/cpPaunMVaBHMnjMMyoabtWbwF
         l/H8gbJWe/5aTtinQtRc1pULovEwtNJQQl7Zo0jzwf3lWwA1VWKMUPvoZ9E6Iad3U70e
         wweij9e3WKHjas0XKP5M5HxTDbhO99e9gEIIqGB8qgshoo6y1Xbk23JjntZb5nt3cTOm
         2gUw==
X-Gm-Message-State: ABUngvecg1d/WZyosUqjPAdLCV5DWQNS7KR/L6pUXXokfxoX90rvLz3zksnCLMt9N/Sbk5LH
X-Received: by 10.99.244.17 with SMTP id g17mr10288355pgi.80.1479408378119;
        Thu, 17 Nov 2016 10:46:18 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id u23sm9898946pfg.86.2016.11.17.10.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Nov 2016 10:46:17 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, hvoigt@hvoigt.net,
        sbeller@google.com, j6t@kdbg.org
Subject: [PATCH v2 1/2] push: --dry-run updates submodules when --recurse-submodules=on-demand
Date:   Thu, 17 Nov 2016 10:46:03 -0800
Message-Id: <1479408364-150268-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479408364-150268-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a test to illustrate how push run with --dry-run doesn't
actually perform a dry-run when push is configured to push submodules
on-demand.  Instead all submodules which need to be pushed are actually
pushed to their remotes while any updates for the superproject are
performed as a dry-run.  This is a bug and not the intended behaviour of
a dry-run.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/t5531-deep-submodule-push.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 198ce84..7840032 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -427,7 +427,31 @@ test_expect_success 'push unpushable submodule recursively fails' '
 		cd submodule.git &&
 		git rev-parse master >../actual
 	) &&
+	test_when_finished git -C work reset --hard master^ &&
 	test_cmp expected actual
 '
 
+test_expect_failure 'push --dry-run does not recursively update submodules' '
+	(
+		cd work/gar/bage &&
+		git checkout master &&
+		git rev-parse master >../../../expected_submodule &&
+		> junk9 &&
+		git add junk9 &&
+		git commit -m "Ninth junk" &&
+
+		# Go up to 'work' directory
+		cd ../.. &&
+		git checkout master &&
+		git rev-parse master >../expected_pub &&
+		git add gar/bage &&
+		git commit -m "Ninth commit for gar/bage" &&
+		git push --dry-run --recurse-submodules=on-demand ../pub.git master
+	) &&
+	git -C submodule.git rev-parse master >actual_submodule &&
+	git -C pub.git rev-parse master >actual_pub &&
+	test_cmp expected_pub actual_pub &&
+	test_cmp expected_submodule actual_submodule
+'
+
 test_done
-- 
2.8.0.rc3.226.g39d4020

