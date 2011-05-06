From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Fri, 06 May 2011 09:43:01 +0200
Message-ID: <4DC3A685.4080300@drmicha.warpmail.net>
References: <20110505191027.GA3242@camk.edu.pl> <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:43:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIFgx-0002i1-2z
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1EFHnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 03:43:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57630 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754548Ab1EFHnE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 03:43:04 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E1E3820446;
	Fri,  6 May 2011 03:43:03 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 06 May 2011 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Wz2gSmI9jVjQkyxYRWmr6Zix/Es=; b=G4X8nxKEHM9wIOkcOTAC2YNR6f6GzzWc4Pt2aESoMkU+wcMJvcwg8RIwzTiTg/RZmKVX0ayuPH0GYdH3rXEpYZ2LKQ4ZIV32c0QxHntEFP2RYgeMIAoGCUyNlRcz2VHj2tqKmX5k5zzTZOgMmW7o0GjxEcOhHOeNVCrVTk3vMWo=
X-Sasl-enc: NE7/zfxbwnYav0266vCyc5V6ALVMQu0ktgUcDg2qmcN5 1304667783
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4175344CEBC;
	Fri,  6 May 2011 03:43:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172952>

Junio C Hamano venit, vidit, dixit 05.05.2011 22:02:
> Kacper Kornet <draenog@pld-linux.org> writes:
> 
>> In bash and some other shells the script:
>>
>>   x=2; unset a; echo "${a:-'$x'}"
>>
>> prints '2'. However ksh shell prints $x. The quoting is added to
>> reproduce bash behaviour.
> 
> What I happen to have in /usr/bin/ksh
> 
>     $ /usr/bin/ksh --version
>       version         sh (AT&T Research) 93t+ 2009-05-01
> 
> does not seem to have this issue.
> 
> Whose ksh is this?  It is broken.
> 
> POSIX "2.6.2 Parameter Expansion" [*1*] says in ${parameter<op>word},
> "word shall be subjected to tilde expansion, parameter expansion, command
> substitution, and arithmetic expansion", when "a value of word is needed"
> based on the state of parameter.
> 
> I am not opposed to the change, but because it is not "change to more
> general one" but "work around a bug in <this implementation of ksh>", and
> I would like to know what to fill in the blank when I rewrite the proposed
> commit log message.

I'm running all tests with "dash" these days, and I'm pretty sure "these
days" started before 34df9ab. Anyways, this test passes with dash. I'd
be happy to replace my test shell with an even stricter one if needed.

>> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
>> ---
>>  t/t1506-rev-parse-diagnosis.sh |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
>> index 4a6396f..bad09f9 100755
>> --- a/t/t1506-rev-parse-diagnosis.sh
>> +++ b/t/t1506-rev-parse-diagnosis.sh
>> @@ -8,8 +8,8 @@ exec </dev/null
>>  
>>  test_did_you_mean ()
>>  {
>> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
>> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
>> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
>> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
>>  	test_cmp expected error
>>  }
>>  
>> -- 
>> 1.7.5
> 
> [Reference]
> 
> *1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

Other than that, I have no objections if this patch makes more shells
happy and no happy ones unhappy.

Is your ksh OK with all other tests?

Michael
