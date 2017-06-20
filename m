Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB2C20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbdFTH47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34540 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdFTH4x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:53 -0400
Received: by mail-wr0-f196.google.com with SMTP id y25so14133931wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7HNr6Jsv9e1L95TePrkQZJ0pYCwnnGITtlQ+mBYK8M0=;
        b=j7AZm2MQFdd2ZwmMcPnKRHyJsk7c2gf+9W6oDpy2JryX/pWDdubM1CyIcOzFLuJMwJ
         6AmlaGdu8Zf0clwfV3BCTTPXdeuMeU2dJzNaQ6KIMUSEWltwbpnHEZUuI8gdIFmaAF0V
         UuRDAhITaiDpPczimuwZTwQL9u3jLr2YwtH20qTOsxfiej+d6xhhEd3xadZ38VjrdiQO
         4XakxJhV3WTwzrO9CXooZrGenS0XJX6yfkXlXhSf/bL1dh8ELIrSyzlb0DOd/RAd8oGc
         yniYOOoDKTH2GX/5J73NCugCwN33lM2Ut0zFXUPmzj+84wqDkQGUZ/AWr7reYrib0Dvv
         M7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7HNr6Jsv9e1L95TePrkQZJ0pYCwnnGITtlQ+mBYK8M0=;
        b=PTfrlPPvx2HFGHql1EUQdmCEtKCEf+kuuMi9ldNz3jvbTHXzasvecLLzKyiDuMm2s8
         xAgdz/TVLlHtGZptMi3aCn3K79YhsQw/9hdM3jTj8h12h7B74FQSgJWZph9Ed7q+rG97
         2DSNEEMqzkNMkDIVDZTMCm/mUwdaco21Mf+zkaB0o4TGr3rcHtRy2BGKVBbgwj8EjeRi
         SQpiIL2fYHYxeP01lCZKbzW5G27x54CEgaJqf903c6h/4LlOwFjkM7GmHVGodhPseZCc
         V8LfUx5+hGDPufw0oU8fQQ7kR3AsY3SrLxlKZxW7nHJti1tLSsi2AhPHaZeZkNAuqtBs
         Hn3g==
X-Gm-Message-State: AKS2vOxm+vv07zUq2C922HYWSwVYGYjqIBeomPW9EZqyrW+MUuRH70DT
        08Y74FuVZljiJa/1
X-Received: by 10.223.148.226 with SMTP id 89mr6451776wrr.169.1497945402235;
        Tue, 20 Jun 2017 00:56:42 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:41 -0700 (PDT)
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
Subject: [RFC/PATCH v4 41/49] external-odb: add external_odb_do_fetch_object()
Date:   Tue, 20 Jun 2017 09:55:15 +0200
Message-Id: <20170620075523.26961-42-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 8c2570b2e7..c39f207dd3 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -95,32 +95,11 @@ const char *external_odb_root(void)
 	return root;
 }
 
-int external_odb_has_object(const unsigned char *sha1)
-{
-	struct odb_helper *o;
-
-	if (!use_external_odb)
-		return 0;
-
-	external_odb_init();
-
-	for (o = helpers; o; o = o->next) {
-		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE))
-			return 1;
-		if (odb_helper_has_object(o, sha1))
-			return 1;
-	}
-	return 0;
-}
-
-int external_odb_fetch_object(const unsigned char *sha1)
+static int external_odb_do_fetch_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 	const char *path;
 
-	if (!external_odb_has_object(sha1))
-		return -1;
-
 	path = sha1_file_name_alt(external_odb_root(), sha1);
 	safe_create_leading_directories_const(path);
 	prepare_external_alt_odb();
@@ -175,6 +154,35 @@ int external_odb_fault_in_object(const unsigned char *sha1)
 	return -1;
 }
 
+int external_odb_has_object(const unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	if (!use_external_odb)
+		return 0;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE)) {
+			if (o->fetch_kind == ODB_FETCH_KIND_FAULT_IN)
+				return 1;
+			return !external_odb_do_fetch_object(sha1);
+		}
+		if (odb_helper_has_object(o, sha1))
+			return 1;
+	}
+	return 0;
+}
+
+int external_odb_fetch_object(const unsigned char *sha1)
+{
+	if (!external_odb_has_object(sha1))
+		return -1;
+
+	return external_odb_do_fetch_object(sha1);
+}
+
 int external_odb_for_each_object(each_external_object_fn fn, void *data)
 {
 	struct odb_helper *o;
-- 
2.13.1.565.gbfcd7a9048

