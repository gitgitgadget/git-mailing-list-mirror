From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] rename "match_refs()" to "match_push_refs()"
Date: Fri,  9 Sep 2011 13:41:43 -0700
Message-ID: <1315600904-17032-4-git-send-email-gitster@pobox.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 22:42:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R27te-0002zX-MZ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 22:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933677Ab1IIUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 16:41:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933652Ab1IIUlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 16:41:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FCD95E5E
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9oPh
	lhvYDyewfeDXyy+MbyJvW6k=; b=Ii3lMfJ2FKNqitMcZR1mZylOpOpDijUjYS7l
	0B6QQiBfxIO2e2r92ku+XktI6tEKnJP4uE1nmiksdMTfouDCwqDOlxEfXh8YvcRV
	DCBMmyU0I6QxNlxxOUHNlN1HNL7vqi1LMMadl47QvmX/NKEwlSyI194TEnYuBMfS
	q6M2XoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JqySLO
	YR2bB54aNsym9xo8rBTTKnnRuvGPrwttWi+pJp8O5/pfYbTX4oM453A4YAw9gyDk
	w9O4imWNXbgXOlfIgDbBTH2zD7V2zebYxtXHUoNjsQAysFdm5J9u4FWW/6/mVmbI
	fny73Qsn9pYktFq0o/sE78HPf1xPOShSCrs7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B925E5D
	for <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 960FF5E5B for
 <git@vger.kernel.org>; Fri,  9 Sep 2011 16:41:51 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.188.g3793ac
In-Reply-To: <1315600904-17032-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 258A5F82-DB24-11E0-9883-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181119>

Yes, there is a warning that says the function is only used by push in big
red letters in front of this function, but it didn't say a more important
thing it should have said: what the function is for and what it does.

Rename it and document it to avoid future confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c    |    4 ++--
 builtin/send-pack.c |    2 +-
 http-push.c         |    4 ++--
 remote.c            |   13 ++++++++-----
 remote.h            |    4 ++--
 transport.c         |    4 ++--
 6 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..f16b544 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -389,8 +389,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	local_refs = get_local_heads();
 	push_map = copy_ref_list(remote_refs);
 
-	match_refs(local_refs, &push_map, remote->push_refspec_nr,
-		   remote->push_refspec, MATCH_REFS_NONE);
+	match_push_refs(local_refs, &push_map, remote->push_refspec_nr,
+			remote->push_refspec, MATCH_REFS_NONE);
 
 	states->push.strdup_strings = 1;
 	for (ref = push_map; ref; ref = ref->next) {
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 87833f4..e0b8030 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -509,7 +509,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		flags |= MATCH_REFS_MIRROR;
 
 	/* match them up */
-	if (match_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
+	if (match_push_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
 		return -1;
 
 	set_ref_status_for_push(remote_refs, args.send_mirror,
diff --git a/http-push.c b/http-push.c
index 376331a..02f46a5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1877,8 +1877,8 @@ int main(int argc, char **argv)
 	}
 
 	/* match them up */
-	if (match_refs(local_refs, &remote_refs,
-		       nr_refspec, (const char **) refspec, push_all)) {
+	if (match_push_refs(local_refs, &remote_refs,
+			    nr_refspec, (const char **) refspec, push_all)) {
 		rc = -1;
 		goto cleanup;
 	}
diff --git a/remote.c b/remote.c
index b8ecfa5..536ffa3 100644
--- a/remote.c
+++ b/remote.c
@@ -1170,12 +1170,15 @@ static struct ref **tail_ref(struct ref **head)
 }
 
 /*
- * Note. This is used only by "push"; refspec matching rules for
- * push and fetch are subtly different, so do not try to reuse it
- * without thinking.
+ * Given the set of refs the local repository has, the set of refs the
+ * remote repository has, and the refspec used for push, determine
+ * what remote refs we will update and with what value by setting
+ * peer_ref (which object is being pushed) and force (if the push is
+ * forced) in elements of "dst". The function may add new elements to
+ * dst (e.g. pushing to a new branch, done in match_explicit_refs).
  */
-int match_refs(struct ref *src, struct ref **dst,
-	       int nr_refspec, const char **refspec, int flags)
+int match_push_refs(struct ref *src, struct ref **dst,
+		    int nr_refspec, const char **refspec, int flags)
 {
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
diff --git a/remote.h b/remote.h
index 9a30a9d..6729477 100644
--- a/remote.h
+++ b/remote.h
@@ -96,8 +96,8 @@ void free_refspec(int nr_refspec, struct refspec *refspec);
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 		     const char *name);
 
-int match_refs(struct ref *src, struct ref **dst,
-	       int nr_refspec, const char **refspec, int all);
+int match_push_refs(struct ref *src, struct ref **dst,
+		    int nr_refspec, const char **refspec, int all);
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	int force_update);
 
diff --git a/transport.c b/transport.c
index fa279d5..740a739 100644
--- a/transport.c
+++ b/transport.c
@@ -1033,8 +1033,8 @@ int transport_push(struct transport *transport,
 		if (flags & TRANSPORT_PUSH_MIRROR)
 			match_flags |= MATCH_REFS_MIRROR;
 
-		if (match_refs(local_refs, &remote_refs,
-			       refspec_nr, refspec, match_flags)) {
+		if (match_push_refs(local_refs, &remote_refs,
+				    refspec_nr, refspec, match_flags)) {
 			return -1;
 		}
 
-- 
1.7.7.rc0.188.g3793ac
