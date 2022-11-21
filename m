Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA165C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKUMQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKUMQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:16:28 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9449F2A403
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w4so1627609plp.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBFSxADpOf/l9+7MRFGtWPsM+rehplbSAtXSv4XLa/4=;
        b=Pah0oBFKKzkpW99sosahT+dVow8GLoOVbjWq4zewSJWSHskqdGmIPD4yyUckDnemjM
         CBG5oWXAfO3OGTi1DrnjeqMfXLbqNECCXt50Q7UPFn2Ml289TMLHjyHxyHAtDm5QdfnK
         sadKrsd2+l8WuzaC4RbNn/NsdXT1d+b6NadoWc2wHcHVOWfHosYAQMXhl2N/MQoziNsq
         mlm6lIE3AdA+lVSkiSyRTtzL6EdoDUAiXlg+44Wa/M11Lxzs27/5sxy6aFlastvGUQ9s
         USOKDHNr8a4jSAl2NAp6oCZUWkg3N2fykIH2eIemTMgqGhlhxUr5anYXkW7ZsJuVP8BP
         pl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBFSxADpOf/l9+7MRFGtWPsM+rehplbSAtXSv4XLa/4=;
        b=wQ0+hPQrTkqVXdyTuTcODdPH5c5F7ar667juLisRZIZpDRjY7kGiY7w2pEmDFEwUYL
         j3rNGMqTXhIDnShIf2kyRKsx55CuHcWsY1Lf3lvnlim7Pfxd6JQd1xgpemrsP1i9BBas
         sX9XM3Dhq/6iYW4gdCWf4n+UQYAnATjG2HvhY5PmdbObeAJ2RucPI9DVZhTiaaxGpRdz
         lGbzkKYboOfU8Ys366sbWLa1n4seYGkN7GyCge4RlGBtt0c0icMXI/zqpNvKNq8KzSZS
         NxGfn54uEqHdLgHeKdR0UnsK4Aqj1qeL/UmABW58hFeaAqqQeGg0vTxZvClW4COwupmt
         n37A==
X-Gm-Message-State: ANoB5pmjShMmrKsEnnBOYkreZuWwb6lRTp59gpkawfKE1YDqd1TMcrR7
        tTOkZf/UA/SOYJgO3vUFQQ0=
X-Google-Smtp-Source: AA0mqf7tzw+7sdtcQ8LQ9LG/0Hwd73Ihpl2geOvnGJqnPkUR6GLujbUk7eiTS/zgeecDGffEU1K+cA==
X-Received: by 2002:a17:903:41c8:b0:188:f0d7:ffbe with SMTP id u8-20020a17090341c800b00188f0d7ffbemr115820ple.27.1669032987030;
        Mon, 21 Nov 2022 04:16:27 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b00176b63535adsm9630098plh.260.2022.11.21.04.16.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:16:26 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v4 1/4] pack-bitmap.c: remove unnecessary "open_pack_index()" calls
Date:   Mon, 21 Nov 2022 20:16:12 +0800
Message-Id: <aaeb021538cdfeb83dc6004fe7b3ac35a23aef49.1669032426.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
References: <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

When trying to open a pack bitmap, we call open_pack_bitmap_1() in a
loop, during which it tries to open up the pack index corresponding
with each available pack.

It's likely that we'll end up relying on objects in that pack later
in the process (in which case we're doing the work of opening the
pack index optimistically), but not guaranteed.

For instance, consider a repository with a large number of small
packs, and one large pack with a bitmap. If we see that bitmap pack
last in our loop which calls open_pack_bitmap_1(), the current code
will have opened *all* pack index files in the repository. If the
request can be served out of the bitmapped pack alone, then the time
spent opening these idx files was wasted.S

Since open_pack_bitmap_1() calls is_pack_valid() later on (which in
turns calls open_pack_index() itself), we can just drop the earlier
call altogether.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 440407f1be..982e286bac 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -411,9 +411,6 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	struct stat st;
 	char *bitmap_name;
 
-	if (open_pack_index(packfile))
-		return -1;
-
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
 
-- 
2.38.1.383.g9d5a491887b

