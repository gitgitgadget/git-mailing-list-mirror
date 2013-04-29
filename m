From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Mon, 29 Apr 2013 11:17:00 -0700
Message-ID: <7vwqrli4mb.fsf@alter.siamese.dyndns.org>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
	<87fvy9dxok.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:17:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsdS-0007n1-Mg
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758394Ab3D2SRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:17:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59778 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757308Ab3D2SRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:17:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09AF31A3D9;
	Mon, 29 Apr 2013 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqsP5yW+y2O/Bfl+Wl/+e9wdajI=; b=hGb8zL
	J0/iu8dJOSCtrmpHO4muXMduUI0o3Zt1g3DYIcXbdSDOKOc1aJZWEpPJV3C+NbQa
	z9DLxZ58v9pOfaxQxOWYlKXJRc7nltl0J0KU7QPseAw3nA/2FpvF0Im1ErFzMMCs
	0R9/kuwyHLcY7+uYqcqprM+xSdSrvYbol9lx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMPsgol7wSvyXbv7mJF0IkjOsAnlZJ3O
	1d97Dr4xGiEvstStKZXTEaTzD/l77p8eAnJEFl61HszxLiQ98bVI6UBrtzLt3RlY
	9PGVOpUiV0s+mn2faQIXhZdMPOQlI+lu7vIcZtHNxgjYQc4Qxj0cXrVUlgZVjLni
	u1PioxIr8M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 004F11A3D8;
	Mon, 29 Apr 2013 18:17:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5778D1A3D7;
	Mon, 29 Apr 2013 18:17:02 +0000 (UTC)
In-Reply-To: <87fvy9dxok.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Mon, 29 Apr 2013 20:00:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD5E044E-B0F8-11E2-AB14-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222836>

Thomas Rast <trast@inf.ethz.ch> writes:

> John Keeping <john@keeping.me.uk> writes:
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index ca6bdef..70ad085 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -54,8 +54,8 @@ done,*)
>>  	# do not redirect again
>>  	;;
>>  *' --tee '*|*' --va'*)
>> -	mkdir -p test-results
>> -	BASE=test-results/$(basename "$0" .sh)
>> +	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
>> +	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
>>  	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
>>  	 echo $? > $BASE.exit) | tee $BASE.out
>>  	test "$(cat $BASE.exit)" = 0
>
> Hmm, I initially was too lazy to review this change, and now it's biting
> me.  The above is Makefile-quoted, which to the shell reads like a
> command substitution.

Heh, when I let my eyes coast over it I didn't notice them either.
Everything in that patch is bad.

This squashed in?

 t/test-lib.sh         | 4 ++--
 t/valgrind/analyze.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b1e843..e7d169c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,8 +54,8 @@ done,*)
 	# do not redirect again
 	;;
 *' --tee '*|*' --va'*)
-	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
-	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
+	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
+	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
 	 echo $? > $BASE.exit) | tee $BASE.out
 	test "$(cat $BASE.exit)" = 0
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index 7b58f01..2ffc80f 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -119,7 +119,7 @@ handle_one () {
 	finish_output
 }
 
-for test_script in "$(TEST_OUTPUT_DIRECTORY)"/test-results/*.out
+for test_script in "$TEST_OUTPUT_DIRECTORY"/test-results/*.out
 do
 	handle_one $test_script
 done
