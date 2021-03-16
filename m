Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B5C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E743864F70
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 00:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhCPA4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhCPA4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 20:56:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A1DC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:32 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x29so21498421pgk.6
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BchThtV8YRognHERkN/0fie3Yzw7/Zd8VpSB+ipofPo=;
        b=nVIriQl2VXr1AH6vJimhtxfgTT5hROf3mR47vgAob23cGjMIlsobJtGb6kcL2om93i
         aq7cShoBx+ZI/ow6phNLve3c1oaJmGiTB43LiXhAXSDwchem1ytwrslHU/rYXmYQSHH1
         C9zRtAtheLOVGgQP40sJg0qPK9CQIFq/2xg52r+Bv9pMq58/8+vSo+oy6e2kqq11rwdS
         T6M24W9WAf7FJM6HGYB3Nrhj1jnflalCptsgenLp50eiOXEeZxuHZuocePKwRkUw6uMJ
         W5DrT/aRekh0bVsLbuKa8kELySHs6rdhBoSusokNjQr+kz7WZegjNRuY1vM5V/7/fw6z
         QHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BchThtV8YRognHERkN/0fie3Yzw7/Zd8VpSB+ipofPo=;
        b=ATwfY1jbc3Q6yqFBfme3+x0fLMNed2TryGSy+7LleNcUqOOPqinQKQrN1G2OGwcTf9
         7IUj8845Ss/XrpS+gXRlQH4ZmxEo9RliMdoJzM960t9cUB4iJON0EIr021rwty9eGeuf
         AGjEO4mmB43J4nFQYCRCLXsG2+22PXoEqzyz6o+ijjm+k2tnFGP7HIi+0atIQjkGDlKX
         r98I7/kcKvRZyvK3DmOpzcX1PMwXpfCuz5vGrb/Ny2aA/oH5TIvRS9Pye0gni2opjWOb
         1VywI38X0Dpm9MCMKRvFBuljSZzFj3pkl5pjpcMbxGdtZPlpxncVzwtKJHjiavhKkUck
         HfeQ==
X-Gm-Message-State: AOAM530q5Wg3Ma3Qqvx1F0J9poF2jAQMQWV0B3yoTUy2gpjAsFDOGdn9
        Sr6ZNPrPhitVX8ucCy8rPe7DFkxYw4g=
X-Google-Smtp-Source: ABdhPJweTMiK+qQ4EEMg1647SsGgR87UDOx57iKpPXMGdP2qcQRSm7CD+UC8Z8Xznkgk8tcwbjx2AQ==
X-Received: by 2002:a05:6a00:b45:b029:207:16ba:12c4 with SMTP id p5-20020a056a000b45b029020716ba12c4mr7563176pfo.31.1615856191476;
        Mon, 15 Mar 2021 17:56:31 -0700 (PDT)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id h186sm14670312pgc.38.2021.03.15.17.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 17:56:31 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] Makefile: ASCII-sort LIB_OBJS
Date:   Mon, 15 Mar 2021 17:56:21 -0700
Message-Id: <1d31e6aee77d374b00696597cf727d6e0d494632.1615856156.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620
In-Reply-To: <cover.1615856156.git.liu.denton@gmail.com>
References: <cover.1615856156.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21), the += lists
in the Makefile were sorted into ASCII order. Since then, more out of
order elements have been introduced. Sort these lists back into ASCII
order.

This patch is best viewed with `--color-moved`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 6dbecdb606..5832aa33da 100644
--- a/Makefile
+++ b/Makefile
@@ -858,8 +858,8 @@ LIB_OBJS += date.o
 LIB_OBJS += decorate.o
 LIB_OBJS += delta-islands.o
 LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-lib.o
+LIB_OBJS += diff-merges.o
 LIB_OBJS += diff-no-index.o
 LIB_OBJS += diff.o
 LIB_OBJS += diffcore-break.o
@@ -910,8 +910,8 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
-LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
+LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
-- 
2.31.0.rc2.261.g7f71774620

