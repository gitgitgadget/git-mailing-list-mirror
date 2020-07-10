Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A42C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 10:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F632082E
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 10:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD0MIzlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJKkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJKka (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 06:40:30 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F273C08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 03:40:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so2375731pfm.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VQoYhipYHx5/PvplxB00MlGjvRVqaBCNWcP6GvkLLlE=;
        b=CD0MIzlqIngnp/Ar/07WHH19K5M4yzlavGOLnDt4XBd8XV83d/KYJxSEdy1tCs66Xm
         7jdmCscoCFNErN+mtFuKQUKbulQkC1NdnLD+esr3Zs27UHTe4T8sOYY9/GOgOkNJgD75
         bTCQ3tMTrfXSAVfVlelHc6umvsO7NJAzwlhXopXFdcOzYrI4uoeKXWqFl4L9U3y6XoOD
         hDqs8jUN+lT5RoEJwE1ZY9vmQB43IkRJL3gSGauMTmRYEHK4S3Jq17L+icyFrtSwGvMB
         i55yu8onmKsD0z35ZEWgk4tc4e0EqSWg6PGfVY2y6dF7PNGU7o4V3N2oYf0oEVsHRkyO
         KP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VQoYhipYHx5/PvplxB00MlGjvRVqaBCNWcP6GvkLLlE=;
        b=b0Yvz6FzAfrDNcKm4d/Ndeu/JgzHSvj+vJPYmvclcFooFhoUtNE0G6addZwk8Qdbgf
         3C6HfhV2dxvWQPrtraLmU/S83G5keuSQDhLl5sYWjzhFHy6Ih0To2WNtRQ3NIt8/DoTd
         E8Jivhxg0OgcWxKsXsymk1Ta5ijHDU2lZV80FZPn9i+gaI5ADaEzTkGpfvWb48JbshtC
         C9U5Zwv04iGM0na1ieZGr9zrucumJt4n0NpENUw++LVm18vZHTYOj3beDueV8fNsayaK
         SOg2hTfvPw/EHwvSvi1nlwvvOzT9gnz30mYw8gcUYmsCARXcy0Gt8Gx+80q7ivVBjQm/
         a7CA==
X-Gm-Message-State: AOAM533iMVCmesFqx1ZUulMW1gibvJKWyPVJu1J+ZwGT1L+UiU+hVYwG
        UpRrH3/sdshme9hvuSJ89ksGhprR3UE=
X-Google-Smtp-Source: ABdhPJzhLPhMniMvAAvaCqPAUinp5h3ulp8VxJrujsj3o/wYmfX/c5JpuGFVYPI+Xx+NIAbvIJLopA==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr57545927pgr.418.1594377629874;
        Fri, 10 Jul 2020 03:40:29 -0700 (PDT)
Received: from centos7.localdomain ([117.11.124.207])
        by smtp.gmail.com with ESMTPSA id t73sm5681007pfc.78.2020.07.10.03.40.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 03:40:29 -0700 (PDT)
From:   simon gao <simon29rock@gmail.com>
To:     git@vger.kernel.org
Cc:     simon gao <simon29rock@gmail.com>
Subject: [PATCH] net : client only want latest osdmap.  If the gap with the latest version exceeds the threshold, mon will send the fullosdmap instead of incremental osdmap
Date:   Fri, 10 Jul 2020 06:41:24 -0400
Message-Id: <1594377684-1540-1-git-send-email-simon29rock@gmail.com>
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

