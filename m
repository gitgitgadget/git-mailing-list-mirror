Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8559D2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbcF1SUC (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35286 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbcF1ST6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:19:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so7945657wme.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvEeHwT6ZERRbCrGVd5+QPEIUuOBSK+lNqrTTvQvlq8=;
        b=ULeqJJcwox5FjjJGZ570LKjcmUlRi/REX4AvocilPYd+EYTVbYAXETsFnS2GgFh3bo
         Jk9L3eO2L+EYdMTPZh6m17KATWw6jS4zRHZqkItW9xkfrcItN411u8KY4yUzdlPPGnSK
         QvbIFxGCdmmAO15yaQ/EjKWbSr6JLYIJrw1RJj2+4YVhQDNJXILI8rjcvJu1TEmsiyWd
         MEtdykoq5QZyLR4pPMz+OlfCFA9W+ZyDdKoMrA9eaaKWRDK69qFUGEGuCFnssh9eKJEz
         /+w9JDxneO0ItZDLv7rDaJkCuivM+HWcd9KB1n08b6B5nL+MWOo89CFWnhhtxgr4Es43
         gOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvEeHwT6ZERRbCrGVd5+QPEIUuOBSK+lNqrTTvQvlq8=;
        b=OjKx9WlP2lGSp6xkTiq+O/ZyiUqGjTVVBa7wqCC7dN8WvkEkbc8zWeXohMXpycSUJ3
         fJ5ycN+/lYi5nk26hdaVxuoMncmXk6DQvzlYE/iRkPLJs1uLgPzk9fSTk3ijHw+jDAdQ
         7ftrFEw2FqPWmAK7UaBqDAdMDLBvOK3HRdTh27M8fqJz2nWyu2oX5+jfYcG1dh4mP1Dm
         7SwyojttcZQlHNAO2sAdtS3zUcIyHsfLFX+TXxVEQqsiecBzuQ3xuIpcs8w6c5Y02IAy
         ES5EQSPzvQJP6VhbLszZC+sNijVr7JuB7ijF9IVbI7IkH+9mfPmBey53TIfEoOmEjbrr
         jRSA==
X-Gm-Message-State: ALyK8tKCOCJr4uIlXiMyuZKwlaCreBIPhBhBYBQcRsZRiDE7iHNHI/bxmO45Ff56tb2TTA==
X-Received: by 10.194.97.201 with SMTP id ec9mr4323495wjb.117.1467137994894;
        Tue, 28 Jun 2016 11:19:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:54 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 06/10] external odb: add write support
Date:	Tue, 28 Jun 2016 20:19:29 +0200
Message-Id: <20160628181933.24620-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.9.0.rc2.11.g990c140

