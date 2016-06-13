From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 2/8] external odb foreach
Date: Mon, 13 Jun 2016 10:55:40 +0200
Message-ID: <20160613085546.11784-3-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfJ-00073d-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161242AbcFMI4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35343 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161166AbcFMI4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id k184so13078274wme.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWOMTrJh3+Tn4QqfWZSse8W20p+nsdoa8fIgcSjoJ/A=;
        b=p2WE4hI/kFOVwtdopNbcFW7VrejsMdAUNW6ny7YPXF2QY1NenYqj8gtq1WAlX0NRqS
         RgKZb9HZ/Vh1mND7TMxqaeiLW/ax3FlPWJBc0+JdTiLvZTg+eb7/xn9gfpaSmwT/YoT2
         0WS5obgmd2kIztd1GYjBfzHLTjMuC1rB9PFwQLCG1a4nicmrSNxyRfr70cHv/BKeNvZ6
         6+UqxS5zTcoegU9W6QSEupHtdOwo2rCYWEjhTBK0+S9RrF/bo6wk646JgIwJv357z+9s
         zxqLXoDvFEfneyBR8A/+GdYpnan2mljwBRzYLR8AoT+l51NIekqs+iTm25GioYwPq6tI
         S2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HWOMTrJh3+Tn4QqfWZSse8W20p+nsdoa8fIgcSjoJ/A=;
        b=R7ss2tsyWToWb13qSZTBejk98F9Dp+V7i+35V3iGUXQLvm10dCf5t3z6zJ+QRU+sjr
         KTcADZBxbhAns4MOdlRrbcgblcVyVfRUDj3bHnF9WuwnqJZn7k/VH5gPW8JYroxsCr22
         mTZ8bzpirjr014DcSp0DzfrHNaGx2zybF3itvHXZqiqSHa/AlFYzogTs5I7aTqF+zybv
         pfSmTesO4d76Zup/m6lSScRCh6+nYLdz9ty8MaQkgpxLAw+KHV7UdNGVOxTsepn400J+
         DJxta1ofANkZ10SollyP/BZYL2wrO2sf4bLcscZ8Yx+aHTPhQtDRkrxwMdXmOo4LPU65
         uAmw==
X-Gm-Message-State: ALyK8tICgxK2e2LSUskgpUij7F5x7q/AphHDxqv/Pzg5efXX6VZ9y5ybWA4T/3Vu7HB7Bw==
X-Received: by 10.194.165.233 with SMTP id zb9mr14647395wjb.172.1465808166159;
        Mon, 13 Jun 2016 01:56:06 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:05 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297165>

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
2.9.0.rc2.362.g3cd93d0
