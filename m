From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Binary grep t7008 known breakage vanished on Cygwin
Date: Tue, 19 Apr 2016 19:52:11 +0100
Message-ID: <57167E5B.6060505@ramsayjones.plus.com>
References: <20160418152149.GD2345@dinwoodie.org>
 <5715147F.7020609@ramsayjones.plus.com> <20160419084232.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 21:02:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asaum-0006pL-O7
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933879AbcDSTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:02:20 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41654 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933875AbcDSTCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:02:20 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id kK2G1s0032D2Veb01K2HYe; Tue, 19 Apr 2016 20:02:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=0vCrn0Jzb4ehFClENy4A:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160419084232.GE2345@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291905>



On 19/04/16 09:42, Adam Dinwoodie wrote:
> On Mon, Apr 18, 2016 at 06:08:15PM +0100, Ramsay Jones wrote:
>> On 18/04/16 16:21, Adam Dinwoodie wrote:
>>> t7008.12 is marked as an expected failure, but building Git on Cygwin
>>> including a `make configure && ./configure` step has the test
>>> unexpectedly passing.  Building without the configure step has the test
>>> failing as expected.
>>>
>>> This appears to be behaviour specific to Cygwin; at least I get that
>>> test failing on my CentOS box regardless of whether I perform the
>>> configure step.
>>
>> Yes, the configure sets NO_REGEX= whereas the config.mak.uname sets
>> NO_REGEX=UnfortunatelyYes.
>>
>> [Note that the regex bug (see t0070-fundamental.sh test #5) now seems to
>> pass with the 'native' regex library]
> 
> Ah, that makes sense.
> 
> I'm still not quite sure what the "correct" thing to do here is; it
> looks as though the NOREGEX=UnfortunatelyYes can disappear from
> config.mak.uname, but that still leaves t7008.12 passing when it's
> expected to fail.

Yep. ;-)

About two years ago, I went from 32-bit 1.5 to 32-bit 1.7 then 64-bit 1.7.
At that time the 'native' regex library suffered from the 'regex bug' (ie it
failed t0070.5). It also 'unexpectedly passed' t7008.12. However, since the
fix for t0070.5 was to use the compat/regex library, I didn't have to give
t7008.12 any thought. :-D

I am currently running:

    $ uname -a
    CYGWIN_NT-10.0 satellite 2.4.0(0.293/5/3) 2016-01-15 16:16 x86_64 Cygwin
    $ 

Until yesterday, I didn't know that the native regex library no longer suffers
from the t0070.5 bug. I simply don't use the configure script - never have.
It seems that t7008.12 is still an issue, however.

The commit which added that test, commit f96e5673, seems to expect that NUL
characters should not be matched in any way. Now, _if_ you accept that this
is correct behaviour, then the native regex library on Cygwin still has a
problem.

Maybe we need to add a check to test-regex (and/or configure)? dunno.
Alternatively, we could skip the test with a !CYGWIN prerequisite.

[Again, I don't use configure or the native regex library]

ATB,
Ramsay Jones
