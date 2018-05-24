Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5456C1F51C
	for <e@80x24.org>; Thu, 24 May 2018 07:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbeEXHFA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 03:05:00 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34040 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754864AbeEXHEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 03:04:53 -0400
Received: by mail-oi0-f68.google.com with SMTP id l1-v6so534234oii.1
        for <git@vger.kernel.org>; Thu, 24 May 2018 00:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3opER6rdB80E92UVrupt+pbZ9FnX7ppMqMdgCfECd+M=;
        b=UeQswvM6KiNTE+XHXLU1k0lj4yFrvdT2+uXbc97fp4aUF38HXT70rHl+dqpzdZD4y4
         emj4sDz3pamyiiHWl9eXFP35u8KAtmilsnY2L43/On/+ce7dwstbqt4NmBgFz9/RJ+3r
         f/QXKosFfgvIwddk3Gj/h5dvo8bUN6rSaBnCnzL7ZOU+4Vaw9ImUDHcUEtmZyRw1sRFS
         Y2t2i7TwoBGDx6FKHBY0gcAMKlhypqKj72+A50BlBg86C2bqiU1yW6Xoy8b2jQ8PKl+7
         udHvjq5fy9FcYAHSl+//423Nd2Hcm2cXwDjtjtdJnBa92A8Wx8Lem2bOJmuMUZqTJL7A
         XPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3opER6rdB80E92UVrupt+pbZ9FnX7ppMqMdgCfECd+M=;
        b=XpOY+DMcMQj9m1OIxNp2UnRxpCO2nEOPxu5p9k8dBsNG083U4Kp/DdXTQ6s8m1KsoI
         uqfi0zcPE7lcIOwC0saUKyIwdCXq43zULocJr2eM9rvxvKYsA0mdQn65wUGQN0AhD5cU
         nYwdEl69y/8hUYAO089Q5GdbG30Oqy60iO/8CrD7eeZiZ7kAnK2JSL+QjhCBSG3sXT9f
         jVzG/K/KC9zY0h3Hqna6q+qK0CNVg8qXMhwnz4dhsfFzSn2fHsz2Ye+AZscX2BWceiKK
         NfFupaTGvrVdmFDxrR+IHnnYecQ9/46VS3rbpZgmGm9v3T7aEeHq+KAtzkUIJm/FjMyJ
         IRGA==
X-Gm-Message-State: ALKqPweyjEJunMr6G09m2zoQVrC9dfAiIBek+Lku0O8u+XF4rRCKdxdS
        WkMuBPlGYJOIVl0KBcBuqFHQTA==
X-Google-Smtp-Source: AB8JxZrJNFt1KJQOKCfHfYIZN1Aweu0zsYmkBrCGzKP27WOmU7qjSUJU774daASqeN+39OvupfavpQ==
X-Received: by 2002:aca:b941:: with SMTP id j62-v6mr3452658oif.290.1527145493163;
        Thu, 24 May 2018 00:04:53 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id q75-v6sm12076244ota.69.2018.05.24.00.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 00:04:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/5] t6036: prefer test_when_finished to manual cleanup in following test
Date:   Thu, 24 May 2018 00:04:39 -0700
Message-Id: <20180524070439.6367-6-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1.gda85003413
In-Reply-To: <20180524070439.6367-1-newren@gmail.com>
References: <20180524070439.6367-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manually cleaning up from former tests in subsequent ones breaks the
ability to select which tests we want to run.  Use test_when_finished to
avoid this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6036-recursive-corner-cases.sh | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index e5f167a06e..b5621303d6 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -4,12 +4,6 @@ test_description='recursive merge corner cases involving criss-cross merges'
 
 . ./test-lib.sh
 
-get_clean_checkout () {
-	git reset --hard &&
-	git clean -fdqx &&
-	git checkout "$1"
-}
-
 #
 #  L1  L2
 #   o---o
@@ -445,10 +439,12 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 '
 
 test_expect_success 'merge of D & E1 fails but has appropriate contents' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		get_clean_checkout D^0 &&
+		git checkout D^0 &&
 
 		test_must_fail git merge -s recursive E1^0 &&
 
@@ -468,10 +464,12 @@ test_expect_success 'merge of D & E1 fails but has appropriate contents' '
 '
 
 test_expect_success 'merge of E1 & D fails but has appropriate contents' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		get_clean_checkout E1^0 &&
+		git checkout E1^0 &&
 
 		test_must_fail git merge -s recursive D^0 &&
 
@@ -491,10 +489,12 @@ test_expect_success 'merge of E1 & D fails but has appropriate contents' '
 '
 
 test_expect_success 'merge of D & E2 fails but has appropriate contents' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		get_clean_checkout D^0 &&
+		git checkout D^0 &&
 
 		test_must_fail git merge -s recursive E2^0 &&
 
@@ -516,10 +516,12 @@ test_expect_success 'merge of D & E2 fails but has appropriate contents' '
 '
 
 test_expect_success 'merge of E2 & D fails but has appropriate contents' '
+	test_when_finished "git -C directory-file reset --hard" &&
+	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
 		cd directory-file &&
 
-		get_clean_checkout E2^0 &&
+		git checkout E2^0 &&
 
 		test_must_fail git merge -s recursive D^0 &&
 
-- 
2.17.0.1.gda85003413

