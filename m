From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 04/21] refs: add do_for_each_per_worktree_ref
Date: Mon, 11 Jan 2016 20:22:03 -0500
Message-ID: <1452561740-8668-5-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfY-0003CZ-7o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761795AbcALBWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:39 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33517 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761753AbcALBWd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:33 -0500
Received: by mail-qk0-f182.google.com with SMTP id p186so153619332qke.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/rIW/82JrAZCkKFMtvnWXUsh+gRFenUGqdTCXrZSb8U=;
        b=srXLJsZ/4eHW7OHFSQ5jBHkM+WZ++BcHuZNTNlBSebbhqHtHFKXIv7gOgIxrF9PRLl
         6CTR8wYoBlDgKi5vcEeQaPrRJ27NUkFm4QvktUk8/mZ3sFQYlzts/iWSLyrjd4qRK3dl
         O9GJ9B3CW77Un7cFFCrYF/e9rCEYVa8QGleo8kGlLdac0K3DzyA21tgwA1k4a608y1S4
         Ic6FvlpYKpqFsUsyPRyquucW/d42iyh3aKfXyIbv2+iRQ1bFW8NzP2hjKUaethz2wT0t
         sXiiS+Cw7nOOOGsrjKCiLFCdKL93B0ttYmXw5Iw3ulfW/9WGPfYJ3WrDUo6/6fh9Vfxh
         gvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/rIW/82JrAZCkKFMtvnWXUsh+gRFenUGqdTCXrZSb8U=;
        b=gmGG3ONQ3GMzDrnZ8/LdP76UWFl/fay8sjtV4Mw2JWYc3MrsZkOZ3EYA+hbRAcoHDd
         34YxZUphyF4Ss1YvGbnxMV31gbDf2zMMEaPz9GuAwwTRUhT9iXLU+4zAFAfIHy8u8UYX
         nyWienjrLE8glRtG0fzZibWTg284dsrH3cTeJj04y6nr6eN59Ssiolqwu/Ww/8iQsKFg
         yISMnirZuhfov2GgdqbpShrhpa6SExiTaTl/mrHLWfuwE7a8MQVVCUS64/d58ZlCcNCt
         6AtmuvPTBudr1SvWrtJkSlJy/amS4FK52Q+p07XRb64+d+QNCe7DVjnp/JQLi58+Y3DS
         YG+g==
X-Gm-Message-State: ALoCoQkA5oZnthZET0Adsv8ONuSDNFVhHzLWExYBbLLw6Kuq5fcrLbOUNJv+wbcv6v3ZM1KJ5egWAvYIkOBEhh/oJenZ1Qk//w==
X-Received: by 10.55.40.3 with SMTP id o3mr27364344qkh.92.1452561752618;
        Mon, 11 Jan 2016 17:22:32 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:31 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283742>

Alternate refs backends might still use files to store per-worktree
refs.  So the files backend's ref-loading infrastructure should be
available to those backends, just for use on per-worktree refs.  Add
do_for_each_per_worktree_ref, which iterates over per-worktree refs.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++++---
 refs/refs-internal.h | 10 ++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b35dece..1c9401f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -518,9 +518,6 @@ static void sort_ref_dir(struct ref_dir *dir)
 	dir->sorted = dir->nr = i;
 }
 
-/* Include broken references in a do_for_each_ref*() iteration: */
-#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
-
 /*
  * Return true iff the reference described by entry can be resolved to
  * an object in the database.  Emit a warning if the referred-to
@@ -568,6 +565,10 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
+	if (data->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+	    ref_type(entry->name) != REF_TYPE_PER_WORKTREE)
+		return 0;
+
 	if (!starts_with(entry->name, data->base))
 		return 0;
 
@@ -1738,6 +1739,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data)
+{
+	return do_for_each_ref(get_ref_cache(submodule), base, fn, trim,
+			       flags | DO_FOR_EACH_PER_WORKTREE_ONLY, cb_data);
+}
+
 static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index cd338f9..2431579 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -42,6 +42,16 @@
  * value to ref_update::flags
  */
 
+/* Include broken references in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_INCLUDE_BROKEN 0x01
+
+/* Only include per-worktree refs in a do_for_each_ref*() iteration */
+#define DO_FOR_EACH_PER_WORKTREE_ONLY 0x02
+
+int do_for_each_per_worktree_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data);
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
-- 
2.4.2.749.g730654d-twtrsrc
