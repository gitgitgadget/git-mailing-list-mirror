Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDDAC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B273D20760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzR/3kzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFJU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFJU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32956C03E96F
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p22so3841075ybg.21
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oil4WVsXtIFy+sPw8yRE5G9BdkdInQYgqdpIbOOmjl4=;
        b=pzR/3kzdE3eCB/FKDKMZz4v0sEwlLR30t15keXZJMJ2ZL0yggJIJeTBCDduhcX97y4
         vhRN5edzmStRA8qxq7KPaFmijL5ETdg0plpVc3j+eFCng1u9D443Wi8x/qDhaK6xnQYG
         3ZNRSTtwwT3lHdmtdmQVS65G0CwuzUEfviHqLfO18OBWhkIG6SSDTCaI2sO/2qymY0LW
         AB5oIoEeY9knrkqa/3F5wdIjGmMVJ7ZOdNcIw6/rKXhqlBoWhpSJ6s9y6LbJydtgRof5
         lEzL8VOfLdK1+MDDHk/ezgWQgEhMT4QrpQpY9ai6Ajf1uiueLKCO9ghNAmah2oKg56lm
         qQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oil4WVsXtIFy+sPw8yRE5G9BdkdInQYgqdpIbOOmjl4=;
        b=t95sCTtMDV6LqlQq5JjSUaXrY4kgGRgs+6cmsKssfVbliDc73Nyztpx7MgVS0dQcnE
         DOteNFpCrO+o5bRhTHhOKdJpqJRXJc6z3neFx80rYI4yPmVumkoVK8bnoxGJpc5PtlOZ
         6NrYEr1P7vJ5sDotbNXoaRlbgB4jUJ4Taz+NLj7ydim8Ic7/ag/qPXNnMQHTYHH+i59R
         c7XgdeXmMJqnZGTUoI+ZeVGZvu9y3Moeoyfr7WZ5UXlpyr6y6rK6Ajrjt1BMyVYrBT/e
         wEGgDdeOhtDHjrq9+lm576TDnBXUQeiqR06rLk1oHbAj68U+kcJYBnfqv1xS6LXAjN5U
         K45w==
X-Gm-Message-State: AOAM532GfU4+UxxkkgWZytXR6rPkrKj5M3P/CN+YSYGdQFzp85d9ycnr
        1QQ27DbboipGmcXyUX+IUYPge5MKOhOHAaNPw586P2RL40X8NVliWhspvxJXyVg1cjnE+SemQp3
        GYJhWgDGlHI3wCXdc71UlrYetM/MXJC6Nvg7Ep1sAlokvo7aXvLNo4FV6mU6L45xtCWLr4Pbh+6
        IX
X-Google-Smtp-Source: ABdhPJze3mvCEWJBihXiOKE0L95Q1mzLn7bX9VzCKgqB7fmCOYtfFf9U/FO3VxWwxXZ+510VP16YDZKX6jthnzirD42v
X-Received: by 2002:a25:50cc:: with SMTP id e195mr8887786ybb.483.1591822651373;
 Wed, 10 Jun 2020 13:57:31 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:16 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <048f6845669570edbf7de3da7f496c4e96592aad.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 2/9] http: refactor finish_http_pack_request()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

finish_http_pack_request() does multiple tasks, including some
housekeeping on a struct packed_git - (1) closing its index, (2)
removing it from a list, and (3) installing it. These concerns are
independent of fetching a pack through HTTP: they are there only because
(1) the calling code opens the pack's index before deciding to fetch it,
(2) the calling code maintains a list of packfiles that can be fetched,
and (3) the calling code fetches it in order to make use of its objects
in the same process.

In preparation for a subsequent commit, which adds a feature that does
not need any of this housekeeping, remove (1), (2), and (3) from
finish_http_pack_request(). (2) and (3) are now done by a helper
function, and (1) is the responsibility of the caller (in this patch,
done closer to the point where the pack index is opened).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http-push.c   |  8 ++++++--
 http-walker.c |  5 +++--
 http.c        | 31 ++++++++++++++++---------------
 http.h        | 13 ++++++++++---
 4 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/http-push.c b/http-push.c
index 822f326599..ac7868ffee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -117,6 +117,7 @@ enum transfer_state {
 
 struct transfer_request {
 	struct object *obj;
+	struct packed_git *target;
 	char *url;
 	char *dest;
 	struct remote_lock *lock;
@@ -314,17 +315,18 @@ static void start_fetch_packed(struct transfer_request *request)
 		release_request(request);
 		return;
 	}
+	close_pack_index(target);
+	request->target = target;
 
 	fprintf(stderr,	"Fetching pack %s\n",
 		hash_to_hex(target->hash));
 	fprintf(stderr, " which contains %s\n", oid_to_hex(&request->obj->oid));
 
-	preq = new_http_pack_request(target, repo->url);
+	preq = new_http_pack_request(target->hash, repo->url);
 	if (preq == NULL) {
 		repo->can_update_info_refs = 0;
 		return;
 	}
-	preq->lst = &repo->packs;
 
 	/* Make sure there isn't another open request for this pack */
 	while (check_request) {
@@ -597,6 +599,8 @@ static void finish_request(struct transfer_request *request)
 		}
 		if (fail)
 			repo->can_update_info_refs = 0;
+		else
+			http_install_packfile(request->target, &repo->packs);
 		release_request(request);
 	}
 }
diff --git a/http-walker.c b/http-walker.c
index fe15e325fa..4fb1235cd4 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -439,6 +439,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 	target = find_sha1_pack(sha1, repo->packs);
 	if (!target)
 		return -1;
+	close_pack_index(target);
 
 	if (walker->get_verbosely) {
 		fprintf(stderr, "Getting pack %s\n",
@@ -447,10 +448,9 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 			hash_to_hex(sha1));
 	}
 
-	preq = new_http_pack_request(target, repo->base);
+	preq = new_http_pack_request(target->hash, repo->base);
 	if (preq == NULL)
 		goto abort;
-	preq->lst = &repo->packs;
 	preq->slot->results = &results;
 
 	if (start_active_slot(preq->slot)) {
@@ -469,6 +469,7 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigne
 	release_http_pack_request(preq);
 	if (ret)
 		return ret;
+	http_install_packfile(target, &repo->packs);
 
 	return 0;
 
diff --git a/http.c b/http.c
index 39cbd56702..4f6e1fb018 100644
--- a/http.c
+++ b/http.c
@@ -2268,22 +2268,13 @@ void release_http_pack_request(struct http_pack_request *preq)
 
 int finish_http_pack_request(struct http_pack_request *preq)
 {
-	struct packed_git **lst;
-	struct packed_git *p = preq->target;
 	struct child_process ip = CHILD_PROCESS_INIT;
 	int tmpfile_fd;
 	int ret = 0;
 
-	close_pack_index(p);
-
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 
-	lst = preq->lst;
-	while (*lst != p)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
-
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
 	argv_array_push(&ip.args, "index-pack");
@@ -2297,15 +2288,26 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		goto cleanup;
 	}
 
-	install_packed_git(the_repository, p);
 cleanup:
 	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
 	return ret;
 }
 
+void http_install_packfile(struct packed_git *p,
+			   struct packed_git **list_to_remove_from)
+{
+	struct packed_git **lst = list_to_remove_from;
+
+	while (*lst != p)
+		lst = &((*lst)->next);
+	*lst = (*lst)->next;
+
+	install_packed_git(the_repository, p);
+}
+
 struct http_pack_request *new_http_pack_request(
-	struct packed_git *target, const char *base_url)
+	const unsigned char *packed_git_hash, const char *base_url)
 {
 	off_t prev_posn = 0;
 	struct strbuf buf = STRBUF_INIT;
@@ -2313,14 +2315,13 @@ struct http_pack_request *new_http_pack_request(
 
 	preq = xcalloc(1, sizeof(*preq));
 	strbuf_init(&preq->tmpfile, 0);
-	preq->target = target;
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		hash_to_hex(target->hash));
+		hash_to_hex(packed_git_hash));
 	preq->url = strbuf_detach(&buf, NULL);
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->hash));
+	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(packed_git_hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
@@ -2344,7 +2345,7 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				hash_to_hex(target->hash),
+				hash_to_hex(packed_git_hash),
 				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
diff --git a/http.h b/http.h
index 5e0ad724f9..bbc6b070f1 100644
--- a/http.h
+++ b/http.h
@@ -216,18 +216,25 @@ int http_get_info_packs(const char *base_url,
 
 struct http_pack_request {
 	char *url;
-	struct packed_git *target;
-	struct packed_git **lst;
 	FILE *packfile;
 	struct strbuf tmpfile;
 	struct active_request_slot *slot;
 };
 
 struct http_pack_request *new_http_pack_request(
-	struct packed_git *target, const char *base_url);
+	const unsigned char *packed_git_hash, const char *base_url);
 int finish_http_pack_request(struct http_pack_request *preq);
 void release_http_pack_request(struct http_pack_request *preq);
 
+/*
+ * Remove p from the given list, and invoke install_packed_git() on it.
+ *
+ * This is a convenience function for users that have obtained a list of packs
+ * from http_get_info_packs() and have chosen a specific pack to fetch.
+ */
+void http_install_packfile(struct packed_git *p,
+			   struct packed_git **list_to_remove_from);
+
 /* Helpers for fetching object */
 struct http_object_request {
 	char *url;
-- 
2.27.0.278.ge193c7cf3a9-goog

