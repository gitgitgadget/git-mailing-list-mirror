From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/17] Let fetch_pack() inform caller about number of
 unique heads
Date: Sat, 25 Aug 2012 07:05:31 +0200
Message-ID: <50385D1B.8010404@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <1345709442-16046-7-git-send-email-mhagger@alum.mit.edu> <20120823085409.GD6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 07:12:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T58g0-0003iR-CQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 07:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab2HYFMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 01:12:40 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:48593 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944Ab2HYFMi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 01:12:38 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 01:12:37 EDT
X-AuditID: 1207440c-b7f616d00000270b-98-50385d1f92c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.34.09995.F1D58305; Sat, 25 Aug 2012 01:05:35 -0400 (EDT)
Received: from [192.168.69.140] (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P55WPx008149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 01:05:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120823085409.GD6963@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCsfaxFgsHOulkXXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ozvi16wFhwRqjizdjVTA2Mv
	fxcjJ4eEgInE8m2fmCBsMYkL99azdTFycQgJXGaU2PinnwnCOcMksW7zc2aQKl4BbYmzZ14y
	gtgsAqoSvdOmsILYbAK6Eot6msEmiQqESKz5NoURol5Q4uTMJywgtoiArMT3wxvB4swC1hIr
	Xh8GqxcWiJBY3fUSrEZIYDWjxMm7niA2p4CVxILzX4HiHED16hLr5wlBtMpLbH87h3kCo8As
	JBtmIVTNQlK1gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZI4PLsYPy2
	TuYQowAHoxIP740z5gFCrIllxZW5hxglOZiURHnXh1sECPEl5adUZiQWZ8QXleakFh9ilOBg
	VhLh/c4AlONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfCejwJqFCxK
	TU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFaXwxMFJBUjxAe1ViQPYWFyTmAkUhWk8x
	6nJ8fnryLqMQS15+XqqUOK8ASJEASFFGaR7cCliaesUoDvSxMK8vSBUPMMXBTXoFtIQJaEm5
	qznIkpJEhJRUA6Oc64pdnj9dbqsuT3716r+sUOY3/U4+tcDiuiAJDsOIsGIRwXtF26w9rMLP
	sUXcmXxfRpShJL94U8Vs7zrnCwJ/lrpO2F31V/NuvZiO0UyptD/tD5trYk4w/o2Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204246>

On 08/23/2012 10:54 AM, Jeff King wrote:
> On Thu, Aug 23, 2012 at 10:10:31AM +0200, mhagger@alum.mit.edu wrote:
> 
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> fetch_pack() remotes duplicates from the list (nr_heads, heads),
>> thereby shrinking the list.  But previously, the caller was not
>> informed about the shrinkage.  This would cause a spurious error
>> message to be emitted by cmd_fetch_pack() if "git fetch-pack" is
>> called with duplicate refnames.
>>
>> So change the signature of fetch_pack() to accept nr_heads by
>> reference, and if any duplicates were removed then modify it to
>> reflect the number of remaining references.
>>
>> The last test of t5500 inexplicably *required* "git fetch-pack" to
>> fail when fetching a list of references that contains duplicates;
>> i.e., it insisted on the buggy behavior.  So change the test to expect
>> the correct behavior.
> 
> Eek, yeah, the current behavior is obviously wrong. The
> remove_duplicates code comes from 310b86d (fetch-pack: do not barf when
> duplicate re patterns are given, 2006-11-25) and clearly meant for
> fetch-pack to handle this case gracefully.
> 
>> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
>> index 3cc3346..0d4edcb 100755
>> --- a/t/t5500-fetch-pack.sh
>> +++ b/t/t5500-fetch-pack.sh
>> @@ -391,7 +391,7 @@ test_expect_success 'fetch mixed refs from cmdline and stdin' '
>>  test_expect_success 'test duplicate refs from stdin' '
>>  	(
>>  	cd client &&
>> -	test_must_fail git fetch-pack --stdin --no-progress .. <../input.dup
>> +	git fetch-pack --stdin --no-progress .. <../input.dup
>>  	) >output &&
>>  	cut -d " " -f 2 <output | sort >actual &&
>>  	test_cmp expect actual
> 
> It's interesting that the output was the same before and after the fix.
> I guess that is because the error comes at the very end, when we are
> making sure all of the provided heads have been consumed.

"git fetch-pack" emits information about successfully-received
references regardless of whether some requested references were not
received.  The "no such remote ref %s" output goes to stderr.  So the
only difference between before/after fix should be what is written to
stderr, whereas the test only looks at stdout.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
