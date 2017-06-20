Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0C720401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752307AbdFTH4x (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36554 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdFTH4l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so16319647wrb.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+JqpWbq2zrraMZvmKDBoy092Z6bJ8WBNFDCauUZc4w=;
        b=HN5qkFyV05dC3cl0vvniQykcFie/NVKmvwzNWesJYuzPT0XxIWLK0jdpXrZf/5tMZW
         fb6jlRHOkJwq4ONdOFicrsesSJgFtFkEmFv0nZuEafUhl3sTrmRqbHxGcYavIvbk3ptV
         GDgtyN5v+8F9iQRYuRE4cB9Kxkcnbzm8ez9f2n2YdmM8tMFLLZsJoodImtxrW0tBOz7O
         3ta8rSd2XOj/W7KtWNVms8Irtzg1zZsAeD/FKu0e9MlyZ5Wjr/r4aPPqaLQKiNj6yaGv
         HxKJm5Hkt9TV3KM5MZBXyc3rlU2H4DQXlJ5Tv+Pks8OwWmWJY3NeozV/pJkcSaW5Ge5g
         jPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g+JqpWbq2zrraMZvmKDBoy092Z6bJ8WBNFDCauUZc4w=;
        b=XrlEC4nXi1s9w/P9dQJeoQb+rJ13n0rJDkDZQRs9tM+LCAXYXEvN8Je7FPya7j304o
         VvfY+ecXdkckmSMkBX5yEvbjcJqdSZH5vQU96sKiOGBw00tSLLRLlCf1f+bpcqxuMMOH
         rEse+jLSNWXdH1zuu5ZyyTuXT76ydJ1IomyOfPggFj0hbEZ4x10ieAQ0S+/745VEqjbb
         FPaYsfXx7dfXQyBa5t56Zrn848ElMtRpdJH4bR9/2OzeyimpQvqCPIDy7NpUZ97pMSGO
         +v1he0VtY2NUbVjhSXyJ9fQOvPnM/S3+/UHNW4NKME+ThNsVYerHIILpkmLB6hWFrDTe
         aZNg==
X-Gm-Message-State: AKS2vOwQb3udA5von9jX9Jvt0jQiw2rFa0hq4cCW2xePQQQEQTmoS+go
        +dxlUMJvU+pPGpVZ
X-Received: by 10.223.154.141 with SMTP id a13mr18402481wrc.139.1497945389743;
        Tue, 20 Jun 2017 00:56:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:29 -0700 (PDT)
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
Subject: [RFC/PATCH v4 31/49] external-odb: add external_odb_get_capabilities()
Date:   Tue, 20 Jun 2017 09:55:05 +0200
Message-Id: <20170620075523.26961-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c | 15 ++++++++++++++-
 odb-helper.c   | 23 +++++++++++++++++++++++
 odb-helper.h   |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/external-odb.c b/external-odb.c
index 2efa805d12..8c2570b2e7 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -66,6 +66,14 @@ static int external_odb_config(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static void external_odb_get_capabilities(void)
+{
+	struct odb_helper *o;
+
+	for (o = helpers; o; o = o->next)
+		odb_helper_get_capabilities(o);
+}
+
 static void external_odb_init(void)
 {
 	static int initialized;
@@ -75,6 +83,8 @@ static void external_odb_init(void)
 	initialized = 1;
 
 	git_config(external_odb_config, NULL);
+
+	external_odb_get_capabilities();
 }
 
 const char *external_odb_root(void)
@@ -94,9 +104,12 @@ int external_odb_has_object(const unsigned char *sha1)
 
 	external_odb_init();
 
-	for (o = helpers; o; o = o->next)
+	for (o = helpers; o; o = o->next) {
+		if (!(o->supported_capabilities & ODB_HELPER_CAP_HAVE))
+			return 1;
 		if (odb_helper_has_object(o, sha1))
 			return 1;
+	}
 	return 0;
 }
 
diff --git a/odb-helper.c b/odb-helper.c
index 20e83cb55a..a6bf81af8d 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -260,6 +260,29 @@ static int odb_helper_finish(struct odb_helper *o,
 	return 0;
 }
 
+int odb_helper_get_capabilities(struct odb_helper *o)
+{
+	struct odb_helper_cmd cmd;
+	FILE *fh;
+	struct strbuf line = STRBUF_INIT;
+
+	if (!o->script_mode)
+		return 0;
+
+	if (odb_helper_start(o, &cmd, 0, "get_cap") < 0)
+		return -1;
+
+	fh = xfdopen(cmd.child.out, "r");
+	while (strbuf_getline(&line, fh) != EOF)
+		parse_capabilities(line.buf, &o->supported_capabilities, o->name);
+
+	strbuf_release(&line);
+	fclose(fh);
+	odb_helper_finish(o, &cmd);
+
+	return 0;
+}
+
 static int parse_object_line(struct odb_helper_object *o, const char *line)
 {
 	char *end;
diff --git a/odb-helper.h b/odb-helper.h
index b23544aa4a..8e0b0fc781 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -33,6 +33,7 @@ struct odb_helper {
 };
 
 struct odb_helper *odb_helper_new(const char *name, int namelen);
+int odb_helper_get_capabilities(struct odb_helper *o);
 int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1);
 int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
 			    int fd);
-- 
2.13.1.565.gbfcd7a9048

