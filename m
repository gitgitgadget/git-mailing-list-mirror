Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DB82018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbcF1STy (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:19:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34023 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbcF1STv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so7972809wmz.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=omjM28PY2aQNxU9cRzLV78vA8JwS0PuGOHI3XllHOHw=;
        b=wAYudbt+G3D0mzHQzryUADy2kMv3xO9A0kLI0R+nUNMrfBHs+IRXuZSqEt6wqfWS04
         FJfu95pMDB52F3sT/zLozfRxE02DJ0kYG7wlkSxOXmldpXoArs624PlJhSq0fyHQlxVd
         TcMPGRymVAdP5UReAnrwwcAXHy2SFb3Ak82J6olMtfcLr3Cqtd0+H7HLAxrcGs1V9Yz9
         AuA9KYvptm+DGoJECdJSHsWITF542ZnUJ1C6CYFtSp2OLLBV8PGJk4i3iwSoJ0G5THW0
         oJ4B9TrbpxrWmYKw9jr0jU+iUVxLFL3UBSVQupibxFnyA/vI6n9AfUw6rLumjWrcTQaS
         pN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=omjM28PY2aQNxU9cRzLV78vA8JwS0PuGOHI3XllHOHw=;
        b=avOv5Y32VAOhHf14YKNVkseJBrMsI4i/vr3xtO+qNz043BcO3F3KUpE1Tt6G1BcFRs
         y1xWt8z/wLrJp/h/HRIqammLKQV1GRgxl37AJmaRaFPAoaI2A29jFnyUBG2ywcgG/rDz
         ATWHEj6K7p/f6br0ogA4Lwp8sMYcIgn91kGVDMD2AS/j1UPGGwlA11ykYacc4/6GFtDb
         Ryz3yCXA2oAYLPQDRmakJNO3lJ3N2uX33nV7vzII/xk5j/8gnQ+LGY+NS8WdrqmtRTLd
         78rbjphHvXVchZfghjOaG3gQhFtDLLDGWkiAOvyB/sz8C2cCir0lHP+TLnli/nxhzUb3
         zuDg==
X-Gm-Message-State: ALyK8tKC3jZB9oeVasMeSVwmeQh2zEqoEUs16XLG1Rx1zijR5bLYVsG7qAj/XfAm5Zwy3Q==
X-Received: by 10.28.36.136 with SMTP id k130mr4777363wmk.4.1467137989662;
        Tue, 28 Jun 2016 11:19:49 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:48 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC/PATCH v2 02/10] external odb foreach
Date:	Tue, 28 Jun 2016 20:19:25 +0200
Message-Id: <20160628181933.24620-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff King <peff@peff.net>

---
 external-odb.c | 14 ++++++++++++++
 external-odb.h |  6 ++++++
 odb-helper.c   | 15 +++++++++++++++
 odb-helper.h   |  4 ++++
 4 files changed, 39 insertions(+)

diff --git a/external-odb.c b/external-odb.c
index 1ccfa99..42978a3 100644
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
index 2397477..cea8570 100644
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
index 7029a59..045cf6f 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -235,5 +235,20 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 		return -1;
 	}
 
+	return 0;
+}
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
 	return 0;
 }
diff --git a/odb-helper.h b/odb-helper.h
index 0f704f9..8c3916d 100644
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
2.9.0.rc2.11.g990c140

