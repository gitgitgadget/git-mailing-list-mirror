From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 22/23] refs.c: add methods for the ref iterators
Date: Wed, 13 Aug 2014 13:15:06 -0700
Message-ID: <1407960907-18189-23-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexm-00009i-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbaHMUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:43 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:60256 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so83278pab.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x5MRTaGlEUCHyBdOmPVGNo1CI2VmiY8y1ZRzDtBfxU8=;
        b=glZENt8/4frmMNTqZoOUz7CEqRg35DGFSYwWQRvV2pNwTVA3LCjqGqdELuBy5/cqpu
         yeYPoOZ+ikk0rz/NsdvK6zd2QAaEntMzY8ZAIdTyuTANCaWp8yyf6YXQnEPXH6WeRocS
         9aJB1uwfx9/TUhKtfz9bNCsukXA6v3CqULIhy9nXfKfwuyBxnrSphmuU4B0qECtscdlq
         o+ENJdgK6iKflwwWEkVUQoFybCT+yHqNjk5j6TIkKtWRBkEcWHC3cNGfG5NzzJbr0s1B
         TJb+UqLkpde12CTtKQ67JBnSmwA/teF8WxC5U9rDcH3l7GUr/9mrHUbreZxVNCkJHuBF
         H6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x5MRTaGlEUCHyBdOmPVGNo1CI2VmiY8y1ZRzDtBfxU8=;
        b=Uce+O5pX7eC7j2p0CnrjnCll6GW3g0pj76FsB/0kc4MwZHFUqO8EQHrdQE8V/JBKWl
         g5CZscMWZHtagNjQHZsMJ1CApD0cKOunhIeTbvxzXgB/CUwO6LZgoBwSV2JwDXLIo1/0
         NFOryEv1zpsMZPLaWGnVQHLfWfhx0aHxmUBk1L/m2Niy30MAyL+iIcXkAFddrz22Vdwn
         m/VDaRfEl1OjmTbGUkbGZ64E0+EVmOFRlj9TbQCkaoaEG1L6xEBun6cZ9QN1YzryjKPs
         VhhTAWXGtwN8KaDWx+0vFF08HUw4AeLAzRXvDgZEXo9ecRFiwgko+6X+yloTSByIg19q
         oxfQ==
X-Gm-Message-State: ALoCoQkbFh8hGp1ycbQqYFjbULc8SaU4rmOCVSBGXJebAMMeqduH/JIu5RUPROTc4oeSf6r5NoXz
X-Received: by 10.66.163.41 with SMTP id yf9mr3491545pab.36.1407960911049;
        Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a66si207154yhg.7.2014.08.13.13.15.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:11 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C92FD31C2A9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AB40AE025A; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255240>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 36 ++++++++++++++++++++++++++++++++++++
 refs.c        | 21 ++++++++++++++-------
 refs.h        | 19 +++++++++++++++++++
 3 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index f19402b..3df725d 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -928,3 +928,39 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return refs->head_ref_submodule(submodule, fn, cb_data);
 }
+ 
+int for_each_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_ref(fn, cb_data);
+}
+
+int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_ref_submodule(submodule, fn, cb_data);
+}
+
+int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_ref_in(prefix, fn, cb_data);
+}
+
+int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+			      each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_ref_in_submodule(submodule, prefix, fn, cb_data);
+}
+
+int for_each_rawref(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_rawref(fn, cb_data);
+}
+
+int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_namespaced_ref(fn, cb_data);
+}
+
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_replace_ref(fn, cb_data);
+}
diff --git a/refs.c b/refs.c
index 7ad07f1..dc0467a 100644
--- a/refs.c
+++ b/refs.c
@@ -1610,33 +1610,33 @@ static int files_head_ref_submodule(const char *submodule, each_ref_fn fn, void
 	return do_head_ref(submodule, fn, cb_data);
 }
 
-int for_each_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), "", fn, 0, 0, cb_data);
 }
 
-int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
+static int files_for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_ref_in_submodule(const char *submodule, const char *prefix,
+static int files_for_each_ref_in_submodule(const char *submodule, const char *prefix,
 		each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_ref_cache(submodule), prefix, fn, strlen(prefix), 0, cb_data);
 }
 
-int for_each_replace_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "refs/replace/", fn, 13, 0, cb_data);
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1646,7 +1646,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3311,6 +3311,13 @@ struct ref_be refs_files = {
 	files_resolve_gitlink_ref,
 	files_head_ref,
 	files_head_ref_submodule,
+	files_for_each_ref,
+	files_for_each_ref_submodule,
+	files_for_each_ref_in,
+	files_for_each_ref_in_submodule,
+	files_for_each_rawref,
+	files_for_each_namespaced_ref,
+	files_for_each_replace_ref,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index 420e9b5..249a14a 100644
--- a/refs.h
+++ b/refs.h
@@ -401,6 +401,18 @@ typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
 typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
 				     void *cb_data);
 
+typedef int (*for_each_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
+					 void *cb_data);
+typedef int (*for_each_ref_in_fn)(const char *prefix, each_ref_fn fn,
+				  void *cb_data);
+typedef int (*for_each_ref_in_submodule_fn)(const char *submodule,
+					    const char *prefix,
+					    each_ref_fn fn, void *cb_data);
+typedef int (*for_each_rawref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_namespaced_ref_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*for_each_replace_ref_fn)(each_ref_fn fn, void *cb_data);
+
 struct ref_be {
 	transaction_begin_fn transaction_begin;
 	transaction_update_sha1_fn transaction_update_sha1;
@@ -423,6 +435,13 @@ struct ref_be {
 	resolve_gitlink_ref_fn resolve_gitlink_ref;
 	head_ref_fn head_ref;
 	head_ref_submodule_fn head_ref_submodule;
+	for_each_ref_fn for_each_ref;
+	for_each_ref_submodule_fn for_each_ref_submodule;
+	for_each_ref_in_fn for_each_ref_in;
+	for_each_ref_in_submodule_fn for_each_ref_in_submodule;
+	for_each_rawref_fn for_each_rawref;
+	for_each_namespaced_ref_fn for_each_namespaced_ref;
+	for_each_replace_ref_fn for_each_replace_ref;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.556.g3edca4c
