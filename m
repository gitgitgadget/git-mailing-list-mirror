From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/12] delete_refs(): new function for the refs API
Date: Sat, 13 Jun 2015 16:42:07 +0200
Message-ID: <9a6c35bd603edfc46da241b8c762f1a269ac44f8.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3mdx-0007iJ-Fu
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbbFMOm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:28 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51272 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbbFMOmY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:24 -0400
X-AuditID: 1207440e-f79fc6d000000caf-ea-557c414f95b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.2D.03247.F414C755; Sat, 13 Jun 2015 10:42:24 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpS026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:23 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqBvgWBNqsGYjk0XXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4Mxav72MpuCRacfjGZNYGxoWCXYycHBICJhI/fj1ngrDFJC7cW8/WxcjFISRwmVFi7q6z
	rBDOCSaJ59deMIJUsQnoSizqaQbrEBFQk5jYdogFpIhZoINR4sLybewgCWEBN4nW9k3MIDaL
	gKrEn3UvgCZxcPAKREks/mwOsU1O4vzxn8wgYU4BC4mXTZkgYSEBc4m3K9pZJzDyLmBkWMUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokRElB8Oxjb18scYhTgYFTi4c2IrQ4V
	Yk0sK67MPcQoycGkJMobuQcoxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXULsmVIg3JbGyKrUo
	HyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMF7zR6oUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UGfHFwNgASfEA7X0I0s5bXJCYCxSFaD3FqCglznsLJCEAksgozYMb
	C0sTrxjFgb4U5j0PUsUDTDFw3a+ABjMBDW7vqQIZXJKIkJJqYMzSyAiVD/h+gz3QoeyI0e8d
	P9paOpX22Nvf37WAJUM/obqza38o/85nQkWFxjG/74RynDY2NFz8o2PzguJXz6V16k4d6cvm
	e6qk9DDrp/f3BCOVI7s2R069MI9L9IpLud3ndb85nk8XSKl9r3itejLvl3l/MtoW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271548>

Move the function remove_branches() from builtin/remote.c to refs.c,
rename it to delete_refs(), and make it public.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/remote.c | 21 +--------------------
 refs.c           | 19 +++++++++++++++++++
 refs.h           |  7 +++++++
 3 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 53b8e13..c8dc724 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -746,25 +746,6 @@ static int mv(int argc, const char **argv)
 	return 0;
 }
 
-static int remove_branches(struct string_list *branches)
-{
-	struct strbuf err = STRBUF_INIT;
-	int i, result = 0;
-
-	if (repack_without_refs(branches, &err))
-		result |= error("%s", err.buf);
-	strbuf_release(&err);
-
-	for (i = 0; i < branches->nr; i++) {
-		const char *refname = branches->items[i].string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
-	}
-
-	return result;
-}
-
 static int rm(int argc, const char **argv)
 {
 	struct option options[] = {
@@ -821,7 +802,7 @@ static int rm(int argc, const char **argv)
 	strbuf_release(&buf);
 
 	if (!result)
-		result = remove_branches(&branches);
+		result = delete_refs(&branches);
 	string_list_clear(&branches, 0);
 
 	if (skipped.nr) {
diff --git a/refs.c b/refs.c
index f0b6cec..6f62bd1 100644
--- a/refs.c
+++ b/refs.c
@@ -2818,6 +2818,25 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
+int delete_refs(struct string_list *refnames)
+{
+	struct strbuf err = STRBUF_INIT;
+	int i, result = 0;
+
+	if (repack_without_refs(refnames, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
+
+	for (i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+
+		if (delete_ref(refname, NULL, 0))
+			result |= error(_("Could not remove branch %s"), refname);
+	}
+
+	return result;
+}
+
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
diff --git a/refs.h b/refs.h
index 68b5e81..1a5d44a 100644
--- a/refs.h
+++ b/refs.h
@@ -212,6 +212,13 @@ extern int reflog_exists(const char *refname);
 extern int delete_ref(const char *refname, const unsigned char *old_sha1,
 		      unsigned int flags);
 
+/*
+ * Delete the specified references. If there are any problems, emit
+ * errors but attempt to keep going (i.e., the deletes are not done in
+ * an all-or-nothing transaction).
+ */
+extern int delete_refs(struct string_list *refnames);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4
