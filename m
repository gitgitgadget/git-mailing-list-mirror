From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 13/33] refs: add method for delete_refs
Date: Mon, 29 Feb 2016 19:52:46 -0500
Message-ID: <1456793586-22082-14-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:55:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYaY-0007iF-8f
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbcCAAyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:54:44 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34858 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbcCAAxl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:41 -0500
Received: by mail-qk0-f181.google.com with SMTP id o6so63937027qkc.2
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TIx8x/n5DHoVOOpjiOzHtlw1WSJAAejYiD8tSIGlioU=;
        b=Lf3P09qkQVTl0Z1+oIb6kS6hZGPSZ91kRLSt2FQaTag9sxQvAGKrEQS9IH5mMu6v6O
         fcSQeBK92kMOVR8qobilluVHqzpypwzzvTC/9eQzmhzsvp0mx9jjc8VDkVriq7TkAHV2
         YwjPfE/Zzx5Nld0MNwvJPg4tL8RHcH9cirwkDnH72JaX4rCjB95W8O8QUg/vyY41RPqZ
         OB8BdwDUaAGg2eKSCY/C+VkZVgXxp3F91tk/8XowNBH6YJf6Q46liab8kztbXYNrs1JL
         a5rAiM+bmxCoT7yyeghHReThSupG4FKfzdUxdjI4+AokuSbzfKMS6EX/xPvExEMGj1Qp
         IEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TIx8x/n5DHoVOOpjiOzHtlw1WSJAAejYiD8tSIGlioU=;
        b=LSgYs7akYJnCR1a5qZ8uFT6Ne/jsmhnXOdj0jVQFrT3wkjm9lvAVHm4+Lmtglx1HOs
         3ykOqQqF7BBfgfCGyZSn/ZBCr67TtiG2VXbmzjPV5aGpZ94hBvaoRFwpzJq6xEsZzy8M
         OkXjffmansWU4HVR3OASiCv2fGwb/33o4rqpQ6godwsgLTerw1unxQEV1EPRGWuJL2Ik
         Y8Rzh02lBgbGId7VpVsF2ntiQSaLu2WadwdP8Nv13msEOvzlHQOiXnKHpgb92PWYZbk3
         QNCFWfmw8iVK6As2wSDH1K2fTU1pcek4qcBPU/clQoMAuKS8GRIM4fGRCBkuuUM7tawE
         5IJA==
X-Gm-Message-State: AD7BkJKQz5hEVq8XIFR1wEz/Gejb8si3a71GRq2EQW0xU1kKP9/qQ8F9bsJvIt4AyvjuDg==
X-Received: by 10.55.72.67 with SMTP id v64mr22928082qka.101.1456793620557;
        Mon, 29 Feb 2016 16:53:40 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:39 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287976>

In the file-based backend, delete_refs has some special optimization
to deal with packed refs.  In other backends, we might be able to make
ref deletion faster by putting all deletions into a single
transaction.  So we need a special backend function for this.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 5 +++++
 refs/files-backend.c | 3 ++-
 refs/refs-internal.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index b5ef4fc..d25eee2 100644
--- a/refs.c
+++ b/refs.c
@@ -1405,3 +1405,8 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 {
 	return the_refs_backend->initial_transaction_commit(transaction, err);
 }
+
+int delete_refs(struct string_list *refnames)
+{
+	return the_refs_backend->delete_refs(refnames);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1906875..35328d2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2237,7 +2237,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+static int files_delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -3432,6 +3432,7 @@ struct ref_storage_be refs_be_files = {
 	files_pack_refs,
 	files_peel_ref,
 	files_create_symref,
+	files_delete_refs,
 
 	files_read_raw_ref,
 	files_verify_refname_available,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5aa3fa0..beef457 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -239,6 +239,7 @@ typedef int peel_ref_fn(const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(const char *ref_target,
 			     const char *refs_heads_master,
 			     const char *logmsg);
+typedef int delete_refs_fn(struct string_list *refnames);
 
 /* resolution methods */
 typedef int read_raw_ref_fn(const char *refname, unsigned char *sha1,
@@ -268,6 +269,7 @@ struct ref_storage_be {
 	pack_refs_fn *pack_refs;
 	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
+	delete_refs_fn *delete_refs;
 
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.4.2.767.g62658d5-twtrsrc
