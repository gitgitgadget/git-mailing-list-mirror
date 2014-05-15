From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 04/44] refs.c: add an err argument to repack_without_refs
Date: Thu, 15 May 2014 10:29:19 -0700
Message-ID: <1400174999-26786-5-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzTz-0006Dh-79
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715AbaEORaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:62295 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so289883obc.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uBERELVjhlPDZ2+dLOPNZrtemVwuFN0iRbnAeYjyAQs=;
        b=goqymvG0x6KfxklZOqF4uUEDg3HyQRN+TAmUlK8pqIOP1qn6jfegoe7baXfieI40C7
         MwkaWR5NMDlOHJSI+4lVuyUrJh/SiBCfm3H0EgyaHrfDoyl0c10O3cBpBhelgmXG1LEs
         TUqix3wBmtKdJ4ypDysejTT3Oyxt74JlAPJCBE0bqH5tRWqd7oHxGXdr2OVnXin4CSqY
         vkof9PFZQdzbJKj6BS1c3Tye5TqoHU35RGdN8PSU4OR+V1QcUSWsB1/p+C6SnV27SAHZ
         e7KFZ3fUcIFH4tqqY/XM5w0O7APoKDncOQB/oiGe4ilQzR88dpYeN29LDlOaV6o245tx
         cS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uBERELVjhlPDZ2+dLOPNZrtemVwuFN0iRbnAeYjyAQs=;
        b=NdHJqOQFSdc1fsoviCJ9w3zoeihW19YX6VHaDTt4L9IMHg/YJvDXYB+E2NxkGbWZOl
         aQSxmwO1KIW+F4TyOwu8TqaJ2LhA/Kld7Yjo71TLYWRIoHxZQHdt71JSNqbjLAPR5IMO
         uIw9xcBp62FdOxQUdgI2rYr0kySQEgASpfl222Fh8y5slZF04ABNy1DLsZMGVzzlfcUW
         0GMLQWDL/XoEQ1YDav4xUKGpIzquoAs2cXI29vJOTqR1Y37NpC/Y6euK04nzXu0bb3Tw
         AjvgwoxRKdWeMhr7+btyLDi87+iW0Rd1oSw1NDKL2Q8rX/9cYN86FCRE7xhFRpvKzWZe
         m8AQ==
X-Gm-Message-State: ALoCoQlLFDUrOeOrCrkg18X57fh5dnqpAwxQQDqE+tp09oPC3h7r6qFH79CMc0/5oU7NF2k21tGB
X-Received: by 10.182.28.102 with SMTP id a6mr4169311obh.44.1400175005968;
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si272068yhl.7.2014.05.15.10.30.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CADF031C1CD;
	Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C411E1129; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249123>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to a problem in repack_without_refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 1a7f9d9..c2b720e 100644
--- a/refs.c
+++ b/refs.c
@@ -2427,12 +2427,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_refs(const char **refnames, int n)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2445,6 +2445,9 @@ static int repack_without_refs(const char **refnames, int n)
 
 	if (lock_packed_refs(0)) {
 		unable_to_lock_error(git_path("packed-refs"), errno);
+		if (err)
+			strbuf_addf(err, "cannot delete '%s' from packed refs",
+				    refnames[i]);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
 	packed = get_packed_refs(&ref_cache);
@@ -2470,12 +2473,15 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file");
+	return ret;
 }
 
 static int repack_without_ref(const char *refname)
 {
-	return repack_without_refs(&refname, 1);
+	return repack_without_refs(&refname, 1, NULL);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
@@ -3486,7 +3492,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.rc3.477.g0f8edf7
