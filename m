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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E23FC43331
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A3D20798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbhAACRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbhAACRR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:17 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B4C06179E
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 11so19262716oty.9
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4El5oTjwd6FnGVnKJN2MYlzd75h8y3cY1tkhyBDF1Uc=;
        b=u8jDO4yWTMekr1aS24w86S//g3L5UAiWu1LEoHj1no94nRCezdV1dBSfRyfKlohhg6
         fHW7i4lubRADzdW1TQ0uMi0irVFhxlVYlhOrdHdqR9Gu8nAZTNecnsia/w1Pu9xk7EPA
         z5Ra5VUO0uMFHQQvxhLvPusM0fDnTf6erxMn63VcFh3domAL+zl4hdThXUwzB2gBgUJh
         0LVAWXEAMaf9T6VtCTMUkoeqVXZ02p+BuQciVjNXl3aJTeKgPh2LzvMEU37zh35DlpfQ
         kQdLw3x7RxLVK2cpm7ioh5REr11s8NSgBVgAVRDVB/3IOGRPcLIx8c4Kpe01ToDXQPNY
         FSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4El5oTjwd6FnGVnKJN2MYlzd75h8y3cY1tkhyBDF1Uc=;
        b=PIeUYrUMSBX4xc8PothEITYNQiL/Win41MhWowoHcbyvFuXLiI8k8U+1ruBRa7T7Al
         /VyGXQ+AeDi3XIk4vm1YBAot6Nh7wplUcqr8wRrx0FCxeK39vBHzyzSaRaRO7k2hxjV3
         HYn0UNJm0A6qLpu9AEBdfCcUUmyNVa03eFmuTySUCimVUYKwkgHOt36lCnxFdOPjdhUR
         oAwPPS4ZL7z2LRnmnqELgimNqU8wd4HB21sML9KUiG4u0QZQJbcdxeRy8EVOHEwblRFy
         0bXYoDbb4ayVNDz4nGoVfWGlyQ8XBIxS39iydtdmzdr8MLwI2HNsE3df0lTNv3D9zBcf
         dE2Q==
X-Gm-Message-State: AOAM530xa/QYOu1+m0X7UGgRxgWp6OJQtGV9pO3fLk1YUBylZPxcp8bu
        Y/FsKzvOq6fqeDUllcQ9Nun+bqv6OXVHHQ==
X-Google-Smtp-Source: ABdhPJze/z0iHetHRz0pR2lw92Gg69BqHKvO90g0dUmcz2JiqIEzQIvtS1ObWa7CaM1TWWlRZJkC1g==
X-Received: by 2002:a05:6830:1e62:: with SMTP id m2mr43075492otr.279.1609467396136;
        Thu, 31 Dec 2020 18:16:36 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s26sm11571985otd.8.2020.12.31.18.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/47] test: completion: switch __gitcomp_nl prefix test
Date:   Thu, 31 Dec 2020 20:15:42 -0600
Message-Id: <20210101021622.798041-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default COMP_WORDBREAKS includes =, so it's not realistic to test for
a prefix that almost never will be there.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 05469f04aa..82bf0ee2e2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -565,9 +565,9 @@ test_expect_success '__gitcomp_nl - trailing space' '
 '
 
 test_expect_success '__gitcomp_nl - prefix' '
-	test_gitcomp_nl "--fixup=m" "$refs" "--fixup=" "m" <<-EOF
-	--fixup=main Z
-	--fixup=maint Z
+	test_gitcomp_nl "branch.m" "$refs" "branch." "m" <<-EOF
+	branch.main Z
+	branch.maint Z
 	EOF
 '
 
-- 
2.30.0

