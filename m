Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9280AC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAFD2080C
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 17:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="W168lHI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRRrF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHRRrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 13:47:04 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B0C061389
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 10:47:03 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so9943958qvk.6
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8Rw9n8K8iP6IGCB8pFB6YSNMvJ23PR7hrYwnkrSfjw=;
        b=W168lHI1kupFxikxpICf7DV4hQjXgdyGna/PS1v730PqazKeuxyOONVWezYA22Vj3H
         t/LpzF3yxf9wb29UWSqFPyMVhFXvOQEY/8Jn3I2pmTfAyssNRZE/9eCRaDUnI1lpHrQL
         0TA512azjR7m5hA2OUvjqa3Z8pRRD9a717/IWRefqaH3LbPGvnCiyLnVNHk/k9CsrpF+
         4gNnFDOHByxwcKaxzXC9KqNk3c8LEqwuBRDofFR0IHjgdjsfsBnjw3VDmXD0tcC7jS13
         /OIeMlwYHNQq3CuPAdQCIAtKDGOxKqUhAt2sMuJtTMTe0GDBmFj8vjX8Jq2tdrsTaeID
         QuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F8Rw9n8K8iP6IGCB8pFB6YSNMvJ23PR7hrYwnkrSfjw=;
        b=JUciOooKryKhjdMvMOmEo1GuAsRyklRsWAxwK19Egm1DYy4EYL5quLUDMIql6l2SmY
         eBmgJMfKQrgVrfRs6urssZ6jxRw5Njf28lY9eaK4xBfOASfPjorC6bmDSfUztouC/WPg
         3vUKW3Vy8TgOycPRSAcUJbt2mrTFD8ZlkkR96613a2PFQRyyByO+5UoTTDiT2KFjX+E2
         2HwNAPJTvgp1w654aVb/9rSTHaVaZryxTLUJWHyslNcVwA1k1XK1RqWM8+I5J+8Gyr1T
         F2vqQt3Fihzqgpdi5bS9Zq9LauweRHa4UJ3uq4l/tOHFZx8qa2sy2nbhl5fwMtDXfw15
         xsiQ==
X-Gm-Message-State: AOAM531FPaFDED7pEdoiQ0U/p5AFVASiU5ZlDnvh96rdQT/9T23MVi37
        cEI/3Go/qZc5+SMrvJL7RjvOVTxq8ujVsQ==
X-Google-Smtp-Source: ABdhPJzBnpXUTIhCbgEH5W5+dTcIjjrLbdZgKe3/nsz4u09mWe6jHjHZg10zzjhkKTQR3yaYWa3mcw==
X-Received: by 2002:ad4:4a29:: with SMTP id n9mr20232225qvz.50.1597772822760;
        Tue, 18 Aug 2020 10:47:02 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::5])
        by smtp.gmail.com with ESMTPSA id p202sm20969555qke.97.2020.08.18.10.47.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 10:47:01 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH] checkout_entry(): remove unreachable error() call
Date:   Tue, 18 Aug 2020 14:46:55 -0300
Message-Id: <a170ee42e6d642d380e6b761e8889b05e452414a.1597772501.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This if statement never evaluates to true since we already check
state->force a few lines above, and immediately return when it is
false.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/entry.c b/entry.c
index 449bd32dee..a0532f1f00 100644
--- a/entry.c
+++ b/entry.c
@@ -492,26 +492,24 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 		if (!state->force) {
 			if (!state->quiet)
 				fprintf(stderr,
 					"%s already exists, no checkout\n",
 					path.buf);
 			return -1;
 		}

 		if (state->clone)
 			mark_colliding_entries(state, ce, &st);

 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
 		 * to emulate by hand - much easier to let the system
 		 * just do the right thing)
 		 */
 		if (S_ISDIR(st.st_mode)) {
 			/* If it is a gitlink, leave it alone! */
 			if (S_ISGITLINK(ce->ce_mode))
 				return 0;
-			if (!state->force)
-				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
 		} else if (unlink(path.buf))
 			return error_errno("unable to unlink old '%s'", path.buf);
-- 
2.28.0

