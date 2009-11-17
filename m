From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t3101: test more ls-tree options
Date: Mon, 16 Nov 2009 22:21:35 -0800
Message-ID: <7vws1piscw.fsf@alter.siamese.dyndns.org>
References: <1258173248-31059-1-git-send-email-bebarino@gmail.com>
 <1258173248-31059-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 07:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAHRn-00056s-Rx
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 07:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340AbZKQGVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 01:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZKQGVh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 01:21:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZKQGVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 01:21:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D14F80ED6;
	Tue, 17 Nov 2009 01:21:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uCtlSZt/sK91epdAfqWifeRwcHY=; b=N+Hk0bKR7M1eGDdaofh3Y1r
	hhLvuFgFEh6fBra4te1c35Tm1YFcUS4q15SalG09M9byvi/XGXEeosB6CgwjOvmJ
	GU3+Wr4VU86vDjgsXAYFmPvgt1w9rJG/NVAuad6V+QcQ3hLpQN/TBkuM2xSENXKU
	znlmwIobk1az5ayq8Bgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vW/M2tGxTlJcemJuCIBi8HdI/3koSGd+QYjgokdT9qoDef4Oq
	TovlmyD7CiLuQR+d68jVwzoWt1YWzK3OVnX1RBwpJHtsucTwF1l3mlKfRWSEng5P
	KahIuxD4Nu5HSFyv136reCJ7xkZmFmeyuOfv3Yo9PHfQADLp576m6wazI4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E12AF80ED5;
	Tue, 17 Nov 2009 01:21:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1922980ED4; Tue, 17 Nov
 2009 01:21:36 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 778058EC-D341-11DE-B80F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133060>

Thanks.  I'd squash this patch in for the following reasons; Ok?

 - The --abbrev=n option only guarantees that at least n hexdigits are
   used but the implementation is allowed to use more to avoid
   ambiguities.

 - The point of test_output function is that it does its own filtering
   before comparison; it is misleading to feed it if the caller munges the
   input.

 - Redirection should be immediately followed by filename; this is just a
   matter of personal taste, but being consistent in the new code is
   better than resulting in blocks of lines with mixed styles (no, I won't
   welcome a patch to fix the existing "cmd > file", unless it is done as
   part of a patch aka "while at it" that fixes something of substance
   nearby at the same time).

 t/t3101-ls-tree-dirname.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t3101-ls-tree-dirname.sh b/t/t3101-ls-tree-dirname.sh
index 99458e4..6ef371a 100755
--- a/t/t3101-ls-tree-dirname.sh
+++ b/t/t3101-ls-tree-dirname.sh
@@ -39,8 +39,8 @@ test_expect_success \
      tree=`git write-tree` &&
      echo $tree'
 
-_x5='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x5$_x5$_x5$_x5$_x5$_x5$_x5$_x5"
+_x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 test_output () {
     sed -e "s/ $_x40	/ X	/" <current >check
     test_cmp expected check
@@ -145,7 +145,7 @@ test_expect_success 'ls-tree --full-name' '
 	(
 		cd path0 &&
 		git ls-tree --full-name $tree a
-	) > current &&
+	) >current &&
 	cat >expected <<\EOF &&
 040000 tree X	path0/a
 EOF
@@ -156,7 +156,7 @@ test_expect_success 'ls-tree --full-tree' '
 	(
 		cd path1/b/c &&
 		git ls-tree --full-tree $tree
-	) > current &&
+	) >current &&
 	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
@@ -172,7 +172,7 @@ test_expect_success 'ls-tree --full-tree -r' '
 	(
 		cd path3/ &&
 		git ls-tree --full-tree -r $tree
-	) > current &&
+	) >current &&
 	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
@@ -186,8 +186,8 @@ EOF
 '
 
 test_expect_success 'ls-tree --abbrev=5' '
-	git ls-tree --abbrev=5 $tree > current.abbrev &&
-	sed -e "s/ $_x5	/ X	/"  < current.abbrev > current &&
+	git ls-tree --abbrev=5 $tree >current &&
+	sed -e "s/ $_x05[0-9a-f]*	/ X	/" <current >check &&
 	cat >expected <<\EOF &&
 100644 blob X	1.txt
 100644 blob X	2.txt
@@ -196,11 +196,11 @@ test_expect_success 'ls-tree --abbrev=5' '
 040000 tree X	path2
 040000 tree X	path3
 EOF
-	test_output
+	test_cmp expected check
 '
 
 test_expect_success 'ls-tree --name-only' '
-	git ls-tree --name-only $tree > current
+	git ls-tree --name-only $tree >current
 	cat >expected <<\EOF &&
 1.txt
 2.txt
@@ -213,7 +213,7 @@ EOF
 '
 
 test_expect_success 'ls-tree --name-only -r' '
-	git ls-tree --name-only -r $tree > current
+	git ls-tree --name-only -r $tree >current
 	cat >expected <<\EOF &&
 1.txt
 2.txt
-- 
1.6.5.3.283.g4b054
