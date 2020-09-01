Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A06C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05AA8207EA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 22:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HgQDCqrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgIAW2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgIAW2R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 18:28:17 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE73C061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 15:28:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o9so1278709pjg.7
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 15:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bo88HJaa/DEQoDRXgGAhU6j3Jv3roE7aYWdXNJ+n32k=;
        b=HgQDCqrRSr5JdjEtWefiZtmffPsGRuzNF0cUkW51mVnr40RaGLibpwFNARYbH9Zs3O
         unQVP0ht38ULL652QSjlnNnCT8CQGmXdnIIOipZ0LikRXOAZ8eVU3yQGZ+EYad8t7/Vv
         kMNZV7v8cagmTQREbhSEHYetmPXt0Ugf1NX+AbJDKMOYWMFk12fVaL0p6W3iB8ldb+5k
         gW1cp3LzfM4LGVetIQoWBDSQfuhVmjEpaHbzucwvKyPGkGAKHogX4PwvkI7OsSoQn0bH
         YnPSmkWmtJEo8AVy6ZuGWDgJGFYQZP0fjAXF6yU9OcyoPuo7brzkuM8q3OWs0HJTkKiv
         8bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bo88HJaa/DEQoDRXgGAhU6j3Jv3roE7aYWdXNJ+n32k=;
        b=GlvdEpQqudn8A8jg6/q9LHSkHqz0k1KXB0PNrA4kWyMdikcV15oPTJEZmZ4s3bC/kL
         OdJ1/M0/6cPDINDj+0LfbvVxPrCSdX6miHr5EJXwV8TH/OCFZd3MucadvWZ5oyArFLAp
         QC19kLSBfZ3lYASBH3xx+jO3iKamIWy0wqHqbQeGPRTABeGvjIDGw3/CFoAzypPnpaxE
         vc24Tqlms6koqgMs5i9CxI4MX2C25rbuPlJFm7dKVaDbcIDyLQtma8saee0VlCwcCerh
         j8d1ApL/E522l4d2+QOzzmh5exmkxkpJe2r7diqHk+FtwHuDqeThlYyXzeArbO/lYgGF
         j8/g==
X-Gm-Message-State: AOAM530WLv27iqTY1v2N8oNmQO0vbzj7H669DpG7LGuZH9DNkv6AhKBw
        adljzhfAtJ3bXLaSSkT94rel6kIkUX1IC88DIZvCjkn7cZ6xxP6Nc1DGKWclpkAn/Bdry8tQFHK
        7uXsmIqG4vfarbbSsk29p0L96ETRqoromp9iT/hoRgG00dY5sEaLmwx8QsLXPJFf1JCRxUOoPO2
        2Z
X-Google-Smtp-Source: ABdhPJwtShmC1PS9WY/VaxhTkzuNRtYyAPuyhWLsbD8jDJm8TEHPBroT779DbEeIXGUblt0QL4Mfaxq7xKoxdy8s9qMz
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7895:b029:cf:85ab:8d4e with
 SMTP id q21-20020a1709027895b02900cf85ab8d4emr3611070pll.1.1598999296641;
 Tue, 01 Sep 2020 15:28:16 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:28:07 -0700
In-Reply-To: <cover.1598998706.git.jonathantanmy@google.com>
Message-Id: <1ce44900a08857332ee70b916c3d9e7e76751221.1598998707.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200513004058.34456-1-jonathantanmy@google.com> <cover.1598998706.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 1/3] sha1-name: replace unsigned int with option struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
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

