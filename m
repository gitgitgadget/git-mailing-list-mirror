From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 08/16] t/t5516-fetch-push: use test_config()
Date: Sat, 22 Jun 2013 11:57:59 +0200
Message-ID: <51C57527.8060806@kdbg.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com> <1371813160-4200-9-git-send-email-artagnon@gmail.com> <7vobazjdrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 11:58:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqKaA-0002Qn-QI
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 11:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501Ab3FVJ6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 05:58:05 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:38088 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751365Ab3FVJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 05:58:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D04E2130049;
	Sat, 22 Jun 2013 11:56:21 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3C2D119F5E8;
	Sat, 22 Jun 2013 11:58:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vobazjdrf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228694>

Am 22.06.2013 00:32, schrieb Junio C Hamano:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> Replace the 'git config' calls in tests with test_config for greater
>> robustness.
> 
> That may be a good thing in principle, but I _think_
> 
> 	mk_empty testrepo &&
>         (
>         	cd testrepo &&
>                 do whatever to its config &&
>                 run test
> 	)
> 
> sequence is used so that we do not even have to worry about what
> leftover configuration values are in the testrepo/.git/config; so
> does it really matter?
> 
> If this conversion had something more than "s/git config/test_config/"
> replacement, that would indicate that you uncovered a bug in the
> existing test and found a good fix, but that does not seem to be the
> case for this particular patch.

And just let me add that the added benefit of test_config to remove the
configuration change after the test case finished would not work because
the test_when_finished registration that happens behind the scenes would
be forgotten when the sub-shell exits.

>> @@ -142,8 +142,8 @@ test_expect_success 'fetch with wildcard' '
>>  	mk_empty testrepo &&
>>  	(
>>  		cd testrepo &&
>> -		git config remote.up.url .. &&
>> -		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
>> +		test_config remote.up.url .. &&
>> +		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
>>  		git fetch up &&
...

-- Hannes
