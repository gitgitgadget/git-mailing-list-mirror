Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD8C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD76207BB
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 01:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fv+5vytI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH2BCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgH2BCc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 21:02:32 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1242DC06121B
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:32 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c4so613868qvq.15
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bo88HJaa/DEQoDRXgGAhU6j3Jv3roE7aYWdXNJ+n32k=;
        b=fv+5vytIgWQJNio79bDjeoD/pLVfFphcENUVoYFLLi9wjZzx0cQk0CvjZivcyznGW2
         twRMqoyKJUxhENZunSYmSNaUSAIbG2mLkGnKZoHkhf1PNGKDPTqH0JJbX5gv/GybBLnN
         Je87Ugmzb7W6P0zOInHNW/IctJQVxFHKrtl4Gm2vOav85dwdDmqFUBZQIrEefYSYV/6m
         9P7l74NY2wtvKjoDH+6fxo69B7OOkq1YgF4i8KhbCNYf3kUPyQO3Wiyc1Rf5zA8g/l1g
         x9LpXvwitbzFlNZbkyYzK+n3Q7NWBxOsY1lyzMsWNXQya25Ch3d7DwwuaKoKlloZxNoL
         EE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bo88HJaa/DEQoDRXgGAhU6j3Jv3roE7aYWdXNJ+n32k=;
        b=IeIR77azjgD6q7nK0/RhBaRWmK8IFNZHx3kM2mhCeng/+WvQKIBersj3Ui6wDnDMUV
         sX8e2jXUvjjawRzU6Yxol/UTrYdBZhPdMk90gGazKeD+k9+oosyUDgXdPCaN/BgPpzFZ
         O3wUZFCCEESwCJM3O2fh22dHuGCK24Bumjvipc1u/hXpVeZTjUZtiSk4ZWY5RAGTME+S
         L8vl01pI+btjyh85gdR4gRLhYW5v8nfyYC3DNavwWAcK+l1ayCiRqFuzgOjaZgcagiLp
         vFVy/pFnqLxv6i12THp5B/QNOPBXec4gJPYZen+PJe+iXcnE3KtVbU0fqwJD6q84Tzzz
         I6Dg==
X-Gm-Message-State: AOAM532M3jLc/hcArANsZ7xF0ROU7obsYsp9O32PA/MpbhKGSWWNDP7D
        hEqRmqLcPF7amNB7kw6RzgY6jPIu2/V9t2ms7xYTfu2WXKaLEsUZ9iYMy1EX2gw+JKULYEYICWP
        K8ZOPl42ikviuIa/nbxtkdsONa7i2vPeC4t9WWU/ujunxbULSnLbMNEQgsZ+fxqbW0+R3BovgNs
        Dt
X-Google-Smtp-Source: ABdhPJylGzoPyDsyBSWUxtPEyhCNOjGzt5dtnRAHul9VXRHHatnha2MZqfmVstOhtr+R57sQ6ypRUyHW1uO+DLEEx6wr
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:51d1:: with SMTP id
 p17mr1181868qvq.14.1598662951214; Fri, 28 Aug 2020 18:02:31 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:02:26 -0700
In-Reply-To: <cover.1598662525.git.jonathantanmy@google.com>
Message-Id: <1ce44900a08857332ee70b916c3d9e7e76751221.1598662525.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com> <cover.1598662525.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 1/2] sha1-name: replace unsigned int with option struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a future patch adding a boolean parameter to
repo_interpret_branch_name(), which might be easily confused with an
existing unsigned int parameter, refactor repo_interpret_branch_name()
to take an option struct instead of the unsigned int parameter.

The static function interpret_branch_mark() is also updated to take the
option struct in preparation for that future patch, since it will also
make use of the to-be-introduced boolean parameter.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     | 20 ++++++++++++--------
 refs.c      |  3 ++-
 revision.c  |  3 ++-
 sha1-name.c | 29 ++++++++++++++++++-----------
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index 4cad61ffa4..4f16a57ba4 100644
--- a/cache.h
+++ b/cache.h
@@ -1557,21 +1557,25 @@ int parse_oid_hex_any(const char *hex, struct object_id *oid, const char **end);
  *
  * If the input was ok but there are not N branch switches in the
  * reflog, it returns 0.
- *
- * If "allowed" is non-zero, it is a treated as a bitfield of allowable
- * expansions: local branches ("refs/heads/"), remote branches
- * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
- * allowed, even ones to refs outside of those namespaces.
  */
 #define INTERPRET_BRANCH_LOCAL (1<<0)
 #define INTERPRET_BRANCH_REMOTE (1<<1)
 #define INTERPRET_BRANCH_HEAD (1<<2)
+struct interpret_branch_name_options {
+	/*
+	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
+	 * expansions: local branches ("refs/heads/"), remote branches
+	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
+	 * allowed, even ones to refs outside of those namespaces.
+	 */
+	unsigned allowed;
+};
 int repo_interpret_branch_name(struct repository *r,
 			       const char *str, int len,
 			       struct strbuf *buf,
-			       unsigned allowed);
-#define interpret_branch_name(str, len, buf, allowed) \
-	repo_interpret_branch_name(the_repository, str, len, buf, allowed)
+			       const struct interpret_branch_name_options *options);
+#define interpret_branch_name(str, len, buf, options) \
+	repo_interpret_branch_name(the_repository, str, len, buf, options)
 
 int validate_headref(const char *ref);
 
diff --git a/refs.c b/refs.c
index 3ee3afaf41..cf09cd039f 100644
--- a/refs.c
+++ b/refs.c
@@ -601,7 +601,8 @@ static char *substitute_branch_name(struct repository *r,
 				    const char **string, int *len)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int ret = repo_interpret_branch_name(r, *string, *len, &buf, 0);
+	struct interpret_branch_name_options options = { 0 } ;
+	int ret = repo_interpret_branch_name(r, *string, *len, &buf, &options);
 
 	if (ret == *len) {
 		size_t size;
diff --git a/revision.c b/revision.c
index 96630e3186..1247ee4ec8 100644
--- a/revision.c
+++ b/revision.c
@@ -315,13 +315,14 @@ static void add_pending_object_with_path(struct rev_info *revs,
 					 const char *name, unsigned mode,
 					 const char *path)
 {
+	struct interpret_branch_name_options options = { 0 };
 	if (!obj)
 		return;
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT) {
 		struct strbuf buf = STRBUF_INIT;
-		int len = interpret_branch_name(name, 0, &buf, 0);
+		int len = interpret_branch_name(name, 0, &buf, &options);
 
 		if (0 < len && name[len] && buf.len)
 			strbuf_addstr(&buf, name + len);
diff --git a/sha1-name.c b/sha1-name.c
index 0b8cb5247a..a7a9de66c4 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1427,9 +1427,12 @@ static int reinterpret(struct repository *r,
 	struct strbuf tmp = STRBUF_INIT;
 	int used = buf->len;
 	int ret;
+	struct interpret_branch_name_options options = {
+		.allowed = allowed
+	};
 
 	strbuf_add(buf, name + len, namelen - len);
-	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, allowed);
+	ret = repo_interpret_branch_name(r, buf->buf, buf->len, &tmp, &options);
 	/* that data was not interpreted, remove our cruft */
 	if (ret < 0) {
 		strbuf_setlen(buf, used);
@@ -1471,7 +1474,7 @@ static int interpret_branch_mark(struct repository *r,
 				 int (*get_mark)(const char *, int),
 				 const char *(*get_data)(struct branch *,
 							 struct strbuf *),
-				 unsigned allowed)
+				 const struct interpret_branch_name_options *options)
 {
 	int len;
 	struct branch *branch;
@@ -1496,7 +1499,7 @@ static int interpret_branch_mark(struct repository *r,
 	if (!value)
 		die("%s", err.buf);
 
-	if (!branch_interpret_allowed(value, allowed))
+	if (!branch_interpret_allowed(value, options->allowed))
 		return -1;
 
 	set_shortened_ref(r, buf, value);
@@ -1506,7 +1509,7 @@ static int interpret_branch_mark(struct repository *r,
 int repo_interpret_branch_name(struct repository *r,
 			       const char *name, int namelen,
 			       struct strbuf *buf,
-			       unsigned allowed)
+			       const struct interpret_branch_name_options *options)
 {
 	char *at;
 	const char *start;
@@ -1515,7 +1518,7 @@ int repo_interpret_branch_name(struct repository *r,
 	if (!namelen)
 		namelen = strlen(name);
 
-	if (!allowed || (allowed & INTERPRET_BRANCH_LOCAL)) {
+	if (!options->allowed || (options->allowed & INTERPRET_BRANCH_LOCAL)) {
 		len = interpret_nth_prior_checkout(r, name, namelen, buf);
 		if (!len) {
 			return len; /* syntax Ok, not enough switches */
@@ -1523,7 +1526,8 @@ int repo_interpret_branch_name(struct repository *r,
 			if (len == namelen)
 				return len; /* consumed all */
 			else
-				return reinterpret(r, name, namelen, len, buf, allowed);
+				return reinterpret(r, name, namelen, len, buf,
+						   options->allowed);
 		}
 	}
 
@@ -1531,22 +1535,22 @@ int repo_interpret_branch_name(struct repository *r,
 	     (at = memchr(start, '@', namelen - (start - name)));
 	     start = at + 1) {
 
-		if (!allowed || (allowed & INTERPRET_BRANCH_HEAD)) {
+		if (!options->allowed || (options->allowed & INTERPRET_BRANCH_HEAD)) {
 			len = interpret_empty_at(name, namelen, at - name, buf);
 			if (len > 0)
 				return reinterpret(r, name, namelen, len, buf,
-						   allowed);
+						   options->allowed);
 		}
 
 		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    upstream_mark, branch_get_upstream,
-					    allowed);
+					    options);
 		if (len > 0)
 			return len;
 
 		len = interpret_branch_mark(r, name, namelen, at - name, buf,
 					    push_mark, branch_get_push,
-					    allowed);
+					    options);
 		if (len > 0)
 			return len;
 	}
@@ -1557,7 +1561,10 @@ int repo_interpret_branch_name(struct repository *r,
 void strbuf_branchname(struct strbuf *sb, const char *name, unsigned allowed)
 {
 	int len = strlen(name);
-	int used = interpret_branch_name(name, len, sb, allowed);
+	struct interpret_branch_name_options options = {
+		.allowed = allowed
+	};
+	int used = interpret_branch_name(name, len, sb, &options);
 
 	if (used < 0)
 		used = 0;
-- 
2.28.0.402.g5ffc5be6b7-goog

