Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C7A20D12
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdFTH4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbdFTH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so21268407wmh.0
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdDXOoqNqkNjT06TYm+20ak8SMIyilzHYREzbN5VBpw=;
        b=dki+zzlIUmSqbuAVRbZCGZcTU1jJbbdwfEAOo6SauKNLwJ2Pr+LbvXsdc5W9s9t93G
         UKQy1kQiGryp9NbMQwdd3zox3JMhGrKOgAHKLQSqMIREj0/3n4nepNTZqeselDU3wW+3
         NoBGjMfECdUqCf7jVGnnrmbf2g2GGkYVtDwCYrAx+DzGNObJjrUDlNGDApg2RE2OAD3Y
         z6RVQlTpAozsM0MvoZPul3XVGJlIJWRwJSIJihdAQAwxa7AIF/Enqg55kiZa/JEb4ZoO
         005SaAOhALLReGW2QdjjSv3F7fS5n3n1OiKw77FEzQA1eUJTutKXr+TNJaUovKfQiefp
         gUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdDXOoqNqkNjT06TYm+20ak8SMIyilzHYREzbN5VBpw=;
        b=fvoKo7D8sr65seVZgL4foWGAOg3K4mXjgLxgoJpe/tjHc86zmvz77/28xt/Gs2jsPB
         K02u6Gfp6WbeBszR3P1m9cemsA6WBuRGJ9QVvca6TxnvSPSobaYGnlOxYWs3NCcza+t0
         TrFkpaO7GzJ4r/MC2iEj5aY4hho28acbz9um/aCNEtF/2Ec9Rlx2Kl4H50NvDKaTCMe3
         d6fHZzdd8CXU8MhFjesGnnS6gCdBOge4goKpHNK3QZCyuv6zXX7/0HkfBLD2Qu+f9oLl
         q2fVE4ETnD8HcJmx+ekRFlT++5nYOYyJwbbmZdIVxosK/ygnHdxvDibXDciIxjgWEKfh
         ZSIA==
X-Gm-Message-State: AKS2vOypCVpA9JisMBVLf2mugJTa9ook1CR7v4hBR23rDbv9ZpZTHgCI
        0n+UFGqvoWBD+Juh
X-Received: by 10.28.128.198 with SMTP id b189mr1578081wmd.79.1497945365622;
        Tue, 20 Jun 2017 00:56:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:04 -0700 (PDT)
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
Subject: [RFC/PATCH v4 12/49] external odb: add write support
Date:   Tue, 20 Jun 2017 09:54:46 +0200
Message-Id: <20170620075523.26961-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
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
index 42978a3298..893937a7d4 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -127,3 +127,18 @@ int external_odb_for_each_object(each_external_object_fn fn, void *data)
 	}
 	return 0;
 }
+
+int external_odb_write_object(const void *buf, size_t len,
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
index cea8570a49..53879e900d 100644
--- a/external-odb.h
+++ b/external-odb.h
@@ -10,5 +10,7 @@ typedef int (*each_external_object_fn)(const unsigned char *sha1,
 				       unsigned long size,
 				       void *data);
 int external_odb_for_each_object(each_external_object_fn, void *);
+int external_odb_write_object(const void *buf, size_t len,
+			      const char *type, unsigned char *sha1);
 
 #endif /* EXTERNAL_ODB_H */
diff --git a/odb-helper.c b/odb-helper.c
index d8ef5cbf4b..af7cc55ca2 100644
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
@@ -121,7 +125,7 @@ static void odb_helper_load_have(struct odb_helper *o)
 		return;
 	o->have_valid = 1;
 
-	if (odb_helper_start(o, &cmd, "have") < 0)
+	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
 	fh = xfdopen(cmd.child.out, "r");
@@ -170,7 +174,7 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 	if (!obj)
 		return -1;
 
-	if (odb_helper_start(o, &cmd, "get %s", sha1_to_hex(sha1)) < 0)
+	if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
 		return -1;
 
 	memset(&stream, 0, sizeof(stream));
@@ -258,3 +262,32 @@ int odb_helper_for_each_object(struct odb_helper *o,
 
 	return 0;
 }
+
+int odb_helper_write_object(struct odb_helper *o,
+			    const void *buf, size_t len,
+			    const char *type, unsigned char *sha1)
+{
+	struct odb_helper_cmd cmd;
+
+	if (odb_helper_start(o, &cmd, 1, "put %s %"PRIuMAX" %s",
+			     sha1_to_hex(sha1), (uintmax_t)len, type) < 0)
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
index 8c3916d215..4e321195e8 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -25,5 +25,8 @@ int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 			    int fd);
 int odb_helper_for_each_object(struct odb_helper *o,
 			       each_external_object_fn, void *);
+int odb_helper_write_object(struct odb_helper *o,
+			    const void *buf, size_t len,
+			    const char *type, unsigned char *sha1);
 
 #endif /* ODB_HELPER_H */
diff --git a/sha1_file.c b/sha1_file.c
index f87c59d711..8dd09334cf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3450,6 +3450,8 @@ int write_sha1_file(const void *buf, unsigned long len, const char *type, unsign
 	 * it out into .git/objects/??/?{38} file.
 	 */
 	write_sha1_file_prepare(buf, len, type, sha1, hdr, &hdrlen);
+	if (!external_odb_write_object(buf, len, type, sha1))
+		return 0;
 	if (freshen_packed_object(sha1) || freshen_loose_object(sha1))
 		return 0;
 	return write_loose_object(sha1, hdr, hdrlen, buf, len, 0);
-- 
2.13.1.565.gbfcd7a9048

