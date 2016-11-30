Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B75D1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbcK3WKH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:10:07 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:33691 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbcK3WKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:10:05 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so24148871wjc.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QObaBGvYaTLFOg7m5aVwl5z6/iQdRZB+6YLyPqRovpw=;
        b=sRYHLhbalcHCqo7vHErHe2fQSiJDFKsMxnu75tzPXl19kpLwXEZcXrIIjo33vAem/Y
         HcMf1TAqPU3R7HQECKwlDWOZMqkja0GnK3Lu4KJHY5RU0rsDtbGWATEd2umT3qAHep0O
         8L29eU5EtRdkoTePR1dSbH8PjY1z2S2idPNxmg6DapVKUOKmAHxtF4/JX85oU9K+9Lg7
         wmmUQi5fG5gQv/I2aLTI8ZoHpfyltUHG5fiJA7U5UyyklTBoMx/3GnD5aPKVy+4HmZ/k
         cwdZDwCtWrFPSWg8g30vZ6wY+CArHnuY4vheTG/jTm41CQqs606wzLeraf4/HVTP8Azh
         BI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QObaBGvYaTLFOg7m5aVwl5z6/iQdRZB+6YLyPqRovpw=;
        b=V9BG9vHYvOfKggfbBRr1zZ3T6+h31J/Dkb9mnaBbymETC65zfWfjIXC6TUkimIQ55/
         6GZxbarhCls8EkhSmTZeHljEd63qHebOA3Iv65Vk0QfgxLTOEo0vh+3J8rbmIWZJUW46
         mjFumoc2uwguqCX+El0HnymtWJ2H1PIsqW/RyN8Tjj/Fh8U/7eGHSszO5aDSZSu31OI/
         FnZQviB15H/GEWFbsUPtdxGP3qZww8RETfY0bo7HuavLTikuxGQGi6WODMHt6tqi9ljj
         TVaabM1YdY1m1IP/BuYsV3ti+s+c7exgSefKVUI1Mc2PA4PxxUCd6AbczFBvTDPa9mrX
         T2vg==
X-Gm-Message-State: AKaTC00tjbeWHlwOQ2oeC1WQf2aKSxLzA6Q5zW84+SCHe1kwHZVi4vvg3+2nmDkVjYxYnQ==
X-Received: by 10.195.13.70 with SMTP id ew6mr29513808wjd.89.1480539888540;
        Wed, 30 Nov 2016 13:04:48 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:47 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 02/16] external odb foreach
Date:   Wed, 30 Nov 2016 22:04:06 +0100
Message-Id: <20161130210420.15982-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
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
index 244bc86792..2db59caa53 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -237,3 +237,18 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 
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
2.11.0.rc2.37.geb49ca6

