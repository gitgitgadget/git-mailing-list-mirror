Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9A020D12
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdFTH4M (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36189 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdFTH4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id d17so21330799wme.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hTQ4+PJiGFR2wm/ZCW+TYPshmlkaIIrwmiQXe9mmdSI=;
        b=YdrxsDhwoxUjYVojbgbsLnqMeP4ROz+sh0bAQmzB4oWGxcYrmR3RMe63o61w2KwoxY
         NiMMPunVmgJ9s3Z7rze9+s6ARwXlshyDXg7iga14CTyNJ6p4gTk0z5m3QHYadzioV3of
         hCSO0j0FSFbn0GdWIO28XnE19IvVEVMSSaOeMl++O3lxGmkfwUV00eEaTfq6VIthd0eC
         /QyD6dB4KFDz5unCz9q2kuU9LOmroDDb/ZKyZZUSaVitvgzUIhOMvgcmX3YvTouSUvZI
         1aOJqUR8OF1yeJ1kVepSf7UIa3k3pgxsfWEvrbX6H+stUpR7FVgdYXxn/kW5k7DtJnLM
         DzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hTQ4+PJiGFR2wm/ZCW+TYPshmlkaIIrwmiQXe9mmdSI=;
        b=YI5qbbfV6KfdEd0i8gjqPgi3pOdO2aR1mIgh4R+S0REg6vxxd0wmlpd481s5pcX3BW
         ZbJ+678oY2uwFssPUJ+KtUatmzG/AsFI+8HuAItq4zfWRfV4jpd7XIeYE7bw9zlPHPL3
         tMOR1zWxsvmsuUBO84UUDXWQZYfT+9I+MFmYhHLroBaai6GSmvy6gk+z0UhoJsuKfU3o
         q2VlDgQxfEnR2nZN+dvymvBvl5qcoY18rm6xnjWTzPdjTnIbEb/peteWWdIe1eM6driE
         M6yPAjawWq/4RG+QBia0lus7supt425ijku5hFuTvn19yw7ByGJ4bCTkWoGhf1l03JVx
         16xg==
X-Gm-Message-State: AKS2vOzNAreb+MIHdpQfdNQbNJWsd5uLiPTOxNv5Qtk67kcEu3QYgsNS
        26ot/1oZoP37Nvnp
X-Received: by 10.28.214.148 with SMTP id n142mr1700790wmg.35.1497945369000;
        Tue, 20 Jun 2017 00:56:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:08 -0700 (PDT)
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
Subject: [RFC/PATCH v4 15/49] Add GIT_NO_EXTERNAL_ODB env variable
Date:   Tue, 20 Jun 2017 09:54:49 +0200
Message-Id: <20170620075523.26961-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h        | 9 +++++++++
 environment.c  | 4 ++++
 external-odb.c | 6 ++++++
 sha1_file.c    | 3 +++
 4 files changed, 22 insertions(+)

diff --git a/cache.h b/cache.h
index 391a69e9c5..6047755629 100644
--- a/cache.h
+++ b/cache.h
@@ -428,6 +428,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_EXTERNAL_ODB_ENVIRONMENT "GIT_NO_EXTERNAL_ODB"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
@@ -760,6 +761,14 @@ void reset_shared_repository(void);
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
index aa478e71de..8c4f52635c 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,7 @@ const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
 int check_replace_refs = 1;
 char *git_replace_ref_base;
+int use_external_odb = 1;
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -120,6 +121,7 @@ const char * const local_repo_env[] = {
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
+	NO_EXTERNAL_ODB_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SUPER_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -188,6 +190,8 @@ static void setup_git_env(void)
 	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
 	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
 							  : "refs/replace/");
+	if (getenv(NO_EXTERNAL_ODB_ENVIRONMENT))
+		use_external_odb = 0;
 	namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	namespace_len = strlen(namespace);
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
diff --git a/external-odb.c b/external-odb.c
index 6d4fdd0bc1..a88837feda 100644
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
@@ -133,6 +136,9 @@ int external_odb_write_object(const void *buf, size_t len,
 {
 	struct odb_helper *o;
 
+	if (!use_external_odb)
+		return 1;
+
 	/* For now accept only blobs */
 	if (strcmp(type, "blob"))
 		return 1;
diff --git a/sha1_file.c b/sha1_file.c
index 8dd09334cf..9d8e37432e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -642,6 +642,9 @@ void prepare_external_alt_odb(void)
 	static int linked_external;
 	const char *path;
 
+	if (!use_external_odb)
+		return;
+
 	if (linked_external)
 		return;
 
-- 
2.13.1.565.gbfcd7a9048

