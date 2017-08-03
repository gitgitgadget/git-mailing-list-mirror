Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055A42047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdHCJVp (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33268 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752046AbdHCJUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so577660wrd.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iynULN6DPEWblqnOhL6eLA04ACiriA5Vj5HoD0OB5WQ=;
        b=ZeGqUp2nz/qJ0d7e4dbtfMDDpZaqOPKt68zaDO5Nh1Xghp26wBr8FimYo3g85cpiIK
         0OSkoOLCPdNrklJL3PgtvRMQGVdOnAJiceH0f7Z2r9YQR1I13DtuT6TUCA3UoGu8Q/xZ
         F5BIYJ3kuWC972ZR7uTNONZXy3o2agSUwDeKU33682VL+I+TmzzZSaQw1MRRE+7veK5i
         QQhD2hg5oqCr1ynz0JVtWYAMYbkPNiTT7OCwxeq4rN8MUCROq5nI2MrJt8LJgoVKKDrR
         AOkAcg8+3jW9LecuEEBhScHNsPRmJjSOLk+Hagnidc9IEg35HbGChRrrN1nExheX9kJ9
         ImaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iynULN6DPEWblqnOhL6eLA04ACiriA5Vj5HoD0OB5WQ=;
        b=BxELN2a2SviCx8PG8Jk3yEtoKj1lgrAvPsVAG/6CnzBPlnyAM30vvmlnBjCVfwwaXR
         G2Ps5Qz8D4c4HYXFqDvaOY1PstXm4JVroVBpXdydlidhKnLCilIwjEkdRQVLr9wiypd6
         4m+mYkhvViYBjOic3IDlvru6CQtbDwvoGHWscl6MR2nOKjx88O81bgMgrB3pzNQcLuvR
         HgQj1ENbIRiy+7ICkaSGHtr3CLFhrMnKm31r1afh9HK7P8heN36BKJpB/BVqUd0tnPL6
         ZUnBidDQV9dba6ZDjCWpJRqBP9eyDMuwQhJfeO7/wIvTRamxdtvRK0plAU8SNgNzkoUA
         dPTA==
X-Gm-Message-State: AIVw112pdctz/0/5KhCgc5W4T8hohvUyKMtpG9USW9SC226FCowCOiIg
        qduExMQpabR3Sjg+
X-Received: by 10.223.131.67 with SMTP id 61mr788858wrd.54.1501752008963;
        Thu, 03 Aug 2017 02:20:08 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 26/40] odb-helper: add 'script_mode' to 'struct odb_helper'
Date:   Thu,  3 Aug 2017 11:19:12 +0200
Message-Id: <20170803091926.1755-27-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

to prepare for having a long running odb helper sub-process
handling the communication between Git and an external odb.

We introduce "odb.<name>.subprocesscommand" to make it
possible to define such a sub-process, and we mark such odb
helpers with the new 'script_mode' field set to 0.

Helpers defined using the existing "odb.<name>.scriptcommand"
are marked with the 'script_mode' field set to 1.

Implementation of the different capabilities/instructions in
the new (sub-)process mode is left for following commits.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c |  8 +++++++-
 odb-helper.c   | 19 ++++++++++++++-----
 odb-helper.h   |  1 +
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index 31d21bfe04..ccca67eff5 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -32,8 +32,14 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	o = find_or_create_helper(name, namelen);
 
-	if (!strcmp(subkey, "scriptcommand"))
+	if (!strcmp(subkey, "scriptcommand")) {
+		o->script_mode = 1;
 		return git_config_string(&o->cmd, var, value);
+	}
+	if (!strcmp(subkey, "subprocesscommand")) {
+		o->script_mode = 0;
+		return git_config_string(&o->cmd, var, value);
+	}
 
 	return 0;
 }
diff --git a/odb-helper.c b/odb-helper.c
index b1f5464214..4c16dd297a 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -123,6 +123,9 @@ int odb_helper_init(struct odb_helper *o)
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
+	if (!o->script_mode)
+		return 0;
+
 	if (odb_helper_start(o, &cmd, 0, "init") < 0)
 		return -1;
 
@@ -173,16 +176,12 @@ static int odb_helper_object_cmp(const void *va, const void *vb)
 	return hashcmp(a->sha1, b->sha1);
 }
 
-static void odb_helper_load_have(struct odb_helper *o)
+static void have_object_script(struct odb_helper *o)
 {
 	struct odb_helper_cmd cmd;
 	FILE *fh;
 	struct strbuf line = STRBUF_INIT;
 
-	if (o->have_valid)
-		return;
-	o->have_valid = 1;
-
 	if (odb_helper_start(o, &cmd, 0, "have") < 0)
 		return;
 
@@ -194,6 +193,16 @@ static void odb_helper_load_have(struct odb_helper *o)
 	strbuf_release(&line);
 	fclose(fh);
 	odb_helper_finish(o, &cmd);
+}
+
+static void odb_helper_load_have(struct odb_helper *o)
+{
+	if (o->have_valid)
+		return;
+	o->have_valid = 1;
+
+	if (o->script_mode)
+		have_object_script(o);
 
 	qsort(o->have, o->have_nr, sizeof(*o->have), odb_helper_object_cmp);
 }
diff --git a/odb-helper.h b/odb-helper.h
index f2fd2b7c9c..04b85f1d02 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -15,6 +15,7 @@ struct odb_helper {
 	const char *name;
 	const char *cmd;
 	unsigned int supported_capabilities;
+	int script_mode;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

