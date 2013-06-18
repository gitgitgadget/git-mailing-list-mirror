From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 3/6] test-lib: verbose mode for only tests matching a pattern
Date: Tue, 18 Jun 2013 10:45:59 +0200
Message-ID: <8761xbdcxk.fsf@linux-k42r.v.cablecom.net>
References: <cover.1371460265.git.trast@inf.ethz.ch>
	<8739d3ba5947c60d402030fc35d47115e7a51b0f.1371460265.git.trast@inf.ethz.ch>
	<20130618053710.GB5916@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 18 10:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UorYh-0005V5-QW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 10:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076Ab3FRIqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 04:46:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:25197 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754907Ab3FRIqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 04:46:11 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 18 Jun
 2013 10:46:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.55.184.227) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 18 Jun 2013 10:46:08 +0200
In-Reply-To: <20130618053710.GB5916@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 18 Jun 2013 01:37:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.55.184.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228174>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 17, 2013 at 11:18:48AM +0200, Thomas Rast wrote:
>
>> As suggested by Jeff King, this takes care to wrap the entire test_expect_*
>> block, but nothing else, in the verbose toggling.  To that end we use
>> a new pair of hook functions.  The placement is a bit weird because we
>> need to wait until the beginning of test_skip for $test_count to be
>> incremented.
[...]
>   test_start ;# increment number, run setup hooks
>   if ! test_skip
>   then
>     ...
>   fi
>   test_finish ;# teardown hooks
>
> Then it is a bit easier to see that each start has a finish (whereas in
> the current version, the setups in test_skip are matched by individual
> teardowns in each caller). I did not look too hard at it, though, so I
> wouldn't be surprised if there is some other hidden order dependency
> that makes that not work. :)

No, I think that's actually very reasonable.  I'll do it that way in v3.

> But then what is this hunk doing:
>
>>  test_eval_ () {
>>  	# This is a separate function because some tests use
>>  	# "return" to end a test_expect_success block early.
>> @@ -358,9 +399,7 @@ test_run_ () {
>>  
>>  	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>>  	then
>> -		setup_malloc_check
>>  		test_eval_ "$test_cleanup"
>> -		teardown_malloc_check
>>  	fi
>>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"
>>  	then

Thanks for catching this -- it's just a mis-edit that would effectively
revert 1/6.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
