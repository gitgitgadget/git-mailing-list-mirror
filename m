Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E5AECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 05:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiITFHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 01:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiITFHS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 01:07:18 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C712AF7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:07:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z191so1316099iof.10
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v0rYN6JTZQ8xCSkSn1ShBeKQG0FFenXVvUXToKvWJyo=;
        b=kOe993I6yp5vzSf0J8wMr18AlHH6KEynYVBydM1JnnfJ24mXRwN66eLz2upNkN0kho
         PTi7EmTQ5ZeWfcQwEPuqfnQX7nkb8CRzjwvXzDOyTb0LUv4mwLTjHGIGn3FpLFOfmKLc
         I+mzNA+5xgW96RZ3kyZoufH8oquAmWdhlTA5snJd9uziWLxUug2NWzC9QvNg8R1wZx74
         51AwZqXHfGo+wfxlRYooacwp9Twwv67bo6c1Vz72RiybODEwdqJRxjcimRfmV57nCGDj
         FHwB/bnadP7wSjA84gL2HhcNPOyQfFYLeC1lF2D3520QJ4oaxKNpJ6m6PBqYaJC2uvqq
         odHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v0rYN6JTZQ8xCSkSn1ShBeKQG0FFenXVvUXToKvWJyo=;
        b=wnvmVSbTmlriPiTSEahMsWu8orCeYIMNMTvj/+QXBOFKCxE+sjVCDfJA+mcBmiZoI6
         8Kx+pyLkEMf9IiD1MKb4Bctq31JC5P2WBet3dTQmEwAxfeN78J4NrFEXJ4SP/5Wr6XoP
         I8RD5hItv9qe4iNKZHPlMp275UksqbMyhAzbUif1rH1e3RH6e49niK00ytC6sL731YRJ
         AxtWGGdquN1GyN2jpUXXEOtVM7UIa6SSsvhtRyJe09GUzm33PkAwU90eagoKieGr6zn2
         lL7jRSRp4Q9nEOxlL+jb9/DRIdHR24Hrr11KZr0/xtmyZtgHB8zC5p+F3KSpOTIzpNHP
         H0vw==
X-Gm-Message-State: ACrzQf3hVp61LjYamaVmX9kQc4+ZA4MR2Aa6/7eJ+i0Z5QltqwDv79Ng
        69wdrszwyHQl8B3YCnVBrpxuAaSJc0U=
X-Google-Smtp-Source: AMsMyM4QvcIKn6NQfnFK+JjsNnYBJM9siHOfGBvqKr6pRtcxrTd3d5L2PVf86OJjeShLK5WOqzI/aA==
X-Received: by 2002:a05:6638:16c1:b0:35a:9e1f:51a5 with SMTP id g1-20020a05663816c100b0035a9e1f51a5mr7435132jat.60.1663650436827;
        Mon, 19 Sep 2022 22:07:16 -0700 (PDT)
Received: from xavier.localdomain (75-169-34-129.slkc.qwest.net. [75.169.34.129])
        by smtp.gmail.com with ESMTPSA id h27-20020a05660208db00b0067b75781af9sm254277ioz.37.2022.09.19.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:07:16 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, jeffhost@microsoft.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] fsmonitor--daemon: don't translate literal commands
Date:   Mon, 19 Sep 2022 23:07:09 -0600
Message-Id: <20220920050709.326359-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These commands have no placeholders to be translated.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/fsmonitor--daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 2c109cf8b3..c69da93ece 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -13,8 +13,8 @@
 static const char * const builtin_fsmonitor__daemon_usage[] = {
 	N_("git fsmonitor--daemon start [<options>]"),
 	N_("git fsmonitor--daemon run [<options>]"),
-	N_("git fsmonitor--daemon stop"),
-	N_("git fsmonitor--daemon status"),
+	"git fsmonitor--daemon stop",
+	"git fsmonitor--daemon status",
 	NULL
 };
 
-- 
2.37.3

