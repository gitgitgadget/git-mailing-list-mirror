From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 01/23] refs.c: create a public function for is_refname_available
Date: Tue, 19 Aug 2014 09:30:25 -0700
Message-ID: <1408465847-30384-2-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:31:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmJS-0002OV-QX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaHSQbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:06 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:59253 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbaHSQax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:53 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so798841qcz.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KkaSeXp/wZdkDBTzsmlQ85wxkxm2NMQF8df7/53eaRc=;
        b=YSHQYCIEfCwIZxBhG85SZ0Vz99qOmxW7q/tIEBfrmTApcSgwiYtRmW7YX0Lj+VHp46
         MaM7/uz2hH4cGlB+ursUoTn2rWWmEjf57MLaQOh8gYYpkAlgJrItlVrvf0qkbuaXcjeP
         XRLJGq1WC+a1ADcKmPJ4cicMROmzSwUEj6xxyIWObOmnBSPR5N5ZlrZWSxO7gMmRGAeb
         Jd+r+C8VgV7xODUtoK7+ba94WWLPFBGRzJTzzxwPFD9LEr6YqGKaS6is6fbKLxVYv4tx
         jzqWzE1SbP87WO68A6x6f7/ApLFx5CMGiG5ZAoYUoxIMp5pGkfis75uvJVhqV3YP6JGn
         gZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KkaSeXp/wZdkDBTzsmlQ85wxkxm2NMQF8df7/53eaRc=;
        b=CGennBRIarVWF18g5Fi/5nWsTDo+SQoDx9sRWxOB4H0IbNntcCNO0WoREUU+bdYVDa
         OV+EsKgwnLPs09aVhhwdVz3Lrc01sfXOZe+XB/OiSEIsqkVgyQLMpSE8wddURnmJQF4H
         TynypO9KvfE83MYwpQEfRs+7U57B2P6hl7fO5y/zul6YD9CJlF+DtIXDdVRp75Qkv4oA
         VpYEwA8B3Df1Tl6zcMwVafykvWzaSQ0EFYFA3WSdB1GbdhrRnHwF3MIXtEbtTonGoreU
         EJV+52lpXXAyf/BI4MG9TyYHH7m1A+usjZZ5ueax37sgUfjqdLLnPRdI9oOR7Mwhjp8h
         LE2A==
X-Gm-Message-State: ALoCoQn8PEykt9F6kWsK29Z+ri4HgmUc10TAmMLCABtEp47BcUnlwUmhBKvt+2Dxduk5cl4m4VnJ
X-Received: by 10.236.123.200 with SMTP id v48mr688738yhh.54.1408465852692;
        Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si332764yhg.1.2014.08.19.09.30.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8A79431C534;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B8B4E0E84; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255480>

Export a generic is_refname_available() function. We will need this
as a public shared function later when we add additional refs backends
since we want to keep using the same rules for ref naming across
all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 ++++++++++++++++++-----------
 refs.h |  6 ++++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 7e13c0f..4a22513 100644
--- a/refs.c
+++ b/refs.c
@@ -830,9 +830,9 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * operation). skip contains a list of refs we want to skip checking for
  * conflicts with.
  */
-static int is_refname_available(const char *refname,
-				struct ref_dir *dir,
-				const char **skip, int skipnum)
+static int is_refname_available_dir(const char *refname,
+				    struct ref_dir *dir,
+				    const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
@@ -1238,6 +1238,18 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
+int is_refname_available(const char *refname, const char **skip, int skipnum)
+{
+	if (!is_refname_available_dir(refname, get_packed_refs(&ref_cache),
+				      skip, skipnum))
+		return 0;
+
+	if (!is_refname_available_dir(refname, get_loose_refs(&ref_cache),
+				      skip, skipnum))
+		return 0;
+	return 1;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
@@ -2168,8 +2180,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, get_packed_refs(&ref_cache),
-				   skip, skipnum)) {
+	     !is_refname_available_dir(refname, get_packed_refs(&ref_cache),
+				       skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2676,12 +2688,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return 1;
 	}
 
-	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
-				  &oldrefname, 1))
-		return 1;
-
-	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
-				  &oldrefname, 1))
+	if (!is_refname_available(newrefname, &oldrefname, 1))
 		return 1;
 
 	log = reflog_exists(oldrefname);
diff --git a/refs.h b/refs.h
index f44b5c8..d526da0 100644
--- a/refs.h
+++ b/refs.h
@@ -131,6 +131,12 @@ extern int ref_exists(const char *);
 extern int is_branch(const char *refname);
 
 /*
+ * Check that a particular refname is available for creation. skip contains
+ * a list of refnames to exclude from the refname collision tests.
+ */
+int is_refname_available(const char *refname, const char **skip, int skipnum);
+
+/*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
  * store the SHA1 of the referred-to object to sha1 and return 0.  If
-- 
2.0.1.552.g1af257a
