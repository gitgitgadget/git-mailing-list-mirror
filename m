From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] request-pull: modernize style
Date: Thu, 22 Sep 2011 15:09:20 -0700
Message-ID: <1316729362-7714-5-git-send-email-gitster@pobox.com>
References: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
 <1316729362-7714-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 00:09:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6rSm-0007M2-NZ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab1IVWJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 18:09:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168Ab1IVWJc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 18:09:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFF46ED7
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=iuvs
	ffNZoQhPIbw537s79ct9Edo=; b=MgpI7VwxEzpYx9Hhp/n6pgKyZUpiGRtwu8Og
	gp9fEIvBEid6D3+nE3zbtp3fB6IjLWpDS1eFUZb7Bt1wkWLwP6vSuvOBaAdXS/Ul
	pcy2Sw6MJ9KnP/Qm3Xq8u/fg9g4aCloZFAGQXGYsRmMSxo5BfpHPH4vUooxWGf3j
	mkjuF7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=X8tBOS
	vI+r415PR3w2WNLY8WDwUxEkrRijFEBhYgcKjL0QrutdufevkyIwhlxGJhp9wXQ4
	KeSy2ElCGOcgYfml6d8KCc2efI5C3VanuShvbQw5u3KyoQlgE02e7xynf26rRnli
	PWAaqWVOhB19yXSNUa7krzbZWdN59ohun8uws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E006ED6
	for <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DD1A6ED5 for
 <git@vger.kernel.org>; Thu, 22 Sep 2011 18:09:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc2.4.g5ec82
In-Reply-To: <1316729362-7714-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8C22342A-E567-11E0-B166-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181927>

Make it a bit more conforming to Documentation/Codingstyle

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh |   29 +++++++++++++----------------
 1 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index fc080cc..afb75e8 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -35,27 +35,24 @@ do
 	shift
 done
 
-base=$1
-url=$2
-head=${3-HEAD}
+base=$1 url=$2 head=${3-HEAD}
 
-[ "$base" ] || usage
-[ "$url" ] || usage
+test -n "$base" && test -n "$url" || usage
+baserev=$(git rev-parse --verify "$base"^0) &&
+headrev=$(git rev-parse --verify "$head"^0) || exit
 
-baserev=`git rev-parse --verify "$base"^0` &&
-headrev=`git rev-parse --verify "$head"^0` || exit
-
-merge_base=`git merge-base $baserev $headrev` ||
+merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
 
-branch=$(git ls-remote "$url" \
-	| sed -n -e "/^$headrev	refs.heads./{
-		s/^.*	refs.heads.//
-		p
-		q
-	}")
+find_matching_branch="/^$headrev	"'refs\/heads\//{
+	s/^.*	refs\/heads\///
+	p
+	q
+}'
+branch=$(git ls-remote "$url" | sed -n -e "$find_matching_branch")
 url=$(git ls-remote --get-url "$url")
-if [ -z "$branch" ]; then
+if test -z "$branch"
+then
 	echo "warn: No branch of $url is at:" >&2
 	git log --max-count=1 --pretty='tformat:warn:   %h: %s' $headrev >&2
 	echo "warn: Are you sure you pushed $head there?" >&2
-- 
1.7.7.rc2.4.g5ec82
