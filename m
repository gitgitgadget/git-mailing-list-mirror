From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 3/3] make-static: pu
Date: Sun, 11 Sep 2011 14:38:37 -0700
Message-ID: <7v39g2n4iq.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Sep 11 23:38:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2rjf-0004QY-Aj
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 23:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760421Ab1IKVil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 17:38:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760404Ab1IKVik (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 17:38:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B84DC433D;
	Sun, 11 Sep 2011 17:38:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=pmAVRazJSA42Mnew+qQguJZrcF8=; b=g40qgak7FFs3bKQO0WYw
	xVIGgj887b30Si691I+9I3zT9HlhAlqhDierpH4UJnw+2vqP3/PBsS7WSrEYHFXI
	oTETyD9ejLDpwpXSoF+O/pDk1qZMnajU0KInzWoz3SYRxat2bJNPfcAQhESizpFg
	r0+j5EN89cjau65KS8GZVto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=flzUmuolGGetnD6xAQL0SybTGB2RgRDOPgom/pVuvSrFuc
	XGvWG4+LGuNpyx6xh8MfF6eCyyX/q4D0rDUaOJTx1BTKZvqhYuHxsK2Jnquo4kVy
	RqmA/zykwe6ol44H9X3P2ZVZHyVo2MYlDZ/K5CvMC+1m9IRah7cJuQWoZpWhU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF262433C;
	Sun, 11 Sep 2011 17:38:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 238CB433B; Sun, 11 Sep 2011
 17:38:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6969C33C-DCBE-11E0-84FC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181196>

Many symbols that are exported to the global scope do not have to be.

This needs to be split into separate patches and squashed into each
individual commit that introduces these symbols.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c            |    2 +-
 dir.h            |    1 -
 metadata-cache.c |    8 ++++----
 metadata-cache.h |    5 -----
 refs.c           |    2 +-
 5 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index fba6433..bee7ed1 100644
--- a/dir.c
+++ b/dir.c
@@ -34,7 +34,7 @@ static int fnmatch_icase(const char *pattern, const char *string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
 }
 
-size_t common_prefix_len(const char **pathspec)
+static size_t common_prefix_len(const char **pathspec)
 {
 	const char *n, *first;
 	size_t max = 0;
diff --git a/dir.h b/dir.h
index 592ceca..9b7bfd4 100644
--- a/dir.h
+++ b/dir.h
@@ -64,7 +64,6 @@ struct dir_struct {
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
-extern size_t common_prefix_len(const char **pathspec);
 extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
diff --git a/metadata-cache.c b/metadata-cache.c
index 32d3c21..5f5ca4e 100644
--- a/metadata-cache.c
+++ b/metadata-cache.c
@@ -287,8 +287,8 @@ static void *lookup_disk(struct metadata_cache *c,
 	return c->disk_entries + (pos * record_size(c)) + 20;
 }
 
-const void *metadata_cache_lookup(struct metadata_cache *c,
-				  const struct object *obj)
+static const void *metadata_cache_lookup(struct metadata_cache *c,
+					 const struct object *obj)
 {
 	void *r;
 
@@ -300,8 +300,8 @@ const void *metadata_cache_lookup(struct metadata_cache *c,
 	return r;
 }
 
-void metadata_cache_add(struct metadata_cache *c, const struct object *obj,
-			const void *value)
+static void metadata_cache_add(struct metadata_cache *c, const struct object *obj,
+			       const void *value)
 {
 	metadata_cache_init(c);
 	add_decoration_value(&c->mem, obj, value, NULL);
diff --git a/metadata-cache.h b/metadata-cache.h
index 15484b5..4819563 100644
--- a/metadata-cache.h
+++ b/metadata-cache.h
@@ -24,11 +24,6 @@ struct metadata_cache {
 #define METADATA_CACHE_INIT(name, width, validity) \
 	{ validity, { (name), (width) } }
 
-const void *metadata_cache_lookup(struct metadata_cache *,
-				  const struct object *);
-void metadata_cache_add(struct metadata_cache *, const struct object *,
-			const void *value);
-
 /* Convenience wrappers around metadata_cache_{lookup,add} */
 int metadata_cache_lookup_uint32(struct metadata_cache *,
 				 const struct object *,
diff --git a/refs.c b/refs.c
index 1c4aa33..6e9588b 100644
--- a/refs.c
+++ b/refs.c
@@ -185,7 +185,7 @@ static void clear_cached_refs(struct cached_refs *ca)
 	ca->did_loose = ca->did_packed = 0;
 }
 
-struct cached_refs *create_cached_refs(const char *submodule)
+static struct cached_refs *create_cached_refs(const char *submodule)
 {
 	int len;
 	struct cached_refs *refs;
-- 
1.7.7.rc0.188.g3793ac
