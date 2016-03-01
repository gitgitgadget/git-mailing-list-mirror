From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 08/33] refs: add method for do_for_each_ref
Date: Mon, 29 Feb 2016 19:52:41 -0500
Message-ID: <1456793586-22082-9-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZK-0006xI-9S
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbcCAAxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:38 -0500
Received: from mail-qg0-f41.google.com ([209.85.192.41]:33584 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcCAAxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:35 -0500
Received: by mail-qg0-f41.google.com with SMTP id d32so74635207qgd.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBO+JmfC4oOkQ5aMvpFTztB3TiZ/h8y2y7RkjSyJ55Y=;
        b=ocsB6iGvatiKgKCZcA6pjO2SyaeCSvdBPEygrW/5NWou8XtX0+DsStUqZwasBoBuo7
         gJj1LmIaMI/hwsPl2tC5Xc4i13h0cRflD2rowIkOUN1ExkUUYWcAhaLORApvZWxffeAQ
         IY7n3EHVZttQtGw/F/LHBKW0RE4aS5tJr3UItS9CKhcBu6zwyRwKPBYYZg1vkTbgjERt
         rO9D9IWNtfsY/bHOPSDRiMdCgut9QSi2lUhx+fNU2BhHKMB634WISE9P5x7MOte6Jh3R
         xK4Ew/ruTn5/wsy3CFlK2XLNLM4W0HBI1lcEeFTtkpE9brzeKzJ1ShnWkgiAykgnlfTq
         u19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBO+JmfC4oOkQ5aMvpFTztB3TiZ/h8y2y7RkjSyJ55Y=;
        b=ZV3QOlfzNyLhxPgIZKbxRIeCEiz414qm8esJkcS8ZUiQ/aasas6g6Q9Ox9C+QehPTF
         rbc/C2eUt//lmN6JmPX7btR9LNt7SW5I5t69BZFGwc7gc97E1EexcpZMWwASR8zMD/1G
         0tC+PgJfDwd3/GvMsgel/lMY2ow53ZwcGDhbLLyzQuYouXsKyuCk269DzIoiDRcSqkal
         eaRvWbyCM6D2k9S/QjP/k/QURrc5TVE9mkxBwqsw4GnCB42f71OnJ37g30gmY6cKXzXu
         9DeRI15xsOFLHGVweIvky5frE0gWu+q9pGiFLGicxH6NQgvYIXe3LArX7B5y6lt2qF2b
         tEUw==
X-Gm-Message-State: AD7BkJLhnO9XW1SKqVD+rOa2tf2k5T//QnZVaztugMgDeo6In1xWH0MPpBblOLaPfQ7XWw==
X-Received: by 10.140.166.6 with SMTP id m6mr619863qhm.70.1456793614697;
        Mon, 29 Feb 2016 16:53:34 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:33 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287948>

Add a ref backend method for do_for_each_ref.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 8 ++++++++
 refs/files-backend.c | 7 +++++--
 refs/refs-internal.h | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f4873d6..dc5682a 100644
--- a/refs.c
+++ b/refs.c
@@ -1342,3 +1342,11 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
index 96be63c..f3d857a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1671,8 +1671,9 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
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
@@ -3406,4 +3407,6 @@ struct ref_storage_be refs_be_files = {
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
