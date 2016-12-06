Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657E91FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 21:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbcLFVxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 16:53:20 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36633 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbcLFVxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 16:53:12 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so72544504pfz.3
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QRn7T0NYJ1gAS13Waao79J1P+HZXJ0c8PEiWTsz2nWg=;
        b=ip5lv3u9jFF4O5yT6OLXbmW5cBccDFpv8jugOXzuhHWb773yd6Zos9zO67+6ERJtn2
         bLcbx+yQBMAFiYa5ceJwoPFeB6QzPs/rwaU1UQ2sg6Hcpp+SZsZWX6z8hwNJpCZffgtk
         W+4yflsk1Ztvykb5Un3p2175lKJJMk7Dtsx7xLBH+8I6Qp/Lf5cZhGMCwFwWqiLRKwY6
         YCLPE1GDSrBIRmH1vHie1EAcpoWXlY+zUF5/9DKoGtrLqCAQ4nOPrCIHo7+uAxK+O9SU
         Lur31ORY5AGaJmpnRDcuJMRRwt/Av+4a6xaOQ1AbNMCra98ArmWCabJkB4Q8P1WBBttn
         Wijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QRn7T0NYJ1gAS13Waao79J1P+HZXJ0c8PEiWTsz2nWg=;
        b=FoINeqxAD3sf7vLRNUwR6mL6SRAE+7Z3BG7qEsb5dn0HlFh6YWKGzoXNARPRYu2Ltl
         UaexNlcvhTvIW8AHVkPzEHaM7T+UoMAhrhZWNa9W1PCwWGMejK1EXSc7fhiCCYLn5pA7
         E4p0nxbsUohbCj/0FQOnGxw2LkzBt1PBMaDNJrlb+lam8Yn30c7q/n2v5B1a3HpYmtgl
         4VMGA8U+OYZQCiqdZWzVzfhb+4UZjqpWoLlKPpMlPvpRutQQQD9wx+ZX97KZDB73mX66
         Wkt587PpUPtpV7qnFZyI6u1zeLVYQRgth5iVzcx/oDEUuuJCRe37QiCUA2EEyD+BhsoD
         LOVg==
X-Gm-Message-State: AKaTC02XOwEKD2MHr+pwQahPnfh3+A7bczyZ9rBja/++EUYoi+FHfBuNhs15FuQ84DHpiIHC
X-Received: by 10.84.213.130 with SMTP id g2mr139640663pli.43.1481061141357;
        Tue, 06 Dec 2016 13:52:21 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id y89sm36940228pfk.83.2016.12.06.13.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 13:52:20 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 03/17] dir: convert fill_directory to use the pathspec struct interface
Date:   Tue,  6 Dec 2016 13:51:32 -0800
Message-Id: <1481061106-117775-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481061106-117775-1-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'fill_directory()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 7df292b..8730a4f 100644
--- a/dir.c
+++ b/dir.c
@@ -188,7 +188,8 @@ int fill_directory(struct dir_struct *dir, const struct pathspec *pathspec)
 	len = common_prefix_len(pathspec);
 
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, pathspec);
+	read_directory(dir, pathspec->nr ? pathspec->items[0].match : "",
+		       len, pathspec);
 	return len;
 }
 
-- 
2.8.0.rc3.226.g39d4020

