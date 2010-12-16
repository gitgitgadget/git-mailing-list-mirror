From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 11/14] t3032-*.sh: Pass the -b (--binary) option to sed
 on cygwin
Date: Thu, 16 Dec 2010 21:19:12 +0000
Message-ID: <4D0A8250.5090403@ramsay1.demon.co.uk>
References: <4D07B8B5.2030409@ramsay1.demon.co.uk> <7vtyigtaxn.fsf@alter.siamese.dyndns.org> <4D07FE91.2090003@sunshineco.com> <4D087AC7.2090705@viscovery.net> <4D088AB6.5090501@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMWM-0000lG-4a
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0LPWls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:41:48 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:65292 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751608Ab0LPWlr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 17:41:47 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PTMWA-00048d-nx; Thu, 16 Dec 2010 22:41:47 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4D088AB6.5090501@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163833>

Eric Sunshine wrote:
> On 12/15/2010 3:22 AM, Johannes Sixt wrote:
>> Am 12/15/2010 0:32, schrieb Eric Sunshine:
>>> On 12/14/2010 2:24 PM, Junio C Hamano wrote:
>>>> Ramsay Jones<ramsay@ramsay1.demon.co.uk>   writes:
>>>>> The test using the conflict_hunks helper function (test 9) fails
>>>>> on cygwin, since sed (by default) throws away the CR from CRLF
>>>>> line endings. This behaviour is undesirable, since the validation
>>>>> code expects the CRLF line-ending to be present. In order to fix
>>>>> the problem we pass the -b (--binary) option to sed, using the
>>>>> SED_OPTIONS variable. We use the SED_STRIPS_CR prerequisite in the
>>>>> conditional initialisation of SED_OPTIONS.
>>>>>
>>>>> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>>>>> ---
>>>>>
>>>>> Note that this test does not fail on MinGW, but I don't
>>>>> really know why, given commit ca02ad3... ahem ;-)
>>>> Ahem, indeed.  Why?
>>> t3032 does indeed fail on MinGW, and was fixed in the msysgit port by [1],
>>> but was subsequently "lost" when msysgit was rebased onto junio/next [2]
>>> which did not have that test. Consequently, the fix never made it into the
>>> mainline git source.
>> Sorry, but on MinGW, I only need the GREP_OPTIONS part of that fix, but
>> not the SED_OPTIONS. It's also mysterious for me.
>>
>> OTOH, the fix in ca02ad3 that applies to t6038, does not work for me as is
>> because my sed does not understand -b; it needs --nocr. Maybe it is the
>> sed version that makes the difference?
>>
>> D:\Src\mingw-git\t>sed --version
>> GNU sed version 3.02
> 
> Failure of t3032 was reported by Pat Thoyts [1] when preparing for the 
> v1.7.3 release. The problem was diagnosed and patched via [2] under the 
> standard msysgit netinstall [3] environment. From commit message [2], 
> GREP_OPTIONS and SED_OPTIONS were applied to resolve distinct cases of 
> line-terminator "corruption" (t3032.4-t3032.8 and t3032.9, respectively) 
> within that environment at the time the patch was prepared.
> 
> Your tool versions may indeed not be compatible with those of the 
> netinstall environment [3]:
> 
> $ sed --version
> GNU sed version 4.2.1
> 
> Unfortunately, the old --nocr is not recognized by modern GNU sed:
> 
> $ sed --nocr
> sed: unrecognized option `--nocr'

Yes. Like Johannes, I have sed version 3.02 on MinGW, but on cygwin
I have sed version 4.1.5. See patch #14, where I introduce the
SED_BIN_OPT variable to allow me to run the tests with SED_OPTIONS
set to -c instead of -b.

[I thought I was unusual in having such an old sed version, but
apparently not... ;-) ]

ATB,
Ramsay Jones
