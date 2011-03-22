From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Tue, 22 Mar 2011 08:55:00 +0100
Message-ID: <4D8855D4.6080804@drmicha.warpmail.net>
References: <cover.1300702130.git.git@drmicha.warpmail.net> <8bad49d4e4897be623b7af3096498a5803dbbd89.1300702130.git.git@drmicha.warpmail.net> <20110321184514.GA1850@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:58:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1wU8-0004tG-O9
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 08:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755039Ab1CVH6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 03:58:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40102 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751048Ab1CVH6b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 03:58:31 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 97E0720C65;
	Tue, 22 Mar 2011 03:58:30 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 22 Mar 2011 03:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1w9AUxX2faG8Tz58tA/W7kRWHso=; b=LaLHHX/ikBcBlywvv/DbC7YfAfcuDkeUKyjU5fUDlXbC6LNypqvYkJ7VhDw9phlFt2LQff/saV7GkrYGsWYK22xtP5Eb4sXVMll+iBskiQLaozkDxuBfFWXkLiotSYVhoPpThgpkgc2vM0G6oVhZQH8SylRkaznzdTaBUC+Lucg=
X-Sasl-enc: Rpfy0jJVgd1pkZmorv+zLloVY8yIqOXgWI7JERyp4i8R 1300780710
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7F6EE440B34;
	Tue, 22 Mar 2011 03:58:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110321184514.GA1850@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169706>

Jonathan Nieder venit, vidit, dixit 21.03.2011 19:45:
> Michael J Gruber wrote:
> 
>> Based on mg/rev-list-one-side-only (in next) to save Junio a build conflict
>> resolution.
> 
> Not a serious problem, but I wish it hadn't been.  What particular

But why? Basing it on something earlier would have served no purpose
(that I know of) at all.

I should have mentioned the dependency in v1.

> functionality from that branch does this use?
> 
> Ah, now that I check it seems that that is to change a use of
> no_merges in the implementation of --cherry to use the new API?  Makes
> sense (and good catch).  With that hunk skipped, the patches apply to
> master.

Yes, revs->no_merges and revs->merges are gone, so a series based on
master would produce a compile failure when applied to next.

> 
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -72,11 +72,24 @@ endif::git-rev-list[]
>>  
>>  --merges::
>>  
>> -	Print only merge commits.
>> +	Print only merge commits. This is equivalent to `--min-parents=2`.
>>  
>>  --no-merges::
>>  
>> -	Do not print commits with more than one parent.
>> +	Do not print commits with more than one parent. This is
>> +	equivalent to `--max-parents=1`.
>> +
>> +--min-parents::
>> +--max-parents::
>> +
>> +	Show only commits which have at least resp. at most that many
> 
> ENOPARSE.  I guess parentheses around "resp. at most" would work as
> a minimal fix, but it might be better to say:
> 
>  --min-parents=<n>::
> 	Show only commits which have at least <n> parents.
> 
>  --max-parents=<n>::
> 	Show only commits which have at least <n> parents.
> 
> and perhaps to put
> 
>  git log --max-parents=0::
> 	Lists all root commits.
> 
>  git log --min-parents=3::
> 	Lists all octopus merges.
> 
> under EXAMPLES.
> 

Well, we discussed this under the v1 thread (after v2 was sent). Junio,
should I do a v3 with that or this?

>> +	commits, where negative parameters for `--max-parents=` denote
>> +	infinity (i.e. no upper	limit).
> 
> Seems hackish.  Maybe --no-max-parents could denote infinity?

For me, "-1" is a quite natural way to reset a count type parameter, and
you don't even have to think "unsigned" or "mod max_int" for that.

There is no problem parsing for "--max-parents=infinity" and/or
"--no-max-parents" or even (better?) "--max-parents=" without number,
it's only a matter of bike shedding decisions.

>> ++
>> +In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
>> +`--merges` (only), `--max-parents=0` gives all root commits and
>> +`--min-parents=3` all octopuses.
>> +
>>  
>>  --first-parent::
> 
> It seems there is an extra newline here.
> 
>> --- a/t/t6009-rev-list-parent.sh
>> +++ b/t/t6009-rev-list-parent.sh
>> @@ -1,9 +1,17 @@
>>  #!/bin/sh
>>  
>> -test_description='properly cull all ancestors'
>> +test_description='ancestor culling and limiting by parent number'
>>  
>>  . ./test-lib.sh
>>  
>> +check_revlist () {
>> +	rev_list_args="$1" &&
>> +	shift &&
>> +	git rev-parse "$@" >expect &&
>> +	git rev-list $rev_list_args --all >actual &&
>> +	test_cmp expect actual
>> +}
>> + 
> 
> "git am" warns about trailing whitespace on the line after the closing
> brace (nothing that --whitespace=fix can't fix, though).

Hmmm, are there whitespace issues which am warns about and diff does
not, or have I missed a warning?

> 
> Thanks for factoring this out btw.  It makes the tests themselves
> very easy to read.
> 
>> +test_expect_success 'rev-list override and infinities' '
>> +
>> +	check_revlist "--min-parents=2 --max-parents=1 --max-parents=3" tripus normalmerge &&
>> +	check_revlist "--min-parents=1 --min-parents=2 --max-parents=7" tetrapus tripus normalmerge &&
>> +	check_revlist "--min-parents=2 --max-parents=8" tetrapus tripus normalmerge &&
>> +	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge
>> +'
> 
> 7 and 8 don't mean infinity any more, do they?  What is this test
> checking?

The test checks "override and infinities", where the plural indicates
the fact that it tests different ways of spelling (practical) infinity
such as the very suggestive "8" which nobody cares about but me.

Michael
