Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEEFC433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F88861076
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 14:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhKEOLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhKEOKz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 10:10:55 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA35C061208
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 07:08:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t30so13922395wra.10
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2a103cCDfhOvr8qEqPP5o9jtt8CojCvoK4h2vCKrY94=;
        b=Z+30MHuDaecuvodjDPU6mgPrxsZyA9UehuFrL+RnS1mIB6BL6jMccgikQiCTcqGFb3
         9S3jb5xFvCnKdujpktyMoAkdYCvt2WeLztAzmrYLLWKgU41WiElHeOXm6U7z5kQXxHgN
         0U3fbSTtls48VHQ8/+Gwtz/R3X6Vyk04UvBPG394C5+XSBzx02D1mb/YTMms2oV9FirC
         CKfL1SfU0XlaNVnLBs3r3nhbFtOiqFLeURhKxN4A06vsX48SH/Jmq2vkWqba+iXO5Cal
         Ledn7mn2dM+zwAxhkORvzpbDOax53fdUNiLP6+dFMokAjmwv7jqIDg4EBtwWF450bcMZ
         vtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2a103cCDfhOvr8qEqPP5o9jtt8CojCvoK4h2vCKrY94=;
        b=JGk2d1x7RjEH++S6+1MvV5wUcgfehzgtbDcegiJ4KvTFN101c5e4+1qreYvCwKYJv9
         AdOgliJCq/2mcp0iwSyWil83IKORZxUcEm8toEqCXHwiy1l9lqH30y32lCkm6uIQe/IN
         Ky0Y/cEMol9bD3+tiG8cAQAxEag/qTFdF5rYsY/VAPCMcDddXc9wBJh8BKVVMZRYt9Os
         BTJj+rL3C5Zdo0wgeLTXXUaBg7q467OXdAW16DQ4RLoZ8mSVmQPJHpoIVErBiI4oUP2Q
         amfRFyDbeoyzXR7bFFBumqUipeM0Y2FyXFVCeZtmxJcGZqoGP+DsmoAeu4Z8HrgI8NaF
         DCRw==
X-Gm-Message-State: AOAM5311/w7rz+DFsyb1SEgE7F858EEbvX9irecf+1uDWPaYvKjAR713
        BA6Q34PyqzAE16rG+ztkY8Et0oxRCvYJtA==
X-Google-Smtp-Source: ABdhPJy8i/sMpG4BX3h++Vfz5IpL15KzZDGtQbnN1VYGIzw30TZIkKhvjaxTasOfhjfpe38N6TV1ww==
X-Received: by 2002:a5d:59a2:: with SMTP id p2mr23966143wrr.252.1636121294597;
        Fri, 05 Nov 2021 07:08:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7821556wrs.19.2021.11.05.07.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:08:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/10] generate-cmdlist.sh: run "grep | sort", not "sort | grep"
Date:   Fri,  5 Nov 2021 15:08:03 +0100
Message-Id: <patch-v3-05.10-d7be565b567-20211105T135058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This doesn't matter for performance, but let's not include the empty
lines in our sorting. This makes the intent of the code clearer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 generate-cmdlist.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 16043e38476..e517c33710a 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -18,8 +18,8 @@ category_list () {
 	command_list "$1" |
 	cut -c 40- |
 	tr ' ' '\012' |
-	LC_ALL=C sort -u |
-	grep -v '^$'
+	grep -v '^$' |
+	LC_ALL=C sort -u
 }
 
 get_synopsis () {
-- 
2.34.0.rc1.721.ga0c1db665bc

