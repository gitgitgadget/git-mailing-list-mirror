From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 6/8] external odb: add write support
Date: Mon, 13 Jun 2016 10:55:44 +0200
Message-ID: <20160613085546.11784-7-chriscool@tuxfamily.org>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfV-0007BL-7b
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422821AbcFMI4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34460 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161007AbcFMI4M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so13086853wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPuvL25aW7me8HduuBLGriCRVdORox9IjXYqg3FEDdg=;
        b=sP9EoHVOC7GVWF1n/s+EP+941eYSiO7eI2qeZnjcg01Chrk3POzJmj63wfmXl9t4J5
         qOTYOzYn9nAtvyjAO/85Moo5o4/Yzl6stEYDlHvqRZPObiOqigwaZLPlYP327iSzTkBr
         iq8BiAWCage5ONZXneMVF31qCAXNwuDPPXuroxFOaXnOa7xBFdVFXzwamOCIx0V9ynMY
         WQdYYibSV2YUK6IGc1IxPN5/694TYwXzRmYT6nFRMUTaRij4JNliY9ratReXamaO6UZ8
         FuGChLfIpsyg93hY1bFfBpRU7wh7JqcrpLXg06xH1Aj4UNTT5MvGF0GANMxBv+TcdiMO
         F0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPuvL25aW7me8HduuBLGriCRVdORox9IjXYqg3FEDdg=;
        b=cjrhgVWN4dU4WnY0/odk8MNItCIWGx/I5iDgv3/gLvwQ0fGC6vyU0X73Vc5FX30LRb
         diQjWc69DK5dPyvRXI6pNEdBC1d13h9VPJqhsfJTza5+Ul6rqxJr/Hi9zYVynbNHvBJC
         R1biOY/Ln5HY6HCjBjFFVRWxERYiFeiSziY3HqAtlG1OuWWvb4s7AnaT/GoV9KsRlcvu
         EkdzeM9qCdzB6nrVuuiTN+94v59nBOEn+EFwCW1zkEKX5lIYwiy/oAHRcIunLox+wakn
         0wwRDK7ejm5t2tUEygMly4cuT67JNDnnr3TbUAC0tOtGfdWQZhoVPdEakVt0aF6VNmwf
         VnwA==
X-Gm-Message-State: ALyK8tJ486t9srak8VGBYnrH7+l/Xt8v+iet084mr4Usx1VHOsyVUFM4PAnbivHfCpUP1A==
X-Received: by 10.194.88.5 with SMTP id bc5mr10304328wjb.100.1465808170611;
        Mon, 13 Jun 2016 01:56:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:09 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297168>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  2 ++
 odb-helper.c   | 41 +++++++++++++++++++++++++++++++++++++----
 odb-helper.h   |  3 +++
 sha1_file.c    |  2 ++
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 42978a3..bb70fe3 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -127,3 +127,18 @@ int external_odb_for_each_object(each_external_object_fn fn, void *data)
 	}
 	return 0;
 }
+
+int external_odb_write_object(const void *buf, unsigned long len,
+			      const char *type, unsigned char *sha1)
+{
+	struct odb_helper *o;
+
+	external_odb_init();
+
+	for (o = helpers; o; o = o->next) {
+		int r = odb_helper_write_object(o, buf, len, type, sha1);
+		if (r <= 0)
+			return r;
+	}
+	return 1;
+}
diff --git a/external-odb.h b/external-odb.h
index cea8570..55d291d 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -10,5 +10,7 @@ typedef int (*each_external_object_fn)(const unsigned char *sha1,
 				       unsigned long size,
 				       void *data);
 int external_odb_for_each_object(each_external_object_fn, void *);
+int external_odb_write_object(const void *buf, unsigned long len,
+			      const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index 045cf6f..677a5e7 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -33,9 +33,10 @@ static void prepare_helper_command(struct argv_array *argv, const char *cmd,
 	strbuf_release(&buf);
 }
 
-__attribute__((format (printf,3,4)))
+__attribute__((format (printf,4,5)))
 static int odb_helper_start(struct odb_helper *o,
 			    struct odb_helper_cmd *cmd,
+			    int use_stdin,
 			    const char *fmt, ...)
 {
 	va_list ap;
@@ -52,7 +53,10 @@ static int odb_helper_start(struct odb_helper *o,
 
 	cmd->child.argv = cmd->argv.argv;
 	cmd->child.use_shell = 1;
-	cmd->child.no_stdin = 1;
+	if (use_stdin)
+		cmd->child.in = -1;
+	else
+		cmd->child.no_stdin = 1;
 	cmd->child.out = -1;
 
 	if (start_command(&cmd->child) < 0) {
@@ -109,7 +113,7 @@ static void odb_helper_load_have(struct odb_helper *o)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -164,7 +168,7 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -252,3 +256,32 @@ int odb_helper_for_each_object(struct odb_helper *o,
 
 	return 0;
 }
+
+int odb_helper_write_object(struct odb_helper *o,
+			    const void *buf, unsigned long len,
+			    const char *type, unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
+
+	if (odb_helper_start(o, &cmd, 1, "put %s %lu %s",
+			     sha1_to_hex(sha1), len, type) < 0)
+		return -1;
+
+	do {
+		int w = xwrite(cmd.child.in, buf, len);
+		if (w < 0) {
+			error("unable to write to odb helper '%s': %s",
+			      o->name, strerror(errno));
+			close(cmd.child.in);
+			close(cmd.child.out);
+			odb_helper_finish(o, &cmd);
+			return -1;
+		}
+		len -= w;
+	} while (len > 0);
+
+	close(cmd.child.in);
+	close(cmd.child.out);
+	odb_helper_finish(o, &cmd);
+	return 0;
+}
diff --git a/odb-helper.h b/odb-helper.h
index 8c3916d..af31cc2 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -25,5 +25,8 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 			    int fd);
 int odb_helper_for_each_object(struct odb_helper *o,
 			       each_external_object_fn, void *);
+int odb_helper_write_object(struct odb_helper *o,
+			    const void *buf, unsigned long len,
+			    const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index a707bc1..90f19de 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3192,6 +3192,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_write_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.9.0.rc2.362.g3cd93d0
