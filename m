From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 07/32] refs: add method for do_for_each_ref
Date: Wed, 24 Feb 2016 17:58:39 -0500
Message-ID: <1456354744-8022-8-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQl-0004sP-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbcBXXBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:01:08 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35532 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759140AbcBXW7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:31 -0500
Received: by mail-qk0-f181.google.com with SMTP id o6so13256415qkc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tKUNiDeGvLKDfdE6rS1bfmQdCvbFAIXSf6N1Pv+9lBY=;
        b=nWO7ZAqbLSJV2IjPMhpu6zqV3PempRNLINBJVSWVRvU6+mE2BtxAfIk33dZrEO7uYe
         Qr5gDagfY7zz2zYPskSLmrzVYoY2Mhspv+alGuN3bdFCwfpBjy6NTE+Ib+uwPkdq3BhC
         QPvvckwGhp009yo7vc/R1XYjHqAxjua88YfElEXkv8qyuG/qnBwiE+xr/fqsApG0oZvR
         rpWVVxrfwrU3UwTwUc+fPb+2CX4V9RLgLpgXz+DRQZ/Kd7VkF25/z2cMmNWXpC0j9gnh
         vbf/Q+tzr4U+/90bIWD1PcjF0297IqOVUd7HxTlkXKqq3lbTRR/FddoouHp86RYoN4b3
         BERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tKUNiDeGvLKDfdE6rS1bfmQdCvbFAIXSf6N1Pv+9lBY=;
        b=KeT+PXkNOrLLBXfJq1NAg1tOn4pYuT+61x19ahCKdJ2bCOZmAU0njfxxt5u2eMVGJx
         03CotTa7AisNJxaLZGxRtojQTLqbEvV9UD8KUmYS439qIsV/kSP5Cliv7Pjm+0YkRiry
         tg1sVyFeQ2vFRA0+m8x1kCEQcjjzqcLbsKHR+teIghnSXVNThH8T5rylgWH0hzccVoXL
         b89bQVNUGyVH3XWreXDvHHYroL9Uop79ce6zCAv5C2pYj7Hbu5vq4rJUe2YwpUGDWlbL
         ssz7cP4X31HaACEr05QzM/AvOMIbUJ751zZp1cIf0yakqroiszteHNGknwStLIoIOtDM
         nsRA==
X-Gm-Message-State: AG10YOTTUrjCLfeDJAPDG93jjcKNGzxS6FQQnqbyJUjUsxq53Qn/gPXCU09toa3wEke0jA==
X-Received: by 10.55.79.5 with SMTP id d5mr52006906qkb.30.1456354760167;
        Wed, 24 Feb 2016 14:59:20 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:19 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287272>

Add a ref backend method for do_for_each_ref.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 8 ++++++++
 refs/files-backend.c | 7 +++++--
 refs/refs-internal.h | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 6fd5121..cd06f4b 100644
--- a/refs.c
+++ b/refs.c
@@ -1339,3 +1339,11 @@ int resolve_gitlink_ref(const char *path, const char *refname,
 {
 	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
 }
+
+int do_for_each_ref(const char *submodule, const char *base,
+		    each_ref_fn fn, int trim, int flags,
+		    void *cb_data)
+{
+	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
+						 flags, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3a83c0d..db9e948 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1679,8 +1679,9 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-int do_for_each_ref(const char *submodule, const char *base,
-		    each_ref_fn fn, int trim, int flags, void *cb_data)
+static int files_do_for_each_ref(const char *submodule, const char *base,
+				 each_ref_fn fn, int trim, int flags,
+				 void *cb_data)
 {
 	struct ref_entry_cb data;
 	struct ref_cache *refs;
@@ -3415,4 +3416,6 @@ struct ref_storage_be refs_be_files = {
 	files_read_raw_ref,
 	files_verify_refname_available,
 	files_resolve_gitlink_ref,
+
+	files_do_for_each_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c5f5ef7..c9b6745 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -227,6 +227,9 @@ typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int do_for_each_ref_fn(const char *submodule, const char *base,
+			       each_ref_fn fn, int trim, int flags,
+			       void *cb_data);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
@@ -240,6 +243,8 @@ struct ref_storage_be {
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
 	resolve_gitlink_ref_fn *resolve_gitlink_ref;
+
+	do_for_each_ref_fn *do_for_each_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.767.g62658d5-twtrsrc
