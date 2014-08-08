From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 21/22] refs.c: add methods for the ref iterators
Date: Fri,  8 Aug 2014 09:45:08 -0700
Message-ID: <1407516309-27989-22-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJG-0000AC-4m
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641AbaHHQpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:32 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:54170 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-yk0-f201.google.com with SMTP id 142so766236ykq.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TRcN840nkqhlvTS4nFBx/qyeNKhk1Mjxn1UHwjaBbg=;
        b=ng+FrTQ3dJIuy+OjtFBEN9X9gXMKo0XoqQCVwLGI3qaweNGGc/AWvYbdYgfgoO2gSj
         ox+mxztHr7QEFNZzmAeWt9rUOy/gTcKhPSQDk4hg2clh+R5SPunjtJivxq6ImMu78s5x
         Zq/xHpsBsSNIJvwWRwoXWUOPX4/JLQ4zxnA8PQ9SYE/JNZCEEfcKB+rhNvUVs5MwMWnT
         kY4NCXHbESrL4PJVTwKUXAPzrYlPSuts9oxaf0PKZpRSMqXQuDAm0/PnVxZMjdPvhaYF
         DDdiCBBEtWL4xc4Qr9s2kJ/JCy1nI/gGkpM4qXj72UCo9TOqPedeB4Lyu2gXhg7fPAk+
         52/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TRcN840nkqhlvTS4nFBx/qyeNKhk1Mjxn1UHwjaBbg=;
        b=VvSOTAMVCCnkRIxTRvMh0FiOPAwwZ7W0Mj7yjSQjk6EqVqfzK+wzT5LEx+0xn3jbV6
         UgrH3BZbtNlrFhh2lq1bwYfKgvmUK1I77FHhyCulz75DOeHpm9k2mlICL41IGmY89qnE
         lDU++lwy0cnriA7c9FZSPI7C0OsLN/kL0vMruG2NDCOWv5+mXLLtpfuEpyLPBg/HrquM
         UxdhWKAaTLYjiaS2qPrefUC0B/va7UEj/QcExx5eAuoRTY1K+XdX9/3nioh0AZwnM3Nb
         OjpEdsWgHExkvWkFEmjc4CbpWWG7lpd1MEAwxilpDFElk7CN1TFJnMLSdgEKbBpP8vo6
         i5Pg==
X-Gm-Message-State: ALoCoQmarmC+0yVOi6migrNcfdND7ttc+blyBXSZ6VZIEy60ldBKGY5/Jagk4iBNQ+xurBSSiT3Y
X-Received: by 10.224.147.77 with SMTP id k13mr4585379qav.6.1407516316255;
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a66si502688yhg.7.2014.08.08.09.45.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 04D9D5A4617;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CC127E0D73; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255039>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 36 ++++++++++++++++++++++++++++++++++++
 refs.c        | 22 +++++++++++++++-------
 refs.h        | 20 ++++++++++++++++++++
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index d9308a3..11c3660 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -918,3 +918,39 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 {
 	return refs->head_ref_namespaced(fn, cb_data);
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
index 94d6160..1b2272d 100644
--- a/refs.c
+++ b/refs.c
@@ -1610,28 +1610,28 @@ static int files_head_ref_submodule(const char *submodule, each_ref_fn fn, void
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
@@ -1651,7 +1651,7 @@ static int files_head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
+static int files_for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret;
@@ -1661,7 +1661,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3330,6 +3330,14 @@ struct ref_be refs_files = {
 	.head_ref			= files_head_ref,
 	.head_ref_submodule	       	= files_head_ref_submodule,
 	.head_ref_namespaced		= files_head_ref_namespaced,
+
+	.for_each_ref			= files_for_each_ref,
+	.for_each_ref_submodule	       	= files_for_each_ref_submodule,
+	.for_each_ref_in		= files_for_each_ref_in,
+	.for_each_ref_in_submodule	= files_for_each_ref_in_submodule,
+	.for_each_rawref		= files_for_each_rawref,
+	.for_each_namespaced_ref	= files_for_each_namespaced_ref,
+	.for_each_replace_ref		= files_for_each_replace_ref,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.h b/refs.h
index b35c406..61b6728 100644
--- a/refs.h
+++ b/refs.h
@@ -402,6 +402,18 @@ typedef int (*head_ref_submodule_fn)(const char *submodule, each_ref_fn fn,
 				     void *cb_data);
 typedef int (*head_ref_namespaced_fn)(each_ref_fn fn, void *cb_data);
 
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
@@ -428,6 +440,14 @@ struct ref_be {
 	head_ref_fn head_ref;
 	head_ref_submodule_fn head_ref_submodule;
 	head_ref_namespaced_fn head_ref_namespaced;
+
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
2.0.1.553.geee1b3e
