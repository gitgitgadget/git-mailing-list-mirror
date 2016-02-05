From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 04/21] refs: add do_for_each_per_worktree_ref
Date: Fri,  5 Feb 2016 14:44:05 -0500
Message-ID: <1454701462-3817-5-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmKX-0002V2-H3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbcBETqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:46:05 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36267 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008AbcBETos (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:48 -0500
Received: by mail-qk0-f174.google.com with SMTP id s68so38142368qkh.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8c1ZOlAAx/P9bIUfSKnLL+oEOEE2Si0jKuUhxbWqrwk=;
        b=ZcqMuNxsPwTM9UnSr3qRdzfxGaxHt0z5QzNQoA0cGnKpfLAPs50xAKGamPN3rP+L+a
         Gh8m6aFEJ58uPDauofKDzLME8h8qtESX5X5mvl4VLnkmNQdFi0lDquclnMH/pDFF/BoS
         IYOsvgD4KZbH8N4JkBMUp6zHixYQohUI81LF3k36kZzlWDfzgiuhxYnzg8zFiRmDR1kt
         tNvNmFq+xwDEkc5B+xQfGHra0JldzD05DmGmSSMj168bMf3ameO8I4CUFq3naTNrWTYP
         u8DyxLCVhfMptMfeWAlwpDaBgvEhcxJ3ahLB6/I5l3lZDTbOaxDZ4aJr5XmTLSZ6t1FH
         oXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8c1ZOlAAx/P9bIUfSKnLL+oEOEE2Si0jKuUhxbWqrwk=;
        b=ZcaMzn3WyqqCbTeBVcs47SpOxkf+p4NO/8oU6hONAFXkuHPhEL+J9oc9cY3/bWmHb2
         nESykSxCPAvTBhNRNy+BjwW1L/eTQwWMUQGO8imzas0j0LB58OlJvKVigdJkPHSTxRAX
         21E+6OqbLcwqDG60TV3jI8spMfTEjxNs+kadRDrqdpa+ZFfV2Gso8Zh6TQlqGyajh+7W
         CT10rUL4bRHL7R7byHWciaenCcPCvcLRFIQ2hs29I0TATLpVL+ZYtbn1fh/6al92RKwL
         u/AoRBnREXZ1iqdu/3qBsBmqQuEe9PVKS/BxhLEvrwMFTOgeQHPwI3ZIV9xGqa9PX8CM
         yn8Q==
X-Gm-Message-State: AG10YOQIzQZ/ng3FRhD9RJMN/NIeKr+QKEd+9wNWmDPbydGR6J4637VtebA/5/7H4lP4Bg==
X-Received: by 10.55.76.11 with SMTP id z11mr18543139qka.83.1454701487515;
        Fri, 05 Feb 2016 11:44:47 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:46 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285621>

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
index 0772a02..3d678ad 100644
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
 
@@ -1756,6 +1757,14 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
index 4a1d215..cb949c5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -57,6 +57,16 @@
  */
 int refname_is_safe(const char *refname);
 
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
 enum peel_status {
 	/* object was peeled successfully: */
 	PEEL_PEELED = 0,
-- 
2.4.2.749.g730654d-twtrsrc
