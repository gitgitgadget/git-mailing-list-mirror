Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD06C2D0C2
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334AE21655
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 20:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1LyaoFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgABUPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:15:40 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37049 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgABUPj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 15:15:39 -0500
Received: by mail-pl1-f202.google.com with SMTP id t21so15683181plo.4
        for <git@vger.kernel.org>; Thu, 02 Jan 2020 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9JxhdVH0IVwNfoh4iVxHhIruKZBR6c1wHbh99ezqr80=;
        b=U1LyaoFoF73ItJbl6FoOqLkcZD3Ez2059JDWojixa+LQW+hCpc3c7vLAlEGW4AOeFA
         FsPJr+EgApDNrCQ3nlU7m530IA1pHT2vOl0vJr/5r/cG05WkNm5eth+pwsP3N6+sZmn/
         MjaYw5YgQm/Vnu64EKTLMlcz5vO010OACKs9qVwqDuJogufniSTIdEIs8HiYR7kUPlEF
         TorhRIryFGzX9+pClAWOcmqIBSzAfnYzMQrCeuSkb4XSQK7nH6q6TKOo+D2ge7/hoHWN
         GdMfE21wOReCgkyxDambOXw/6vU5VoWFo70gujTzoXLAEjprwapT4cnokhT2zWnanWbU
         l6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9JxhdVH0IVwNfoh4iVxHhIruKZBR6c1wHbh99ezqr80=;
        b=Z4c6FCY/zo8/Pn+Kaa95Ng5m9jFiv8ZYQYIR7vXgNW2P1i14Cz2+L5y3/UFPghx1LF
         I5qByzJtvqZ/K6aCU1zSMKHPxfcpovCReAsh9JTMCDYjwXjGf1oxl6SxzxWyjQL9Z5in
         sixm/JGd++/G27pvxaJaqjYYS1e3z0QLGDgWrlyPFtfkrVMxjg6WlqqxH6xfsBZYwPgT
         bu/oo5PR0NjxhoadA0s92KqAcs/YiQ59B2/uUpHdIRZ0LmTbujKk9Y1u55/pVXzpY0qV
         uJOGMHVi2rzoL6/ECnbTSC/3wvbSj0KPSnDciWES05a1nUXM2oOqoAAC0q/qsbwzo8Cp
         u1Uw==
X-Gm-Message-State: APjAAAVw4aKoZZDFSt6JZCu+yFExGjWkh9k2U+p8jhsKEct4ckWcUwpj
        VgXdAFXuVtc74TaoB+rvamlcyJOcQ3lXpcgGTN79ZZUkES/4gjwwPmCcsmIU0tO67Fvaq504UMh
        eSiEp6y0PNLpq5euv2rzV6LU8Um49S6ppluGB1Fbd81uLqW1bgLKrCZfXBnm+Lp3hRDIhtMeAXV
        Km
X-Google-Smtp-Source: APXvYqy5HD68AqmimA94efChVSuzec6W7LhEt+eImJnxHQbQTf9j+fiR0tZpi2UpY1fo3z/Pt7MD0YEFyJfvhyXkWoN1
X-Received: by 2002:a63:1b54:: with SMTP id b20mr90750222pgm.312.1577996138735;
 Thu, 02 Jan 2020 12:15:38 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:15:35 -0800
In-Reply-To: <20191230211027.37002-1-jonathantanmy@google.com>
Message-Id: <20200102201535.179417-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191230211027.37002-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH] sha1-file: remove OBJECT_INFO_SKIP_CACHED
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

