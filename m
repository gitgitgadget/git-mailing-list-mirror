From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/8] Fix atomicity and avoid fd exhaustion in ref transactions
Date: Mon, 11 May 2015 08:52:57 +0200
Message-ID: <555051C9.7040204@alum.mit.edu>
References: <1431225937-10456-1-git-send-email-mhagger@alum.mit.edu> <xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:53:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrhaT-000382-2j
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbbEKGxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 02:53:07 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59320 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065AbbEKGxG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:53:06 -0400
X-AuditID: 12074414-f797f6d000004084-80-555051ccf573
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 33.28.16516.CC150555; Mon, 11 May 2015 02:53:00 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4B6qvTp013403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 02:52:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqr3qng2h4.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqHsmMCDUYOtiMYuuK91MFg29V5gt
	frT0MFts3tzOYnHmTSOjA6vHgk2lHs969zB6XLyk7LH4gZfH501yAaxR3DZJiSVlwZnpefp2
	CdwZey/OZytYxF/xaf1t5gbGhTxdjJwcEgImEveO/mOFsMUkLtxbz9bFyMUhJHCZUeLpjm9M
	EM45JokFyxczglTxCmhLPNlyih3EZhFQlbi4sYMJxGYT0JVY1NMMZosKBEm0XpsKVS8ocXLm
	ExYQW0RATWJi2yEWkKHMAh2MEkcfXwcbJCwQKrHy1yawZiGBYomHb5cAFXFwcApYS6z8nAQS
	ZhbQk9hx/RcrhC0v0bx1NvMERoFZSFbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5
	qUW6Fnq5mSV6qSmlmxghAS6yg/HISblDjAIcjEo8vAYX/EOFWBPLiitzDzFKcjApifJm2QSE
	CvEl5adUZiQWZ8QXleakFh9ilOBgVhLhPWUElONNSaysSi3Kh0lJc7AoifN+W6zuJySQnliS
	mp2aWpBaBJOV4eBQkuB1CwBqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFanwx
	MFpBUjxAe7NB2nmLCxJzgaIQracYFaXEeatBEgIgiYzSPLixsLT1ilEc6EthXiWQKh5gyoPr
	fgU0mAlo8N9iH5DBJYkIKakGxqXWH9TOFovw/Pwy761aUZialk9R7oV5mxpkci5r7hWcO7/C
	Yl3vP5eq648jGHIzjIO+bNobJqEnYiitmVCzc43Irfb8QsEVU56pJ6Z/nhC6YXlH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268762>

On 05/11/2015 06:30 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The following other branches, also from my GitHub repo, might be
>> useful:
>>
>> * 'write-refs-sooner-2.3' -- suggested merge of the change to 'maint'.
>>
>> * 'write-refs-sooner-master' -- suggested merge of the change to
>>   'master'.
>>
>> * 'write-refs-sooner-rebased-2.3' and
>>   'write-refs-sooner-rebased-master' -- rebases of 'write-refs-sooner'
>>   onto 'maint' and 'master' respectively, in case anybody is
>>   interested to see how the individual patches would look if
>>   implemented natively on these branches.
> 
> Thanks, that indeed is very helpful and instructive.
> 
> A mechanical merge of sooner-2.2 to maint trivially gave sooner-2.3,
> so I am happy with that one.
> 
> Even though I manually resolved it and the resulting tree pretty
> much matched with your suggested merge, I am hesitant to record the
> change of sooner-2.3 as a single large merge to master.  I am
> tempted to record this as somewhat a wicked merge, e.g.
> 
>  - apply posted patches on maint-2.2, which is your sooner-2.2;
> 
>  - branch sooner-2.3 from maint, merge sooner-2.2;
> 
>  - branch sooner-master from v2.4.0, apply the patches in your
>    sooner-rebased-master on top, and then merge sooner-2.3, possibly
>    with "-s ours"
> 
> And then sooner-master would record both "if built naturally on 2.4"
> progression, which would explain what was done much better than a
> huge merge of sooner-2.3 into 'master', and "what is to be done on
> older codebase".

This is exactly the kind of case that "rebase with history" [1] was
meant to address. But given that our tooling doesn't support such
complicated histories very well, your plan sounds reasonable.

Michael

[1]
http://softwareswirl.blogspot.de/2009/04/truce-in-merge-vs-rebase-war.html

-- 
Michael Haggerty
mhagger@alum.mit.edu
