Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4AB20401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbdFTH5f (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:57:35 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34927 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbdFTH4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id d64so21285648wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ejEA108Uuvu2c6f2NAP0tzYDPj+0C0t0eaLs1AUEck=;
        b=rkQLMTilSDz6qIvkwp89XLfXFrweMbBwhNXE0ooQi0DUgX62Z6aeljevSrpV4g4dck
         XsKi200r/or7JzfxNHiIbyaAcmb0Stv8Vzyrb/eJhT0sGE4H/YtycYz8lHr1EMOxNemA
         y5PcgEZ6Shc/59h3mtMXXhnVnieQNNunHESZzqWNndYVTei1V3IIUagNoHCIZLQhs8RG
         D0uHc7LiBnA55ZUPhOCO2TNEyuTO0oXEoDCrzGnC1uwx/2fnFuwq7fYoG0+NNfOGShEY
         13C5edsw/ZTD0REfU3gEx8L+3cTpaWAJMq+npOQuXH90ki3kjNE2/khY46M7BG70A7v4
         JQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ejEA108Uuvu2c6f2NAP0tzYDPj+0C0t0eaLs1AUEck=;
        b=TZ1L40ouOuJ2HxotsFar5ENZmbpVb3CLMZGH33FqkqH8pzqIjJP6rGG2fQkEaJ2cW5
         RoQhFfuSt2OrGSZbPlpWwfUzhDyMZsMf5UFHx3ztiDvz3n8UmICNxovdSabaiCbw08ii
         6egMELx+HqxIEXo9F8y42KzyUx+pUjsr3XlsUnjfl3zcdrS3+5QvFskXxQ2fAh5o5rKs
         pEYhpsdDIhBcgtpMLb1kW8Y3pjFgaCOwGUrcl5YNYvSenMhgyLiMO/3W3/ZviFQAIc19
         kQ2Pr2ZV11MQsYpAMxyOqrkErvYB82CvcZni/CL3+yPw2AHbqXZQcz44KB2SrfooLj/T
         UcJw==
X-Gm-Message-State: AKS2vOwKHRvzCCr3cJLAcG+INeJj2qKw7iuv8bTU2L+Y2ieJsM7iTy6c
        ErZOyBmtthQwaBST
X-Received: by 10.28.11.145 with SMTP id 139mr1822328wml.11.1497945381087;
        Tue, 20 Jun 2017 00:56:21 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:20 -0700 (PDT)
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
Subject: [RFC/PATCH v4 24/49] odb-helper: start fault in implementation
Date:   Tue, 20 Jun 2017 09:54:58 +0200
Message-Id: <20170620075523.26961-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 external-odb.c                 | 24 ++++++++++++++++++++++--
 odb-helper.c                   | 30 ++++++++++++++++++++++++++++--
 odb-helper.h                   |  8 +++++++-
 t/t0400-external-odb.sh        |  2 ++
 t/t0410-transfer-e-odb.sh      |  4 +++-
 t/t0420-transfer-http-e-odb.sh |  6 +++---
 6 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/external-odb.c b/external-odb.c
index d11fc98719..0b6e443372 100644
--- a/external-odb.c
+++ b/external-odb.c
@@ -20,6 +20,19 @@ static struct odb_helper *find_or_create_helper(const char *name, int len)
 	return o;
 }
 
+static enum odb_helper_fetch_kind parse_fetch_kind(const char *key,
+						   const char *value)
+{
+	if (!strcasecmp(value, "plainobject"))
+		return ODB_FETCH_KIND_PLAIN_OBJECT;
+	else if (!strcasecmp(value, "gitobject"))
+		return ODB_FETCH_KIND_GIT_OBJECT;
+	else if (!strcasecmp(value, "faultin"))
+		return ODB_FETCH_KIND_FAULT_IN;
+
+	die("unknown value for config '%s': %s", key, value);
+}
+
 static int external_odb_config(const char *var, const char *value, void *data)
 {
 	struct odb_helper *o;
@@ -36,8 +49,15 @@ static int external_odb_config(const char *var, const char *value, void *data)
 
 	if (!strcmp(key, "command"))
 		return git_config_string(&o->cmd, var, value);
-	if (!strcmp(key, "plainobjects"))
-		o->store_plain_objects = git_config_bool(var, value);
+	if (!strcmp(key, "fetchkind")) {
+		const char *fetch_kind;
+		int ret = git_config_string(&fetch_kind, var, value);
+		if (!ret) {
+			o->fetch_kind = parse_fetch_kind(var, fetch_kind);
+			free((char *)fetch_kind);
+		}
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/odb-helper.c b/odb-helper.c
index b33ee81c97..24dc5375cb 100644
--- a/odb-helper.c
+++ b/odb-helper.c
@@ -347,14 +347,40 @@ static int odb_helper_fetch_git_object(struct odb_helper *o,
 	return 0;
 }
 
+static int odb_helper_fetch_fault_in(struct odb_helper *o,
+				     const unsigned char *sha1,
+				     int fd)
+{
+	struct odb_helper_object *obj;
+	struct odb_helper_cmd cmd;
+
+	obj = odb_helper_lookup(o, sha1);
+	if (!obj)
+		return -1;
+
+	if (odb_helper_start(o, &cmd, 0, "get %s", sha1_to_hex(sha1)) < 0)
+		return -1;
+
+	if (odb_helper_finish(o, &cmd))
+		return -1;
+
+	return 0;
+}
+
 int odb_helper_fetch_object(struct odb_helper *o,
 			    const unsigned char *sha1,
 			    int fd)
 {
-	if (o->store_plain_objects)
+	switch(o->fetch_kind) {
+	case ODB_FETCH_KIND_PLAIN_OBJECT:
 		return odb_helper_fetch_plain_object(o, sha1, fd);
-	else
+	case ODB_FETCH_KIND_GIT_OBJECT:
 		return odb_helper_fetch_git_object(o, sha1, fd);
+	case ODB_FETCH_KIND_FAULT_IN:
+		return odb_helper_fetch_fault_in(o, sha1, fd);
+	default:
+		BUG("invalid fetch kind '%d'", o->fetch_kind);
+	}
 }
 
 int odb_helper_for_each_object(struct odb_helper *o,
diff --git a/odb-helper.h b/odb-helper.h
index 3953b9bbaf..e3ad8e3316 100644
--- a/odb-helper.h
+++ b/odb-helper.h
@@ -3,10 +3,16 @@
 
 #include "external-odb.h"
 
+enum odb_helper_fetch_kind {
+	ODB_FETCH_KIND_PLAIN_OBJECT = 0,
+	ODB_FETCH_KIND_GIT_OBJECT,
+	ODB_FETCH_KIND_FAULT_IN
+};
+
 struct odb_helper {
 	const char *name;
 	const char *cmd;
-	int store_plain_objects;
+	enum odb_helper_fetch_kind fetch_kind;
 
 	struct odb_helper_object {
 		unsigned char sha1[20];
diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 3c868cad4c..c3cb0fdc84 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -49,6 +49,7 @@ test_expect_success 'alt objects are missing' '
 
 test_expect_success 'helper can retrieve alt objects' '
 	test_config odb.magic.command "$HELPER" &&
+	test_config odb.magic.fetchKind "gitObject" &&
 	cat >expect <<-\EOF &&
 	two
 	one
@@ -68,6 +69,7 @@ test_expect_success 'helper can add objects to alt repo' '
 
 test_expect_success 'commit adds objects to alt repo' '
 	test_config odb.magic.command "$HELPER" &&
+	test_config odb.magic.fetchKind "gitObject" &&
 	test_commit three &&
 	hash3=$(git ls-tree HEAD | grep three.t | cut -f1 | cut -d\  -f3) &&
 	content=$(cd alt-repo && git show "$hash3") &&
diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
index 868b55db94..cba89866e2 100755
--- a/t/t0410-transfer-e-odb.sh
+++ b/t/t0410-transfer-e-odb.sh
@@ -89,7 +89,8 @@ HELPER2="\"$PWD\"/odb-helper2"
 test_expect_success 'setup first alternate repo' '
 	git init alt-repo1 &&
 	test_commit zero &&
-	git config odb.magic.command "$HELPER1"
+	git config odb.magic.command "$HELPER1" &&
+	git config odb.magic.fetchKind "gitObject"
 '
 
 test_expect_success 'setup other repo and its alternate repo' '
@@ -119,6 +120,7 @@ test_expect_success 'other repo gets the blobs from object store' '
 	 test_must_fail git cat-file blob "$hash1" &&
 	 test_must_fail git cat-file blob "$hash2" &&
 	 git config odb.magic.command "$HELPER2" &&
+	 git config odb.magic.fetchKind "gitObject"
 	 git cat-file blob "$hash1" &&
 	 git cat-file blob "$hash2"
 	)
diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
index 716d722e97..8a5f3adaa7 100755
--- a/t/t0420-transfer-http-e-odb.sh
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -53,7 +53,7 @@ HELPER="\"$PWD\"/odb-http-helper"
 test_expect_success 'setup repo with a root commit and the helper' '
 	test_commit zero &&
 	git config odb.magic.command "$HELPER" &&
-	git config odb.magic.plainObjects "true"
+	git config odb.magic.fetchKind "plainObject"
 '
 
 test_expect_success 'setup another repo from the first one' '
@@ -108,7 +108,7 @@ test_expect_success 'update other repo from the first one' '
 	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
 	 test_must_fail git cat-file blob "$hash1" &&
 	 git config odb.magic.command "$HELPER" &&
-	 git config odb.magic.plainObjects "true" &&
+	 git config odb.magic.fetchKind "plainObject" &&
 	 git cat-file blob "$hash1" &&
 	 git pull origin master)
 '
@@ -140,7 +140,7 @@ test_expect_success 'no-local initial-refspec clone succeeds' '
 	mkdir my-other-clone &&
 	(cd my-other-clone &&
 	 git config odb.magic.command "$HELPER" &&
-	 git config odb.magic.plainObjects "true" &&
+	 git config odb.magic.fetchKind "plainObject" &&
 	 git -c odb.magic.command="$HELPER" -c odb.magic.plainObjects="true" \
 		clone --no-local --initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
 '
-- 
2.13.1.565.gbfcd7a9048

