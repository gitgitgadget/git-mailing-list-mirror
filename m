From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refname_match(): always use the rules in ref_rev_parse_rules
Date: Tue, 14 Jan 2014 14:16:02 -0800
Message-ID: <xmqq38kq43bx.fsf@gitster.dls.corp.google.com>
References: <xmqqlhyn90ka.fsf@gitster.dls.corp.google.com>
	<1389669367-27343-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 14 23:16:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3CHS-0007bb-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 23:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbaANWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 17:16:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbaANWQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 17:16:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 665D864E8D;
	Tue, 14 Jan 2014 17:16:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fAF/mJXRP7xY+pc84L8C2DvLgT0=; b=kesN0x
	Bri1ElkvCNdBVzHQvLeQPTJWhGPpTeF+oP//+fMq3QEu/vwqeL8CpbVKhwusx7hj
	jSKN3L+YTwPJkKXvY8RYuuQlflorGKZhtHFjOy89WhDRKJFTr1nDKpPUwUNTwVZZ
	RjlUBTrShqmCoPEhyIKmSlKWeoNwNIQti3O2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+AQLAe9sLttpGkCnjUXI1ZNRrQH2k5n
	7/FNINmoWTEgJblPe4TNqPyYKz6FhUsLczMn/6h+nCadU1BdIi6HDIhpfY6Y/9XJ
	kdHBDXzcyJlhVYRg5WLkhXg4eQBjMvcXz0330FSMRYfLHFPbEhH/N/AqzUS4pCrn
	Ln6cCd194P4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAD8A64E8A;
	Tue, 14 Jan 2014 17:16:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C82B264E7D;
	Tue, 14 Jan 2014 17:16:08 -0500 (EST)
In-Reply-To: <1389669367-27343-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 14 Jan 2014 04:16:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77ECCA96-7D69-11E3-AE51-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240416>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> We used to use two separate rules for the normal ref resolution
> dwimming and dwimming done to decide which remote ref to grab.  The
> third parameter to refname_match() selected which rules to use.
>
> When these two rules were harmonized in
>
>     2011-11-04 dd621df9cd refs DWIMmery: use the same rule for both "git fetch" and others
>
> , ref_fetch_rules was #defined to avoid potential breakages for
> in-flight topics.
>
> It is now safe to remove the backwards-compatibility code, so remove
> refname_match()'s third parameter, make ref_rev_parse_rules private to
> refs.c, and remove ref_fetch_rules entirely.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> See
>
>     http://article.gmane.org/gmane.comp.version-control.git/240305
>
> in which Junio made the suggestion and wrote most of the commit
> message :-)

;-) ...and on top of it this may be an obvious endgame follow-up.

was done mindlessly and mechanically, so there may be some slip-ups,
though.


 refs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 5a10c25..b1c9cf5 100644
--- a/refs.c
+++ b/refs.c
@@ -1886,16 +1886,16 @@ static const char *ref_rev_parse_rules[] = {
 	"refs/tags/%.*s",
 	"refs/heads/%.*s",
 	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
-	NULL
+	"refs/remotes/%.*s/HEAD"
 };
 
 int refname_match(const char *abbrev_name, const char *full_name)
 {
-	const char **p;
+	int i;
 	const int abbrev_name_len = strlen(abbrev_name);
 
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (i = 0; i < ARRAY_SIZE(ref_rev_parse_rules); i++) {
+		const char **p = &ref_rev_parse_rules[i];
 		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
 			return 1;
 		}
@@ -1963,11 +1963,13 @@ static char *substitute_branch_name(const char **string, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p, *r;
+	int i;
+	const char *r;
 	int refs_found = 0;
 
 	*ref = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (i = 0; i < ARRAY_SIZE(ref_rev_parse_rules); i++) {
+		const char **p = &ref_rev_parse_rules[i];
 		char fullref[PATH_MAX];
 		unsigned char sha1_from_ref[20];
 		unsigned char *this_result;
@@ -1994,11 +1996,11 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
-	const char **p;
-	int logs_found = 0;
+	int logs_found = 0, i;
 
 	*log = NULL;
-	for (p = ref_rev_parse_rules; *p; p++) {
+	for (i = 0; i < ARRAY_SIZE(ref_rev_parse_rules); i++) {
+		const char **p = &ref_rev_parse_rules[i];
 		struct stat st;
 		unsigned char hash[20];
 		char path[PATH_MAX];
@@ -3368,8 +3370,8 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	if (!nr_rules) {
 		size_t total_len = 0;
 
-		/* the rule list is NULL terminated, count them first */
-		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
+		/* Count the bytesize needed to hold rule strings */
+		for (nr_rules = 0; ARRAY_SIZE(ref_rev_parse_rules); nr_rules++)
 			/* no +1 because strlen("%s") < strlen("%.*s") */
 			total_len += strlen(ref_rev_parse_rules[nr_rules]);
 
