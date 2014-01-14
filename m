From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] refname_match(): always use the rules in ref_rev_parse_rules
Date: Tue, 14 Jan 2014 04:16:07 +0100
Message-ID: <1389669367-27343-1-git-send-email-mhagger@alum.mit.edu>
References: <xmqqlhyn90ka.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 04:16:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2uUT-0005ij-QF
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 04:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaANDQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 22:16:30 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47214 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751399AbaANDQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 22:16:29 -0500
X-AuditID: 1207440f-b7f306d000006d99-40-52d4ac0c4c50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 20.39.28057.C0CA4D25; Mon, 13 Jan 2014 22:16:28 -0500 (EST)
Received: from michael.fritz.box (p57A241AD.dip0.t-ipconnect.de [87.162.65.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0E3GC79019765
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 13 Jan 2014 22:16:27 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <xmqqlhyn90ka.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsUixO6iqMuz5kqQwazlPBZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1x8eAbpoJLChVL991mb2A8
	J9XFyMkhIWAiseLYZxYIW0ziwr31bF2MXBxCApcZJabtnACWEBI4wSRx5mQ5iM0moCuxqKeZ
	CcQWEVCTmNh2CKyGWcBBYvPnRkYQW1jAV+LWnT/MXYwcHCwCqhKvLvqDhHkFXCQedneAhSUE
	FCRWXxcCCXMKWEtsPz2DZQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkp
	pZsYIeHAv4Oxa73MIUYBDkYlHt4TjFeChFgTy4orcw8xSnIwKYnypi8ECvEl5adUZiQWZ8QX
	leakFh9ilOBgVhLhrVwAlONNSaysSi3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAo
	SfAuWQ7UKFiUmp5akZaZU4KQZuLgBBFcIBt4gDZcXQWyobggMbc4Mx2i6BSjopQ4r+xqoIQA
	SCKjNA9uACxyXzGKA/0jzPsUpJ0HGPVw3a+ABjMBDa51vwQyuCQRISXVwKhpvCThVbwSy/Sc
	SUUtqmY16TszXLXz7/ipbGX4def1zN5gpfuf3kdwcDnq7pfLWJVto55cNHvvcpXtHJPedrpo
	/Ci/fz7yjmOKVmVADpO7uf1Xu2kaFw66Ljt4/snN6vy5Gj27gi+puCmV6CtmHd4rfOyD5KH0
	i+4Ldzi5iYcUvufj3apWqMRSnJFoqMVcVJwIACunpF23AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240389>

We used to use two separate rules for the normal ref resolution
dwimming and dwimming done to decide which remote ref to grab.  The
third parameter to refname_match() selected which rules to use.

When these two rules were harmonized in

    2011-11-04 dd621df9cd refs DWIMmery: use the same rule for both "git fetch" and others

, ref_fetch_rules was #defined to avoid potential breakages for
in-flight topics.

It is now safe to remove the backwards-compatibility code, so remove
refname_match()'s third parameter, make ref_rev_parse_rules private to
refs.c, and remove ref_fetch_rules entirely.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
See

    http://article.gmane.org/gmane.comp.version-control.git/240305

in which Junio made the suggestion and wrote most of the commit
message :-)

 cache.h  | 9 ++++++---
 refs.c   | 6 +++---
 remote.c | 8 ++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index 83a2726..508c49a 100644
--- a/cache.h
+++ b/cache.h
@@ -893,9 +893,12 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
 extern int interpret_branch_name(const char *str, int len, struct strbuf *);
 extern int get_sha1_mb(const char *str, unsigned char *sha1);
 
-extern int refname_match(const char *abbrev_name, const char *full_name, const char **rules);
-extern const char *ref_rev_parse_rules[];
-#define ref_fetch_rules ref_rev_parse_rules
+/*
+ * Return true iff abbrev_name is a possible abbreviation for
+ * full_name according to the rules defined by ref_rev_parse_rules in
+ * refs.c.
+ */
+extern int refname_match(const char *abbrev_name, const char *full_name);
 
 extern int create_symref(const char *ref, const char *refs_heads_master, const char *logmsg);
 extern int validate_headref(const char *ref);
diff --git a/refs.c b/refs.c
index 490b57b..fc33ee8 100644
--- a/refs.c
+++ b/refs.c
@@ -1880,7 +1880,7 @@ const char *prettify_refname(const char *name)
 		0);
 }
 
-const char *ref_rev_parse_rules[] = {
+static const char *ref_rev_parse_rules[] = {
 	"%.*s",
 	"refs/%.*s",
 	"refs/tags/%.*s",
@@ -1890,12 +1890,12 @@ const char *ref_rev_parse_rules[] = {
 	NULL
 };
 
-int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
+int refname_match(const char *abbrev_name, const char *full_name)
 {
 	const char **p;
 	const int abbrev_name_len = strlen(abbrev_name);
 
-	for (p = rules; *p; p++) {
+	for (p = ref_rev_parse_rules; *p; p++) {
 		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
 			return 1;
 		}
diff --git a/remote.c b/remote.c
index a89efab..e41251e 100644
--- a/remote.c
+++ b/remote.c
@@ -1000,7 +1000,7 @@ int count_refspec_match(const char *pattern,
 		char *name = refs->name;
 		int namelen = strlen(name);
 
-		if (!refname_match(pattern, name, ref_rev_parse_rules))
+		if (!refname_match(pattern, name))
 			continue;
 
 		/* A match is "weak" if it is with refs outside
@@ -1571,7 +1571,7 @@ int branch_merge_matches(struct branch *branch,
 {
 	if (!branch || i < 0 || i >= branch->merge_nr)
 		return 0;
-	return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
+	return refname_match(branch->merge[i]->src, refname);
 }
 
 static int ignore_symref_update(const char *refname)
@@ -1624,7 +1624,7 @@ static const struct ref *find_ref_by_name_abbrev(const struct ref *refs, const c
 {
 	const struct ref *ref;
 	for (ref = refs; ref; ref = ref->next) {
-		if (refname_match(name, ref->name, ref_fetch_rules))
+		if (refname_match(name, ref->name))
 			return ref;
 	}
 	return NULL;
@@ -2121,7 +2121,7 @@ static void apply_cas(struct push_cas_option *cas,
 	/* Find an explicit --<option>=<name>[:<value>] entry */
 	for (i = 0; i < cas->nr; i++) {
 		struct push_cas *entry = &cas->entry[i];
-		if (!refname_match(entry->refname, ref->name, ref_rev_parse_rules))
+		if (!refname_match(entry->refname, ref->name))
 			continue;
 		ref->expect_old_sha1 = 1;
 		if (!entry->use_tracking)
-- 
1.8.5.2
