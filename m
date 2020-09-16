Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE0C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0ACB22210
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBMml+yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIPMFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgIPKcf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:32:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93CBC061353
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c18so6311235wrm.9
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSu2isLmb8MNrfyLVvJURzR0Ft3qMcAz4QMS4YYdr+0=;
        b=qBMml+yHagQiPcKWYFJTBggMlq8g0bBIKY6Gxr60daCyG5PShqR/jTtkyDzwr9Zy1t
         ZL/9sQAVYXMOO6FyawxXcm8n5mFOC818dtu89LAwCTTm1KsVjsk6dQfS28FVzur2SnW5
         MVj2GpQqvUSWimpGVWJiOsfc+rjECD4q5ZIWCCqT5ppDunDSxqt5lH3t6xkpHX+30Y38
         5GoTFDkmwTLj4dX1zpKmFa6vwzKuD6JL93ZhcpO+SJMy3QeXdYuED8K5RgLARzI+fx93
         PofQQc3KncpPM08glGw/9vbN5CA9emduGk3LcG9N32Z3mn0Fb0NxdxQcnI9zTTLQX5cb
         BOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSu2isLmb8MNrfyLVvJURzR0Ft3qMcAz4QMS4YYdr+0=;
        b=QkCCiNSNQ2aWMCZW6xFKOfwAJeEEQY+R3uWGIzUNp1le+LMuPxj/hFs/5zc8+BqBmb
         67N6tmD77y2zahkV4ZzRJvcTFGQxoHXEeK5YJyBDeX+Vo+xm6L9On+A2tEA5I3vG7LLm
         AUancLLiXiadFgvGCa2Wc6S3gUZ1OiJbjIDua/r+kg9VZo3KYEKDeG34pMXmKqes/UYu
         MCGOpe/2UeuEE3PNPiobjz7D/0RVOVY484lE1K5+ItM+9LVPRi28ryweb9GLP6atqYYI
         dScRi/zXHWmdFjw85CEhagoUcAHdHWkk790xOZ4Vbi80PO7xZ/SqMJfFHwF/oiRxWY/B
         UWuQ==
X-Gm-Message-State: AOAM531DRMddRElhXocGHz4VhD57cSsQ9IR8BK3NVdPC8+nX94o6UMxy
        ycjJME78oBmaNg+HexL3iepw9aw7j7abdUhI
X-Google-Smtp-Source: ABdhPJx3X9KTUvcPWIh2nDT3/mnEA551mWbAk1p110mLT0VJzlU5V7FKpvU8D8lMsC8WVdhPiKLSGA==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr27415174wrn.357.1600252205397;
        Wed, 16 Sep 2020 03:30:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:30:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/15] remote-mediawiki tests: use test_cmp in tests
Date:   Wed, 16 Sep 2020 12:29:09 +0200
Message-Id: <20200916102918.29805-7-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that used an ad-hoc diff invocation to use our test_cmp
helper instead. I'm also changing the order of arguments to be the
standard "test_cmp <expected> <actual>".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index 9106833578..4c39bda7bf 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -28,7 +28,7 @@ test_expect_success 'Git clone creates the expected git log with one file' '
 		git log --format=%s HEAD^..HEAD >log.tmp
 	) &&
 	echo "this must be the same" >msg.tmp &&
-	diff -b mw_dir_1/log.tmp msg.tmp
+	test_cmp msg.tmp mw_dir_1/log.tmp
 '
 
 
@@ -50,8 +50,8 @@ test_expect_success 'Git clone creates the expected git log with multiple files'
 	echo "this must be the same" >>msgDaddy.tmp &&
 	echo "identical too" >msgDj.tmp &&
 	echo "identical" >>msgDj.tmp &&
-	diff -b mw_dir_2/logDaddy.tmp msgDaddy.tmp &&
-	diff -b mw_dir_2/logDj.tmp msgDj.tmp
+	test_cmp msgDaddy.tmp mw_dir_2/logDaddy.tmp &&
+	test_cmp msgDj.tmp mw_dir_2/logDj.tmp
 '
 
 
@@ -135,7 +135,7 @@ test_expect_success 'Git clone works with one specific page cloned ' '
 		cd mw_dir_8 &&
 		echo "this log must stay" >msg.tmp &&
 		git log --format=%s >log.tmp &&
-		diff -b msg.tmp log.tmp
+		test_cmp msg.tmp log.tmp
 	) &&
 	wiki_check_content mw_dir_8/Namnam.mw Namnam
 '
-- 
2.28.0.297.g1956fa8f8d

