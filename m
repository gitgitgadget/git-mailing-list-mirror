Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F931C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D62206DB
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 21:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkz6Vc96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfL3VKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 16:10:32 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34768 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VKc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 16:10:32 -0500
Received: by mail-pg1-f201.google.com with SMTP id t189so23428165pgd.1
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 13:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T0EXxwrmuytLXJQdjSRC8GZoD852bInomwNczSt3Lsk=;
        b=kkz6Vc96EtTKtC6mKHguFrO6NbLEl5Njj4aRdSb0BS8EgF1+p7QXA1gS4uKfj8ov8n
         cpE+C1W0SBNXzfFY3Uxi4TVPFxMUw39VNaqP0u/Y3ftf9eJjg5BXWc/KUkII7UFVDZ6b
         kAthSy6/ZDzsQWqEx4eRlutYzX+1HTV9tIdhoFtQwvtAVPjaGxiN8lyKtYUa1o/FsW1U
         YG5JYDutwp85VlgvmRjpVwIaEoNziaXgCF6DDUfkDJoMqssQD5N8NpxJRf4hkJwU7a82
         0OTQT5+QcEpjiXvDnan9g97+7P7FbUq16rVzuS5cVJCnJafKsfybrDk9leSFCQcJs8uI
         J57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T0EXxwrmuytLXJQdjSRC8GZoD852bInomwNczSt3Lsk=;
        b=EOcPOfrUkfhPD5yKLCQfV0d53fJOiqWd8BtdXkbkxJiup3H8AVs9SI45ENF/Yr1t5m
         riM0NXa/pNNrxtom0Mq7nCpdT/E7or6SwPUDxaZsVRlDGYZsjlazG/flNopagal3W/gH
         v8ogLREIqDWXG8amNMTIS0V0xGA9SEkZaMkpakfJuuHThVYLH7IUy5l7VxUacRS/0q4p
         yEsXx9vysuuZCg72t2uON1gg1Ikc8jNc/577odGpWgmpGmmrTpRxy8w/10BQkVcmhwf+
         RVpKVGXvJ6dZibwEqyO3XptIktKOhPINIBMxJIsghouJOY5IzSGbEYEsOZcDftILde07
         cDXA==
X-Gm-Message-State: APjAAAX7+50jRCtT5TH2lTx0Imr0Sdjj2Ri4jckEdAxeTtQW86wTwG4Z
        kLi40ruatMJKZokU4y5jtCAknfBVDeqvoH8wMX2Cf0xdPFbLkjU/fABoV83BUlZqaXneV0iaUZv
        Ig8o9NT6W6rvKs3tFsKcJpGIGQIfxYy9pXuHy/UO2a6ZLFb+rca4wGcMOoBRl1KZfw/tx7ZvVxg
        7V
X-Google-Smtp-Source: APXvYqzcKxVyz8U/Bks0AbTu8qRHr897YvNDC+r5396v5z8iA+KHYMThBNYxeaKbdtqWSB8LMyog+nYrkhbqDK3WcHk+
X-Received: by 2002:a63:d54f:: with SMTP id v15mr76472700pgi.64.1577740231012;
 Mon, 30 Dec 2019 13:10:31 -0800 (PST)
Date:   Mon, 30 Dec 2019 13:10:27 -0800
Message-Id: <20191230211027.37002-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, if a user provides the hash of the empty tree ("git
mktree </dev/null" - for SHA-1, this is 4b825d...) to a command which
requires that that object be parsed, for example:

  git diff-tree 4b825d <a non-empty tree>

then Git will lazily fetch the empty tree. This fetch would merely be
inconvenient if the promisor remote could supply that tree, but at
$DAYJOB we discovered that some repositories do not (e.g. [1]).

There are 2 functions: repo_has_object_file() which does not consult
find_cached_object() (which, among other things, knows about the empty
tree); and repo_read_object_file() which does. This issue occurs
because, as an optimization to avoid reading blobs into memory,
parse_object() calls repo_has_object_file() before
repo_read_object_file(). In the case of a regular repository (that is,
not a partial clone), repo_has_object_file() will return false for the
empty tree (thus bypassing the optimization) and repo_read_object_file()
will nevertheless succeed, thus things coincidentally work. But in a
partial clone, repo_has_object_file() triggers a lazy fetch of the
missing empty tree. This optimization was introduced by 090ea12671
("parse_object: avoid putting whole blob in core", 2012-03-07), and the
empty-tree special-case dichotomy between repo_has_object_file() (then,
has_sha1_file()) and repo_read_object_file() (then, sha1_object_info())
has existed since then.

(The flag OBJECT_INFO_SKIP_CACHED, introduced later in dfdd4afcf9
("sha1_file: teach sha1_object_info_extended more flags", 2017-06-26)
and used in e83e71c5e1 ("sha1_file: refactor has_sha1_file_with_flags",
2017-06-26), was introduced to preserve the empty-tree special-case
dichotomy.)

The best solution to the problem introduced at the start of this commit
message seems to be to eliminate this dichotomy. Not only will this fix
the problem, but it reduces a potential avenue of surprise for future
developers of Git - it will no longer be the case that
repo_has_object_file() doesn't know about empty trees, but
repo_read_object_file() does. A cost is that repo_has_object_file() will
now need to oideq upon each invocation, but that is trivial compared to
the filesystem lookup or the pack index search required anyway. (And if
find_cached_object() needs to do more because of previous invocations to
pretend_object_file(), all the more reason to be consistent in whether
we present cached objects.) Therefore, remove OBJECT_INFO_SKIP_CACHED.

[1] https://dart.googlesource.com/json_rpc_2

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
I put a lot of historical references which makes the commit message
rather long - let me know if you think that some can be omitted.
---
 object-store.h |  2 --
 sha1-file.c    | 38 ++++++++++++++++++--------------------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/object-store.h b/object-store.h
index 55ee639350..61b8b13e3b 100644
--- a/object-store.h
+++ b/object-store.h
@@ -292,8 +292,6 @@ struct object_info {
 #define OBJECT_INFO_LOOKUP_REPLACE 1
 /* Allow reading from a loose object file of unknown/bogus type */
 #define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not check cached storage */
-#define OBJECT_INFO_SKIP_CACHED 4
 /* Do not retry packed storage after checking packed and loose storage */
 #define OBJECT_INFO_QUICK 8
 /* Do not check loose object */
diff --git a/sha1-file.c b/sha1-file.c
index 188de57634..03ae9ae93a 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1417,6 +1417,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			     struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
+	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const struct object_id *real = oid;
@@ -1431,24 +1432,22 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 	if (!oi)
 		oi = &blank_oi;
 
-	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
-		struct cached_object *co = find_cached_object(real);
-		if (co) {
-			if (oi->typep)
-				*(oi->typep) = co->type;
-			if (oi->sizep)
-				*(oi->sizep) = co->size;
-			if (oi->disk_sizep)
-				*(oi->disk_sizep) = 0;
-			if (oi->delta_base_sha1)
-				hashclr(oi->delta_base_sha1);
-			if (oi->type_name)
-				strbuf_addstr(oi->type_name, type_name(co->type));
-			if (oi->contentp)
-				*oi->contentp = xmemdupz(co->buf, co->size);
-			oi->whence = OI_CACHED;
-			return 0;
-		}
+	co = find_cached_object(real);
+	if (co) {
+		if (oi->typep)
+			*(oi->typep) = co->type;
+		if (oi->sizep)
+			*(oi->sizep) = co->size;
+		if (oi->disk_sizep)
+			*(oi->disk_sizep) = 0;
+		if (oi->delta_base_sha1)
+			hashclr(oi->delta_base_sha1);
+		if (oi->type_name)
+			strbuf_addstr(oi->type_name, type_name(co->type));
+		if (oi->contentp)
+			*oi->contentp = xmemdupz(co->buf, co->size);
+		oi->whence = OI_CACHED;
+		return 0;
 	}
 
 	while (1) {
@@ -1932,8 +1931,7 @@ int repo_has_object_file_with_flags(struct repository *r,
 {
 	if (!startup_info->have_repository)
 		return 0;
-	return oid_object_info_extended(r, oid, NULL,
-					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
+	return oid_object_info_extended(r, oid, NULL, flags) >= 0;
 }
 
 int repo_has_object_file(struct repository *r,
-- 
2.24.1.735.g03f4e72817-goog

