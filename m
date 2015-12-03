From: David Turner <dturner@twopensource.com>
Subject: [PATCH 04/16] refs: add do_for_each_per_worktree_ref
Date: Wed,  2 Dec 2015 19:35:09 -0500
Message-ID: <1449102921-7707-5-git-send-email-dturner@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Hsg-0006rU-6g
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864AbbLCAgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:36:13 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35860 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154AbbLCAfm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:42 -0500
Received: by iofh3 with SMTP id h3so64841383iof.3
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6iMkaykmh8nWzwXcbakamfSG3toMdbeL3SHQqBhUQ0E=;
        b=UJw6vm7bONRxx0QfS2/NKYUL//zShDopvsxfWFMhPKGZmIu4dZQku02YDUiFk4i+0b
         6jrplB7lwgFTxgVRxLjQRLl+8G6YKHMQRV8Ue1PFzCzovY/BKif25+NXU+gzJedDh+1D
         6VW8IsWXa/ZHMJs9Ep/ZymCbl0G5Y2QDlwZNW3MAlv+Z31tc7+Zmijk1yjLr8OuKMqda
         LIgSWc+t2pVfkxaA0xX3xJOJa71dRgqcqzhZd4tTy/4OvKpwJayq4u/AJ5WHmgevU9tX
         nLYQvtlPuCXVm18sI8qJ2hzFCefx/CtZHZM9QIh02WRInZyOKIdFeYjyN5oyyTV1eyX2
         dvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6iMkaykmh8nWzwXcbakamfSG3toMdbeL3SHQqBhUQ0E=;
        b=bHNowIjSa1f3sBmBr2Ge6Ni/TK/YSBWJ2aZtr4XPivcc6/5dCYGGSBjf9WRmd7OElI
         +7SURGuhvJUyyZ9SQ72ul9HCdS1QemoiwAxoKNqEXrblRSSKKUNJQJHLUPrnsOWuLMm1
         21jThaOhDCcli1IxCyZMqF2qcE25CIUDUrIEx1ikNcs+aoHCwzWzeFApMDW2ppduvBvB
         TID06s4SuG6E1MNpC9QMrec0f8GGcgYsEhkALqsrLisYNudzzzj64tyR80r/68P76q5Q
         AHAZOv75TVgCHUeLURs/QqWCh8eohv13vqAbjRPooPwGB7RP+48l8ue/dYCgq4H0WA0N
         OcVg==
X-Gm-Message-State: ALoCoQkR91HvlzS2CPx5v3iJojNKEgILwVnW9R8WefxYCb8t/WS0ClLJCyubr2W69O+DcRdtlYiv
X-Received: by 10.107.132.211 with SMTP id o80mr5856861ioi.85.1449102941793;
        Wed, 02 Dec 2015 16:35:41 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:40 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
In-Reply-To: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281928>

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
index d4bd6cf..bde4892 100644
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
index ad683df..433d0fe 100644
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
2.4.2.749.g0ed01d8-twtrsrc
