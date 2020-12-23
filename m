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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7AC433E9
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC952256F
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgLWBjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgLWBjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:05 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF019C0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g25so526727wmh.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONRVlfiGx9q9HfOBJVTLP6SbL5DYRCDyddIEgdAlUcU=;
        b=SFwHhcmmI2DsmhDuzUVy/DMeCXF7fcncb2tIW/OhWsvXp6jlbl5wtTAKklcqzi3Fi8
         n0JecmpSPJoUSSeHYSwVkTq8N2gpo/b7rhpbB2nZZyG+3ipvhAPVlKl9afOpimO7uk2b
         +yGIJwz1Q5pV+i32LPDjQnlaZnyHPmzkgKtF4osfxIux2EZch84O3w6EyN8QsaRitBDD
         CuYdi3UVREx/uOdM1pCDvKOMykQ8lyu6e9jiGOA4fSCQVUjW1Y1kaR48O3/TOkXhIF3k
         4EA4yS7QsUA6flpxASs2D30V7RNvIwmz1zIWU+R5ckE56arnzchjrj9uuWb+DcFLLULo
         caUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONRVlfiGx9q9HfOBJVTLP6SbL5DYRCDyddIEgdAlUcU=;
        b=PQ8EmKOwgjx8XZrugqfWHyygjg5Gf5C2C+e0wouXMqRoSNL+bQX94Ecet8NYkKQ1Ov
         Xo55eKG0KFbWtuhC8Ds3aKJ0SifnCUOZ2jS2qZo4elq91akKOdzK1xHfewEFr0RgejD3
         ioENeb1ZQdyBKhKkxNxr0fpN6ERdW0kLTArA2AYw2Ns52eKuhHJwWgqMGPrrN3YxXqzf
         2naS4CXQp3IoYzpgw5NSp1S6jDh2O4t1J+a/fshFKTqVQcxi32f1NmgKqrbAbKTY4YiX
         +Y4u2+O2wbV4ekRpW/9OvpmC8qLkx1Y2wn1VdPFkGwvD6pGcgtDph5DS7rwzyXR/PHPK
         O4HA==
X-Gm-Message-State: AOAM532af3XUt5EQNdB40k7SHzelsUSIGHA93LZI0mauUGadqSrJ+iMl
        7sAWafGnfQTkdsWSNkjyXqJvh6IxyFlfMw==
X-Google-Smtp-Source: ABdhPJyE0Uq4KL0CH+hnWHJnDS1po5RjTUdpHpQBUb/gQYThTl6aWDI7MELlv1ipjMX+7An//S1hzQ==
X-Received: by 2002:a05:600c:3549:: with SMTP id i9mr14301884wmq.89.1608687469353;
        Tue, 22 Dec 2020 17:37:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/20] mktag tests: don't pipe to stderr needlessly
Date:   Wed, 23 Dec 2020 02:35:52 +0100
Message-Id: <20201223013606.7972-8-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the piping of stderr to "message" in the valid tag test. This
pattern seems to have been copy/pasted from the failure case in
446c6faec6 (New tests and en-passant modifications to mktag.,
2006-07-29).

Nothing is piped to "message" here, and in the event of the test
failing it only serves to hide the error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 9ae1b0bb0a..bbd148618e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -257,7 +257,7 @@ EOF
 
 test_expect_success \
     'allow empty tag email' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -385,7 +385,7 @@ EOF
 
 test_expect_success \
     'create valid tag' \
-    'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
+    'git mktag <tag.sig >.git/refs/tags/mytag'
 
 ############################################################
 # 25. check mytag
-- 
2.29.2.222.g5d2a92d10f8

