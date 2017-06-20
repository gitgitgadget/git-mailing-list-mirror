Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0112520401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdFTH6N (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:58:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbdFTH4J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id d64so21283790wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MSDljYQGfq7lR5+KlvtRunglaalbBai8QxNQ+QRaIxU=;
        b=G25Zlt25xwJGgcqKtOKW/ELrTZf/7hSLktnRRY5R46LQdbBoafZRrBY5AoZcddDOo5
         LVW95rnLi8Y9uA/o6AYsO7ItGoeBZo/xsnApCfHISEQo0xxAYI+qAYlxAe68xWGpV2q0
         BPo3839YYTpkUCtb6g4TC+W3qJ1rcxN/XBPod0dwcVNMeNdyGO/DED262wYQNj47ZNfC
         dhnr/jiRUVOcg4kkaIYgCyUdtFimaZmJId/aYIB67W5e6U2wS3nRIwvlqvh2R2aMpdub
         /kWt3tJavK+gOfnN0zoENTlyRKrGFuM8UQG/lw80W98a3sIT5iNlXUP8bmztkPclAgn2
         xsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MSDljYQGfq7lR5+KlvtRunglaalbBai8QxNQ+QRaIxU=;
        b=bzsWMvxNg+78pCK4CzKW/7pM9Rl3JAlCgs7ErE2f8c/aGk1MFAQEOh042Zfav9UL8a
         7dgOgjGq3fXVQN79vZ/m0QAYecCH1mD8uuSyXaQUuEaklfM2BxZiAA9+0J0QtV6jkZoS
         03QlTA6hHh3eeUfsb9jncPCETa2cRv99BdLBjr/yKTG2RAjyYdzhtROm0vXE8X2q2009
         WCyWCAnIcUgYb38zmTdtsUBeWOzKIXIKatFgoWQsxaDWCfBCl4yScIBigNwWIKxv4ERQ
         YaXvJEG6j88qmgWSiZ7h/SI7Hlxo8TlleIZXRyJH/6W42God0BN1SHVdi66NTCctqc/M
         +N+g==
X-Gm-Message-State: AKS2vOxNi0e3hbrprdJoClicZ36LoUTB4sQGkMN7sL9cOnuXNolZp2Z9
        uKvlmustNv4mAo1j
X-Received: by 10.28.107.88 with SMTP id g85mr1659202wmc.42.1497945362789;
        Tue, 20 Jun 2017 00:56:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:02 -0700 (PDT)
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
Subject: [RFC/PATCH v4 10/49] external odb foreach
Date:   Tue, 20 Jun 2017 09:54:44 +0200
Message-Id: <20170620075523.26961-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

---
 external-odb.c | 14 ++++++++++++++
 external-odb.h |  6 ++++++
 odb-helper.c   | 15 +++++++++++++++
 odb-helper.h   |  4 ++++
 4 files changed, 39 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 1ccfa99a01..42978a3298 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -113,3 +113,17 @@ int external_odb_fetch_object(const unsigned char *sha1)
 
 	return -1;
 }
+
+int external_odb_for_each_object(each_external_object_fn fn, void *data)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		int r = odb_helper_for_each_object(o, fn, data);
+		if (r)
+			return r;
+	}
+	return 0;
+}
diff --git a/external-odb.h b/external-odb.h
index 2397477684..cea8570a49 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -5,4 +5,10 @@ const char *external_odb_root(void);
 int external_odb_has_object(const unsigned char *sha1);
 int external_odb_fetch_object(const unsigned char *sha1);
 
+typedef int (*each_external_object_fn)(const unsigned char *sha1,
+				       enum object_type type,
+				       unsigned long size,
+				       void *data);
+int external_odb_for_each_object(each_external_object_fn, void *);
+
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index de5562da9c..d8ef5cbf4b 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -243,3 +243,18 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 
 	return 0;
 }
+
+int odb_helper_for_each_object(struct odb_helper *o,
+			       each_external_object_fn fn,
+			       void *data)
+{
+	int i;
+	for (i = 0; i < o->have_nr; i++) {
+		struct odb_helper_object *obj = &o->have[i];
+		int r = fn(obj->sha1, obj->type, obj->size, data);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 0f704f9452..8c3916d215 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -1,6 +1,8 @@
 #ifndef ODB_HELPER_H
 #define ODB_HELPER_H
 
+#include "external-odb.h"
+
 struct odb_helper {
 	const char *name;
 	const char *cmd;
@@ -21,5 +23,7 @@ struct odb_helper *odb_helper_new(const char *name, int namelen);
 int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 			    int fd);
+int odb_helper_for_each_object(struct odb_helper *o,
+			       each_external_object_fn, void *);
 
 #endif /* ODB_HELPER_H */
-- 
2.13.1.565.gbfcd7a9048

