Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A2EC4167B
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiLOJtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiLOJsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1B1BEA0
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c66so26251320edf.5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf43tipxSVafZ6e68cmXdyGjRFRmawZcs5en6ZDQI8o=;
        b=HpguxYzZJpnwevMApOnicAwyAxsI+QniTSbCLDqhvnhTAbKbyqd4MRhHVNsNnN+whx
         KkwgVh5f9m21laNWeT0TbicVvKa4FRRVYbV0DEpv3wRbx/uwXYptdI3jocloiRhMEXaH
         Y4AfMsTEfSYnZ2gpQPIIkCw8XR9px1UQT+0Q2WxT7lGpATecT8iRT4EpNyHLidPFj6iV
         01QgFfSieBYprTgLBFGxBuSdIBJJRR7Dh1+A4lp/pBjYtxYiWJ+QdmPF0r5rfeZ1g+Wz
         mzp9emVEop/GMzUTc7wZJjaodR5TSfQGJgojI6rgMgonEU/kfbUl8/FV3MsKH2s6u7kd
         LBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rf43tipxSVafZ6e68cmXdyGjRFRmawZcs5en6ZDQI8o=;
        b=EpUOw+RG0HymV8LG5JpZbJ4aAl+/r4uws2B2A/YeLxF0X0BwUgmGN4/EpA+CV0/eji
         ei9Ogx0CLLvO+OHGQSlX/AXD7e4RfTFMRUm+8di09seH69o7o9QpKKW+RjyGDDwFGdom
         3KxRA1+dcbiEXGlHvEmijMGe/vWXDHKfwUPQ7emo25rVmX1oAD5C5fFZEY++VWHk0XdO
         bQzpSueg7Znwl16jo4UBpzCIfn1ojLUBwMb5eG9qL+ZelOsMIhEZsiPeWOguSZziy7fB
         v6LBKDTJnyoXDB0HqZ7YJqdHqMMK0RMOJXixZ2El+WAMWoTcknQiurNmgQZ9vSVK3pkX
         8Ucg==
X-Gm-Message-State: ANoB5pm0IpxFqa4D6E0iteXj/cDMNALGTniJqdNnd6UNWDSmOvfeYEqM
        SCZEJr+4MhRcOUp5mkFuxHnUuJ9bPqoTAQ==
X-Google-Smtp-Source: AA0mqf4z1ItunovXCa5AKlhtq+cf0a+pdQxeD6ib+xGi584oDu3FtjZXk+czPoWFpR/4+pSTxowZdQ==
X-Received: by 2002:a05:6402:540b:b0:461:75f1:9254 with SMTP id ev11-20020a056402540b00b0046175f19254mr23871225edb.2.1671097675578;
        Thu, 15 Dec 2022 01:47:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] bisect: verify that a bogus option won't try to start a bisection
Date:   Thu, 15 Dec 2022 10:47:46 +0100
Message-Id: <patch-3.6-e1e31278fef-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not want `git bisect --bogus-option` to start a bisection. To
verify that, we look for the tell-tale error message `You need to start
by "git bisect start"` and fail if it was found.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 98a72ff78a7..9e56b42b5da 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1058,6 +1058,16 @@ test_expect_success 'bisect start with one term1 and term2' '
 	git bisect reset
 '
 
+test_expect_success 'bogus command does not start bisect' '
+	git bisect reset &&
+	test_must_fail git bisect --bisect-terms 1 2 2>out &&
+	! grep "You need to start" out &&
+	test_must_fail git bisect --bisect-terms 2>out &&
+	! grep "You need to start" out &&
+	grep "git bisect.*visualize" out &&
+	git bisect reset
+'
+
 test_expect_success 'bisect replay with term1 and term2' '
 	git bisect replay log_to_replay.txt >bisect_result &&
 	grep "$HASH2 is the first term1 commit" bisect_result &&
-- 
2.39.0.rc2.1048.g0e5493b8d5b

