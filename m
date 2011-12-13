From: mhagger@alum.mit.edu
Subject: [PATCH 2/6] add_extra_ref(): remove flag argument
Date: Tue, 13 Dec 2011 21:06:47 +0100
Message-ID: <1323806811-5798-3-git-send-email-mhagger@alum.mit.edu>
References: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 21:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaYdH-0001PP-BL
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 21:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755704Ab1LMUHE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 15:07:04 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:37189 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab1LMUHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 15:07:00 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RaYUP-0006aj-Oq; Tue, 13 Dec 2011 20:58:13 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323806811-5798-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187054>

From: Michael Haggerty <mhagger@alum.mit.edu>

The argument was always set to 0 (and other values do not make sense)
so remove the argument.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/clone.c        |    4 ++--
 builtin/receive-pack.c |    2 +-
 refs.c                 |    4 ++--
 refs.h                 |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..5035767 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -252,7 +252,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	transport = transport_get(remote, ref_git);
 	for (extra = transport_get_remote_refs(transport); extra;
 	     extra = extra->next)
-		add_extra_ref(extra->name, extra->old_sha1, 0);
+		add_extra_ref(extra->name, extra->old_sha1);
 
 	transport_disconnect(transport);
 	free(ref_git);
@@ -441,7 +441,7 @@ static void write_remote_refs(const struct ref *local_refs)
 	for (r = local_refs; r; r = r->next) {
 		if (!r->peer_ref)
 			continue;
-		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
+		add_extra_ref(r->peer_ref->name, r->old_sha1);
 	}
 
 	pack_refs(PACK_REFS_ALL);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b6d957c..e3b46ce 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -872,7 +872,7 @@ static int delete_only(struct command *commands)
 
 static void add_one_alternate_sha1(const unsigned char sha1[20], void *unused)
 {
-	add_extra_ref(".have", sha1, 0);
+	add_extra_ref(".have", sha1);
 }
 
 static void collect_one_alternate_ref(const struct ref *ref, void *data)
diff --git a/refs.c b/refs.c
index f5cb297..6115487 100644
--- a/refs.c
+++ b/refs.c
@@ -248,9 +248,9 @@ static void read_packed_refs(FILE *f, struct ref_array *array)
 	sort_ref_array(array);
 }
 
-void add_extra_ref(const char *name, const unsigned char *sha1, int flag)
+void add_extra_ref(const char *name, const unsigned char *sha1)
 {
-	add_ref(name, sha1, flag, 0, &extra_refs, NULL);
+	add_ref(name, sha1, 0, 0, &extra_refs, NULL);
 }
 
 void clear_extra_refs(void)
diff --git a/refs.h b/refs.h
index 3fd5536..39bb289 100644
--- a/refs.h
+++ b/refs.h
@@ -56,7 +56,7 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
  * called. Only extra refs added before for_each_ref() is called will
  * be listed on a given call of for_each_ref().
  */
-extern void add_extra_ref(const char *refname, const unsigned char *sha1, int flags);
+extern void add_extra_ref(const char *refname, const unsigned char *sha1);
 extern void clear_extra_refs(void);
 extern int ref_exists(const char *);
 
-- 
1.7.8
