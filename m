Return-Path: <SRS0=UM1m=AW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEF3C433DF
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 01:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BCF2078B
	for <git@archiver.kernel.org>; Sat, 11 Jul 2020 01:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpSHpy5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgGKB7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKB7K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 21:59:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0A5C08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 18:59:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so3353469pje.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 18:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VQoYhipYHx5/PvplxB00MlGjvRVqaBCNWcP6GvkLLlE=;
        b=lpSHpy5XkQyVbifLtuupgIRHkrec5rpg1HKQtWuddJyPq5YVTKaA6MFHHFaskDnnZH
         6RbF6znAwWyquMydiEzQdS63In3fnkcEtyBhSYRtrTVFjY+px+d1YlpDilz0oG8x/6cl
         PmF2xvAwGYxFx4pdycvOZZM7T1A3Q1XyVUu6zUMJzid9dBBzpNCAEdssyDe6BAmaCz4W
         gEe1yz9NJg/hdU+5g/A8CH+e0bE4dIT8vHVqF4KOCdhbMQwqqr4QLGxruZTiQ0++9mEW
         2t0YnsR18oJSNlQn942MWYkQPeJcNeOFiAfJ75ihHuRKUR/7+VObPG5yDqDTYXLeE+Qu
         x+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VQoYhipYHx5/PvplxB00MlGjvRVqaBCNWcP6GvkLLlE=;
        b=Jdzw82cZDR1d9eqUiLh1GOsxiTAxiAYaMg2It5IqN3ObeWhmv+oW1KLHbKmKaKhYlD
         VDdoGgTv7HhhGImzvHQ2R+Y104lVODibdWoICpzqoQxI/cdNaHl0TioN1iSFA3BCp33u
         dujNCO1/uYWieXzIa2XJpkGySl7QuxUqspHNYoXEwYHENhUVCcNSOE1/eaG8p9FLP84P
         op4vc8T3NdP0rLMy8cOdUOH+Xi14lPon+d+lMxgwVLKY+IDbVV2FUV6UMXif10vU1m2V
         xTShdxELqUwc8BhOZEc0Tg+ETzX9O135ar1HB/AAedTLOx61D53rxMzRk3xGoyVeqJW5
         9EKQ==
X-Gm-Message-State: AOAM530jC6Bjo7/5M7yezVKZAlQUZStSu4D4VGEQZgFHVf5yx7rTROW/
        1ScvsdI/l/Ld9JQjdyLpczzGAYBp7n8=
X-Google-Smtp-Source: ABdhPJzBcNDXjj0tVJEA87i6pX7T/S1bTpOclGMlaQ7X6rJRSGYzwR9lY+Q2lNWNEFZn0Ojn7rUUrw==
X-Received: by 2002:a17:90a:1f06:: with SMTP id u6mr8566918pja.33.1594432749542;
        Fri, 10 Jul 2020 18:59:09 -0700 (PDT)
Received: from centos7.localdomain ([117.11.124.207])
        by smtp.gmail.com with ESMTPSA id b191sm6985643pga.13.2020.07.10.18.59.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 18:59:09 -0700 (PDT)
From:   simon gao <simon29rock@gmail.com>
To:     git@vger.kernel.org
Cc:     simon gao <simon29rock@gmail.com>
Subject: [PATCH] libceph : client only want latest osdmap.      If the gap with the latest version exceeds the threshold, mon will send the fullosdmap instead of incremental osdmap
Date:   Fri, 10 Jul 2020 21:59:53 -0400
Message-Id: <1594432793-1451-1-git-send-email-simon29rock@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix: https://tracker.ceph.com/issues/43421
Signed-off-by: simon gao <simon29rock@gmail.com>
---
 include/linux/ceph/ceph_fs.h | 1 +
 net/ceph/mon_client.c        | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index ebf5ba6..9dcc132 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -208,6 +208,7 @@ struct ceph_client_mount {
 } __attribute__ ((packed));
 
 #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after have */
+#define CEPH_SUBSCRIBE_LATEST_OSDMAP   2  /* i want the latest fullmap, for client */ 
 
 struct ceph_mon_subscribe_item {
 	__le64 start;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 3d8c801..8d67671 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
 {
 	__le64 start = cpu_to_le64(epoch);
 	u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
-
+	if (CEPH_SUB_OSDMAP == sub)
+            flags |= CEPH_SUBSCRIBE_LATEST_OSDMAP;
 	dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
 	     epoch, continuous);
 
-- 
1.8.3.1

