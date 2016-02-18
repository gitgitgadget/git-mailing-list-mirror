From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 05/27] refs: add method for do_for_each_ref
Date: Thu, 18 Feb 2016 00:17:28 -0500
Message-ID: <1455772670-21142-6-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWH1I-0002sZ-3u
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425045AbcBRFUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:20:45 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36183 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424582AbcBRFSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:33 -0500
Received: by mail-qg0-f52.google.com with SMTP id y9so29815659qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gbe4xZ6bOgRTQt9wkWgWkDGUOPuczKWIOYO7iyefsoU=;
        b=uBn/uM6oS7rbxfoOAxdM063j3n8+xbtD0T8PV+Ya/CeEBDr5J5qnwkW15NVIe9Iz5l
         Z3vyEhuqv7hcvKpNX/+Ok424qiyfcSeSuAH94lSsSLdUJ7HfNXbBgzv1tucuiavPhXgB
         osMoeJBLaCCHB6FV+D6imj0Zmop2sheh41H/fLfmUrT6EJpIK2x5zmCcAJTYXGi7zv2Z
         XRcCiVt34GygUPloXlmKPOmtBeV6HLA5VJ057/BSRfnNT62f+n1jqRajRIbPDRaFsvqA
         vm88ROAbgLXuUzTcKjVe2Y5GhbYBIXEvaKfwfFa2h1LQlGatGhme5PnUv6HkrLePa/GR
         PT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gbe4xZ6bOgRTQt9wkWgWkDGUOPuczKWIOYO7iyefsoU=;
        b=COErVqg4lJ/c8LnpaZdu+RouiqTlDaBs7rcs8HzQyBlE21KnDwWE0V9PW0Vx0cwNKl
         tUpI6vapXJ9BaO/oXxWXXxNHBFDrn2Z28PTpuC3+6rP55W/ehE/0fQlc8RKMjZikpFKC
         CTA9lGu1VmI36HMfaB++xzWVXlllIVxCCxvwy5VYiPQ5cAUgq02Nk02VPhjaIccEp4jZ
         2hrxUmAWiwxiHk8MbCym7Mal+XnKJK8lItpWv6AXCY4oG/Z8Bq5p88wMA1jlez+Uq2cH
         MlbDtjAMQyGkx6xsZjiZTpHT7eXgB+Xbc52QnVbrftLMD2ubnLzNggHJEfIrsedvLlCS
         8B9w==
X-Gm-Message-State: AG10YOQA9ikdzL5OlaN/MC44Ilt56ZDz3GNe95aTwxxvv2cO4xMHlDqJZDJ6XkalqD1VPw==
X-Received: by 10.140.18.114 with SMTP id 105mr6606644qge.41.1455772711963;
        Wed, 17 Feb 2016 21:18:31 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:30 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286599>

Add a ref backend method for do_for_each_ref.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 8 ++++++++
 refs/files-backend.c | 7 +++++--
 refs/refs-internal.h | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index bfe3b4e..253e566 100644
--- a/refs.c
+++ b/refs.c
@@ -1233,3 +1233,11 @@ int resolve_gitlink_ref(const char *path, const char *refname,
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
index dec8575..34c414b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1735,8 +1735,9 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
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
@@ -3471,4 +3472,6 @@ struct ref_storage_be refs_be_files = {
 	files_resolve_ref_unsafe,
 	files_verify_refname_available,
 	files_resolve_gitlink_ref,
+
+	files_do_for_each_ref,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ed458fb..1caeb61 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -224,6 +224,9 @@ typedef const char *resolve_ref_unsafe_fn(const char *ref,
 typedef int verify_refname_available_fn(const char *refname, struct string_list *extra, struct string_list *skip, struct strbuf *err);
 typedef int resolve_gitlink_ref_fn(const char *path, const char *refname,
 				   unsigned char *sha1);
+typedef int do_for_each_ref_fn(const char *submodule, const char *base,
+			       each_ref_fn fn, int trim, int flags,
+			       void *cb_data);
 
 struct ref_storage_be {
 	struct ref_storage_be *next;
@@ -237,6 +240,8 @@ struct ref_storage_be {
 	resolve_ref_unsafe_fn *resolve_ref_unsafe;
 	verify_refname_available_fn *verify_refname_available;
 	resolve_gitlink_ref_fn *resolve_gitlink_ref;
+
+	do_for_each_ref_fn *do_for_each_ref;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.4.2.767.g62658d5-twtrsrc
