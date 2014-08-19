From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 23/23] refs-be-files.c: add methods for the ref iterators
Date: Tue, 19 Aug 2014 09:30:47 -0700
Message-ID: <1408465847-30384-24-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKa-0002zZ-7r
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbaHSQbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:31 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:43546 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbaHSQaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:55 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so216927iec.3
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DtDZ6nJ46DQKr+0VWS+Dgmh264RwdGHMfBk7k5qXBhY=;
        b=QbkwHO+R3V+r9+LngwobAvOvTB75PgS/yMSwpaUiL/xmJTPVfjVZ8KK9/q4naEDiyg
         9kz2LDEoU4okgKZAI0xEUz0CgC9aZPIKuddXx40CyaHBTLl4x5gd1CdU0Ne9+3YiJY0b
         wALJwSm43oqOPICqAocafJ5u8OpnM/jyNi5M9Zl/Xj+fvEzGh1KsL/kNCIwZW3UyH+Kp
         r1G8zDNK3OIOYRKnFaA6KFZS5EqpFHwW8ozrLde273b1S2wXVBq1L+ZH/F63XFEU2nk7
         Ikd8XceG3hTI7tAnpmFufTpcb64QjaIoPu/QoFMmAgTmKOgQKWhDtejhzq5l7c16Rvj5
         vbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DtDZ6nJ46DQKr+0VWS+Dgmh264RwdGHMfBk7k5qXBhY=;
        b=V6qmWVVy/0rk1cowHJqJs6CXHQSuzso0Gk9H9ChmfB5i69lwKD16TR0Bkui93tkXm6
         eMCwpqLMO30c9Iu1k3yrlG2FLrRFdPfr+89SdtZraesJcug81l0yFmTO4+gL/JnYfNvj
         a2cmcy73ux5lmyuxCTLgLY1JyiowB+yQVIb6CJH8Mm4f2RTQ77QsD0mHGWXBxCeB1W9X
         AoF6U5V6Ez4DI8H43eBGw1MI/d3M+QgyliGBs78gcAs4ZOQFRGojrdwPv3Cu7kH6PXcc
         a/sm87z9OSLk27OSjXqTD0GWG7/E34Fs8gZm4i3SY2KRrP3314cJidJ7li3ZKtttsHFn
         uEvQ==
X-Gm-Message-State: ALoCoQkPn439g/CWOz+edi9d8E0QCMB2ui2wb6cogR70QFwUc8gqPgTyWN2nvHhmAombO7YG4cf2
X-Received: by 10.50.73.5 with SMTP id h5mr3649110igv.2.1408465853984;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l23si332772yhg.1.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 894B95A441C;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 67039E119C; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255493>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 21 ++++++++++++++-------
 refs.c          | 36 ++++++++++++++++++++++++++++++++++++
 refs.h          | 18 ++++++++++++++++++
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 910663b..7c0ab25 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1614,33 +1614,33 @@ static int files_head_ref_submodule(const char *submodule, each_ref_fn fn,
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
@@ -1650,7 +1650,7 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	return ret;
 }
 
-int for_each_rawref(each_ref_fn fn, void *cb_data)
+static int files_for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
@@ -3318,6 +3318,13 @@ struct ref_be refs_files = {
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
diff --git a/refs.c b/refs.c
index 841d905..ceee979 100644
--- a/refs.c
+++ b/refs.c
@@ -931,3 +931,39 @@ int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
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
diff --git a/refs.h b/refs.h
index 92f8f44..bd3a0d4 100644
--- a/refs.h
+++ b/refs.h
@@ -397,6 +397,17 @@ typedef int (*resolve_gitlink_ref_fn)(const char *path, const char *refname,
 typedef int (*head_ref_fn)(each_ref_fn fn, void *cb_data);
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
 
 struct ref_be {
 	transaction_begin_fn transaction_begin;
@@ -420,6 +431,13 @@ struct ref_be {
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
2.0.1.552.g1af257a
