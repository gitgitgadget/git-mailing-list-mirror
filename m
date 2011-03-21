From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 09:52:45 +0100
Message-ID: <4D8711DD.2040407@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318211418.GA23407@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 09:52:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1ar6-0008AV-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 09:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab1CUIws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 04:52:48 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:48878 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751623Ab1CUIwq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 04:52:46 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C9D1B2057F;
	Mon, 21 Mar 2011 04:52:45 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 21 Mar 2011 04:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=9hZFZYQ//LUGb00XROqnJwSp7LE=; b=E9u+D8NYPltekgSmEMJ/msvLxX8pPi9/22si8MtVYDgAtsqQmOTNExYqRzbEPFI2rUU+YXBAHyA6N1Pv5VogVTOZwzJr0saCPoDYkLxnbw9MfQB3fIAMGIrLcpOSdb4I4qGe856thL5VcqvrfnHzkfgi0SXkuKi8TNSXDCwnTCU=
X-Sasl-enc: O+Vubpio2ikICsBHRvNsF2PgGuEGemgFvx6/NTtP8AXU 1300697565
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 550DB44406D;
	Mon, 21 Mar 2011 04:52:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318211418.GA23407@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169561>

Jonathan Nieder venit, vidit, dixit 18.03.2011 22:14:
> Hi,
> 
> Michael J Gruber wrote:
> 
>> [Subject: rev-list --min-parents,--max-parents: doc and test and completion]
>>
>> This also adds test for "--merges" and "--no-merges" which we did not
>> have so far.
> 
> Minor nit: the life of reviewers is easier when the documentation and
> tests are squashed with the implementation (or if anything, the
> documentation comes first) so they can look at what the code tries to
> do before seeing how it does it.

Come on, with a cover-letter saying doc and tests are in 3/3, how much
effort is it to read that before 1/3 if you care?

The tests are bogus before the code and the doc pointless before it.

Squashing 1 and 3 is okay, of course. For my own digestion, smaller
bites are better.

>> --- a/t/t6009-rev-list-parent.sh
>> +++ b/t/t6009-rev-list-parent.sh
>> @@ -1,6 +1,6 @@
> [...]
>> -test_description='properly cull all ancestors'
>> +test_description='ancestor culling and limitting by parent number'
> 
> sp: limiting
> 
> Thanks for updating the description.  It's easy to forget.

I would have preferred to assign an extra test number (since the
relation between the above is a bit weak) but the numbers are all used
up in that range.

> 
>> @@ -28,4 +28,72 @@ test_expect_success 'one is ancestor of others and should not be shown' '
> [...]
>> +check_revlist () {
>> +	> expect &&
>> +	for c in $2; do echo "$c" >> expect; done &&
>> +	git rev-list $1 master | git name-rev --name-only --tags --stdin >actual &&
>> +	test_cmp expect actual
>> +}
> 
> Pedantic nits:
> 
>  * if global functions are defined before all test_expect_success stanzas,
>     (1) it is easier to reuse them in tests throughout the script;
>     (2) it is easy to see at a glance what primitives a test script
>         will be using when getting acquainted with it and what
>         syntax might be worth lifting to test-lib or other test
>         scripts when shopping for that
>  * style: no space between >redirection operators and their argument
>    for consistency (maybe because > &2 is a syntax error)
>  * might be simpler to pass one rev per argument.  Like so:
> 
> 	rev_list_args=$1 &&
> 	shift &&
> 	printf '%s\n' "$@" >expect &&
> 	git rev-list $rev_list_args master ...
> 
>    Avoiding the for loop means errors from 'echo' before the last
>    iteration are not ignored; a more verbose way to write the same

Do we really need to safe-guard echo and prints?

>    thing is
> 
> 	for commit
> 	do
> 		printf '%s\n' "$commit" ||
> 		return
> 	done >expect &&
> 	git rev-list ...
>  * this does not catch errors from rev-list!  how about
> 
> 	git rev-list $rev_list_args master >rev-list &&
> 	git name-rev ... <rev-list >actual &&
> 	test_cmp expect actual

Thanks for both of the above, that makes things much better. Although I
have to treat the case with empty rev-list specially now, or use the
verbose version.

> 
>    Junio will probably complain that this is not meant to be a test
>    for name-rev; indeed, filling "expect" by computing commit names
>    might be even better (because faster).

Well, we do this in other places as well, and it makes the test much
more readable. Alternatively, I could use rev-parse on the args, which
is faster than name-rev on the rev-list output. That makes it less
readable in case a test breaks, though. Anyways, I'll go for that.

> 
>> +test_expect_success 'rev-list roots' '
>> +test_expect_success 'rev-list no merges' '
>> +test_expect_success 'rev-list no octopusses' '
>> +test_expect_success 'rev-list no roots' '
>> +test_expect_success 'rev-list merges' '
> 
> Neat. :)
> 
> 
>> +test_expect_success 'rev-list octopus' '
>> +
>> +	check_revlist "--min-parents=3" "octopus"
>> +'
> 
> Might make sense to check a dodecapus (with --min-parents=3 still) as
> well.

Dodeka, really? I leave that to you.
I might add a tetrapus, though.

> 
>> +test_expect_success 'rev-list override and infinities' '
> 
> Ah, here's the test I suggested in reply to patch 1.  But this is not
> about overriding but the lack thereof, no?  So I'd be happier reading
> something like
> 
> 	test_expect_success '--no-merges --merges yields the empty set' '
> 		check_revlist "--no-merges --merges" &&
> 		check_revlist "--min-parents=2 --no-merges"
> 	'
> 
> 	test_expect_success 'last --max-parents wins' '

wins against? Against itself, i.e. it overrides previous occurences. But
I'll separate these.

> 		check_revlist "--min-parents=2 --no-merges --max-parents=3" octopus normalmerge &&
> 		check_revlist "--min-parents=2 --max-parents=3 --no-merges" ...
> 	'
> 
> 	test_expect_success '--max-parents=infinity' '
> 		...
> 	'
> 
> 	test_expect_success '--min-parents=infinity' '
> 		...
> 	'
> 
> 	test_expect_failure '--max-parents=gobbledegood errors out' '
> 		...
> 	'

I don't really want to parse for the string "infinity" nor go for strtol
instead of atoi. Why shouldn't something "unparseable" be 0?

Michael
