From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 20/23] refs-be-files.c: add reflog backend methods
Date: Tue, 19 Aug 2014 09:30:44 -0700
Message-ID: <1408465847-30384-21-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKe-0002zZ-Cs
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbaHSQbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:51 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:37187 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so1804616pdj.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zbwhnmhWRnR1KBuw3wilIgc4zBkdGAx78dJ/tLZ0/VM=;
        b=WbZ7MAgPX3a5eDhuMn5Vb+IgBamXJynzhRxiuufm3ulXRbyKWqyqxozcc71WotjxUe
         4vJQ+gK4cKdpuEMfmWSfhYDIiJV2HCzbbw50io3lRs5p6fHDb1C51WbKiMC8d2zycP4R
         5iRZA1fYkL7OM1FEqqFshoLYit8Rz0a/YVybXIDnSFEZo4ZlfUiSNs/qEBYHqp73CK57
         BmpVorWB3DeiL7g51lniWoFN/x4izhTyqr4+yIn2WTCySYLFRGAvkpYLuV5CnoS4hJUA
         sd7wq+fi9NQTitUccCpyb3yihnMnEfXZflHx19IexANcMaEJ6tbe3YEgb1oSS12y2I37
         xHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zbwhnmhWRnR1KBuw3wilIgc4zBkdGAx78dJ/tLZ0/VM=;
        b=VvWYl/Np9a05vMsV3MGXEgDuE2WuMWcuhZH6vzrursd+Pu7JdAyqYniuWZ31DtJR/r
         NTJg/tf34XCtILsDD3wK24hbELBG+Mv0TQo8GV/enkWBBlmDbes3Xbo+miAc7zdWbwPJ
         H0kid38/iA+ca3Aevouqyw1WDzT2uXefGYgsVgDZFNHgdU1n6lSPhIGJ0moAXoFpOQ2U
         O5hvAo43kyF17BMn4z7VK4I0n6MkVk3NJdI9zadq04Rl9FqnAWQrPluBrvAUBEEB+WGF
         0wsRgn0M+kor077hE0XNW5MpAbqKmuM5udPchGQjnWwoGiXdp9O4KF5/+kJrcE2GXMkE
         ZpKg==
X-Gm-Message-State: ALoCoQkJix/CYfZGNAbQgyx0l0veqxKbo8EK6ryIP2OpfWEjGL1dHyhDdsCZGBOd/pk8IvIwk1vh
X-Received: by 10.66.144.102 with SMTP id sl6mr22458983pab.17.1408465853746;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si329150yhe.2.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7762031C538;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 43BE1E11B0; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255489>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 21 +++++++++++++++------
 refs.c          | 32 ++++++++++++++++++++++++++++++++
 refs.h          | 16 ++++++++++++++++
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 27eafd0..464d488 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2251,7 +2251,7 @@ static int copy_msg(char *buf, const char *msg)
 }
 
 /* This function must set a meaningful errno on failure */
-int create_reflog(const char *refname)
+static int files_create_reflog(const char *refname)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 	char logfile[PATH_MAX];
@@ -2516,7 +2516,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-int reflog_exists(const char *refname)
+static int files_reflog_exists(const char *refname)
 {
 	struct stat st;
 
@@ -2524,7 +2524,7 @@ int reflog_exists(const char *refname)
 		S_ISREG(st.st_mode);
 }
 
-int delete_reflog(const char *refname)
+static int files_delete_reflog(const char *refname)
 {
 	return remove_path(git_path("logs/%s", refname));
 }
@@ -2568,7 +2568,9 @@ static char *find_beginning_of_line(char *bob, char *scan)
 	return scan;
 }
 
-int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent_reverse(const char *refname,
+					     each_reflog_ent_fn fn,
+					     void *cb_data)
 {
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
@@ -2645,7 +2647,8 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 	return ret;
 }
 
-int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data)
+static int files_for_each_reflog_ent(const char *refname,
+				     each_reflog_ent_fn fn, void *cb_data)
 {
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
@@ -2706,7 +2709,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 	return retval;
 }
 
-int for_each_reflog(each_ref_fn fn, void *cb_data)
+static int files_for_each_reflog(each_ref_fn fn, void *cb_data)
 {
 	int retval;
 	struct strbuf name;
@@ -3295,6 +3298,12 @@ struct ref_be refs_files = {
 	files_transaction_update_reflog,
 	files_transaction_commit,
 	files_transaction_free,
+	files_for_each_reflog_ent,
+	files_for_each_reflog_ent_reverse,
+	files_for_each_reflog,
+	files_reflog_exists,
+	files_create_reflog,
+	files_delete_reflog,
 };
 
 struct ref_be *refs = &refs_files;
diff --git a/refs.c b/refs.c
index b8c942f..2db1a74 100644
--- a/refs.c
+++ b/refs.c
@@ -856,3 +856,35 @@ void transaction_free(struct ref_transaction *transaction)
 {
 	return refs->transaction_free(transaction);
 }
+
+int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn,
+				void *cb_data)
+{
+	return refs->for_each_reflog_ent_reverse(refname, fn, cb_data);
+}
+
+int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn,
+			void *cb_data)
+{
+	return refs->for_each_reflog_ent(refname, fn, cb_data);
+}
+
+int for_each_reflog(each_ref_fn fn, void *cb_data)
+{
+	return refs->for_each_reflog(fn, cb_data);
+}
+
+int reflog_exists(const char *refname)
+{
+	return refs->reflog_exists(refname);
+}
+
+int create_reflog(const char *refname)
+{
+	return refs->create_reflog(refname);
+}
+
+int delete_reflog(const char *refname)
+{
+	return refs->delete_reflog(refname);
+}
diff --git a/refs.h b/refs.h
index 4b669f5..0a68986 100644
--- a/refs.h
+++ b/refs.h
@@ -372,6 +372,16 @@ typedef int (*transaction_update_reflog_fn)(
 typedef int (*transaction_commit_fn)(struct ref_transaction *transaction,
 				       struct strbuf *err);
 typedef void (*transaction_free_fn)(struct ref_transaction *transaction);
+typedef int (*for_each_reflog_ent_fn)(const char *refname,
+				      each_reflog_ent_fn fn,
+				      void *cb_data);
+typedef int (*for_each_reflog_ent_reverse_fn)(const char *refname,
+					      each_reflog_ent_fn fn,
+					      void *cb_data);
+typedef int (*for_each_reflog_fn)(each_ref_fn fn, void *cb_data);
+typedef int (*reflog_exists_fn)(const char *refname);
+typedef int (*create_reflog_fn)(const char *refname);
+typedef int (*delete_reflog_fn)(const char *refname);
 
 struct ref_be {
 	transaction_begin_fn transaction_begin;
@@ -381,6 +391,12 @@ struct ref_be {
 	transaction_update_reflog_fn transaction_update_reflog;
 	transaction_commit_fn transaction_commit;
 	transaction_free_fn transaction_free;
+	for_each_reflog_ent_fn for_each_reflog_ent;
+	for_each_reflog_ent_reverse_fn for_each_reflog_ent_reverse;
+	for_each_reflog_fn for_each_reflog;
+	reflog_exists_fn reflog_exists;
+	create_reflog_fn create_reflog;
+	delete_reflog_fn delete_reflog;
 };
 
 extern struct ref_be *refs;
-- 
2.0.1.552.g1af257a
