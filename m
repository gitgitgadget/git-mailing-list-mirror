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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EDC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABECF20767
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 10:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr69OSFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGJKiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgGJKip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 06:38:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8FC08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 03:38:45 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so2097729plk.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZI5yB8NC3FXlTdch1Ac7w+3ZlVRkOei25ObYEJlVfuw=;
        b=sr69OSFJ1cYb7xBTtRQ21Bd62UO9sY0SjYAePggTc02M0bMEsgqqM+Cx+zUdPwoJSl
         Q6RBWXvDz6RVvtJVp3dx1i85pwKu2sa9aekhRmtTL4UwLTFMwrErDGRmrRHrNaAepfMu
         FXVLAz6frj24AatQc6raa9/iIdqTft/bYj0pPHsywbiF39J/rThslPTO1sHo+LcysgHy
         ViMcU27oDGYdR9luOLb0qMJgSRhbwA1sbH9vE8nmaqNafz8S/C0Rr3KSfnG5MlCbAlDs
         LSpAY/7hWS7x1CbJOtiQZRd3EyW0So9c5WvtAWgml0xjkWJ5jT5QKX89ZC90qd/cMMJf
         84iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZI5yB8NC3FXlTdch1Ac7w+3ZlVRkOei25ObYEJlVfuw=;
        b=OWgeI/ocKN3gBwuxtrkHiIwsEjE84vtyN04hr912/RxjBTPMlgMyGeeCMrPcJTpdbK
         AzwU6Vn0dnItNrVP2Zni54kPmdyCxT1T6bOmEpiTTzheNJjMcwvxqaOWxpgD5biYlQTd
         1j6rAv0I+XzoKYaRhuCZNkbTWbhgKMYNgIfQE4MPuahRviKQrZN0aS2uJcntzYC0UFwt
         dgOIGy4scFelrKxmyt+TXE9rwCKiu3HzUSLbIRhOhyK1h+dpD20JC6oqNI2rB/9GhMZW
         9zBH5gnow+DmCXJL4fm5oc/JVG33LK0Np/FQSiMOBVK+BrWzeNyQR7vypQABd19bbBjn
         M3SA==
X-Gm-Message-State: AOAM531TKKzxhWxCP8bMoGh2uGL+nOQBSB5NZQS7VNx4gb/5WIjJkh+l
        5lF7GGt0YeFVHl/1R3BZ1G5FArzD2kY=
X-Google-Smtp-Source: ABdhPJxjpzEFL44pRmKoOCY10HjsOIg5z2LaZb6b9r/DINcEYtbMvsMWqXG8jr00wnIPwb7TfNkhtw==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr58530198plb.235.1594377524658;
        Fri, 10 Jul 2020 03:38:44 -0700 (PDT)
Received: from centos7.localdomain ([117.11.124.207])
        by smtp.gmail.com with ESMTPSA id t187sm5474242pgb.76.2020.07.10.03.38.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 03:38:44 -0700 (PDT)
From:   simon gao <simon29rock@gmail.com>
To:     git@vger.kernel.org
Cc:     simon gao <simon29rock@gmail.com>
Subject: [PATCH] net : client only want latest osdmap.  If the gap with the latest version exceeds the threshold, mon will send the fullosdmap instead of incremental osdmap
Date:   Fri, 10 Jul 2020 06:39:20 -0400
Message-Id: <1594377560-1482-1-git-send-email-simon29rock@gmail.com>
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
index 3d8c801..b0d1ce6 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_client *monc, int sub,
 {
 	__le64 start = cpu_to_le64(epoch);
 	u8 flags = !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
-
+    if (CEPH_SUB_OSDMAP == sub)
+        flags |= CEPH_SUBSCRIBE_LATEST_OSDMAP
 	dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[sub],
 	     epoch, continuous);
 
-- 
1.8.3.1

