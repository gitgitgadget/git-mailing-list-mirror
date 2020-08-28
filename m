Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2477C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0854207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 11:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUrgTIlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgH1LHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgH1LFn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 07:05:43 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13204C061232
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r13so855215ljm.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2fPYiJDcwKgFt/M6Vw4KDPh3ztUo9YdNT/cdPm3Z04=;
        b=OUrgTIlIBhv/+JkOdETNIsWv7OzOr4Hx9vRy0uKFSd6EViuAofOQxpWN0IMp2g37On
         /0Bf6PMQkvt467RgouTgsbZTN0drvjN7kfxehaeIUlnm+nVNBBrj0h8ksXaJt9349HmE
         +wE9tGiYerTl/IsZumyQ5e7CLWKT8WEenS0HE1o25d1/fDJUsMryBM1lT8H5sWSwdS9N
         HeseTMPh5hV4aI9xuiV3md+9S4DnjubrDswVB2+i1vu3dxdUkCHhQea29CuIPwNIAMUJ
         YD0oeoLMGD9+tomTNYghYRnXU1Rb9xSYNLQZuhmSQkbW/20Zudx000/r1KwImrvGccGR
         G4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2fPYiJDcwKgFt/M6Vw4KDPh3ztUo9YdNT/cdPm3Z04=;
        b=IlKc0WZAxrrBoh6giSRkdN9TBoaqOd2Dd15MeQ/zhZG7ScSA+bQj8b4pDfw05TY+ho
         f/APlUkWvRN/5OKhqQtRWh98EoMLNMWPV8suASofYT4juaB6M/IrBb70ZYaVLaHGhK2N
         dL/xzw1Kscm6SkcZPHtmcqyIloU8NWucGWsIceF2Nx1c/AIFVXbM73o86VLvneJOtKP+
         7Fr48tafiP8ESTnjYXtWwcrg1w3wbxi/4uzmsPQK2XwXwJOlVeX5q2GHLOYL3+WrwiyH
         ZMeW4c0zq2OAkLJ+cGxnkbbPx9by7f7Cspl+LuwtXEHWw+1K9WSw8fh/01VUQQqmuMbS
         56sQ==
X-Gm-Message-State: AOAM533vCsVjNJDUbdnpqQCCaz7keAQ9mGUKXKhhf5fWjOjqkawS6S/u
        DvPg9jkzjqaoIeiw/ztAz6Y=
X-Google-Smtp-Source: ABdhPJx3i0wCIvvzDD3v/V4UJF9MEMNRtcSBEeiTDNAusuUcisdiyVTIq18siN2Y0b7O+inp5XJ5Nw==
X-Received: by 2002:a2e:531c:: with SMTP id h28mr684431ljb.322.1598612740401;
        Fri, 28 Aug 2020 04:05:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id e21sm218707lfc.97.2020.08.28.04.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:05:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 2/2] log_tree_diff: get rid of extra check for NULL
Date:   Fri, 28 Aug 2020 14:05:26 +0300
Message-Id: <20200828110526.21145-3-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828110526.21145-1-sorganov@gmail.com>
References: <20200828110526.21145-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of needless check of 'parents' for NULL. The NULL case
is already handled right above, and 'parents' is dereferenced
without check below anyway.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index c01932fa72bf..8ac285a25af5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -917,7 +917,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	}
 
 	/* More than one parent? */
-	if (parents && parents->next) {
+	if (parents->next) {
 		if (opt->ignore_merges)
 			return 0;
 		else if (opt->combine_merges)
-- 
2.25.1

