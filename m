From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/22] refs.c: create a public function for is_refname_available
Date: Fri,  8 Aug 2014 09:44:48 -0700
Message-ID: <1407516309-27989-2-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIC-0007Hj-TL
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701AbaHHQpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:19 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:57369 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so1475619pdj.0
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3XOhhJNxbV30sMtZjw0Wsh+NiBFSRkkHqgdUkcP861g=;
        b=X+Zc33LAA2QndLXSXayRuAuaP3+sV7Exlx2zlmTyJuhjuCnOFLFm55z7QWHnfXFvht
         mxKEbW8wVcbGkYG14C0dI2qNqQFKFNTJkXEsiJ38ertifjE64Pmnroui7G32HL2+EJHi
         /1dNQ6XmnTLLGKGOih93bbMAUFAN2MbVwtD+SGjrGdX1zx/5FuDJt475Ok0qPRwF2tob
         kVoPWsNK+NN23aUqFEgBU32tD8fJZsaPt56c/kyQ8KjvkSRx4B3+EZEudbqPPISugKAZ
         K5Nj44b7agDXPuXkQbKkwhAD9SYJBKoVphPggztmvNgsVQ5iCzIgG3PwKePDSe3zBQ1K
         GkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3XOhhJNxbV30sMtZjw0Wsh+NiBFSRkkHqgdUkcP861g=;
        b=QOnPuVOhGP0LM76nx/GKvG6bD0yveF/pGaVu5v8T0YF9IQkdjeK0NYaztbfx4p5nOy
         0aGrcpQHEyyB6Hup4oRF85+3tinxTJqMeq5ddfeyvXMK7K93lV8w/n9JMmGWt5NVyTRj
         dPW3mS18SunLKAuams57Ep1kgIRYu+xy0rEwVEQZDnY4KgEEH98HEKlLVfGdYrXI217B
         Vr5ZS2iOx4stWh/Hsf1GClcKfCChCL0cxtBtSGAzYsLxLueimiUktW5L1LkkJusYQJR/
         R94zn+rQ4LVOpql/VXvpka52L00Jx+hUy6VAo+k+oPe01QhnslyHXZC/u9MJoNV2RQXA
         x+RA==
X-Gm-Message-State: ALoCoQno0n3hbNmBUanBUriz1MI1RxHef7RuHjOjmAC1f5zTylZcE0kcT6M1hBGCTgSkhqsAv5pJ
X-Received: by 10.66.193.227 with SMTP id hr3mr6469016pac.0.1407516315480;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si504803yhb.3.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 43F265A4615;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DEA62E0D62; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255025>

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
index f44b5c8..7b59044 100644
--- a/refs.h
+++ b/refs.h
@@ -131,6 +131,12 @@ extern int ref_exists(const char *);
 extern int is_branch(const char *refname);
 
 /*
+ * Check is a particular refname is available for creation. skip contains
+ * a list of refnames to exclude from the refname collission tests.
+ */
+int is_refname_available(const char *refname, const char **skip, int skipnum);
+
+/*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
  * store the SHA1 of the referred-to object to sha1 and return 0.  If
-- 
2.0.1.553.geee1b3e
