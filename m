Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10759C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A1E207F9
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjD693q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEQSwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQSwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AAEC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c12so2629183lfc.10
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/tOlumivPrtndi0Yw/zXNc++fLoP3hbuwF9Rup9nmE8=;
        b=jjD693q/9HVZaLRRf3p4g+DtUrJiLP3zQ+3TbrTMfyzL0GP3s7CTPPNz/WtfrnblM8
         nKbOaJ9CxVfxE3Ok4NyVnx7+W9zhZvb+PBi21yGJQR05KldA0GPpKC9uUx2Akp8B6qYK
         5cmJaWwLVSHDwOw6YSvTX3oLJj9N7eKgDr73jUNk2rKY1Q7ohFJ1WGBEJ5gDVKy+Easi
         /q9RiksjZxANF6oD86FgbnYCFDb2x294IUEXAIYI3rxmSBv0LRiuqCVZaxtlnLgJVO8J
         KVUCWo1Xuc9PGg2BAUgciS+STSSaEiEYeifien/rro8EsDu/scHn57EVcDLiodCqVEIj
         Gfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/tOlumivPrtndi0Yw/zXNc++fLoP3hbuwF9Rup9nmE8=;
        b=dpQBhe7u25cSihVO0I6jpcmXnfrFRQ2UA9VCtoEeuoVHMBG11JT2T5k3J/4O6jO6ft
         ageRxaTU1RiRuEFiRRMC5Wn0XTp7d7EqVnw6yzSrE0EtrQRAPBY/rhTY0g4hfp2nY41h
         izv5POGvs8Bj7geIQml29HWdGVTClTtBgN/ptxb3zg+pTuvleprvtWAGTsneDDXNvJbD
         fBn5yRodefmuacxpgpxbKwslYoPijduS3BvesbzA0Y2dNAGPwMRupcZ03554jx/DbRJP
         y9oL6B4t0DAIagINM3yQhbzUYL4vrco0sVHpsi0qblsKLwoe8zwPNZOm2G0FPCc6mK/v
         92Mg==
X-Gm-Message-State: AOAM530r/lUBc1SQOZ3qZkoiS6e7PmIlFdYyFVgZwGPetyFYu3ebbovI
        Sve8VTomAG99QNVLorpTa9l+DFLj
X-Google-Smtp-Source: ABdhPJzqTlU7FqLjNuydfL9MZZTrtsc2y67LTrDAgFyM/Mqi5SVe4szKFGzPiHPWK0GnedAHCPdD5g==
X-Received: by 2002:a19:6b13:: with SMTP id d19mr9268264lfa.126.1589741554420;
        Sun, 17 May 2020 11:52:34 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/7] git-bugreport.txt: fix reference to strftime(3)
Date:   Sun, 17 May 2020 20:52:17 +0200
Message-Id: <4753804d23ba7b1b267b6557077c80f3a8891712.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <cover.1589739920.git.martin.agren@gmail.com>
References: <cover.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we say "link:strftime[3]", it ends up rendered as "3[1]" and we
produce a footnote referring to the non-existing
file:///.../git-doc/strftime. Make sure we use gitlink, not link, to get
the effect we're after.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-bugreport.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 7fe9aef34e..5ee9988628 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -46,7 +46,7 @@ OPTIONS
 --suffix <format>::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named 'git-bugreport-<formatted suffix>'. This should take the form of a
-	link:strftime[3] format string; the current local time will be used.
+	linkgit:strftime[3] format string; the current local time will be used.
 
 GIT
 ---
-- 
2.27.0.rc0

