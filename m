From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 08/48] refs.c: add an err argument to repack_without_refs
Date: Tue, 17 Jun 2014 08:53:22 -0700
Message-ID: <1403020442-31049-9-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:58:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvm6-0000AW-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933616AbaFQP57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:57:59 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:41920 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1490516oac.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qluV8FvMG/b5tLu1YLqs2PQwYrocP/+U9pi9qMw+Q5U=;
        b=DzwRe3CPGqeOqX/Ke5YNwtjZfKCWirymwjokYAA3/+H4esjWPPoxcQeCvk4Js0kyjR
         Fc57haE0tUSzuMbf9XaTSYXwZN72c6pBq3QoM3aYMHQfiWUxmf4weuHMjxZTx2Z6PhT4
         OwrO8DmORlBsc7MqvGyeFd9lJPNbWLEgNmxP2OuFkNf11vtty19ocbpRDCtLkBmgn+NZ
         MbsA8CcT/r3Dpf4IDkNfggAVp0AEqQ2yqcaLiiYJPSlr/EaXFA1DT5aQA/jtc/7sYRLq
         wAkOpX5bLq2d8QBR9vUgZRP2Zwta2ab6xV/11xkjLl+xx8+kCL24H0mDAaF+LjIBLpjf
         yZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qluV8FvMG/b5tLu1YLqs2PQwYrocP/+U9pi9qMw+Q5U=;
        b=gX00KkRHadQEr7qgrPdw4Q5By/fF375I8XKOyPRBLJm8ZBtpoUlgWWSo+WoGFQ+RaD
         ZqqsSLpOJ/+k3+J+HTKzMOcRgkvfR02gUoWTo5oaMlsc0BSOIFOGHOPrSCh9kIemQSB7
         chAjOEBbjOYPjPUmWx4nqjCxunRjZ3KdcLV9lC8MZbGrWmd2EbhW7gCAamXZkiVJFctL
         7D6Nk1RScqD6s6zpfCUZ1B/27usN0pzqXCsE7CZ0U4NkbgwcyR5xosbtnzCxTk3m+Q4a
         5VBWNruW5HsGBr+J0BHXI6sPuamaLk0vlrWh9vCjaaR10Qs1XA3lfqUS+64SznLnh1iR
         wxlg==
X-Gm-Message-State: ALoCoQnU3nMw5rOl9z1YcnTNViC+RwgVg20bRugKrbtdu0KOSOC7v5hx3uSaZ1s0yFJqnkGOzWNF
X-Received: by 10.182.130.169 with SMTP id of9mr188824obb.27.1403020444742;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1207435yhl.7.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 7C6CD5A45BA;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 19F51E1129; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251918>

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
2.0.0.438.gec92e5c
