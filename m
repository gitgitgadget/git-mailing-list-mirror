Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0DC2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6384217F4
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNoPNL2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgABUQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:16:35 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46461 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:16:35 -0500
Received: by mail-pg1-f201.google.com with SMTP id t12so27536033pgs.13
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sm16XkiBG6aotAKeMSmMmmpB3+ZX2sLt4nkdeXBooKg=;
        b=YNoPNL2ATfMJ49dqJwDCeiOBkhYg+FXY2YXEAl89B1pE2phOS07NdSUdZNbbqaD9FW
         YK6LJ3jZiCKidGdVkSvNAhwGfC+xe8dP9RE4AxzYex55H25f50yI8ZZVGUMgiTvcspME
         4hecKhJ62uNE8N4Tz7ESljewOsm9wew5nzlZ/onfW4aRzAmCSOb3OGu8p9dK8tnUyuTv
         FFAV27eoxvAtqwLODRqHLAzZ8e5vIqe6m0Z67yW9zBti48D1Z36x/rZ31+8AAxhbmz/I
         x6ye4tNSrst015QBa/1fyGuT3mSiibbHfinAZYKjAAmihEURx5svzTJmvRn1+MlrjBbT
         KypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sm16XkiBG6aotAKeMSmMmmpB3+ZX2sLt4nkdeXBooKg=;
        b=br+IYXnUY1D5jQUSncRBBbzNy5hl6yia/uNjtAWbiUq8ugyd9cusoq05dPeTW8Dw5f
         nn2fgW3iVe0/JvCAqP6ejK83V7GTWsdN57HCG04C1Un51peub09taEEtMBk+w2eKRS9m
         BU6rARxJoAGuy+Wz1NlkQ/mSK3mLS5E8DJAqYJewm5eG5SwR1JVFWnJp3jCdPWMkszRi
         /OyX5CaF6N83Ge6CckRUrmPxhkgvlIn+lpDPMbx4XD9zCmMBV+g5QInvX3VRxAZ4S+gO
         Lj+EqZZ7EaDdGQejzvAzLQVyvDYzFlZUF1gbLOyCzumB3GU0qZsympiQeKsEPrI8NL5h
         y8tg==
X-Gm-Message-State: APjAAAUlbt38Ct6XLpgsxKAtw60Apaiko02aHXdfH+6Jr39VSSimguLz
        X6vWYVGstB2nXxYMwXLzeATUzAkzvpzYgQ5IVVIsn+9+M0vgCW3w9zSJaqwblBz3qmJnBs5ZQe9
        dL82XetQyo/S3CRiT3oWKHDcsLcmhN2XgLwZPvRy0gtamBEnxUEPH1YsnsrqXpAoFQj4+ux8CsC
        tt
X-Google-Smtp-Source: APXvYqy+pL0K9ruk5z3/34rw/0A8cu7FZeB0c0aZ87f6E+m8stiWNdgkN7xDqG19C0jWiTzxHKegeMArhp4xdn9TwDCc
X-Received: by 2002:a63:1346:: with SMTP id 6mr93052364pgt.111.1577996194429;
 Thu, 02 Jan 2020 12:16:34 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:16:30 -0800
In-Reply-To: <20191230211027.37002-1-jonathantanmy@google.com>
Message-Id: <20200102201630.180969-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191230211027.37002-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a partial clone, if a user provides the hash of the empty tree ("git
mktree </dev/null" - for SHA-1, this is 4b825d...) to a command which
requires that that object be parsed, for example:

  git diff-tree 4b825d <a non-empty tree>

then Git will lazily fetch the empty tree, unnecessarily, because
parsing of that object invokes repo_has_object_file(), which does not
special-case the empty tree.

Instead, teach repo_has_object_file() to consult find_cached_object()
(which handles the empty tree), thus bringing it in line with the rest
of the object-store-accessing functions. A cost is that
repo_has_object_file() will now need to oideq upon each invocation, but
that is trivial compared to the filesystem lookup or the pack index
search required anyway. (And if find_cached_object() needs to do more
because of previous invocations to pretend_object_file(), all the more
reason to be consistent in whether we present cached objects.)

As a historical note, the function now known as repo_read_object_file()
was taught the empty tree in 346245a1bb ("hard-code the empty tree
object", 2008-02-13), and the function now known as oid_object_info()
was taught the empty tree in c4d9986f5f ("sha1_object_info: examine
cached_object store too", 2011-02-07). repo_has_object_file() was never
updated, perhaps due to oversight. The flag OBJECT_INFO_SKIP_CACHED,
introduced later in dfdd4afcf9 ("sha1_file: teach
sha1_object_info_extended more flags", 2017-06-26) and used in
e83e71c5e1 ("sha1_file: refactor has_sha1_file_with_flags", 2017-06-26),
was introduced to preserve this difference in empty-tree handling, but
now it can be removed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Forgot to add v2 to the other email, so resending it with the correct
email subject.

Difference from v1: updated commit message in response to Jonathan
Nieder's feedback. Hopefully I didn't remove too much.
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

