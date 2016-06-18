Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7FE1FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbcFREPg (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:36 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:64356 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751132AbcFREPe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:34 -0400
X-AuditID: 12074411-e2bff70000000955-89-5764cae560d8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 66.9A.02389.5EAC4675; Sat, 18 Jun 2016 00:15:33 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJf029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:31 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/13] delete_refs(): add a flags argument
Date:	Sat, 18 Jun 2016 06:15:10 +0200
Message-Id: <daa9f7a2f12394c00c6791bdaafadedd4f3004dc.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv0VEq4QX+rmMX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDO+X5rFXLBNrOL212OMDYxzhLoY
	OTkkBEwkNh3fxdLFyMUhJLCVUeLFl9NQzkkmic+7NjODVLEJ6Eos6mlmArFFBCIkGl61MIIU
	MQvMYZK4/bATrEhYwFbi6eFfjCA2i4CqxN/ffawgNq9AlMSuSXPYINbJSVye/gDM5hSwkFiw
	ZR/QUA6gbeYSexcbTmDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMj
	JOgEdzDOOCl3iFGAg1GJhzfAPiVciDWxrLgy9xCjJAeTkijvlUqgEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHeLSeAcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCV6L
	k0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAYiC8GRgFIigdorz5IO29xQWIu
	UBSi9RSjopQ47wKQgwRAEhmleXBjYankFaM40JfCvOtA2nmAaQiu+xXQYCagwZrzkkEGlyQi
	pKQaGHO5xOd+ylqo/73E8YJDVe6GgmiTwGbTWXvcz69dmRl04JVT+LMfr6omzlm00N68cUFX
	We7GTztnijGankhcJifidv7wqplnJl07ZWfmZCY4T0ziOCej4jK9QoWN341aV/S8/NItfNz8
	TcPB4xNDrwMd/tP+H+PGMIWvDJPcLkZ4eruF82hfUGIpzkg01GIuKk4EAHh0pjAAAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This will be useful for passing REF_NODEREF through.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch.c      | 2 +-
 builtin/remote.c     | 4 ++--
 refs.h               | 5 +++--
 refs/files-backend.c | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f8455bd..b55c83c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -806,7 +806,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 		for (ref = stale_refs; ref; ref = ref->next)
 			string_list_append(&refnames, ref->name);
 
-		result = delete_refs(&refnames);
+		result = delete_refs(&refnames, 0);
 		string_list_clear(&refnames, 0);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index fda5c2e..1bbf9b4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -788,7 +788,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = delete_refs(&branches);
+		result = delete_refs(&branches, 0);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
@@ -1303,7 +1303,7 @@ static int prune_remote(const char *remote, int dry_run)
 	string_list_sort(&refs_to_prune);
 
 	if (!dry_run)
-		result |= delete_refs(&refs_to_prune);
+		result |= delete_refs(&refs_to_prune, 0);
 
 	for_each_string_list_item(item, &states.stale) {
 		const char *refname = item->util;
diff --git a/refs.h b/refs.h
index 21874f0..6d515a4 100644
--- a/refs.h
+++ b/refs.h
@@ -274,9 +274,10 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 /*
  * Delete the specified references. If there are any problems, emit
  * errors but attempt to keep going (i.e., the deletes are not done in
- * an all-or-nothing transaction).
+ * an all-or-nothing transaction). flags is passed through to
+ * ref_transaction_delete().
  */
-int delete_refs(struct string_list *refnames);
+int delete_refs(struct string_list *refnames, unsigned int flags);
 
 /** Delete a reflog */
 int delete_reflog(const char *refname);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d5c4789..e15f7ae 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2403,7 +2403,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_refs(struct string_list *refnames)
+int delete_refs(struct string_list *refnames, unsigned int flags)
 {
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
@@ -2432,7 +2432,7 @@ int delete_refs(struct string_list *refnames)
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
 
-		if (delete_ref(refname, NULL, 0))
+		if (delete_ref(refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
 
-- 
2.8.1

