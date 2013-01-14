From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/6] t9600: further prepare for sharing
Date: Sun, 13 Jan 2013 23:48:27 -0800
Message-ID: <7vmwwcfbn8.fsf_-_@alter.siamese.dyndns.org>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358148351-31552-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 08:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuemp-0005JO-4m
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756112Ab3ANHsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:48:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754758Ab3ANHsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:48:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8D85979E;
	Mon, 14 Jan 2013 02:48:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KN1zFJYjCzTunn7PP3O6U6BEWc=; b=pNpjJQ
	RwxoU+uhVnbjeEsCfF3gaa6q+0F4rwwsEno+jkbQ7hQ/8w4ugzmu/uLiFiIABVhP
	OdXi7LhUjhjGNvJi+yvyzqscnWPK4xyVWlddSa2U5Ojq6o9s2PVOOuNivzoo/gEJ
	RDYXHxHKV62DYpKkNODPgeOjYRNdlrCIuljo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KX+C9qlCDtVFln6Zm+DmR9E3jl4LdP7p
	XXmAyn0Ou7GaMfyKmCwp6jUTNDAb7NiDJjV7v6CP2F87wtja7lb5Q64paEPGvA+W
	q7WTQ/v1ZeS6ODfyQBXMTXkmaIvEthrQxDPvgwi8UZ3EATowpOGtGW4vRLK4t6US
	YEGh6M2xWZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEA09979D;
	Mon, 14 Jan 2013 02:48:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6D1B979B; Mon, 14 Jan 2013
 02:48:28 -0500 (EST)
In-Reply-To: <1358148351-31552-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun, 13 Jan 2013 23:25:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C90131F8-5E1E-11E2-A897-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213467>

When t9650, which dot-sources this script, really becomes ready to
test the new cvsimport, we no longer depend on having PERL to run
this test through it.  Move the PERL dependency to lib-cvs.sh
instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-cvs.sh         |  7 +++++++
 t/t9600-cvsimport.sh | 30 +++++++++++++++---------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/t/lib-cvs.sh b/t/lib-cvs.sh
index 3a55b8a..d2bf5bf 100644
--- a/t/lib-cvs.sh
+++ b/t/lib-cvs.sh
@@ -22,6 +22,9 @@ case "$TEST_CVSPS_VERSION" in
 	if test "$CVSPS2_PATH" = NoThanks
 	then
 		skip_all='skipping cvsimport tests, cvsps(2) not used'
+	elif ! test_have_prereq PERL
+	then
+		skip_all='skipping cvsimport tests, Perl not available'
 	else
 		case $($CVSPS2_PATH -h 2>&1 | sed -ne 's/cvsps version //p') in
 		2.1 | 2.2*)
@@ -39,6 +42,10 @@ case "$TEST_CVSPS_VERSION" in
 	if test "$CVSPS3_PATH" = NoThanks
 	then
 		skip_all='skipping cvsimport tests, cvsps(3) not used'
+	elif ! test_have_prereq PYTHON
+	then
+		# NEEDSWORK: we may need Python lower-bound prerequisite
+		skip_all='skipping cvsimport tests, Python not available'
 	else
 		case $($CVSPS3_PATH -h 2>&1 | sed -ne 's/cvsps version //p') in
 		3.*)
diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 4c384ff..906cbdc 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,14 +3,14 @@
 test_description='git cvsimport basic tests'
 . ./lib-cvs.sh
 
-test_expect_success PERL 'setup cvsroot environment' '
+test_expect_success 'setup cvsroot environment' '
 	CVSROOT=$(pwd)/cvsroot &&
 	export CVSROOT
 '
 
-test_expect_success PERL 'setup cvsroot' '$CVS init'
+test_expect_success 'setup cvsroot' '$CVS init'
 
-test_expect_success PERL 'setup a cvs module' '
+test_expect_success 'setup a cvs module' '
 
 	mkdir "$CVSROOT/module" &&
 	$CVS co -d module-cvs module &&
@@ -42,23 +42,23 @@ EOF
 	)
 '
 
-test_expect_success PERL 'import a trivial module' '
+test_expect_success 'import a trivial module' '
 
 	git cvsimport -a -R -z 0 -C module-git module &&
 	test_cmp module-cvs/o_fortuna module-git/o_fortuna
 
 '
 
-test_expect_success PERL 'pack refs' '(cd module-git && git gc)'
+test_expect_success 'pack refs' '(cd module-git && git gc)'
 
-test_expect_success PERL 'initial import has correct .git/cvs-revisions' '
+test_expect_success 'initial import has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1) > expected &&
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'update cvs module' '
+test_expect_success 'update cvs module' '
 	(cd module-cvs &&
 	cat <<EOF >o_fortuna &&
 O Fortune,
@@ -86,7 +86,7 @@ EOF
 	)
 '
 
-test_expect_success PERL 'update git module' '
+test_expect_success 'update git module' '
 
 	(cd module-git &&
 	git config cvsimport.trackRevisions true &&
@@ -97,7 +97,7 @@ test_expect_success PERL 'update git module' '
 
 '
 
-test_expect_success PERL 'update has correct .git/cvs-revisions' '
+test_expect_success 'update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^ &&
@@ -105,7 +105,7 @@ test_expect_success PERL 'update has correct .git/cvs-revisions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'update cvs module' '
+test_expect_success 'update cvs module' '
 
 	(cd module-cvs &&
 		echo 1 >tick &&
@@ -114,7 +114,7 @@ test_expect_success PERL 'update cvs module' '
 	)
 '
 
-test_expect_success PERL 'cvsimport.module config works' '
+test_expect_success 'cvsimport.module config works' '
 
 	(cd module-git &&
 		git config cvsimport.module module &&
@@ -126,7 +126,7 @@ test_expect_success PERL 'cvsimport.module config works' '
 
 '
 
-test_expect_success PERL 'second update has correct .git/cvs-revisions' '
+test_expect_success 'second update has correct .git/cvs-revisions' '
 
 	(cd module-git &&
 	 git log --format="o_fortuna 1.1 %H" -1 HEAD^^ &&
@@ -135,7 +135,7 @@ test_expect_success PERL 'second update has correct .git/cvs-revisions' '
 	test_cmp expected module-git/.git/cvs-revisions
 '
 
-test_expect_success PERL 'import from a CVS working tree' '
+test_expect_success 'import from a CVS working tree' '
 
 	$CVS co -d import-from-wt module &&
 	(cd import-from-wt &&
@@ -148,12 +148,12 @@ test_expect_success PERL 'import from a CVS working tree' '
 
 '
 
-test_expect_success PERL 'no .git/cvs-revisions created by default' '
+test_expect_success 'no .git/cvs-revisions created by default' '
 
 	! test -e import-from-wt/.git/cvs-revisions
 
 '
 
-test_expect_success PERL 'test entire HEAD' 'test_cmp_branch_tree master'
+test_expect_success 'test entire HEAD' 'test_cmp_branch_tree master'
 
 test_done
-- 
1.8.1.421.g6236851
