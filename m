From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] branch: allow pattern arguments
Date: Thu, 25 Aug 2011 12:29:40 -0700
Message-ID: <7vwre1jnmj.fsf@alter.siamese.dyndns.org>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
 <00847b8ee77129433a5d908ad25c9ebaf7fa7130.1314259226.git.git@drmicha.warpmail.net> <20110825175405.GD519@sigill.intra.peff.net> <7vliuhl4us.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Schubert <mschub@elegosoft.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 21:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwfca-0000NK-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 21:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1HYT3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 15:29:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab1HYT3n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 15:29:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8B34835;
	Thu, 25 Aug 2011 15:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65PZJ8XYWn4JiPhP1IS3zhLmIEM=; b=r+cdBD
	aQcpJ2g1gyAyoM12jbqoP1/Tkt/S5ESvzxMfISC9EtTOk4pMS9jAAE1MHkMWtVKf
	QjbI0jauBDuR+PRIzNK7qXyuEY+gPIjYpQLsCdBjHyNNHyPjRwHAa2Sd76b73WeB
	V5DYM0pfNt2lNI8LeFmjs4xDVsg1P73tYnZQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jB6CrZIPmXj24YYnBZvFtNrU43E4RZQg
	OGG82GQ9XeH+HO/gZUXR9rmxO9CA7vMVTY1YO0wl6uWMOUdJAgceVVWeAuA4cE9e
	0BMEMgNwVjAennXiZF/ncAF+dHafE1bZsiEVuy6vSQcTJ62JjCalpahBiPPvvTy1
	BrX7sG5239U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A24E14833;
	Thu, 25 Aug 2011 15:29:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1C09482A; Thu, 25 Aug 2011
 15:29:41 -0400 (EDT)
In-Reply-To: <7vliuhl4us.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 25 Aug 2011 11:32:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 949C3B82-CF50-11E0-9D1C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180105>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Thu, Aug 25, 2011 at 10:30:17AM +0200, Michael J Gruber wrote:
>>
>>> -	else if (argc == 0)
>>> -		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
>>> +	else if (argc == 0 || (verbose && argc == 1))
>>> +		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
>>
>> Note that "git tag -l" takes multiple patterns these days (it used to
>> silently ignore everything after the first one!). "git branch" should
>> probably do the same.
>
> Agreed.

... and can be done without too much additional code.

An offtopic side note about naming:

I called it "const char **pattern" not "patterns" and that is
deliberate. I find it natural to be able to call the 2nd pattern, counting
from 0 as any CS person would, by spelling "pattern[2]". "patterns[2]"
sounds as if I am have multiple sets of patterns and refering to the
second set of patterns.

 builtin/branch.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 495bf2e..0fa62bd 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -260,10 +260,22 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
-	const char *pattern;
+	const char **pattern;
 	int ret;
 };
 
+static int match_patterns(const char **pattern, const char *refname)
+{
+	if (!*pattern)
+		return 1; /* no pattern always matches */
+	while (*pattern) {
+		if (!fnmatch(*pattern, refname, 0))
+			return 1;
+		pattern++;
+	}
+	return 0;
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct append_ref_cb *cb = (struct append_ref_cb *)(cb_data);
@@ -298,7 +310,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (cb->pattern && fnmatch(cb->pattern, refname, 0))
+	if (!match_patterns(cb->pattern, refname))
 		return 0;
 
 	commit = NULL;
@@ -496,7 +508,7 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char *pattern)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -528,7 +540,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && (!pattern || !fnmatch(pattern, "HEAD", 0)))
+	if (detached && match_patterns(pattern, "HEAD"))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
@@ -703,8 +715,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
-	else if (argc == 0 || (verbose && argc == 1))
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit, argc ? argv[0] : NULL);
+	else if (argc == 0 || (verbose && argc))
+		return print_ref_list(kinds, detached, verbose, abbrev,
+				      with_commit, argv);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
