From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: simplify GIT_SKIP_TESTS loop
Date: Fri, 09 Jul 2010 16:07:57 -0700
Message-ID: <7v7hl4l0du.fsf@alter.siamese.dyndns.org>
References: <0f97dc0377b97675f45b568254dabefb5b1e0146.1278669505.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jul 10 01:08:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXMg1-0003aq-El
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0GIXII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 19:08:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0GIXIF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 19:08:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 876D9C3347;
	Fri,  9 Jul 2010 19:08:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3bl+s83d8V2+6elwxAKyhqvKRsw=; b=XWw8x2
	kJRRvOFv+gKIp6Oo1bArWeYDEiSoiCSKFTwDiCdBPzO5O54QpiOJhOEtDDL3q+7o
	HxJPUOETY9/VBXRfxiizU0wX1Ss7CgpX2WTtIOmJowP2GpjkWPkku8dhlF291Kj3
	rUG3JDyAVMDRuReDsHtHCoSoGUC6lOIba8J38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GeJgD2jPo3KbAmROYFu4i9tFEAmzuBNT
	zsFK/7RBAHXj7PI11GoK5RT1YLQ1YOBok2+/BcxajAzcujhUB2eBY3JK3NaAGIXX
	7WlobwzNyctIuJr99LdVGpQTiX2yF2H3o7hZiA9kaY/oNTjFAccoUXK7e1OT32DG
	n/c9if/naog=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63EE3C3337;
	Fri,  9 Jul 2010 19:08:02 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82F19C3334; Fri,  9 Jul
 2010 19:07:59 -0400 (EDT)
In-Reply-To: <0f97dc0377b97675f45b568254dabefb5b1e0146.1278669505.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\,  9 Jul 2010 12\:01\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2EDF59C-8BAE-11DF-BE37-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150697>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I am probably making a complete shell fool out of myself by overlooking
> something completely trivial.

I don't think so.  I don't know what the double-loop is trying to achieve
myself.

We could even lose to_skip variable and the call to test_done inside the
case statement, perhaps like this.

Thanks.

 t/test-lib.sh |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..bc06564 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -385,6 +385,7 @@ test_skip () {
 		case $this_test.$test_count in
 		$skp)
 			to_skip=t
+			break
 		esac
 	done
 	if test -z "$to_skip" && test -n "$prereq" &&
@@ -829,16 +830,8 @@ this_test=${0##*/}
 this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
 do
-	to_skip=
-	for skp in $GIT_SKIP_TESTS
-	do
-		case "$this_test" in
-		$skp)
-			to_skip=t
-		esac
-	done
-	case "$to_skip" in
-	t)
+	case "$this_test" in
+	$skp)
 		say_color skip >&3 "skipping test $this_test altogether"
 		say_color skip "skip all tests in $this_test"
 		test_done
