Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07013207EC
	for <e@80x24.org>; Sun,  9 Oct 2016 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbcJIMes (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 08:34:48 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33827 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbcJIMer (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 08:34:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id p80so5318286lfp.1
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 05:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfxnSsMoe+JnivTKWc6LBUN23u8LJOlweG45i0KaPNE=;
        b=qD0GHVwaw2N00FxH7L4BpyKHhv27fyl09FFhZsxJkpz/m23htOeeAmPKUxVPEfO3gA
         RUnAEmklGxDVX0qY+8533HWD3y64X2LFBiUBPR/0VHEZ+0GFHf76OixkoUocOluaYuEj
         eF+qJbxaPECiwZR/P9uH6PUZCJoJlCNidhGo5yfVFnBn7ky5i9a1pts7Nlx/xa9T3HOp
         dyEhewWUmjBYGzvvk1kz62jf7dcO3jV8iNAwz8Vs4KZ0+AblPttZhZ/PfHvYQF09AjqI
         yEOTTGogkkMWjp3zVBJfkE93D+/16s+6oMedBYwb/L5c9GAufRYvvSE9vQBVUb3L1s/3
         fXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IfxnSsMoe+JnivTKWc6LBUN23u8LJOlweG45i0KaPNE=;
        b=aoIXxsFzkPsbiSS0IfZIxV5YXmN1v2QZ4C3dFc5glA/GaUprymFXTqwFInxBQvEwuC
         swx2D1S8cTDs05PRT3oM2QYEz96QNgMzbkC6Lb4vpi6WFP4NmLWzCKOwIbMe1+BeVcSA
         JHWnJu17OZyEbRkS6DdleTNBNTm4ZPGVrIu+7+25L6j5pDN4F7PNxxMPMbsfChz7x5LP
         Vo5o2of0DwrcKVY99ektQRppfeiRBMHAVmCTl+X/2cJbQTqtBFwOFmb4CMPvesD/U8RV
         n+kPqB95m5z9SgAZec7RbZRxLDrTAGyCaiQmF4/R55v4tTsPdbJ6Nkm9phZz8pzx98RL
         HFTg==
X-Gm-Message-State: AA6/9RkFvrhvBediwaSgOERfSlmbBCB8h+X4/UotOIvTvD/nwOXnFku5+3tKAaYHKgXw3A==
X-Received: by 10.25.132.18 with SMTP id g18mr12237104lfd.7.1476016485458;
        Sun, 09 Oct 2016 05:34:45 -0700 (PDT)
Received: from localhost ([2001:778:e27f:a70::1000])
        by smtp.gmail.com with ESMTPSA id 23sm5203670ljf.9.2016.10.09.05.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Oct 2016 05:34:44 -0700 (PDT)
From:   =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Mantas=20Mikul=C4=97nas?= <grawity@gmail.com>
Subject: [PATCH] contrib: add credential helper for libsecret
Date:   Sun,  9 Oct 2016 15:34:17 +0300
Message-Id: <20161009123417.147239-1-grawity@gmail.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the existing gnome-keyring helper, but instead of
libgnome-keyring (which was specific to GNOME and is deprecated), it
uses libsecret which can support other implementations of XDG Secret
Service API.

Passes t0303-credential-external.sh.

Signed-off-by: Mantas Mikulėnas <grawity@gmail.com>
---
 contrib/credential/libsecret/Makefile              |  25 ++
 .../libsecret/git-credential-libsecret.c           | 370 +++++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 contrib/credential/libsecret/Makefile
 create mode 100644 contrib/credential/libsecret/git-credential-libsecret.c

diff --git a/contrib/credential/libsecret/Makefile b/contrib/credential/libsecret/Makefile
new file mode 100644
index 000000000000..3e67552cc5b5
--- /dev/null
+++ b/contrib/credential/libsecret/Makefile
@@ -0,0 +1,25 @@
+MAIN:=git-credential-libsecret
+all:: $(MAIN)
+
+CC = gcc
+RM = rm -f
+CFLAGS = -g -O2 -Wall
+PKG_CONFIG = pkg-config
+
+-include ../../../config.mak.autogen
+-include ../../../config.mak
+
+INCS:=$(shell $(PKG_CONFIG) --cflags libsecret-1 glib-2.0)
+LIBS:=$(shell $(PKG_CONFIG) --libs libsecret-1 glib-2.0)
+
+SRCS:=$(MAIN).c
+OBJS:=$(SRCS:.c=.o)
+
+%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<
+
+$(MAIN): $(OBJS)
+	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
+
+clean:
+	@$(RM) $(MAIN) $(OBJS)
diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
new file mode 100644
index 000000000000..4c56979d8a08
--- /dev/null
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -0,0 +1,370 @@
+/*
+ * Copyright (C) 2011 John Szakmeister <john@szakmeister.net>
+ *               2012 Philipp A. Hartmann <pah@qo.cx>
+ *               2016 Mantas Mikulėnas <grawity@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * Credits:
+ * - GNOME Keyring API handling originally written by John Szakmeister
+ * - ported to credential helper API by Philipp A. Hartmann
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <glib.h>
+#include <libsecret/secret.h>
+
+/*
+ * This credential struct and API is simplified from git's credential.{h,c}
+ */
+struct credential {
+	char *protocol;
+	char *host;
+	unsigned short port;
+	char *path;
+	char *username;
+	char *password;
+};
+
+#define CREDENTIAL_INIT { NULL, NULL, 0, NULL, NULL, NULL }
+
+typedef int (*credential_op_cb)(struct credential *);
+
+struct credential_operation {
+	char *name;
+	credential_op_cb op;
+};
+
+#define CREDENTIAL_OP_END { NULL, NULL }
+
+/* ----------------- Secret Service functions ----------------- */
+
+static char *make_label(struct credential *c)
+{
+	if (c->port)
+		return g_strdup_printf("Git: %s://%s:%hu/%s",
+					c->protocol, c->host, c->port, c->path ? c->path : "");
+	else
+		return g_strdup_printf("Git: %s://%s/%s",
+					c->protocol, c->host, c->path ? c->path : "");
+}
+
+static GHashTable *make_attr_list(struct credential *c)
+{
+	GHashTable *al = g_hash_table_new_full(g_str_hash, g_str_equal, NULL, g_free);
+
+	if (c->username)
+		g_hash_table_insert(al, "user", g_strdup(c->username));
+	if (c->protocol)
+		g_hash_table_insert(al, "protocol", g_strdup(c->protocol));
+	if (c->host)
+		g_hash_table_insert(al, "server", g_strdup(c->host));
+	if (c->port)
+		g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
+	if (c->path)
+		g_hash_table_insert(al, "object", g_strdup(c->path));
+
+	return al;
+}
+
+static int keyring_get(struct credential *c)
+{
+	SecretService *service = NULL;
+	GHashTable *attributes = NULL;
+	GError *error = NULL;
+	GList *items = NULL;
+
+	if (!c->protocol || !(c->host || c->path))
+		return EXIT_FAILURE;
+
+	service = secret_service_get_sync(0, NULL, &error);
+	if (error != NULL) {
+		g_critical("could not connect to Secret Service: %s", error->message);
+		g_error_free(error);
+		return EXIT_FAILURE;
+	}
+
+	attributes = make_attr_list(c);
+	items = secret_service_search_sync(service,
+					   SECRET_SCHEMA_COMPAT_NETWORK,
+					   attributes,
+					   SECRET_SEARCH_LOAD_SECRETS,
+					   NULL,
+					   &error);
+	g_hash_table_unref(attributes);
+	if (error != NULL) {
+		g_critical("lookup failed: %s", error->message);
+		g_error_free(error);
+		return EXIT_FAILURE;
+	}
+
+	if (items != NULL) {
+		SecretItem *item;
+		SecretValue *secret;
+		const char *s;
+
+		item = items->data;
+		secret = secret_item_get_secret(item);
+		attributes = secret_item_get_attributes(item);
+
+		s = g_hash_table_lookup(attributes, "user");
+		if (s) {
+			g_free(c->username);
+			c->username = g_strdup(s);
+		}
+
+		s = secret_value_get_text(secret);
+		if (s) {
+			g_free(c->password);
+			c->password = g_strdup(s);
+		}
+
+		g_hash_table_unref(attributes);
+		secret_value_unref(secret);
+		g_list_free_full(items, g_object_unref);
+	}
+
+	return EXIT_SUCCESS;
+}
+
+
+static int keyring_store(struct credential *c)
+{
+	char *label = NULL;
+	GHashTable *attributes = NULL;
+	GError *error = NULL;
+
+	/*
+	 * Sanity check that what we are storing is actually sensible.
+	 * In particular, we can't make a URL without a protocol field.
+	 * Without either a host or pathname (depending on the scheme),
+	 * we have no primary key. And without a username and password,
+	 * we are not actually storing a credential.
+	 */
+	if (!c->protocol || !(c->host || c->path) ||
+	    !c->username || !c->password)
+		return EXIT_FAILURE;
+
+	label = make_label(c);
+	attributes = make_attr_list(c);
+	secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+				    attributes,
+				    NULL,
+				    label,
+				    c->password,
+				    NULL,
+				    &error);
+	g_free(label);
+	g_hash_table_unref(attributes);
+
+	if (error != NULL) {
+		g_critical("store failed: %s", error->message);
+		g_error_free(error);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static int keyring_erase(struct credential *c)
+{
+	GHashTable *attributes = NULL;
+	GError *error = NULL;
+
+	/*
+	 * Sanity check that we actually have something to match
+	 * against. The input we get is a restrictive pattern,
+	 * so technically a blank credential means "erase everything".
+	 * But it is too easy to accidentally send this, since it is equivalent
+	 * to empty input. So explicitly disallow it, and require that the
+	 * pattern have some actual content to match.
+	 */
+	if (!c->protocol && !c->host && !c->path && !c->username)
+		return EXIT_FAILURE;
+
+	attributes = make_attr_list(c);
+	secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
+				    attributes,
+				    NULL,
+				    &error);
+	g_hash_table_unref(attributes);
+
+	if (error != NULL) {
+		g_critical("erase failed: %s", error->message);
+		g_error_free(error);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
+/*
+ * Table with helper operation callbacks, used by generic
+ * credential helper main function.
+ */
+static struct credential_operation const credential_helper_ops[] = {
+	{ "get",   keyring_get },
+	{ "store", keyring_store },
+	{ "erase", keyring_erase },
+	CREDENTIAL_OP_END
+};
+
+/* ------------------ credential functions ------------------ */
+
+static void credential_init(struct credential *c)
+{
+	memset(c, 0, sizeof(*c));
+}
+
+static void credential_clear(struct credential *c)
+{
+	g_free(c->protocol);
+	g_free(c->host);
+	g_free(c->path);
+	g_free(c->username);
+	g_free(c->password);
+
+	credential_init(c);
+}
+
+static int credential_read(struct credential *c)
+{
+	char *buf;
+	size_t line_len;
+	char *key;
+	char *value;
+
+	key = buf = g_malloc(1024);
+
+	while (fgets(buf, 1024, stdin)) {
+		line_len = strlen(buf);
+
+		if (line_len && buf[line_len-1] == '\n')
+			buf[--line_len] = '\0';
+
+		if (!line_len)
+			break;
+
+		value = strchr(buf, '=');
+		if (!value) {
+			g_warning("invalid credential line: %s", key);
+			g_free(buf);
+			return -1;
+		}
+		*value++ = '\0';
+
+		if (!strcmp(key, "protocol")) {
+			g_free(c->protocol);
+			c->protocol = g_strdup(value);
+		} else if (!strcmp(key, "host")) {
+			g_free(c->host);
+			c->host = g_strdup(value);
+			value = strrchr(c->host, ':');
+			if (value) {
+				*value++ = '\0';
+				c->port = atoi(value);
+			}
+		} else if (!strcmp(key, "path")) {
+			g_free(c->path);
+			c->path = g_strdup(value);
+		} else if (!strcmp(key, "username")) {
+			g_free(c->username);
+			c->username = g_strdup(value);
+		} else if (!strcmp(key, "password")) {
+			g_free(c->password);
+			c->password = g_strdup(value);
+			while (*value)
+				*value++ = '\0';
+		}
+		/*
+		 * Ignore other lines; we don't know what they mean, but
+		 * this future-proofs us when later versions of git do
+		 * learn new lines, and the helpers are updated to match.
+		 */
+	}
+
+	g_free(buf);
+
+	return 0;
+}
+
+static void credential_write_item(FILE *fp, const char *key, const char *value)
+{
+	if (!value)
+		return;
+	fprintf(fp, "%s=%s\n", key, value);
+}
+
+static void credential_write(const struct credential *c)
+{
+	/* only write username/password, if set */
+	credential_write_item(stdout, "username", c->username);
+	credential_write_item(stdout, "password", c->password);
+}
+
+static void usage(const char *name)
+{
+	struct credential_operation const *try_op = credential_helper_ops;
+	const char *basename = strrchr(name, '/');
+
+	basename = (basename) ? basename + 1 : name;
+	fprintf(stderr, "usage: %s <", basename);
+	while (try_op->name) {
+		fprintf(stderr, "%s", (try_op++)->name);
+		if (try_op->name)
+			fprintf(stderr, "%s", "|");
+	}
+	fprintf(stderr, "%s", ">\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = EXIT_SUCCESS;
+
+	struct credential_operation const *try_op = credential_helper_ops;
+	struct credential cred = CREDENTIAL_INIT;
+
+	if (!argv[1]) {
+		usage(argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	g_set_application_name("Git Credential Helper");
+
+	/* lookup operation callback */
+	while (try_op->name && strcmp(argv[1], try_op->name))
+		try_op++;
+
+	/* unsupported operation given -- ignore silently */
+	if (!try_op->name || !try_op->op)
+		goto out;
+
+	ret = credential_read(&cred);
+	if (ret)
+		goto out;
+
+	/* perform credential operation */
+	ret = (*try_op->op)(&cred);
+
+	credential_write(&cred);
+
+out:
+	credential_clear(&cred);
+	return ret;
+}
-- 
2.10.0

