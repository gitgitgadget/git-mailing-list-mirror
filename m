Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F46C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7329B23976
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnD9y+np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgI0OMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 10:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0OMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 10:12:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EDC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:12:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so8071331lfy.10
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4+kxm8LSoyWUoNM50l1Z42GDLAmzp/f1V7G+Isbzlw=;
        b=hnD9y+np76NBtBueb+Wz3kB9pIwkuG/dowsp0pi6RXtbNhWs+43NrTBMcaToHq/Rm8
         rrzb04Fdn2XsYh12NkrfGK8AbiRsHZI45kBxkNcF22lZHrl3FGCAG14uq3JSQdwSv/Ny
         U8az7dHqDDMmT19F3nrCSC6ZCjDtk3DDB34hs5Mt6bWdSXASC3nhkKvkBgQRN8QMm5wG
         Vhlwy7pROEkgfqcWsNyepiwBgDswd9WfffF4jUub2n5/PerZAO0lrJOoZfnihgukCa2P
         9n+j5uLcSpaQHq1WG2PFKP2raK/0X4571jyEh/M66Oa5/C4TVwi0nXisPPdRJjDwizQx
         ezmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g4+kxm8LSoyWUoNM50l1Z42GDLAmzp/f1V7G+Isbzlw=;
        b=bZY3yF5GWY4gqlOOxJ4Vet5mg18uQq1nM3HrjcqIxlv44S8mZ4/xzyc54zgwc4GBbG
         a+bSc9Xau4AP/ho3qNtQU98uApPE6maM+WBHf364rgicTjoyg3Km666d9bWFK2CzT1xD
         URRQ6wr4WsxgAchmkNjWuAbD4yRUcRjGk99irNyUidrbFLJxiVwMzY0Rw8V2R7UXg4O6
         yjFshdLELB6J4Z590ldBUEuT16F0AUlbK/HUN5rbEk38tO7CidUjeZuHeBtNkNiEAntY
         7WcUM8ivXBrDLYmIBIGODmDCfLNoceHXhjNbz2HDfOO5C+P8Hwph5RUbJgZlWg2K787E
         1R8Q==
X-Gm-Message-State: AOAM532YeXx5hOtjaFzQoeug8HUVvEtZGlH+ke42uaiX4FdUVi59RIhu
        wz3RfHaHUub+3Jdn8V4ePgtMnTZMe0w=
X-Google-Smtp-Source: ABdhPJw/hUPnhbTSdS2k+SzBzDOJVGl8vONRWOsWSR5Tk5SFTUg5iuDUp+lPBT+/VPWM6600Ue8nNg==
X-Received: by 2002:a19:521a:: with SMTP id m26mr2762817lfb.133.1601215934657;
        Sun, 27 Sep 2020 07:12:14 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id l3sm2470816lfc.34.2020.09.27.07.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 07:12:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] config/uploadpack.txt: fix typo in `--filter=tree:<n>`
Date:   Sun, 27 Sep 2020 16:11:55 +0200
Message-Id: <20200927141156.9878-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That should be a ":", not a second "=". While at it, refer to the
placeholder "<n>" as "<n>", not "n" (see, e.g., the entry just before
this one).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 On tb/upload-pack-filters.

 Documentation/config/uploadpack.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index ee7b3ac94f..b0d761282c 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -65,17 +65,17 @@ uploadpackfilter.allow::
 uploadpackfilter.<filter>.allow::
 	Explicitly allow or ban the object filter corresponding to
 	`<filter>`, where `<filter>` may be one of: `blob:none`,
 	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
 	combined filters, both `combine` and all of the nested filter
 	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
 
 uploadpackfilter.tree.maxDepth::
-	Only allow `--filter=tree=<n>` when `n` is no more than the value of
+	Only allow `--filter=tree:<n>` when `<n>` is no more than the value of
 	`uploadpackfilter.tree.maxDepth`. If set, this also implies
 	`uploadpackfilter.tree.allow=true`, unless this configuration
 	variable had already been set. Has no effect if unset.
 
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
 	is intended for the benefit of load-balanced servers which may
-- 
2.28.0.277.g9b3c35fffd

