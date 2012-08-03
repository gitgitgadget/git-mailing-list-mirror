From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 03 Aug 2012 16:12:54 -0700
Message-ID: <7vfw83a7t5.fsf@alter.siamese.dyndns.org>
References: <7v3943bsuc.fsf@alter.siamese.dyndns.org>
 <1344032464-14104-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:13:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxR3I-00058k-Gi
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 01:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab2HCXM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 19:12:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753959Ab2HCXM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 19:12:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FEEC87E7;
	Fri,  3 Aug 2012 19:12:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=a7oC6Y8vdzBUiJICAHreRkvUrG4=; b=Nf7ufIgecTffzTJEkK6n
	VMRhKPQqpjp+T4kTJ8CIOP3gu1dYzyvpUgj0wk93+tCzanGUgf0d/eJbjlrWRx8B
	p5H0zOnlKH6Ryox9Fz4CeG9VR3+XqY2x5TcwD134ZKO441Vc0GHtid9pyf/Fjdlp
	eK7xPT80aj582g0sVNpngW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YCiVJldBSHPJAg/GrAqm70CDJ3/JOqbm1rQ+/kGue+1xz1
	VJVRyr+RjD7yK/Ot/JBXKp6rR7uTDOsyLV9+nICbIWYhktbRkYP1dmzgxbSAIh/h
	azEsnl0obtEYkHbmtKeaRRjy6QStCPWFADmg+qI1WXE+IegiHXZKVhrOZ++os=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E22F87E6;
	Fri,  3 Aug 2012 19:12:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64B4387E4; Fri,  3 Aug 2012
 19:12:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C314CB12-DDC0-11E1-86C9-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202870>

Tentatively I'll queue this one on top, but I am tempted to squash
this in before merging the topic down.

-- >8 --
Subject: [PATCH] fixup! tests: Introduce test_seq

Complex chains of && and || are harder to read when used as
replacement for if/else statements, but it is easy to rewrite it
with a case/esac in this case.

Avoid using unnecessary variables $first and $last.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index c8b4ae3..7dc70eb 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -532,7 +532,7 @@ test_cmp() {
 
 # Print a sequence of numbers or letters in increasing order.  This is
 # similar to GNU seq(1), but the latter might not be available
-# everywhere.  It may be used like:
+# everywhere (and does not do letters).  It may be used like:
 #
 #	for i in `test_seq 100`; do
 #		for j in `test_seq 10 20`; do
@@ -543,11 +543,12 @@ test_cmp() {
 #	done
 
 test_seq () {
-	test $# = 2 && { first=$1; shift; } || first=1
-	test $# = 1 ||
-	error "bug in the test script: not 1 or 2 parameters to test_seq"
-	last=$1
-	"$PERL_PATH" -le 'print for "$ARGV[0]".."$ARGV[1]"' "$first" "$last"
+	case $# in
+	1)	set 1 "$@" ;;
+	2)	;;
+	*)	error "bug in the test script: not 1 or 2 parameters to test_seq" ;;
+	esac
+	"$PERL_PATH" -le 'print for $ARGV[0]..$ARGV[1]' "$@"
 }
 
 # This function can be used to schedule some commands to be run
-- 
1.7.12.rc1.50.g3df08cf
