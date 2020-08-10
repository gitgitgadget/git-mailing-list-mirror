Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA0FC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22D220734
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Uk+mPO7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHJVfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHJVfv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:35:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050C4C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s16so7982769qtn.7
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rw4A1c5Qr5hHagunbyoBniK9C8/HmVggraJ+NBd3OcA=;
        b=Uk+mPO7pGzZF3gblALHy74ToBGwUzFena7h4SevbEuXhn9oIOW5toKSkyE3H5vXg/N
         e9RZkE3O73BDCehquS7WN7lX+fIl7Y6+NHkJL4z0l6hotPpjvgRiGb2/0wCs7FIe0lMz
         1xJY8HbJzlk5TiQZJXmIwO2JLYVE8XWdIQcRVdQAoBnC9yMm2qIs2giwJkJodXABDGZI
         Fpun1eDjcy3rq/AZF8yA3NoqhZAP87LM6N/VO0W+k77rhgXMXmwGC75N0Y3yctuk+Zl6
         BJVVB4lBtSj5phdUNkchyiIpLCT1VdV2AeKLEAB5vXZbht8O0GgRp8gUOwqUIJslWgL0
         kwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rw4A1c5Qr5hHagunbyoBniK9C8/HmVggraJ+NBd3OcA=;
        b=ZA/HKv1Z3b526jnF4p7Zx6Nbg4ijYTU2heVV/7ugBtFXskbJMeDe/l5zLRmu6ToZ8Q
         QWPUBr0FKIduw9+vkI4jhV7ZERdB3Pnig6+PVDKWjhCENo3QiEI/3DeinkrEIY1sLc4i
         u+mbzPjK0JYVV1dQaH8AC1J463NTU2wamea0vecRCytubuVDtiG4ki7qDuXG90EcJQ4I
         53tN1XBgXRoVsrd7Tu+F9KzGPxcNwtorvFEfjCq2n+hddC/JLtqrnysioI9ro2WbKYf8
         0qO+UgCFDjJaBhJf1GBbEOtvvFdQkM+EFNUv5QbJBaHkIWmDk9Us5LjEYs1vDbPJt77H
         DKtw==
X-Gm-Message-State: AOAM530pXGnj5qN6h0ENzDQWv8ovdHqtpnIsk/8kLkw+YlGoc/yzzhGK
        v+TymHnEHivSF2JaQ5U5wVtgiZ7rfVk=
X-Google-Smtp-Source: ABdhPJzxkYBJFYgdbKoYi7s85gGtifZBBIq6Bj9ZZ8wkDvBtgWi86GqKygiMY8zkXHMqbINaSp3BfA==
X-Received: by 2002:ac8:4b78:: with SMTP id g24mr29917028qts.248.1597095348694;
        Mon, 10 Aug 2020 14:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:35:47 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC PATCH 20/21] parallel-checkout: create leading dirs in workers
Date:   Mon, 10 Aug 2020 18:33:28 -0300
Message-Id: <d9e8bad5d4e6cf3c44c6e48d28c40536afcba115.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow the parallel workers to create the leading directories of the
entries being checked out, instead of pre-creating them in the main
process. This optimization should be more effective on file systems with
higher I/O latency.

Part of the process of creating leading dirs is the removal of any
non-directory file that could be in the way. This is currently done
inside entry.c:create_directories(). However, if we were to move this to
the workers as well, we would risk removing a file just written by
another worker, which collided with the one currently being written.  In
a worse scenario, we could remove the file right after a worker have
closed it but before it called stat(). To avoid these problems, let's
remove the non-directory files in the main process. And to avoid the
cost of extra lstat() calls in this process, we use
has_dirs_only_path(), which will have the necessary information already
cached from check_path().

Finally, to create the leading dirs in the workers, we could re-use
create_directories(). But, unlike the main process, we wouldn't have the
stat() information cached. Thus, let's use raceproof_create_file(),
which will only stat() the path components after a open() failure,
saving us time when creating subsequent files in the same directory.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c             | 45 ++++++++++++++++++++++++++++++++++++++++++---
 parallel-checkout.c | 42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index e876adff19..5dfd4d150d 100644
--- a/entry.c
+++ b/entry.c
@@ -57,6 +57,43 @@ static void create_directories(const char *path, int path_len,
 	free(buf);
 }
 
+static void remove_non_dirs(const char *path, int path_len,
+			    const struct checkout *state)
+{
+	char *buf = xmallocz(path_len);
+	int len = 0;
+
+	while (len < path_len) {
+		int ret;
+
+		do {
+			buf[len] = path[len];
+			len++;
+		} while (len < path_len && !is_dir_sep(path[len]));
+		if (len >= path_len)
+			break;
+		buf[len] = 0;
+
+		ret = has_dirs_only_path(buf, len, state->base_dir_len);
+
+		if (ret > 0)
+			continue; /* Is directory. */
+		if (ret < 0)
+			break; /* No entry */
+
+		/* ret == 0: not a directory, let's unlink it. */
+
+		if (!state->force)
+			die("'%s' already exists, and it's not a directory", buf);
+
+		if (unlink(buf))
+			die_errno("cannot unlink '%s'", buf);
+		else
+			break;
+	}
+	free(buf);
+}
+
 static void remove_subtree(struct strbuf *path)
 {
 	DIR *dir = opendir(path->buf);
@@ -555,8 +592,6 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 	} else if (state->not_new)
 		return 0;
 
-	create_directories(path.buf, path.len, state);
-
 	if (nr_checkouts)
 		(*nr_checkouts)++;
 
@@ -565,9 +600,13 @@ int checkout_entry_ca(struct cache_entry *ce, struct conv_attrs *ca,
 		ca = &ca_buf;
 	}
 
-	if (!enqueue_checkout(ce, ca))
+	if (!enqueue_checkout(ce, ca)) {
+		/* "clean" path so that workers can create leading dirs */
+		remove_non_dirs(path.buf, path.len, state);
 		return 0;
+	}
 
+	create_directories(path.buf, path.len, state);
 	return write_entry(ce, path.buf, ca, state, 0);
 }
 
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 4d72540256..5b73d8fa4b 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -298,20 +298,48 @@ static int close_and_clear(int *fd)
 	return ret;
 }
 
+struct ci_open_data {
+	int fd;
+	unsigned int mode;
+};
+
+static int ci_open(const char *path, void *cb)
+{
+	struct ci_open_data *data = cb;
+	data->fd = open(path, O_WRONLY | O_CREAT | O_EXCL, data->mode);
+
+	if (data->fd < 0) {
+		/*
+		 * EISDIR can only indicate path collisions among the entries
+		 * being checked out. We don't need raceproof_create_file() to
+		 * try removing empty dirs. Instead, just let the caller known
+		 * that the path already exists, so that the collision can be
+		 * properly handled later.
+		 */
+		if (errno == EISDIR)
+			errno = EEXIST;
+		return 1;
+	}
+
+	return 0;
+}
+
 void write_checkout_item(struct checkout *state, struct checkout_item *ci)
 {
-	unsigned int mode = (ci->ce->ce_mode & 0100) ? 0777 : 0666;
+	struct ci_open_data open_data;
 	int fd = -1, fstat_done = 0;
 	struct strbuf path = STRBUF_INIT;
 
+	open_data.mode = (ci->ce->ce_mode & 0100) ? 0777 : 0666;
 	strbuf_add(&path, state->base_dir, state->base_dir_len);
 	strbuf_add(&path, ci->ce->name, ci->ce->ce_namelen);
 
-	fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, mode);
-
-	if (fd < 0) {
-		if (errno == EEXIST || errno == EISDIR || errno == ENOENT ||
-		    errno == ENOTDIR) {
+	/*
+	 * The main process already removed any non-directory file that was in
+	 * the way. So if we find one, it's a path collision.
+	 */
+	if (raceproof_create_file(path.buf, ci_open, &open_data)) {
+		if (errno == EEXIST || errno == ENOTDIR || errno == ENOENT) {
 			/*
 			 * Errors which probably represent a path collision.
 			 * Suppress the error message and mark the ci to be
@@ -325,6 +353,8 @@ void write_checkout_item(struct checkout *state, struct checkout_item *ci)
 		goto out;
 	}
 
+	fd = open_data.fd;
+
 	if (write_checkout_item_to_fd(fd, state, ci, path.buf)) {
 		/* Error was already reported. */
 		ci->status = CI_FAILED;
-- 
2.27.0

