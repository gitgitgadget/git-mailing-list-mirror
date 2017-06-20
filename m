Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F4B20D11
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbdFTH4k (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34307 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdFTH4i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id f134so3647160wme.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ukauU9N4BR0fJy5i0lUZpD6f40REghUnjJ/fxQueXuA=;
        b=sN7A4ry8v7pxK2KyIRSAM794GVAl8gSIdZ0ed/waDwynhJ9r/mgmLSprMrex8lJWsv
         GB3p4DoQfq1QuV4vbUVb79JVBvmKh/0JVd+XukNA0VdQAgAxtk7EQ9dtxfAc/4KihsDJ
         nps71DBtj/DRKVnaDw9TN2NIjOfGzjKILgCe8MRr6HCAL3mePSUIgkZGJBbWbCpVNmSn
         IyeCXh59d+8C6OyQxrY5+eDYz9SwRSpHfMp8r2LDyqn3gQcQfWZQdccJCgXSpJlAJda1
         WIq3sLapcny3JimWlSLRwPVYYvi9+ekdRJ4YP8zaCowE48forQSfKjUmsKDrwdDqUs/E
         bJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ukauU9N4BR0fJy5i0lUZpD6f40REghUnjJ/fxQueXuA=;
        b=TWfnFdV0ehbeIq5UlW4/ZavPPXtlN7sezN+QRQOAF0GsrJ6w9znkoiCM//XXY2oZ83
         YHbJOowI6iGxn3cXpjbWXE1l46oH/KN3oI+RY5kN+KB9ZzPgh8QO4SwNsHAyCTE3IOj3
         RMNbobjYgktjQLroCz/gZSBzVhT6F5yvcEvIbCgkm5XFcK0BnnpZSYMJZh4/4ta1emNY
         NE0xhmSfVAR04xt6WwMZcfalRTq9TnC9ek+7TmUWUBCVy4w+NJuc1FwDYqG9QAqyMNJy
         ez6WbWTZR42l1fXRgORVUE7BAoaXT6BVQFeC63UlNWdjWk6I9wHNzmaWNYYv7tUrUGNj
         k2xQ==
X-Gm-Message-State: AKS2vOzvJX500FfmOdc6KHbyg8UFeyc/rz3MCnPs2hlL9qa4EegG5SxW
        AvCkq2o18LL29x+1
X-Received: by 10.28.7.18 with SMTP id 18mr1800912wmh.20.1497945392154;
        Tue, 20 Jun 2017 00:56:32 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:31 -0700 (PDT)
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
Subject: [RFC/PATCH v4 33/49] odb-helper: call odb_helper_lookup() with 'have' capability
Date:   Tue, 20 Jun 2017 09:55:07 +0200
Message-Id: <20170620075523.26961-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 odb-helper.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/odb-helper.c b/odb-helper.c
index a6bf81af8d..910c87a482 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -142,19 +142,20 @@ static int check_object_process_error(int err,
 	return err;
 }
 
-static int read_object_process(const unsigned char *sha1)
+static int read_object_process(struct odb_helper *o, const unsigned char *sha1, int fd)
 {
 	int err;
 	struct read_object_process *entry;
 	struct child_process *process;
 	struct strbuf status = STRBUF_INIT;
-	const char *cmd = "read-object";
+	const char *cmd = o->cmd;
 	uint64_t start;
 
 	start = getnanotime();
 
 	entry = launch_read_object_process(cmd);
 	process = &entry->subprocess.process;
+	o->supported_capabilities = entry->supported_capabilities;
 
 	if (!(ODB_HELPER_CAP_GET & entry->supported_capabilities))
 		return -1;
@@ -173,6 +174,13 @@ static int read_object_process(const unsigned char *sha1)
 	if (err)
 		goto done;
 
+	if (o->fetch_kind != ODB_FETCH_KIND_FAULT_IN) {
+		struct strbuf buf;
+		read_packetized_to_strbuf(process->out, &buf);
+		if (err)
+			goto done;
+	}
+
 	subprocess_read_status(process->out, &status);
 	err = strcmp(status.buf, "success");
 
@@ -554,10 +562,11 @@ static int odb_helper_fetch_git_object(struct odb_helper *o,
 int odb_helper_fault_in_object(struct odb_helper *o,
 			       const unsigned char *sha1)
 {
-	struct odb_helper_object *obj = odb_helper_lookup(o, sha1);
-
-	if (!obj)
-		return -1;
+	if (o->supported_capabilities & ODB_HELPER_CAP_HAVE) {
+		struct odb_helper_object *obj = odb_helper_lookup(o, sha1);
+		if (!obj)
+			return -1;
+	}
 
 	if (o->script_mode) {
 		struct odb_helper_cmd cmd;
@@ -567,7 +576,7 @@ int odb_helper_fault_in_object(struct odb_helper *o,
 			return -1;
 		return 0;
 	} else {
-		return read_object_process(sha1);
+		return read_object_process(o, sha1, -1);
 	}
 }
 
-- 
2.13.1.565.gbfcd7a9048

