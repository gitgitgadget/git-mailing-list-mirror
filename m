From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] resolve_ref(): report breakage to the caller without warning
Date: Wed, 19 Oct 2011 12:39:50 -0700
Message-ID: <7v62jkdb3t.fsf_-_@alter.siamese.dyndns.org>
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
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
 <7v39epft32.fsf@alter.siamese.dyndns.org>
 <7vaa8wdbld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 21:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGbzb-0002kq-0x
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 21:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab1JSTjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 15:39:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038Ab1JSTjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 15:39:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B2E5B9D;
	Wed, 19 Oct 2011 15:39:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uvOg7Clsyvj/Tkg8hYl2WVwZVQc=; b=X159in
	HtKeCp329+wpkDSPyXj5wCFFfGuCjZ0P6F/Iw9uul8rbahCacBTWVlGYt3zuYFXQ
	iGtCRfEOXvht2iVd+sr2uepPSbNXPn3x9TQQJM9zih+SDVyvxx2zD36PjhsjqcF8
	HCJsV1Nd5Wyjrwks3JhTZNq3cG+VV8BYBuvw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NzyRbXBWBysIFm1xvnqzQ3GvQaEmY2JM
	SsfVARAya/J4XBeM5Pt9X5kp9KabwZDGHO6d8MgYrc7ksaK+dOYq0A1EoQNDSbfo
	4auEfQeGzVPMJZd2UwKeYTfRgRVuf0645U/MLxMKYz2ANHA+dpYTC8kw8DGZ4KW2
	JeGhvgF2rug=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9745B9C;
	Wed, 19 Oct 2011 15:39:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0F595B9A; Wed, 19 Oct 2011
 15:39:51 -0400 (EDT)
In-Reply-To: <7vaa8wdbld.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 19 Oct 2011 12:29:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1CE459A2-FA8A-11E0-B661-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183944>

629cd3a (resolve_ref(): emit warnings for improperly-formatted references,
2011-09-15) made resolve_ref() warn against files that are found in the
directories the ref dwimmery looks at. The intent may be good, but these
messages come from a wrong level of the API hierarchy.

Instead record the breakage in "flags" whose purpose is to explain the
result of the function to the caller, who is in a much better position to
make intelligent decision based on the information.

This updates sha1_name.c::dwim_ref() to warn against such a broken
candidate only when it does not appear directly below $GIT_DIR to restore
the traditional behaviour, as we know many files directly underneath
$GIT_DIR/ are are not refs.

Warning against "git show config --" with "$GIT_DIR/config does not look
like a well-formed ref" does not make sense, and we may later tweak the
dwimmery not to even consider them as candidates, but that is a longer
term topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * With a log message and the same patch text.

 refs.c      |   22 +++++++++++-----------
 refs.h      |    5 +++--
 sha1_name.c |    5 ++++-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index cab4394..0f58e46 100644
--- a/refs.c
+++ b/refs.c
@@ -4,9 +4,8 @@
 #include "tag.h"
 #include "dir.h"
 
-/* ISSYMREF=01 and ISPACKED=02 are public interfaces */
-#define REF_KNOWS_PEELED 04
-#define REF_BROKEN 010
+/* ISSYMREF=0x01, ISPACKED=0x02 and ISBROKEN=0x04 are public interfaces */
+#define REF_KNOWS_PEELED 0x10
 
 struct ref_entry {
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -329,12 +328,12 @@ static void get_ref_dir(const char *submodule, const char *base,
 				flag = 0;
 				if (resolve_gitlink_ref(submodule, ref, sha1) < 0) {
 					hashclr(sha1);
-					flag |= REF_BROKEN;
+					flag |= REF_ISBROKEN;
 				}
 			} else
 				if (!resolve_ref(ref, sha1, 1, &flag)) {
 					hashclr(sha1);
-					flag |= REF_BROKEN;
+					flag |= REF_ISBROKEN;
 				}
 			add_ref(ref, sha1, flag, array, NULL);
 		}
@@ -501,7 +500,6 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	ssize_t len;
 	char buffer[256];
 	static char ref_buffer[256];
-	char path[PATH_MAX];
 
 	if (flag)
 		*flag = 0;
@@ -510,6 +508,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		return NULL;
 
 	for (;;) {
+		char path[PATH_MAX];
 		struct stat st;
 		char *buf;
 		int fd;
@@ -586,8 +585,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			warning("symbolic reference in %s is formatted incorrectly",
-				path);
+			if (flag)
+				*flag |= REF_ISBROKEN;
 			return NULL;
 		}
 		ref = strcpy(ref_buffer, buf);
@@ -596,7 +595,8 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 	}
 	/* Please note that FETCH_HEAD has a second line containing other data. */
 	if (get_sha1_hex(buffer, sha1) || (buffer[40] != '\0' && !isspace(buffer[40]))) {
-		warning("reference in %s is formatted incorrectly", path);
+		if (flag)
+			*flag |= REF_ISBROKEN;
 		return NULL;
 	}
 	return ref;
@@ -624,8 +624,8 @@ static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		return 0;
 
 	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
-		if (entry->flag & REF_BROKEN)
-			return 0; /* ignore dangling symref */
+		if (entry->flag & REF_ISBROKEN)
+			return 0; /* ignore dangling symref and corrupt ref */
 		if (!has_sha1_file(entry->sha1)) {
 			error("%s does not point to a valid object!", entry->name);
 			return 0;
diff --git a/refs.h b/refs.h
index 0229c57..7442b29 100644
--- a/refs.h
+++ b/refs.h
@@ -10,8 +10,9 @@ struct ref_lock {
 	int force_write;
 };
 
-#define REF_ISSYMREF 01
-#define REF_ISPACKED 02
+#define REF_ISSYMREF 0x01
+#define REF_ISPACKED 0x02
+#define REF_ISBROKEN 0x04
 
 /*
  * Calls the specified function for each ref file until it returns nonzero,
diff --git a/sha1_name.c b/sha1_name.c
index ba976b4..1fe37c6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -282,8 +282,11 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 				*ref = xstrdup(r);
 			if (!warn_ambiguous_refs)
 				break;
-		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD"))
+		} else if ((flag & REF_ISSYMREF) && strcmp(fullref, "HEAD")) {
 			warning("ignoring dangling symref %s.", fullref);
+		} else if ((flag & REF_ISBROKEN) && strchr(fullref, '/')) {
+			warning("ignoring broken ref %s.", fullref);
+		}
 	}
 	free(last_branch);
 	return refs_found;
-- 
1.7.7.494.g7d7707
