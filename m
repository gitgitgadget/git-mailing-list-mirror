Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4942018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538AbcF1SUT (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36461 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbcF1SUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:20:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id c82so7985001wme.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:19:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yT0ein6BpSE9UiReHfaVaL+Z7rAVzTmuJC02Fmpy3jA=;
        b=FvcKuvemitQ3MshKh1nyOdEafhoPN7ODaINdIalyc933ZPH940dzCbSyAV8K6206j3
         N5+/FdXNUQHacakgZ/DfSGXoYCZmMmdcxIXzUpDSFVnWShV8zmIU/pSXqN9WdBFyVotP
         LV3hdD8WNrPmbEJ7Tu6pl1hLmm4qC2s30dG8k2a35rbKmrRcDZdmkydvso0vUFw5c3qy
         Xl4X2ieKxKR1qXdRDd040uR+MQ/3SGW5Hk9V62Tke6yj9clF+/9Otdl7SOkUg/piz5no
         LNFPDop1rahy/uO3U7hjOZglC9CI2UOzh9OHX1JhFpc6x95Brgpjv+sxKVb88nSEqEaT
         WxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yT0ein6BpSE9UiReHfaVaL+Z7rAVzTmuJC02Fmpy3jA=;
        b=OCpcTb5F6rgGkVTOMiKQ/SZrDJLmx1CceuXt6NqSpoxBmYbkz1fe0V0sAWpB9nUsRk
         FNMfe5hDT0nq+L5ptjFy09MLy5giV8Vbymz/u6WK1qDawxojgJaxM5SJcKOynlMO5d3W
         4+TJdEnL7249pCNYHKUh2t91Vi1l+qtKXjoljShZX/HJMc9VzVvrWGxL8gl1KPnN4Hai
         p3dIURAMd2rNOVnhv39uKywFnjLQHupUrh2zzjRrHYJrtW8f4IrvSQPvB3yKdQSrcIHR
         6GRhF81ARPklcpkroEi9AdBa7N2UDaQt3iN4y3QVC+Ie1Gd93+ponsLcZEjxFTJ7Q/wc
         4/oA==
X-Gm-Message-State: ALyK8tLcEZEhBQ3iQMwoCznrCdgRmqWZ482TTMD7YhvV1aWKU0ahNis/vU8GCYhPAlnElA==
X-Received: by 10.28.69.210 with SMTP id l79mr4684647wmi.31.1467137998516;
        Tue, 28 Jun 2016 11:19:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:57 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 09/10] Add GIT_NO_EXTERNAL_ODB env variable
Date:	Tue, 28 Jun 2016 20:19:32 +0200
Message-Id: <20160628181933.24620-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h        | 9 +++++++++
 environment.c  | 4 ++++
 external-odb.c | 6 ++++++
 sha1_file.c    | 3 +++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index cc0a934..b0fe2bc 100644
--- a/cache.h
+++ b/cache.h
@@ -420,6 +420,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -678,6 +679,14 @@ int get_shared_repository(void);
 extern int check_replace_refs;
 extern char *git_replace_ref_base;
 
+/*
+ * Do external odbs need to be used this run?  This variable is
+ * initialized to true unless $GIT_NO_EXTERNAL_ODB is set, but it
+ * maybe set to false by some commands that do not want external
+ * odbs to be active.
+ */
+extern int use_external_odb;
+
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_apply_sparse_checkout;
diff --git a/environment.c b/environment.c
index ca72464..1799339 100644
--- a/environment.c
+++ b/environment.c
@@ -48,6 +48,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -119,6 +120,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
 	GIT_COMMON_DIR_ENVIRONMENT,
@@ -183,6 +185,8 @@ static void setup_git_env(void)
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/external-odb.c b/external-odb.c
index 6dd7b25..a980fbf 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -63,6 +63,9 @@ int external_odb_has_object(const unsigned char *sha1)
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 0;
+
 	external_odb_init();
 
 	for (o = helpers; o; o = o->next)
@@ -133,6 +136,9 @@ int external_odb_write_object(const void *buf, unsigned long len,
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 1;
+
 	/* For now accept only blobs */
 	if (strcmp(type, "blob"))
 		return 1;
diff --git a/sha1_file.c b/sha1_file.c
index 90f19de..13d4d75 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -448,6 +448,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.9.0.rc2.11.g990c140

