From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] request-pull: explicitly ask tags/$name to be pulled
Date: Tue, 31 Jan 2012 21:50:21 -0800
Message-ID: <7vty3b3xwi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 06:50:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsT5S-0002Rn-5w
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 06:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab2BAFuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 00:50:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65326 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab2BAFuY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 00:50:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B722220C6;
	Wed,  1 Feb 2012 00:50:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	TgsEz3XjEEJQgb37on5xtNww0U=; b=g3P/9CS5NJ3STKzhpFU3WmO/tOI+k7CE/
	0UvkkWcerTpP1lu9e03jfecxmHH3EKw9HkWZZom/iONOqivRjtPT6YApEg1dVdBX
	LoGwLrLp4dtXGA/xJMB+Gs/0Lq4ZOZeX/EfV40miZ0yKG+ofvoub/js8d9i4spB5
	xThfSBo4/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=hwFvGUWYLL1WnxL03p5LVJPTxe6wDRn5SKJk0Nq629vTYn5Fd1hCRYl5
	XBfMoI9joKtxES5CMaM+ZjtD6D5Cv1R/3KiNIyaXxkwGUhkp6VCGr7mOogBSxNbM
	lXOTRFJJmhV5NAr3KmZGdrqStiZc/vQpOQ6LY3pz7TqyoOKtgIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEF4E20C5;
	Wed,  1 Feb 2012 00:50:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 251AC20C4; Wed,  1 Feb 2012
 00:50:23 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A1D4900E-4C98-11E1-9432-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189498>

When asking for a tag to be pulled, disambiguate by leaving tags/ prefix
in front of the name of the tag. E.g.

    ... in the git repository at:

      git://example.com/git/git.git/ tags/v1.2.3

    for you to fetch changes up to 123456...

This way, older versions of "git pull" can be used to respond to such a
request more easily, as "git pull $URL v1.2.3" did not DWIM to fetch
v1.2.3 tag in older versions. Also this makes it clearer for humans that
the pull request is made for a tag and he should anticipate a signed one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * http://thread.gmane.org/gmane.linux.kernel/1245709/focus=1245909
   triggered this

 .../howto/using-signed-tag-in-pull-request.txt     |    4 ++--
 git-request-pull.sh                                |    2 +-
 t/t5150-request-pull.sh                            |    6 +-----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.txt
index a1351c5..98c0033 100644
--- a/Documentation/howto/using-signed-tag-in-pull-request.txt
+++ b/Documentation/howto/using-signed-tag-in-pull-request.txt
@@ -109,7 +109,7 @@ The resulting msg.txt file begins like so:
 
  are available in the git repository at:
 
-   example.com:/git/froboz.git frotz-for-xyzzy
+   example.com:/git/froboz.git tags/frotz-for-xyzzy
 
  for you to fetch changes up to 703f05ad5835c...:
 
@@ -141,7 +141,7 @@ After receiving such a pull request message, the integrator fetches and
 integrates the tag named in the request, with:
 
 ------------
- $ git pull example.com:/git/froboz.git/ frotz-for-xyzzy
+ $ git pull example.com:/git/froboz.git/ tags/frotz-for-xyzzy
 ------------
 
 This operation will always open an editor to allow the integrator to fine
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 64960d6..e6438e2 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -63,7 +63,7 @@ die "fatal: No commits in common between $base and $head"
 find_matching_ref='
 	sub abbr {
 		my $ref = shift;
-		if ($ref =~ s|refs/heads/|| || $ref =~ s|refs/tags/||) {
+		if ($ref =~ s|^refs/heads/|| || $ref =~ s|^refs/tags/|tags/|) {
 			return $ref;
 		} else {
 			return $ref;
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index da25bc2..7c1dc64 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -179,11 +179,7 @@ test_expect_success 'request names an appropriate branch' '
 		read repository &&
 		read branch
 	} <digest &&
-	{
-		test "$branch" = full ||
-		test "$branch" = master ||
-		test "$branch" = for-upstream
-	}
+	test "$branch" = tags/full
 
 '
 
-- 
1.7.9.155.gf6ee6
