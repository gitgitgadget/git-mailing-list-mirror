From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 08/48] refs.c: add an err argument to repack_without_refs
Date: Fri, 20 Jun 2014 07:42:49 -0700
Message-ID: <1403275409-28173-9-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02x-0001No-Qr
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489AbaFTOnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:43 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:55813 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-ob0-f202.google.com with SMTP id va2so192826obc.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=guFQBkTmkGAxhnyObOfB31gi3VjEWZJegAmLgIbG2FQ=;
        b=BzxM9hWHk1no/J9GjzDI/BRjJmr3DJfwVCiotMCVPfa28EwXg1+I6oglD7jXt4jWDp
         e3MrItgMSY2gkBhW5CCUzH307yWJ9Llk43r2022vL8N0+botrOTq8Eqx4E1oOr/yRJhB
         exIC1foulrFVz1kPUP9G1q8SXNl7YUNpkPzcHhTFh6Gjpjw3jCS2PYI4lK9MdTk7/DqP
         6Uyj2CScQiqGCl5aaNl6vJP+KV6BZsR50eAz6qEX6yzYyLemPZzFLustOETMWg/5/K18
         e9H5GkVxcXNuegejFoYJmV5nnw+MqV99Zz0oaA9VWA+anzo85SB7KW8BnIqmolvegBsj
         7aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=guFQBkTmkGAxhnyObOfB31gi3VjEWZJegAmLgIbG2FQ=;
        b=W1ttK6EPVefk7ZcPorUdFGAzwb+Vft974Y1LqXDFXrJ1V+LyNrPWbacAt4OwbcCLvC
         0CQkCNIA7aRIAdwIMGhb0zY/JkCgzMqI0BrjcBYynGWk/W+TZiJjhxI6KpY+ekWwBm81
         skYI6ldnPKTsWMs0nPPFuxvekG0+XJCs2otkaki2u5Ie9mHZhZsCAdGWiwypJ3I0xd+N
         eW+s4QMoAm0jJvXf5UD4nJnPdHM5RD5kGbkc6mrWffA9QAJsOxDMOpuC2nfLwvRGG2Es
         APQSupIUlSxIf2beTpg8JZx6MUsdUIma4OtBvgaHI7JhHQY8BPVfkJ9rifKspS81PdaD
         cCnw==
X-Gm-Message-State: ALoCoQnB1eOmxI0PDORWq+CsiZY8z+u6bQdzeBZBJCC81uYBDxWPun7Kj0DawnXigKUfgzE03DTd
X-Received: by 10.50.85.102 with SMTP id g6mr1509836igz.8.1403275412445;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si665231yhi.1.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 33EA831C6B5;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D38D3E0ABA; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252233>

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
2.0.0.420.g181e020.dirty
