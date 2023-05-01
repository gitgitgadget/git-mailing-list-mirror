Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F28C77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 15:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjEAPyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjEAPyS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 11:54:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F1D199
        for <git@vger.kernel.org>; Mon,  1 May 2023 08:53:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9d87dffadfso2096887276.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682956439; x=1685548439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mV6bruf5iOXfF9MBhazeJqDknG+ed//kgRlEScXJzo=;
        b=Z3t+W7Vbu2AICE3F6WpExLbPuRWaeddzDclduv2YNl8l1npf0gajexmrV6/pbbrmSW
         za4D+x6AaKLIhJtrgGoL0Op/dsE08Y0zD7X4J5dONor3nVwcOs9SdVUVWwHiUhjUh3Yo
         YI4lbJ43OEXGR4feTAxn1C1Zkx2d1Rd0uU2MNNA9/ojYyMkY8RodltDuEAlI2zahMGrS
         sTo5/Rc6waoKhKW5mwEjDvEe/c8ZAZq0iLdEoRdjkk63L9EfmzfjQ+nEqv9eDBCZK2oR
         XtpuK/TCmht/Y6WKlpZdqf0Clsoxt2Y5UAqar46urcAH6oEDlCVBxCsYSkzORa/O+JM5
         jJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682956439; x=1685548439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mV6bruf5iOXfF9MBhazeJqDknG+ed//kgRlEScXJzo=;
        b=dtZ1YJ/z/St/YScfh5XjtuUy9dCpf4Y9QFEsMxOyv3qKX5/ebDEG1q/lFZ4X7vjJ24
         yF8JWP/sF5I5mqu19Lv1OS+dZedP5DKIq8F3f1lWsS0Sg/7f9wixLj+SBgVBQW+GCx5w
         BEzdqtgf5xqjD8z5n9c88w/iBWtEVtJ2Gsynu7cVO+Nb0Dsc3vwLqLlzZs6VgXi1deQO
         E3MRysBBpi9DnQJA9+Q+9vHGcbkCx15TtYEn07MEDr2DrmjrNwU0xnqC3gCJPBVAaHuc
         bk3hx6NSY9bNiBIiQK+JlJZZk9B0BV4Azel0cpAYBSk+LkaXUS8DRfzLWbZsg8tGhT4o
         F5Ng==
X-Gm-Message-State: AC+VfDzMl0j6TPYjT/HYSJkqxqgtvefkS1jtnLwEgn1vPRKC3hPBlA5o
        NLlZjmH0tBKsIUsbk0JhmOBzgsaqVu+yt8vWDpQqRw==
X-Google-Smtp-Source: ACHHUZ4S5lcl0Ph6SxpTt/SEwb8rdCMcpMzg5IiQi5oGQS4wm19eP5Apj1D2urehs6yTWO4uTAfpUA==
X-Received: by 2002:a05:6902:1003:b0:b8c:a9c:ac6c with SMTP id w3-20020a056902100300b00b8c0a9cac6cmr15191612ybt.4.1682956438814;
        Mon, 01 May 2023 08:53:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a82-20020a251a55000000b00b8f3e224dcesm906885yba.13.2023.05.01.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:53:58 -0700 (PDT)
Date:   Mon, 1 May 2023 11:53:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 4/7] contrib/credential: remove 'gnome-keyring' credential
 helper
Message-ID: <aebc4f7794a7b423ebcf22389530b3de1adfd1fe.1682956419.git.me@ttaylorr.com>
References: <cover.1682956419.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682956419.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

libgnome-keyring was deprecated in 2014 (in favor of libsecret), more
than nine years ago [1].

The credential helper implemented using libgnome-keyring has had a small
handful of commits since 2013, none of which implemented or changed any
functionality. The last commit to do substantial work in this area was
15f7221686 (contrib/git-credential-gnome-keyring.c: support really
ancient gnome-keyring, 2013-09-23), just shy of nine years ago.

This credential helper suffers from the same `fgets()`-related injection
attack (using the new "wwwauth[]" feature) as in the previous commit.
Instead of patching it, let's remove this helper as deprecated.

[1]: https://mail.gnome.org/archives/commits-list/2014-January/msg01585.html

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/credential/gnome-keyring/.gitignore   |   1 -
 contrib/credential/gnome-keyring/Makefile     |  25 -
 .../git-credential-gnome-keyring.c            | 470 ------------------
 3 files changed, 496 deletions(-)
 delete mode 100644 contrib/credential/gnome-keyring/.gitignore
 delete mode 100644 contrib/credential/gnome-keyring/Makefile
 delete mode 100644 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c

diff --git a/contrib/credential/gnome-keyring/.gitignore b/contrib/credential/gnome-keyring/.gitignore
deleted file mode 100644
index 88d8fcdbce..0000000000
--- a/contrib/credential/gnome-keyring/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-git-credential-gnome-keyring
diff --git a/contrib/credential/gnome-keyring/Makefile b/contrib/credential/gnome-keyring/Makefile
deleted file mode 100644
index 22c19df94b..0000000000
--- a/contrib/credential/gnome-keyring/Makefile
+++ /dev/null
@@ -1,25 +0,0 @@
-MAIN:=git-credential-gnome-keyring
-all:: $(MAIN)
-
-CC = gcc
-RM = rm -f
-CFLAGS = -g -O2 -Wall
-PKG_CONFIG = pkg-config
-
--include ../../../config.mak.autogen
--include ../../../config.mak
-
-INCS:=$(shell $(PKG_CONFIG) --cflags gnome-keyring-1 glib-2.0)
-LIBS:=$(shell $(PKG_CONFIG) --libs gnome-keyring-1 glib-2.0)
-
-SRCS:=$(MAIN).c
-OBJS:=$(SRCS:.c=.o)
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(INCS) -o $@ -c $<
-
-$(MAIN): $(OBJS)
-	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
-
-clean:
-	@$(RM) $(MAIN) $(OBJS)
diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
deleted file mode 100644
index 5927e27ae6..0000000000
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ /dev/null
@@ -1,470 +0,0 @@
-/*
- * Copyright (C) 2011 John Szakmeister <john@szakmeister.net>
- *               2012 Philipp A. Hartmann <pah@qo.cx>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-/*
- * Credits:
- * - GNOME Keyring API handling originally written by John Szakmeister
- * - ported to credential helper API by Philipp A. Hartmann
- */
-
-#include <stdio.h>
-#include <string.h>
-#include <stdlib.h>
-#include <glib.h>
-#include <gnome-keyring.h>
-
-#ifdef GNOME_KEYRING_DEFAULT
-
-   /* Modern gnome-keyring */
-
-#include <gnome-keyring-memory.h>
-
-#else
-
-   /*
-    * Support ancient gnome-keyring, circ. RHEL 5.X.
-    * GNOME_KEYRING_DEFAULT seems to have been introduced with Gnome 2.22,
-    * and the other features roughly around Gnome 2.20, 6 months before.
-    * Ubuntu 8.04 used Gnome 2.22 (I think).  Not sure any distro used 2.20.
-    * So the existence/non-existence of GNOME_KEYRING_DEFAULT seems like
-    * a decent thing to use as an indicator.
-    */
-
-#define GNOME_KEYRING_DEFAULT NULL
-
-/*
- * ancient gnome-keyring returns DENIED when an entry is not found.
- * Setting NO_MATCH to DENIED will prevent us from reporting DENIED
- * errors during get and erase operations, but we will still report
- * DENIED errors during a store.
- */
-#define GNOME_KEYRING_RESULT_NO_MATCH GNOME_KEYRING_RESULT_DENIED
-
-#define gnome_keyring_memory_alloc g_malloc
-#define gnome_keyring_memory_free gnome_keyring_free_password
-#define gnome_keyring_memory_strdup g_strdup
-
-static const char *gnome_keyring_result_to_message(GnomeKeyringResult result)
-{
-	switch (result) {
-	case GNOME_KEYRING_RESULT_OK:
-		return "OK";
-	case GNOME_KEYRING_RESULT_DENIED:
-		return "Denied";
-	case GNOME_KEYRING_RESULT_NO_KEYRING_DAEMON:
-		return "No Keyring Daemon";
-	case GNOME_KEYRING_RESULT_ALREADY_UNLOCKED:
-		return "Already UnLocked";
-	case GNOME_KEYRING_RESULT_NO_SUCH_KEYRING:
-		return "No Such Keyring";
-	case GNOME_KEYRING_RESULT_BAD_ARGUMENTS:
-		return "Bad Arguments";
-	case GNOME_KEYRING_RESULT_IO_ERROR:
-		return "IO Error";
-	case GNOME_KEYRING_RESULT_CANCELLED:
-		return "Cancelled";
-	case GNOME_KEYRING_RESULT_ALREADY_EXISTS:
-		return "Already Exists";
-	default:
-		return "Unknown Error";
-	}
-}
-
-/*
- * Support really ancient gnome-keyring, circ. RHEL 4.X.
- * Just a guess for the Glib version.  Glib 2.8 was roughly Gnome 2.12 ?
- * Which was released with gnome-keyring 0.4.3 ??
- */
-#if GLIB_MAJOR_VERSION == 2 && GLIB_MINOR_VERSION < 8
-
-static void gnome_keyring_done_cb(GnomeKeyringResult result, gpointer user_data)
-{
-	gpointer *data = (gpointer *)user_data;
-	int *done = (int *)data[0];
-	GnomeKeyringResult *r = (GnomeKeyringResult *)data[1];
-
-	*r = result;
-	*done = 1;
-}
-
-static void wait_for_request_completion(int *done)
-{
-	GMainContext *mc = g_main_context_default();
-	while (!*done)
-		g_main_context_iteration(mc, TRUE);
-}
-
-static GnomeKeyringResult gnome_keyring_item_delete_sync(const char *keyring, guint32 id)
-{
-	int done = 0;
-	GnomeKeyringResult result;
-	gpointer data[] = { &done, &result };
-
-	gnome_keyring_item_delete(keyring, id, gnome_keyring_done_cb, data,
-		NULL);
-
-	wait_for_request_completion(&done);
-
-	return result;
-}
-
-#endif
-#endif
-
-/*
- * This credential struct and API is simplified from git's credential.{h,c}
- */
-struct credential {
-	char *protocol;
-	char *host;
-	unsigned short port;
-	char *path;
-	char *username;
-	char *password;
-};
-
-#define CREDENTIAL_INIT { 0 }
-
-typedef int (*credential_op_cb)(struct credential *);
-
-struct credential_operation {
-	char *name;
-	credential_op_cb op;
-};
-
-#define CREDENTIAL_OP_END { NULL, NULL }
-
-/* ----------------- GNOME Keyring functions ----------------- */
-
-/* create a special keyring option string, if path is given */
-static char *keyring_object(struct credential *c)
-{
-	if (!c->path)
-		return NULL;
-
-	if (c->port)
-		return g_strdup_printf("%s:%hd/%s", c->host, c->port, c->path);
-
-	return g_strdup_printf("%s/%s", c->host, c->path);
-}
-
-static int keyring_get(struct credential *c)
-{
-	char *object = NULL;
-	GList *entries;
-	GnomeKeyringNetworkPasswordData *password_data;
-	GnomeKeyringResult result;
-
-	if (!c->protocol || !(c->host || c->path))
-		return EXIT_FAILURE;
-
-	object = keyring_object(c);
-
-	result = gnome_keyring_find_network_password_sync(
-				c->username,
-				NULL /* domain */,
-				c->host,
-				object,
-				c->protocol,
-				NULL /* authtype */,
-				c->port,
-				&entries);
-
-	g_free(object);
-
-	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
-		return EXIT_SUCCESS;
-
-	if (result == GNOME_KEYRING_RESULT_CANCELLED)
-		return EXIT_SUCCESS;
-
-	if (result != GNOME_KEYRING_RESULT_OK) {
-		g_critical("%s", gnome_keyring_result_to_message(result));
-		return EXIT_FAILURE;
-	}
-
-	/* pick the first one from the list */
-	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
-
-	gnome_keyring_memory_free(c->password);
-	c->password = gnome_keyring_memory_strdup(password_data->password);
-
-	if (!c->username)
-		c->username = g_strdup(password_data->user);
-
-	gnome_keyring_network_password_list_free(entries);
-
-	return EXIT_SUCCESS;
-}
-
-
-static int keyring_store(struct credential *c)
-{
-	guint32 item_id;
-	char *object = NULL;
-	GnomeKeyringResult result;
-
-	/*
-	 * Sanity check that what we are storing is actually sensible.
-	 * In particular, we can't make a URL without a protocol field.
-	 * Without either a host or pathname (depending on the scheme),
-	 * we have no primary key. And without a username and password,
-	 * we are not actually storing a credential.
-	 */
-	if (!c->protocol || !(c->host || c->path) ||
-	    !c->username || !c->password)
-		return EXIT_FAILURE;
-
-	object = keyring_object(c);
-
-	result = gnome_keyring_set_network_password_sync(
-				GNOME_KEYRING_DEFAULT,
-				c->username,
-				NULL /* domain */,
-				c->host,
-				object,
-				c->protocol,
-				NULL /* authtype */,
-				c->port,
-				c->password,
-				&item_id);
-
-	g_free(object);
-
-	if (result != GNOME_KEYRING_RESULT_OK &&
-	    result != GNOME_KEYRING_RESULT_CANCELLED) {
-		g_critical("%s", gnome_keyring_result_to_message(result));
-		return EXIT_FAILURE;
-	}
-
-	return EXIT_SUCCESS;
-}
-
-static int keyring_erase(struct credential *c)
-{
-	char *object = NULL;
-	GList *entries;
-	GnomeKeyringNetworkPasswordData *password_data;
-	GnomeKeyringResult result;
-
-	/*
-	 * Sanity check that we actually have something to match
-	 * against. The input we get is a restrictive pattern,
-	 * so technically a blank credential means "erase everything".
-	 * But it is too easy to accidentally send this, since it is equivalent
-	 * to empty input. So explicitly disallow it, and require that the
-	 * pattern have some actual content to match.
-	 */
-	if (!c->protocol && !c->host && !c->path && !c->username)
-		return EXIT_FAILURE;
-
-	object = keyring_object(c);
-
-	result = gnome_keyring_find_network_password_sync(
-				c->username,
-				NULL /* domain */,
-				c->host,
-				object,
-				c->protocol,
-				NULL /* authtype */,
-				c->port,
-				&entries);
-
-	g_free(object);
-
-	if (result == GNOME_KEYRING_RESULT_NO_MATCH)
-		return EXIT_SUCCESS;
-
-	if (result == GNOME_KEYRING_RESULT_CANCELLED)
-		return EXIT_SUCCESS;
-
-	if (result != GNOME_KEYRING_RESULT_OK) {
-		g_critical("%s", gnome_keyring_result_to_message(result));
-		return EXIT_FAILURE;
-	}
-
-	/* pick the first one from the list (delete all matches?) */
-	password_data = (GnomeKeyringNetworkPasswordData *)entries->data;
-
-	result = gnome_keyring_item_delete_sync(
-		password_data->keyring, password_data->item_id);
-
-	gnome_keyring_network_password_list_free(entries);
-
-	if (result != GNOME_KEYRING_RESULT_OK) {
-		g_critical("%s", gnome_keyring_result_to_message(result));
-		return EXIT_FAILURE;
-	}
-
-	return EXIT_SUCCESS;
-}
-
-/*
- * Table with helper operation callbacks, used by generic
- * credential helper main function.
- */
-static struct credential_operation const credential_helper_ops[] = {
-	{ "get",   keyring_get },
-	{ "store", keyring_store },
-	{ "erase", keyring_erase },
-	CREDENTIAL_OP_END
-};
-
-/* ------------------ credential functions ------------------ */
-
-static void credential_init(struct credential *c)
-{
-	memset(c, 0, sizeof(*c));
-}
-
-static void credential_clear(struct credential *c)
-{
-	g_free(c->protocol);
-	g_free(c->host);
-	g_free(c->path);
-	g_free(c->username);
-	gnome_keyring_memory_free(c->password);
-
-	credential_init(c);
-}
-
-static int credential_read(struct credential *c)
-{
-	char *buf;
-	size_t line_len;
-	char *key;
-	char *value;
-
-	key = buf = gnome_keyring_memory_alloc(1024);
-
-	while (fgets(buf, 1024, stdin)) {
-		line_len = strlen(buf);
-
-		if (line_len && buf[line_len-1] == '\n')
-			buf[--line_len] = '\0';
-
-		if (!line_len)
-			break;
-
-		value = strchr(buf, '=');
-		if (!value) {
-			g_warning("invalid credential line: %s", key);
-			gnome_keyring_memory_free(buf);
-			return -1;
-		}
-		*value++ = '\0';
-
-		if (!strcmp(key, "protocol")) {
-			g_free(c->protocol);
-			c->protocol = g_strdup(value);
-		} else if (!strcmp(key, "host")) {
-			g_free(c->host);
-			c->host = g_strdup(value);
-			value = strrchr(c->host, ':');
-			if (value) {
-				*value++ = '\0';
-				c->port = atoi(value);
-			}
-		} else if (!strcmp(key, "path")) {
-			g_free(c->path);
-			c->path = g_strdup(value);
-		} else if (!strcmp(key, "username")) {
-			g_free(c->username);
-			c->username = g_strdup(value);
-		} else if (!strcmp(key, "password")) {
-			gnome_keyring_memory_free(c->password);
-			c->password = gnome_keyring_memory_strdup(value);
-			while (*value)
-				*value++ = '\0';
-		}
-		/*
-		 * Ignore other lines; we don't know what they mean, but
-		 * this future-proofs us when later versions of git do
-		 * learn new lines, and the helpers are updated to match.
-		 */
-	}
-
-	gnome_keyring_memory_free(buf);
-
-	return 0;
-}
-
-static void credential_write_item(FILE *fp, const char *key, const char *value)
-{
-	if (!value)
-		return;
-	fprintf(fp, "%s=%s\n", key, value);
-}
-
-static void credential_write(const struct credential *c)
-{
-	/* only write username/password, if set */
-	credential_write_item(stdout, "username", c->username);
-	credential_write_item(stdout, "password", c->password);
-}
-
-static void usage(const char *name)
-{
-	struct credential_operation const *try_op = credential_helper_ops;
-	const char *basename = strrchr(name, '/');
-
-	basename = (basename) ? basename + 1 : name;
-	fprintf(stderr, "usage: %s <", basename);
-	while (try_op->name) {
-		fprintf(stderr, "%s", (try_op++)->name);
-		if (try_op->name)
-			fprintf(stderr, "%s", "|");
-	}
-	fprintf(stderr, "%s", ">\n");
-}
-
-int main(int argc, char *argv[])
-{
-	int ret = EXIT_SUCCESS;
-
-	struct credential_operation const *try_op = credential_helper_ops;
-	struct credential cred = CREDENTIAL_INIT;
-
-	if (!argv[1]) {
-		usage(argv[0]);
-		exit(EXIT_FAILURE);
-	}
-
-	g_set_application_name("Git Credential Helper");
-
-	/* lookup operation callback */
-	while (try_op->name && strcmp(argv[1], try_op->name))
-		try_op++;
-
-	/* unsupported operation given -- ignore silently */
-	if (!try_op->name || !try_op->op)
-		goto out;
-
-	ret = credential_read(&cred);
-	if (ret)
-		goto out;
-
-	/* perform credential operation */
-	ret = (*try_op->op)(&cred);
-
-	credential_write(&cred);
-
-out:
-	credential_clear(&cred);
-	return ret;
-}
-- 
2.40.1.452.gb3cd41c833

