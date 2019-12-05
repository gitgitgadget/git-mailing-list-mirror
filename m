Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF90CC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821A20706
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apsi78TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfLEWzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:55:08 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:39274 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfLEWzH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 17:55:07 -0500
Received: by mail-qk1-f181.google.com with SMTP id d124so4854340qke.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ui9j7G6vyaJIbZ0EdArmHV+j8rfus/HEcDta168HZHU=;
        b=apsi78TQ+Mz2mwJ/xRCi4CqGJyxZEq/0Mg5EwvhW07ligDPuI9CkPpNG2Kd0ENqn8q
         0FUqjZEcQPiKfWGE7CIwaGcfFYasBLubZoUy9hbrVvmkVKL1nX56swQASyLKgyAmYQvA
         xTrQQl1pCNvJ/jqk6JWFjamcew1sUUsCteLVnriQn1Ao5XfxcUA99v53/c3js3fN3UZo
         XKCoj3BbMHya6hA42IbdWA5BNHocGd+tdKnbMk0Iva1HF+ho2nPbRfp8zM5/wS8V1qpV
         j3+XDntEYfKHvoynfcjNDcp2Q/ax48vCboVNkkUNgw0J9Kr9G6h1T2sC10O0Fr3PVmOh
         pfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ui9j7G6vyaJIbZ0EdArmHV+j8rfus/HEcDta168HZHU=;
        b=CJCVQ8dCWZ+JRuYQhYTbyVZKh24zrlWNIU3DJkD0giLclb93PwiGOlxFNjvzU9IwEW
         kPBMqEDBpg4GYUdZqbf7sIOQqBYS2lNSQ9hWi6aqDfKMmVN6xyvHHjzDuiOj59aII9GO
         AK0342krTBsrJemHhPS3MRPNqY+xMRTlJ6yMH6kHAqGscAwgE0wLsziTfoHJsvbaFpBM
         +xEIwPFXrO4i0ltninF7uYTJ2AkYmE4fpK9t6wCyae8gFkojHt3lJXWF7ANUdJrVMdym
         CTAEDKVmtz+v0vA2844HMqHd3wSs5Z758KUW21sGB7ym4nTfDEz5/o7UjBp2JfNi6XEP
         yvpw==
X-Gm-Message-State: APjAAAXb+4hI3yOFY3IDVog6PYRYtP03ekQdZYAAbxCX3nULp1BqlRPO
        ljuYDycBj3gLp1doHX8UV/fx6A1aRS8=
X-Google-Smtp-Source: APXvYqyh4PBIEiHz1l7VMFUX8JtbyVduPEl1SNNS4Sr4XOBREaGqtIOhgDJ2AGb5RtdxY6apoEUFOw==
X-Received: by 2002:a37:a20f:: with SMTP id l15mr10674289qke.56.1575586505973;
        Thu, 05 Dec 2019 14:55:05 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id f23sm5426066qke.104.2019.12.05.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:55:04 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH 1/3] rebase: add test for rebase --fork-point with short upstream
Date:   Thu,  5 Dec 2019 17:53:20 -0500
Message-Id: <20191205225322.5529-2-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205225322.5529-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This proves the bug of "rebase --fork-point upstream branch" not using
the fork point of upstream and branch if upstream is not the full
refname of the upstream branch.

Signed-off-by: Alex Torok <alext9@gmail.com>
---
 t/t3431-rebase-fork-point.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 78851b9a2a..6ecdae918e 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -49,6 +49,7 @@ test_rebase 'G F C D B A' --no-fork-point --onto D
 test_rebase 'G F C B A' --no-fork-point --keep-base
 test_rebase 'G F E D B A' --fork-point refs/heads/master
 test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D master
 test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
 test_rebase 'G F C E D B A' refs/heads/master
 test_rebase 'G F C D B A' --onto D refs/heads/master
-- 
2.17.1

