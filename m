Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2854FC25B06
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 19:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbiHITKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbiHITJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 15:09:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C6D2C65E
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 11:55:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2461780wms.5
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zLEaoJFNZSQleFo9016QNQHr9BNunzTXAbdw7oqVu+o=;
        b=pnMi4mDjxH+JbIrYQZOWUOrCd8lCBgTOjWVkBAc6J9WA7wTSj0HUEv8iNCIx29aPaL
         VsB6yze6FPk+yrY1Ucnxwg7lAWpaM7gsaeBgm/HlHDANLjwLIJgL38d+T51vIajIEc2D
         hTUo6zBiUlhu9BKvVtoTOUE2TvuAEj2GP3+cC8EZueaoB4bR867eZdEvGvTEAGsx7tXc
         xDO4hJGGMlxo8gFmLyhNFphBNZcML+udkcMV3PLtUYNU8t2TuB3ncXehgzM4zsqNCd5e
         d5bHOPn3p9Vx3s5VVMOgXBZ/LH0MteKSXx2lGhmmUV3Vo13gAAXoLv3e7NrUgAc74rWr
         1M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zLEaoJFNZSQleFo9016QNQHr9BNunzTXAbdw7oqVu+o=;
        b=dic5GmwaXhlQvFUzb7nXvyK9TFoNYY/G6qpwRaLcszQbsPsRN4TKg0TxcILO+6FcRX
         d2HzFvtRKA/EBxjHXxtw3+o0ljZc2uEVmVeF0qhSLxdCAC/IYbSDEeVBjicy81hYzlEl
         DCi7BLYVAypA0t0m9g5BVshwLnqfdUmixgZmsF/3SV890VPiYcOUSr+Zus2Eh9wHFXoX
         dyWzClnTRjI9SxJD1qJbST8n0PZJFvrd65FA/dtw4H7226n3t507CeC01o7tKbRUw9Sb
         HmlG39NQVOHIGpw0gLAByCJPMNIRu9ceCgnJPs/t5JEo84aXMHXijnCC4eK2hHZTOW3T
         5Idg==
X-Gm-Message-State: ACgBeo2WURxRGdiJQuPKoItBlsqdbnHhh5dm4OysS6243jCglUPl5FTg
        C6CbtG4KW/q3hRcKRGshgZIuTwmxNRM=
X-Google-Smtp-Source: AA6agR4c4dxZTzr+svWwnGngp5M8env20h7XZKvnYbOFDS9S3WzPKFcUTaRHPKjAn8N8Oy7+9k3c5A==
X-Received: by 2002:a7b:c5c8:0:b0:3a5:415d:20d3 with SMTP id n8-20020a7bc5c8000000b003a5415d20d3mr6641525wmk.97.1660071336298;
        Tue, 09 Aug 2022 11:55:36 -0700 (PDT)
Received: from ylate.lan (89-81-181-244.abo.bbox.fr. [89.81.181.244])
        by smtp.googlemail.com with ESMTPSA id j9-20020a05600c1c0900b003a529b7bc27sm13237414wms.9.2022.08.09.11.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:55:35 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v8 14/14] sequencer: use the "octopus" strategy without forking
Date:   Tue,  9 Aug 2022 20:54:29 +0200
Message-Id: <20220809185429.20098-15-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220809185429.20098-1-alban.gruin@gmail.com>
References: <20210317204939.17890-1-alban.gruin@gmail.com>
 <20220809185429.20098-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 0e5e6cbb24..00a3620584 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2319,6 +2319,9 @@ static int do_pick_commit(struct repository *r,
 		if (!strcmp(opts->strategy, "resolve")) {
 			repo_read_index(r);
 			res |= merge_strategies_resolve(r, common, oid_to_hex(&head), remotes);
+		} else if (!strcmp(opts->strategy, "octopus")) {
+			repo_read_index(r);
+			res |= merge_strategies_octopus(r, common, oid_to_hex(&head), remotes);
 		} else {
 			res |= try_merge_command(r, opts->strategy,
 						 opts->xopts_nr, (const char **)opts->xopts,
-- 
2.37.1.412.gcfdce49ffd

