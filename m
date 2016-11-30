Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1901B1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754942AbcK3VRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:17:41 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36434 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcK3VRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:17:38 -0500
Received: by mail-wj0-f195.google.com with SMTP id jb2so23998558wjb.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2v1t+dE43T792AfuIb5do0+sixwBI1zrTbIxppQItyo=;
        b=Tk4PQVfvCt6O7qjeAUS3WvhDHjgYBaRD96zlAsBk+uPg6Zmfq4oygGZR/MagPBQVme
         4kRiyDZt+LQMK69XQlgsqYU0ZyolDE9Mg0A3I3UWEiOZG2CoZMZ9PyfaUbTH7NnjERY0
         TPYIxwKc0YyHXnPaqebJytJ1+sZptYchJlN+7m3iQtQJmFgcFbdXr6+JSczwKUSr75NU
         LNdiMdamzH6D4okx8MO8CbYI1BXMyUU+S/9cCjbVWs6puGFz09x98R1sGxJCwhrWGY3D
         ueJpvNnbXju1QuATrnH0vazNebDDRLB0O3kJaQQXnDkqQHz/WIfDaBb3Jofo+rYuIVo1
         jWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2v1t+dE43T792AfuIb5do0+sixwBI1zrTbIxppQItyo=;
        b=CXoy8wIG6xVk2pIpMqtPQgsL/WcUxS62r7nIAj67bqg1aVjUWSCbUvog1ADaRAryUh
         saNwHhbSarfXua9ooWSB2YA8wZ6YgW7w9xcVaJTg44A31YJG2KkIMDVL7ADjjBgW4s3r
         TqreAR8UDSF3oumaPocRyrlkrp+nobxQz4VImNFnrwy9mN9DmCoaj4J8L9zG5o0ymmvn
         LFz64Q8j+dw1cKejw5XdWX8fn2beCQ+NZq98oTkKwd/GRtlaGr6vSjyIvlR6gBBzL3mO
         pwC+AzupLJ2f24XkZcnlTw8Nsd6/i+2GVV36Y2p+6qKTtLtnlQieS9lwJZez8hwC5BDT
         1XAw==
X-Gm-Message-State: AKaTC02mL5eSrS7/zcH55mtvMY2OZMkiXfO/lcBtx5x1G7v9ENAz3u/gxc5/yfQLzgtgkQ==
X-Received: by 10.194.109.42 with SMTP id hp10mr6406493wjb.167.1480539896490;
        Wed, 30 Nov 2016 13:04:56 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.04.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:04:55 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 06/16] external odb: add write support
Date:   Wed, 30 Nov 2016 22:04:10 +0100
Message-Id: <20161130210420.15982-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 +++++++++++++++
 external-odb.h |  2 ++
 odb-helper.c   | 41 +++++++++++++++++++++++++++++++++++++----
 odb-helper.h   |  3 +++
 sha1_file.c    |  2 ++
 5 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 42978a3298..bb70fe3298 100644
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
index cea8570a49..55d291d1cf 100644
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
index 2db59caa53..7b7de7380f 100644
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
index 8c3916d215..af31cc27d5 100644
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
index 6d68157e30..3532c1c598 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3320,6 +3320,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_write_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.11.0.rc2.37.geb49ca6

