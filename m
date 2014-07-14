From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 08/19] refs.c: add an err argument to repack_without_refs
Date: Mon, 14 Jul 2014 13:58:50 -0700
Message-ID: <1405371541-32121-9-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLS-0002z1-R8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757179AbaGNU73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:29 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:33745 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so821417vcb.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TjIN17Qww6rupoAXIakmg4QaP9IWOsUhXq0DHlGDOjk=;
        b=TrXNupBWrO0kPXnB3FtVrA/BhuHhWouQoUfWqmSf5Ot7/b3u4Yq6p/VhdcDaJqZg0d
         4UAXbpoWK+vkmPjoc7k6NrE7MDAP9zSXscVnGHEnjRaT7Xi0hz7UO7aJEfefVrzuK/Vr
         scUe/cUEYgKiehTS03tCaNT2SZmuBIkLXjL8oQU8WRxz/75tcmq2SCNMt/Iz+oglLyXT
         CPtFhlD7EvJzZ2T6bT4gUXZ1J6gEflK7MgJEXTENzB7rq5+YytBXEPlCvcW5+juIM8As
         CRjGUTNHBzjRD38dOrswD2UMqo3en2jCgTDLQzoIqT/TgTI+PEB+okH9mOcq4qzZWc5H
         Y2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TjIN17Qww6rupoAXIakmg4QaP9IWOsUhXq0DHlGDOjk=;
        b=it5l30P1rsykw5/0WoW7qJryETdqUaLwTv+6GtdIy06zcohEQckzW2Z4DLOP7kuEZu
         orwPQO4kGF0Q7zf67/KzS7uSmHTgHlT8yXQyz1uXrQE7DqDT1n06FXU7qSckmjbfojum
         JRBzr/X2b6H6WOOfBjGUa1EJMli6+DBg/xndhzaLIyExmuIDiuaFqdsfIFNsVOQc6ZEy
         C0tULuj4JhID4npHw8NggX3c91uWyQnEqwFkrp6UxrsKfh0WNYbhEDrO1zVslhn2nMSV
         d7ivBuyrp/QdQtST0b4XRRItBM9xFf9WJIpkI/OJCT0n0j4i+kfgKb74jIPHxpcXxn+9
         sxfQ==
X-Gm-Message-State: ALoCoQkw7GMDslvQ9DPP/PRUZRwjZD7plSragEDRKHXxXD/TjRwXGQ+PdF9lMwG7Jc0yxd4enGD3
X-Received: by 10.58.94.166 with SMTP id dd6mr9143906veb.12.1405371546018;
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si820542yhp.6.2014.07.14.13.59.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B21CD31C42D;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 70389E07FA; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253520>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
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
2.0.1.546.gf603308
