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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56971C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E05D22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbhAETov (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbhAETou (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2143C0617A0
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so343276wrp.6
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y73RTM2CzwNsFUtuH4bVhFDjnUQf4pKzMQOA0TBPuWk=;
        b=izjpqdasRE8TTyrorcSLS2ntshcnoHojR6rSvEmZ5tFA3TismxDho4FiMIzau1IQ+A
         lCw6QF9N4IMhT92sYZhiU2LPHdJSnFXt7TeCWcyFsA6ULPlAiODbHaGcGhNZWaikoMFR
         MLrUZQZGh9uPDEk/Gd6m8iTJb5QDOEwWjXcWfW/+34ml9FOyCl+nuzYX/PdoD+xTsRBJ
         8anXlDrJOAnfmWfMHarRQtr+GmbMipMA1ec0MHZWz+oQRoa1KeK8q7PBLbWtGz6FGjwx
         szlLrCe4mikBRK6+tqOJB+9qiZx/HCFUPIIUANYviI0eLDs9xTtyJO/JTrJZY1kYIEsi
         ym2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y73RTM2CzwNsFUtuH4bVhFDjnUQf4pKzMQOA0TBPuWk=;
        b=EMylk6+OP/Rhn5KWi0k9j2YS9mH4prYA9IzcMiAud4jJXd9IsHgxjrjJP1RQVPOiJh
         5CvWk1ZzdSe+g6R4eCOZ9hEqr6itlZyGDuDZGayF1OQndZb4WLGLqSvkGdfLH64W9QQn
         Q8/6YrXnnQTKhKIct8a6zmPVpxXLZsdOjGQaZJv3ARHlCgecOxg2mxk6HiUTx4gxdBiB
         /zGUkTsY38+UfVzMQdoJoj9Pr5TbFYCMeXdk/y+JuKnbPkyL6h+yitrqfoJy2eF8plkj
         8lqOI7379nnH9Hitib8hCJy7oRy+tyePgxjXrUGEfUObZ+TbjdiZqMN/MfgJHN4z3mHQ
         8EBQ==
X-Gm-Message-State: AOAM5303pHzlEOXm2mrySjPjzLHS/E/NnOTLIKgQYTgJ7muXCfOQUYBm
        B42M6bDcGeSDYXFa4Gs8Mpq39x1vHQFctA==
X-Google-Smtp-Source: ABdhPJy81iT+IhvPGK760JIWtXbkYe6hU50FGfcm3WMCByJqZ65d/SWeFsgRFkqg5+LVSiF0FXnOMg==
X-Received: by 2002:adf:fbd2:: with SMTP id d18mr1103958wrs.222.1609875815476;
        Tue, 05 Jan 2021 11:43:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/23] mktag tests: don't create "mytag" twice
Date:   Tue,  5 Jan 2021 20:42:37 +0100
Message-Id: <20210105194252.627-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test added in e0aaf781f6 (mktag.c: improve verification of
tagger field and tests, 2008-03-27) to not create "mytag", which
should only be created and verified at the end in an earlier test
added in 446c6faec6 (New tests and en-passant modifications to mktag.,
2006-07-29).

While we're at it let's prevent a similar logic error from creeping
into the test by asserting that "mytag" doesn't exist before we create
it. Let's do this by moving the test to use "update-ref", instead of
our own homebrew ad-hoc refstore update.

We're not really testing for anything yet by creating the tag at the
end here. A subsequent commit will change that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index c542c3e1a8e..bb300d567db 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -222,7 +222,7 @@ EOF
 
 test_expect_success \
     'allow empty tag email' \
-    'git mktag <tag.sig >.git/refs/tags/mytag'
+    'git mktag <tag.sig'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -348,16 +348,9 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success \
-    'create valid tag' \
-    'git mktag <tag.sig >.git/refs/tags/mytag'
-
-############################################################
-# 25. check mytag
-
-test_expect_success \
-    'check mytag' \
-    'git tag -l | grep mytag'
-
+test_expect_success 'create valid tag' '
+	git mktag <tag.sig >hash &&
+	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
+'
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

