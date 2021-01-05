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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60304C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CD022D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbhAETot (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbhAETos (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:48 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D57C06179A
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k10so594093wmi.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGCEbG3r9vJyDszwDye8xvPIIaJtBo9NAN9QrwG5HB4=;
        b=tJq4DcU3yhIpV7Wi4PvuI0s1eTyirpwBymoveMkCXI+B6P/kxmnlkfjJ1cx5PhrmOj
         2iNunK7ld379ioLrFWTF6MsnZzOTzFBvFqJVYw4gHDDofj0j5sRQ+qPeEdfagzodulQM
         Zv4tEFMp8DFXIKyCvIe8xXhLLvXdhSvqlrHQXMlwcqVCj2k1dbYSxgePV7cKV8iTeC5s
         3BSz3cj61SBA6VMWu24EhiMo6Rbtg1jX9mPuGdR499KXJtwv9KI9LVqFvGmRCFSFT6zH
         Rdk/KptXKYJcLwJXaC3zFT1PBNdNuzPvfpdJDGgcHc0D9ieBxd85G8njJ9g9zq+VXmHb
         +hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGCEbG3r9vJyDszwDye8xvPIIaJtBo9NAN9QrwG5HB4=;
        b=buf/p8ObOXefHaoXnxjExh4gvOQ4/eqZ4Em5t5XDwI22hKagewY8Dv/HeJdOq9Dcxs
         tNFF7FpqXOdZcGGLhPCpWvc0nihAESQmwQssXzkMtkU3mSzLT7HTtR1lhkXdpJxlclJA
         2pcyf+vl3gTzHC/bmnouFV2xYZLgbieREiNY2kuix3OYOWLqCWJgeITcMbBwhZEtM5+z
         wajqRj6gNyeePDfHa/kotCTgLueeVDBTXiwKn0IZQiTKt2nnmGKM+IWY4KizsWM3+8qs
         xhy5AUWW5mPiYCwv/9SDRSDLOcVk5S7QQIB3bj66IBND9EcHf/s4rOoKAp//uSlTVM2s
         rrBA==
X-Gm-Message-State: AOAM531hGqyfl+F5zKnQvT7v/Y6dMYpA3kt/frcUD2q5VLOe15Slzr9w
        kFUNzUzKXckSR3V1i+F6Q+jHppiiD+//rA==
X-Google-Smtp-Source: ABdhPJxue5LDgtlsfrzjTuMESAng3PVDPEVVBwlcWUyInK9X7lnZ5Y1j0PlPVqAZ7tGYPT963CBZ8w==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr621882wmj.160.1609875812164;
        Tue, 05 Jan 2021 11:43:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:31 -0800 (PST)
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
Subject: [PATCH v5 05/23] mktag tests: use "test_commit" helper
Date:   Tue,  5 Jan 2021 20:42:34 +0100
Message-Id: <20210105194252.627-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace ad-hoc setup of a single commit in the "mktag" tests with our
standard helper pattern. The old setup dated back to 446c6faec69 (New
tests and en-passant modifications to mktag., 2006-07-29) before the
helper existed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0e411e3c45f..dd21a1247a2 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -23,9 +23,7 @@ check_verify_failure () {
 # first create a commit, so we have a valid object/type
 # for the tag.
 test_expect_success 'setup' '
-	echo Hello >A &&
-	git update-index --add A &&
-	git commit -m "Initial commit" &&
+	test_commit A &&
 	head=$(git rev-parse --verify HEAD)
 '
 
-- 
2.29.2.222.g5d2a92d10f8

