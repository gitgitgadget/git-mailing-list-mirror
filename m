From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 16:24:20 -0800
Message-ID: <7vr61kpw0b.fsf@gitster.siamese.dyndns.org>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com>
 <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org>
 <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com>
 <7vmyc8rhry.fsf@gitster.siamese.dyndns.org>
 <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
 <7veixkrfif.fsf@gitster.siamese.dyndns.org>
 <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com>
 <7v4oygrd3w.fsf@gitster.siamese.dyndns.org>
 <wRrDhWKagbvPUgIXKKh8JIhASl974j2rrgyuh-WEzRJFcXywywNupg@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0902270056270.10279@pacific.mpi-cbg.de> <4WGE1cq9SGp9DuzqT2ZuVN0RzLGmBe1mAX4n1O4-TNyRqiZqxDP62A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 27 01:26:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcqYB-00032H-C6
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 01:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZB0AYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 19:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbZB0AYb
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 19:24:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZB0AYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 19:24:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F06F2571;
	Thu, 26 Feb 2009 19:24:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B8E52570; Thu,
 26 Feb 2009 19:24:22 -0500 (EST)
In-Reply-To: <4WGE1cq9SGp9DuzqT2ZuVN0RzLGmBe1mAX4n1O4-TNyRqiZqxDP62A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 26 Feb 2009 18:12:26 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEB8B856-0464-11DE-90E6-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111620>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Johannes Schindelin wrote:
>> Hi,
>> 
>> On Thu, 26 Feb 2009, Brandon Casey wrote:
>> 
>>>    sed -e 'script' input-file
>>>
>>> rather than
>>>
>>>    sed -e 'script' < input-file
>> 
>> What should make the former more preferable to the latter?
>
> It's less complex, but as you describe in the next paragraph, if the
> file name is not desired in the result then the latter is preferable.
> I initially viewed the latter form as a useless use of cat, equivalent
> to:
>
>    cat input-file | sed -e 'script'
>
>> Especially given that the latter way is preferable with other commands (at 
>> least as far as our test suite is concerned), such as grep, because you do 
>> not get the file name as part of the result?
>> 
>> And especially given that sed means _stream_ editor, not file editor?
>
> especially? Your first argument is valid, but this last sentence means nothing.
>

Ok, ok, I heard all of you.  I think "sed -e 'script' file" is better
because it is one letter shorter than with "<" rediretion, nothing else.

I merely was shooting for rejecting an obvious crap, not aiming for
perfection.

Here is the final one.  Let's stop wasting time and go on with our lives
;-)

Thanks.

-- >8 --
From: Jay Soffian <jaysoffian@gmail.com>
Date: Thu, 26 Feb 2009 18:44:40 -0500
Subject: [PATCH] t5540-http-push.sh: avoid non-portable grep -P

OS X's GNU grep does not support -P/--perl-regexp.

We use a basic RE instead, and simplify the pattern slightly by
replacing '+' with '*' so it can be more easily expressed using a basic
RE.  The important part of pattern, checking for a SHA-1 has suffix in
the successful PUT/MOVE operations, remains the same.  Also, a-z instead
of a-f was an obvious mistake in the original RE. Here are samples of
what we want to match:

127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "PUT /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277
127.0.0.1 - - [26/Feb/2009:22:38:13 +0000] "MOVE /test_repo.git/objects/3e/a4fbb9e18a401a6463c595d08118fcb9fb7426_fab55116904c665a95438bcc78521444a7db6096 HTTP/1.1" 201 277

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5540-http-push.sh |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 11b3432..10e5fd0 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -94,10 +94,15 @@ test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 '
 
-test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+x1="[0-9a-f]"
+x2="$x1$x1"
+x5="$x1$x1$x1$x1$x1"
+x38="$x5$x5$x5$x5$x5$x5$x5$x1$x1$x1"
+x40="$x38$x2"
 
-	grep -P "\"(?:PUT|MOVE) .+objects/[\da-z]{2}/[\da-z]{38}_[\da-z\-]{40} HTTP/[0-9.]+\" 20\d" \
-		< "$HTTPD_ROOT_PATH"/access.log
+test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
+	sed -e "s/PUT /OP /" -e "s/MOVE /OP /" "$HTTPD_ROOT_PATH"/access.log |
+	grep -e "\"OP .*/objects/$x2/${x38}_$x40 HTTP/[.0-9]*\" 20[0-9] "
 
 '
 
-- 
1.6.2.rc2.91.gf9a36
