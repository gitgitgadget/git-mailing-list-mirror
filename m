Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84A320401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbdFTH5C (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33130 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752338AbdFTH45 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id f90so21272663wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nADKf6Bjhupr/w7WIKpvl3CVAEYUEtES/vSMMT7NX8c=;
        b=DLSHIhTw8A8QjV7wxwtt1D0xpBs81ij4R6FnfBlFUS9or0qluItpZ5zhaX54oMfnHj
         zjrtjjRRPDE00D58hDm7lI0DhL5A7oxIJRr5wcJVpRrt66Obc4VudsaWel2//0PnedFZ
         0hUUa4wTMSjx53vJY40xDZke7faSm5vWm+v8WDM/HXaK1TsRY0in8QnEXtKW29cRNGqu
         X53tc6T1SxaX3JpsZu1huLdezTJgP821u5V71vNBWm6zfDu2/Bc35wUlI3EyhwbRagCR
         5WD/HsousbeNXE8O3hs7DQAk1Vevs9OlmmP65fOz3LNYM6qzfL1DDCKCOFnc61aVHe3u
         8vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nADKf6Bjhupr/w7WIKpvl3CVAEYUEtES/vSMMT7NX8c=;
        b=YEFyBgoqfQBWzPi0ykcs68jBjcJrJ51qfpIR51sT5ZQTowqF6BSz519mktJnACCrM/
         lIZszsE4gtqCfnVCRuuLQ/W7IzNvDu8E96rHRp+l5Lcdw5eS+p09bCyYX9XTeERjooEA
         oHIPnWac6AEsgnpKmD+DL7CNJqtM46yCxB1XEwGECJ0bMQStkyuxiJ3f4yiuFHDvaGvW
         DdeRWcdXL1Y1DeXt/28HwQu0qcZ+G7GnBRBuq7BR0H8V4c50uQWxkhz/YfJGGmJBShx+
         zU11RQBWc4hqxR8S+RMGaqv0GaPSr4xNiPVFsHYtqh0KyHjQNtVi2in62ZJtxZ/QN1pv
         Fzzw==
X-Gm-Message-State: AKS2vOwMyeoUfJenJn+G2k8M/Z6xK9YTctgeVpoztjXfSVgGchgracCh
        Ld8RtwUxMNh5g66g
X-Received: by 10.28.50.70 with SMTP id y67mr1817874wmy.62.1497945410831;
        Tue, 20 Jun 2017 00:56:50 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 45/49] clone: add initial param to write_remote_refs()
Date:   Tue, 20 Jun 2017 09:55:19 +0200
Message-Id: <20170620075523.26961-46-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 370a233d22..bd690576e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -572,7 +572,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void write_remote_refs(const struct ref *local_refs)
+static void write_remote_refs(const struct ref *local_refs, int initial)
 {
 	const struct ref *r;
 
@@ -591,8 +591,13 @@ static void write_remote_refs(const struct ref *local_refs)
 			die("%s", err.buf);
 	}
 
-	if (initial_ref_transaction_commit(t, &err))
-		die("%s", err.buf);
+	if (initial) {
+		if (initial_ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	} else {
+		if (ref_transaction_commit(t, &err))
+			die("%s", err.buf);
+	}
 
 	strbuf_release(&err);
 	ref_transaction_free(t);
@@ -639,7 +644,8 @@ static void update_remote_refs(const struct ref *refs,
 			       const char *branch_top,
 			       const char *msg,
 			       struct transport *transport,
-			       int check_connectivity)
+			       int check_connectivity,
+			       int initial)
 {
 	const struct ref *rm = mapped_refs;
 
@@ -654,7 +660,7 @@ static void update_remote_refs(const struct ref *refs,
 	}
 
 	if (refs) {
-		write_remote_refs(mapped_refs);
+		write_remote_refs(mapped_refs, initial);
 		if (option_single_branch && !option_no_tags)
 			write_followtags(refs, msg);
 	}
@@ -1163,7 +1169,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport,
+			   !is_local, 0);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
-- 
2.13.1.565.gbfcd7a9048

