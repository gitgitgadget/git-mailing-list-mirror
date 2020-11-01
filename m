Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76CC388F9
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F89E20B1F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeLgiA+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgKATe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKATeW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 14:34:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551FC061A49
        for <git@vger.kernel.org>; Sun,  1 Nov 2020 11:34:21 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id i6so14670247lfd.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2020 11:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=ZeLgiA+Ftxl3x8JiFQRvs16NPgG/RIRqoQnIq7xUpcbx80Z2H/jkPKlYod0mhgnJI0
         PMICfG43yDHNLVdae5FcSmp0mG7GPMR6TZPxrxOpvEwnHv/JYceoAJ2EUK2t+OtBWlHg
         YS+UZF/XufH2z385VQ7jUZYi51o5tAgF2GoHCXWsPieDbuArUIwKxIp1eMCa9T9yW60a
         7jli7Xvq4xEyr25QuAlCZbjTSs9srw2lL7tnIV4jUvNRKXe+jzZ/c8N4RmKv4vNfTmxL
         +XYvxrKOW33Tu7MONIpoEEOBJ4kHlt4vuoKsOUpS8wTBiM3OzXP3FUXb//G9lIJYU24T
         D5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W3us1d0G5MzwFNR/Pz+9/j1tIqVyxQx+lyRwVD3uME=;
        b=Hf0FpMcGoPqvKoIJAZMj5fZyiBgi0Vmi9fAKQVlK8U2IJyVRwVrUqOJ6gqZHUhVs7A
         mrkS5alRbvd6WME9FDumynOGq4lvQrLem9Dc0+s6a/I+edP2XE4rmK91cC1rEJCakaZp
         T8jsuIm6lRxrgtNIDCSs0rqqBMJ0uG6j4MuYLmtOG1lXxnaeHbgs3p8CBETpFTI+pqv7
         hvE/jmSQYct1GONfsNKjYKEczpJJsQ0HYPQVaWLcWuf2M9UjaTIh6YatnuLEUtf/DobJ
         psDDSvs5+dulOJ5+02UwKGgLAf/0NI7s2k//PZAIOtoXwOFT7Hw0jjnQqGebsZu80gBw
         w+lw==
X-Gm-Message-State: AOAM533+Fqv5hN84tZX3IVf25V/HfplrueFaxbvDo5b62WbuD0G1/eGS
        LNSypXKKpohq3mSJuwUyeZ4=
X-Google-Smtp-Source: ABdhPJzZ38OBJw7bX82yUcZSLgT6gs9FdRpvf4x9vY3lIKBwBJdfDqnS+QefxaNiuK6QuH7P+KTJYQ==
X-Received: by 2002:a19:e45:: with SMTP id 66mr5000828lfo.376.1604259260286;
        Sun, 01 Nov 2020 11:34:20 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m12sm1766526ljc.88.2020.11.01.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 11:34:19 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 18/26] diff-merges: group diff-merge flags next to each other inside 'rev_info'
Date:   Sun,  1 Nov 2020 22:33:22 +0300
Message-Id: <20201101193330.24775-19-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
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

