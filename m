From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Branch Name Case Sensitivity
Date: Tue, 04 Mar 2014 21:37:38 +0100
Message-ID: <53163992.20701@web.de>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>	<53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com>	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com> <xmqqsiqzrwzr.fsf@gitster.dls.corp.google.com> <5315D3B9.6050602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKw6P-00066I-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 21:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757718AbaCDUiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 15:38:06 -0500
Received: from mout.web.de ([212.227.15.4]:56723 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756496AbaCDUiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 15:38:03 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LhvYQ-1Wy4TG22Ne-00nCwc; Tue, 04 Mar 2014 21:37:41
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <5315D3B9.6050602@gmail.com>
X-Provags-ID: V03:K0:XXNYaRrJxbUKuzZH7ObChA7jNSIR/10XM1W5E8cOdllA0Sm34Al
 5Yz+co2dgp2Rcrkokhjpuo0Y+mUWn9laPO7/MJ52oD3hwnrNGm5+0Poywx0fGolF4Lk2woT
 CST2VU5wN00d/KeQsmIUAGBqRo0Domq8MwwhRx3FRjyg4OhEJbn/DgRz2UAKvZWBPTqDZ2P
 2dFqXi/1S/UxruicR57Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243387>

On 2014-03-04 14.23, Karsten Blees wrote:
> Am 03.03.2014 18:51, schrieb Junio C Hamano:
>> Lee Hopkins <leerhop@gmail.com> writes:
>>
>>> I went ahead and took a stab at a solution. My solution is more
>>> aggressive than a warning, I actually prevent the creation of
>>> ambiguous refs. My changes are also in refs.c, which may not be
>>> appropriate, but it seemed like the natural place.
>>>
>>> I have never contributed to Git (in fact this is my first dive into
>>> the source) and my C is a bit rusty, so bear with me, this is just a
>>> suggestion:
>>>
>>> ---
>>>  refs.c |   31 ++++++++++++++++++++++++-------
>>>  1 files changed, 24 insertions(+), 7 deletions(-)
>>
>> Starting something like this from forbidding is likely to turn out
>> to be a very bad idea that can break existing repositories.
>>
> 
> Its sure worth considering what should be done with pre-existing duplicates. However, repositories with such refs are already broken on case-insensitive filesystems, and allowing something that's known to be broken is even more dangerous, IMO.
> 
> An alternative approach could be to encode upper-case letters in loose refs if core.ignorecase == true (e.g. "Foo" -> "%46oo"). Although this may pose a problem for commands that bypass the refs API / plumbing for whatever reason.
> 
>> A new configuration
>>
>> 	refs.caseInsensitive = {warn|error|allow}
>>
> 
> s/caseInsensitive/caseSensitive/
> Its case-sensitive refs that cause trouble, case-insensitive refs would be fine on all platforms.
> 
> I still don't see why we need an extra setting for this. The problems are inherently caused by case-insensitive filesystems, and we already have 'core.ignorecase' for that (its even automatically configured). Having an extra setting for refs is somewhat like making 'core.ignorecase' configurable per sub-directory.
I start to agree here.
The case-insensitive file system does not allow branches foo and Foo at the same time,
and the packed refs should simply follow this convention/restriction/behaviour.

(and everything else could and should go into another patch:
 If we ever want Linux to ignore the case in refs,
 to ease the cross-platform development with Windows.
 Or if we allow Windows/Mac OS to handle case insensitive refs (by always packing them)
 to ease the co-working with e.g. Linux.
)

Lee, could you improve your change in refs.c into a real patch, with a commit message?
(And please have a look at the indentation with TABs)

A test case could be good, if time allows I can make a suggestion.

Thanks for all comments
/Torsten
 
