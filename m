Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B8C388F9
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8CF5206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBQt9vA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKHVlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 16:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbgKHVlk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 16:41:40 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C8EC0613D3
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 13:41:38 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so1133521ljj.6
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 13:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=NBQt9vA31w/MeMHIpBSh6OK400OHt25OnGnm5pO7eAV7MiunNjJArRQvSPR4PamR/h
         IvhpNCtLXBoPHEem+o+DiGFdqy6qsaNTgQFqEpoGC4TpQ83lZwQTwXSzKIuaeBqS/pj6
         /uAxpzMAZc6UkptPBRwHmYssxiSYp/3TTXqSE/2Jz9Nmt6l2pfE3D6cXNLwWEuuP8jK5
         KhJuo2I8+F3P/1zbUhzor1ZPCPXM80sGeNaLhfGtzCxxMFpbQSR2xGjOqOSZt7ocmE8K
         Ex44x2EpRNzoTEnSqqGvrEoWQdO8ihuX+l1EF6FO7eqYoecTbIPqTHGybqBCv1WRyM3E
         WzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=CF7lztYP9LN+wqYLF1fqUTGTDcOQuZ7tbr/HlVh4A5Pq3TJAkN8YiE+4ETw79wyG0Z
         BBNqKFs3nGGcvZ1Ni5xVWVbAY0B/Yv1WU2F4vqA7XmSEqdbOAA0Jj6wwUhIN/qQEtPv+
         Sg3DoGeBnHtfxrdR57VbQZ5nsoXPKIuJwvrcXP7i/1cSH46GOqZAT2vuaTQaMiJUTz8h
         d0pnRY3Sk+M2KlmWw7muFiFc4/LC2WBC5D1COT+cpCpNjJfxWSbEpPX5jdlXJ30Z+Nzd
         r2PnDvOreoG4WmKFjqTT89x87sIhZZelRft8scHqsARJB8EMW8RY0oaU7470coK4u5K0
         e+TA==
X-Gm-Message-State: AOAM532wFyi0q/s5YKvYLthn20E6l7GXib57t3jCF1GFfR0rnsKuOtDv
        GIUsAk+WZRf6Fqw7JgXRsAM=
X-Google-Smtp-Source: ABdhPJy82miPBLEXjZoYXbOkpvl2WJKhPdzZYTp3Qxm83v4Y+SRLs1XmT/YQk+l4+1VW5a54CQ3sCQ==
X-Received: by 2002:a2e:90d2:: with SMTP id o18mr4685906ljg.243.1604871696931;
        Sun, 08 Nov 2020 13:41:36 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k21sm1937392ljb.43.2020.11.08.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 13:41:36 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 18/27] diff-merges: group diff-merge flags next to each other inside 'rev_info'
Date:   Mon,  9 Nov 2020 00:38:29 +0300
Message-Id: <20201108213838.4880-19-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201108213838.4880-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The relevant flags were somewhat scattered over definition of 'struct
rev_info'. Rearrange them to group them together.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 revision.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.h b/revision.h
index fcc532c873d1..dcfa14454a55 100644
--- a/revision.h
+++ b/revision.h
@@ -191,13 +191,14 @@ struct rev_info {
 			match_missing:1,
 			no_commit_id:1,
 			verbose_header:1,
+			always_show_header:1,
+			/* Diff-merge flags */
 			explicit_diff_merges: 1,
 			separate_merges: 1,
 			combine_merges:1,
 			combined_all_paths:1,
 			dense_combined_merges:1,
-			first_parent_merges:1,
-			always_show_header:1;
+			first_parent_merges:1;
 
 	/* Format info */
 	int		show_notes;
-- 
2.25.1

