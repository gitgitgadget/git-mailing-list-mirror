From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 08/48] refs.c: add an err argument to repack_without_refs
Date: Thu, 19 Jun 2014 08:52:50 -0700
Message-ID: <1403193210-6028-9-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxegs-0000Hk-OW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbaFSPzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:48 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:52148 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757861AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so250083igi.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIoxY9Pj4yIRPqczgZ/pOP95UqHf8YqCWfT5b1eabzM=;
        b=QQwVRx+/LQZUNeQjLGJhpJ+u2x9wVdMj9YazsVqSP3ArwhvdkLiOx53/hARnT/ysKF
         CwEkEmysxL6/IzxzONerAt2pSdXfOD8UBVTnBDmg1MxamCjUF0GKwQ9wu8Ye7OHUQE+x
         qy4lF7JhfKgP72uZkR8teSan0faQ5PN9fyJvv/Zh+jl5qO2erM9DSdxKvzc6DcWlrAJ/
         jiYPI638Olmbnb5dxH6HacGK1QDhMr0kmw2Rg83vAwm6yYZk72nX3F2KsD3o1+wcicdo
         IJYpBnhqOBSu70wnI7Rtl3926qCxEtBEJFLB/FWJSGEVsEw2YT8wHSdI+oS4nXnH+ytz
         RHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIoxY9Pj4yIRPqczgZ/pOP95UqHf8YqCWfT5b1eabzM=;
        b=enHlJDzO59KYuAGQ4UfZ1E2Xs65DIqMA5keGIX/s9tudFbsdGZ6Zkw6OVkse99ylBc
         Bxa88mgourgVwAvrQdSu8IqLRwJCjXyAY/1Z1I7iLjBazvNRHTnB8c4fBcc4F8dcBDsH
         YmcHxI/lhYqJkrowZRiLeFo5jtLFFUxmQL9cDNICdFajlZbgaDG+eM1IC/GxFx63wATl
         jjhyGTgcBH6aWGVA7id5T8Kt+1S+fq974tKooDPJ1pX/GawkryJXDBJg37U3HZQN2DnT
         OX6qzDeI9+Okd/fR165NdsHA7iEe34ep8ni4yg/jkpi5cBrF5UYR/o48XH1bpj2XWg3z
         5J9w==
X-Gm-Message-State: ALoCoQnoq8dwogxAcs2XJ+JhFWFiCffCE2y8JMsnO/ClwRGTfOo3xsUQFBqa2wstHDjcMJQQ07tF
X-Received: by 10.182.24.69 with SMTP id s5mr1032783obf.30.1403193213285;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si419896yhb.3.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0242231C416;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 94B91E0ED7; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252146>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/remote.c |  5 +++--
 refs.c           | 19 ++++++++++++++-----
 refs.h           |  3 ++-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c9102e8..401feb3 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -755,7 +755,7 @@ static int remove_branches(struct string_list *branches)
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
-	result |= repack_without_refs(branch_names, branches->nr);
+	result |= repack_without_refs(branch_names, branches->nr, NULL);
 	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
@@ -1333,7 +1333,8 @@ static int prune_remote(const char *remote, int dry_run)
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
 		if (!dry_run)
-			result |= repack_without_refs(delete_refs, states.stale.nr);
+			result |= repack_without_refs(delete_refs,
+						      states.stale.nr, NULL);
 		free(delete_refs);
 	}
 
diff --git a/refs.c b/refs.c
index e9d53e4..67a0217 100644
--- a/refs.c
+++ b/refs.c
@@ -2456,12 +2456,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-int repack_without_refs(const char **refnames, int n)
+int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2473,6 +2473,11 @@ int repack_without_refs(const char **refnames, int n)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
+		if (err) {
+			unable_to_lock_message(git_path("packed-refs"), errno,
+					       err);
+			return -1;
+		}
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
@@ -2499,12 +2504,16 @@ int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
+			    strerror(errno));
+	return ret;
 }
 
 static int repack_without_ref(const char *refname)
 {
-	return repack_without_refs(&refname, 1);
+	return repack_without_refs(&refname, 1, NULL);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
@@ -3508,7 +3517,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index 64f25d9..65f7637 100644
--- a/refs.h
+++ b/refs.h
@@ -122,7 +122,8 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-extern int repack_without_refs(const char **refnames, int n);
+extern int repack_without_refs(const char **refnames, int n,
+			       struct strbuf *err);
 
 extern int ref_exists(const char *);
 
-- 
2.0.0.438.g337c581
