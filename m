From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t3419-rebase-patch-id: heed USR_BIN_TIME prereq
Date: Tue, 16 Oct 2012 09:32:03 -0700
Message-ID: <7vd30itm2k.fsf@alter.siamese.dyndns.org>
References: <k5gq60$q8c$1@ger.gmane.org>
 <b04898886f0c7ed9d943aef0ce6e047f10c97d76.1350387132.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joachim Schmitz <jojo@schmitz-digital.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:32:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOA48-00013B-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 18:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab2JPQcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 12:32:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41018 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755189Ab2JPQcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 12:32:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E03AD931B;
	Tue, 16 Oct 2012 12:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25QrISDA/EV3MbzRh4Z4KSm2Jfs=; b=bWjeSr
	1lMctxLDBAtT1jd6t2QTYiAq5Rrghd1ATpzkmI+ikjRObV95CQ1nE51fihqkX04V
	ekCvXn27908/5EPvmhzMkzR9eJ1hxpHAPY/zvLB6qyryeWwg5f1ozfixAg8P8F+R
	L77KeLV3A04RoUCKWej4G9IiL1xzilE2xDENQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h2WO4ns7jCT9/kGc/6grK63ylYdDLz3z
	aZ3qlhLF3zHT9egBJox+Pm//R8UYt0FVExu+hkH9RgfKF6RufExNC0sD/lZI6k5C
	CsaXOC5tOMa+EJP6sWOjbACcKSo69ZA6DjCmAyiuNY3nO9uxwpYJWjvoLmOZSC2T
	2bOhelpttY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6252931A;
	Tue, 16 Oct 2012 12:32:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 183BF9313; Tue, 16 Oct 2012
 12:32:05 -0400 (EDT)
In-Reply-To: <b04898886f0c7ed9d943aef0ce6e047f10c97d76.1350387132.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 16 Oct 2012 13:39:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 055E101E-17AF-11E2-9959-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207845>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> t3419 sets the t3419-rebase-patch-id.sh prereq based on the availability
> of /usr/bin/time but calls the binary unconditionally (in debug mode).
>
> Make it run the timing only when the prereq is matched.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

I do not think we should ship our tests with too many test_debug in
the first place (it is something you as a developer who are trying
to figure out why your change broke tests can insert into tests).
It might be useful to be able to say "sh ./t1234-*.sh -d" and see
debug output that somebody else thought that it might be useful, so
I wouldn't say we should remove all existing test_debug, but at the
same time, if a developer finds existing test_debug does not work
for him (either what the debug output gives him is insufficient for
his needs, or what the debug command uses is not available on his
system), he should be willing to update (and capable of doing so) it
to suit his needs.  Adding prereq in front of test_debug is simply
an act of insanity.

For this particular one, I think this should suffice.  If the shell
does not have "time" built-in, then timeme can be set to even an
empty string, but that is left as an exercise to the readers.

 t/t3419-rebase-patch-id.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git i/t/t3419-rebase-patch-id.sh w/t/t3419-rebase-patch-id.sh
index e70ac10..bf2736a 100755
--- i/t/t3419-rebase-patch-id.sh
+++ w/t/t3419-rebase-patch-id.sh
@@ -6,7 +6,11 @@ test_description='git rebase - test patch id computation'
 
 test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
-test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
+if test -x /usr/bin/time
+	timeme=/usr/bin/time
+else
+	timeme=time
+fi
 
 count()
 {
@@ -35,7 +39,7 @@ scramble()
 run()
 {
 	echo \$ "$@"
-	/usr/bin/time "$@" >/dev/null
+	$timeme "$@" >/dev/null
 }
 
 test_expect_success 'setup' '
