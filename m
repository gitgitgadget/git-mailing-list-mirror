From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t1512: correct leftover constants from earlier edition
Date: Mon,  1 Jul 2013 22:12:34 -0700
Message-ID: <1372741955-20691-2-git-send-email-gitster@pobox.com>
References: <1372741955-20691-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 07:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtstW-0004rP-GZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab3GBFMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:12:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3GBFMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F51E27D43
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Yos6
	L8LiNplskdbLa109MT+L7cs=; b=Q67NsBlh11fjwZS1G5bHwT26X8qcJN6dkAYd
	SC4bIXZx0B6TihfzVL5eMF4uJqreVddl3zTUYfbzOOAfTj9xA6r9ihVywCtsqWfJ
	B7hkPKXsujXVLYBbEV4oYT2ylq1cp2oa9tlZl42HAUU9IPR9CGCFL24hKI6Odg+V
	9kcH4cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gCUimF
	Z+a29Cp75P0D/NdSXRvqGWuK5sRwP8ygnHc4C9U8deJ9+pv4gLKXqyDqJWf21rmc
	Cfbs+pO9ug81bLwE3LCFEczfuelzbfB7IktB5PvoBM5Bpe898+eX3080wP8Ahsyk
	ww2UVYBpNOcHjT/gDHXHJ2HiEK3+P/C/AusuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D2427D40
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B715E27D3C
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:38 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
In-Reply-To: <1372741955-20691-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 03B4A7BC-E2D6-11E2-B63E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229360>

The earliest iteration of this test script used a magic string
110282 as the common prefix for ambiguous object names, but the
final edition switched the common prefix to 0000000000 (10 "0"s).

Unfortunately, instances of the original prefix were left in the
comments and a few tests.  Replace them with the correct constants.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1512-rev-parse-disambiguation.sh | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 6b3d797..5b58e4f 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -77,6 +77,7 @@ test_expect_success 'disambiguate blob' '
 
 test_expect_success 'disambiguate tree' '
 	commit=$(echo "d7xm" | git commit-tree 000000000) &&
+	# this commit is fffff2e and not ambiguous with the 00000* objects
 	test $(git rev-parse $commit^{tree}) = $(git rev-parse 0000000000cdc)
 '
 
@@ -99,10 +100,14 @@ test_expect_success 'disambiguate commit-ish' '
 
 test_expect_success 'disambiguate commit' '
 	commit=$(echo "hoaxj" | git commit-tree 0000000000cdc -p 000000000) &&
+	# this commit is ffffffd8 and not ambiguous with the 00000* objects
 	test $(git rev-parse $commit^) = $(git rev-parse 0000000000e4f)
 '
 
 test_expect_success 'log name1..name2 takes only commit-ishes on both ends' '
+	# These are underspecified from the prefix-length point of view
+	# to disambiguate the commit with other objects, but there is only
+	# one commit that has 00000* prefix at this point.
 	git log 000000000..000000000 &&
 	git log ..000000000 &&
 	git log 000000000.. &&
@@ -112,16 +117,19 @@ test_expect_success 'log name1..name2 takes only commit-ishes on both ends' '
 '
 
 test_expect_success 'rev-parse name1..name2 takes only commit-ishes on both ends' '
+	# Likewise.
 	git rev-parse 000000000..000000000 &&
 	git rev-parse ..000000000 &&
 	git rev-parse 000000000..
 '
 
 test_expect_success 'git log takes only commit-ish' '
+	# Likewise.
 	git log 000000000
 '
 
 test_expect_success 'git reset takes only commit-ish' '
+	# Likewise.
 	git reset 000000000
 '
 
@@ -131,26 +139,30 @@ test_expect_success 'first tag' '
 '
 
 test_expect_failure 'two semi-ambiguous commit-ish' '
+	# At this point, we have a tag 0000000000f8f that points
+	# at a commit 0000000000e4f, and a tree and a blob that
+	# share 0000000000 prefix with these tag and commit.
+	#
 	# Once the parser becomes ultra-smart, it could notice that
-	# 110282 before ^{commit} name many different objects, but
+	# 0000000000 before ^{commit} name many different objects, but
 	# that only two (HEAD and v1.0.0 tag) can be peeled to commit,
 	# and that peeling them down to commit yield the same commit
 	# without ambiguity.
-	git rev-parse --verify 110282^{commit} &&
+	git rev-parse --verify 0000000000^{commit} &&
 
 	# likewise
-	git log 000000000..000000000 &&
-	git log ..000000000 &&
-	git log 000000000.. &&
-	git log 000000000...000000000 &&
-	git log ...000000000 &&
-	git log 000000000...
+	git log 0000000000..0000000000 &&
+	git log ..0000000000 &&
+	git log 0000000000.. &&
+	git log 0000000000...0000000000 &&
+	git log ...0000000000 &&
+	git log 0000000000...
 '
 
 test_expect_failure 'three semi-ambiguous tree-ish' '
 	# Likewise for tree-ish.  HEAD, v1.0.0 and HEAD^{tree} share
 	# the prefix but peeling them to tree yields the same thing
-	git rev-parse --verify 000000000^{tree}
+	git rev-parse --verify 0000000000^{tree}
 '
 
 test_expect_success 'parse describe name' '
@@ -241,7 +253,7 @@ test_expect_success 'ambiguous commit-ish' '
 	# Now there are many commits that begin with the
 	# common prefix, none of these should pick one at
 	# random.  They all should result in ambiguity errors.
-	test_must_fail git rev-parse --verify 110282^{commit} &&
+	test_must_fail git rev-parse --verify 00000000^{commit} &&
 
 	# likewise
 	test_must_fail git log 000000000..000000000 &&
-- 
1.8.3.2-795-g615e8f0
