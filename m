From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] refs.c: move dwim_ref()/dwim_log() from sha1_name.c
Date: Wed, 12 Oct 2011 10:48:40 -0700
Message-ID: <7vzkh69k3r.fsf_-_@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 19:48:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE2vB-00042j-Dh
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 19:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab1JLRso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 13:48:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab1JLRsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 13:48:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0874C54A4;
	Wed, 12 Oct 2011 13:48:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9c2pYIToSFX9vrxoGSLn0Z8Adck=; b=XhN8sr
	6yAGRcKEk1aRxGlvbykTL5u9Kzl447Ketsjb7VwVDjBdrbFih9NwMNu4lLCenwsl
	q8pd7msrXabgMYsiP+p09rLXO/uoiUWrFALvLkoHX1e37SXkEKBqFKWJZkMmCekZ
	1boar27JwqtlONXvMQkaS03eW8uiWFGizcSJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ByH2/M7Xlv7cT7WzZ0eON5EoXDGXfAbi
	Sas5Yf5fR5UG4kbftCjXzy+04GbOZ73YvbDyE4O6ZEM/+N3ujE/V+hW+4LeyoGTX
	GK6qygNeo9Vr/zpH3ComiCN+jEIybIjFfTokDQ6/B7dQxVDZxglYeq4F3PG4cZYr
	4Z+PK7CgALo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECDCC54A3;
	Wed, 12 Oct 2011 13:48:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEFC254A0; Wed, 12 Oct 2011
 13:48:41 -0400 (EDT)
In-Reply-To: <20111012045004.GA22413@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Oct 2011 00:50:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C78211E-F4FA-11E0-834C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183379>

OK, so here is a re-roll of the one from yesterday. This one is new but is
a mere preparatory step.

-- >8 --

Both dwim_ref()/dwim_log() functions are intimately related to the ref
parsing rules defined in refs.c and better fits there. Move them together
with substitute_branch_name(), a file scope static helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c      |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1_name.c |   85 -----------------------------------------------------------
 2 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/refs.c b/refs.c
index 832a52f..e3692bd 100644
--- a/refs.c
+++ b/refs.c
@@ -1067,6 +1067,91 @@ static int is_refname_available(const char *ref, const char *oldref,
 	return 1;
 }
 
+/*
+ * *string and *len will only be substituted, and *string returned (for
+ * later free()ing) if the string passed in is a magic short-hand form
+ * to name a branch.
+ */
+static char *substitute_branch_name(const char **string, int *len)
+{
+	struct strbuf buf = STRBUF_INIT;
+	int ret = interpret_branch_name(*string, &buf);
+
+	if (ret == *len) {
+		size_t size;
+		*string = strbuf_detach(&buf, &size);
+		*len = size;
+		return (char *)*string;
+	}
+
+	return NULL;
+}
+
+int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p, *r;
+	int refs_found = 0;
+
+	*ref = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		char fullref[PATH_MAX];
+		unsigned char sha1_from_ref[20];
+		unsigned char *this_result;
+		int flag;
+
+		this_result = refs_found ? sha1_from_ref : sha1;
+		mksnpath(fullref, sizeof(fullref), *p, len, str);
+		r = resolve_ref(fullref, this_result, 1, &flag);
+		if (r) {
+			if (!refs_found++)
+				*ref = xstrdup(r);
+			if (!warn_ambiguous_refs)
+				break;
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD"))
+			warning("ignoring dangling symref %s.", fullref);
+	}
+	free(last_branch);
+	return refs_found;
+}
+
+int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+{
+	char *last_branch = substitute_branch_name(&str, &len);
+	const char **p;
+	int logs_found = 0;
+
+	*log = NULL;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		struct stat st;
+		unsigned char hash[20];
+		char path[PATH_MAX];
+		const char *ref, *it;
+
+		mksnpath(path, sizeof(path), *p, len, str);
+		ref = resolve_ref(path, hash, 1, NULL);
+		if (!ref)
+			continue;
+		if (!stat(git_path("logs/%s", path), &st) &&
+		    S_ISREG(st.st_mode))
+			it = path;
+		else if (strcmp(ref, path) &&
+			 !stat(git_path("logs/%s", ref), &st) &&
+			 S_ISREG(st.st_mode))
+			it = ref;
+		else
+			continue;
+		if (!logs_found++) {
+			*log = xstrdup(it);
+			hashcpy(sha1, hash);
+		}
+		if (!warn_ambiguous_refs)
+			break;
+	}
+	free(last_branch);
+	return logs_found;
+}
+
 static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int flags, int *type_p)
 {
 	char *ref_file;
diff --git a/sha1_name.c b/sha1_name.c
index 143fd97..d423635 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -241,91 +241,6 @@ static int ambiguous_path(const char *path, int len)
 	return slash;
 }
 
-/*
- * *string and *len will only be substituted, and *string returned (for
- * later free()ing) if the string passed in is a magic short-hand form
- * to name a branch.
- */
-static char *substitute_branch_name(const char **string, int *len)
-{
-	struct strbuf buf = STRBUF_INIT;
-	int ret = interpret_branch_name(*string, &buf);
-
-	if (ret == *len) {
-		size_t size;
-		*string = strbuf_detach(&buf, &size);
-		*len = size;
-		return (char *)*string;
-	}
-
-	return NULL;
-}
-
-int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
-	int refs_found = 0;
-
-	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		char fullref[PATH_MAX];
-		unsigned char sha1_from_ref[20];
-		unsigned char *this_result;
-		int flag;
-
-		this_result = refs_found ? sha1_from_ref : sha1;
-		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref(fullref, this_result, 1, &flag);
-		if (r) {
-			if (!refs_found++)
-				*ref = xstrdup(r);
-			if (!warn_ambiguous_refs)
-				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD"))
-			warning("ignoring dangling symref %s.", fullref);
-	}
-	free(last_branch);
-	return refs_found;
-}
-
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
-{
-	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
-	int logs_found = 0;
-
-	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
-		struct stat st;
-		unsigned char hash[20];
-		char path[PATH_MAX];
-		const char *ref, *it;
-
-		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref(path, hash, 1, NULL);
-		if (!ref)
-			continue;
-		if (!stat(git_path("logs/%s", path), &st) &&
-		    S_ISREG(st.st_mode))
-			it = path;
-		else if (strcmp(ref, path) &&
-			 !stat(git_path("logs/%s", ref), &st) &&
-			 S_ISREG(st.st_mode))
-			it = ref;
-		else
-			continue;
-		if (!logs_found++) {
-			*log = xstrdup(it);
-			hashcpy(sha1, hash);
-		}
-		if (!warn_ambiguous_refs)
-			break;
-	}
-	free(last_branch);
-	return logs_found;
-}
-
 static inline int upstream_mark(const char *string, int len)
 {
 	const char *suffix[] = { "@{upstream}", "@{u}" };
-- 
1.7.7.213.g8b0e1
