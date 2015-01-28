From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Wed, 28 Jan 2015 20:19:10 +0100
Message-ID: <54C9362E.2000705@web.de>
References: <54C7B115.7020405@web.de> <xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com> <54C89DC8.1050805@web.de> <CAPc5daVAGOnu3pe_r=GuDXp1kNkJgbCqP-qD38kXmdEJa3ZSFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:26:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZBy-0002Or-9B
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbbA1U0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2015 15:26:21 -0500
Received: from mout.web.de ([212.227.17.11]:50814 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757649AbbA1U0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:26:10 -0500
Received: from birne.lan ([78.68.171.17]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MZUS9-1XxeNO0a33-00LHRI; Wed, 28 Jan 2015 20:19:11
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAPc5daVAGOnu3pe_r=GuDXp1kNkJgbCqP-qD38kXmdEJa3ZSFQ@mail.gmail.com>
X-Provags-ID: V03:K0:kKVMLOADsIJW7a0EJ2V8VbqvDpVvGw1S6lbiTb22gaju7si29xG
 jhcrXTFXfhDQ4QO6EfZtNkpyHrOSXUYESie8Ct94K41RxRon3TFnQwtHyCBbohP3XjFxffE
 cpn+mhUgl9CpdGBbqobbrccX0XD1ovWwl5rOrKWp23jE1njRnTQOdSNzVbdce2nXBtnNvTM
 opYbjcr454tJAxIGbagBg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263108>


On 28.01.15 18:38, Junio C Hamano wrote:
> On Wed, Jan 28, 2015 at 12:28 AM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> On 27.01.15 23:20, Junio C Hamano wrote:
>>
>>> How about extending it like this (not tested)?
>> Thanks, this looks good: the test is more extensive,
>> I can test this next week.
>>
>>> -- >8 --
>>> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>>> Date: Tue, 27 Jan 2015 16:39:01 +0100
>>> Subject: [PATCH] test-lib.sh: set prerequisite SANITY by testing wh=
at we really need
>>>
>>> What we wanted out of the SANITY precondition is that the filesyste=
m
>>> behaves sensibly with permission bits settings.
>>>
>>>  - You should not be able to remove a file in a read-only directory=
,
>>>
>>>  - You should not be able to tell if a file in a directory exists i=
f
>>>    the directory lacks read or execute permission bits.
> Forgot one thing. I do not offhand know if tests that needs SANITY
> depends on this, but we may also want to check for this:
>
>  - You should not be able to write to a file that is marked as read-o=
nly.
>
> by adding something like
>
>   >sanitytest && chmod -w sanitytest && ! echo boo >sanitytest && !
> test -s sanitytest"
>
> in the mix.
>
>>> We used to cheat by approximating that condition with "is the /
>>> writable?" test and/or "are we running as root?" test.  Neither tes=
t
>>> is sufficient or appropriate in more exotic environments like
>>> Cygwin.
>> How about going this direction:
>>
>> We used to cheat by approximating that condition with "is the /
>> writable?" test and/or "are we running as root?" test. Neither test
>> is sufficient or appropriate, especially in environments like
>> Cygwin, Mingw or Mac OS X.
> OK, but MacOS X does not have SANITY problem; "is the / writable?" te=
st
> was misdetecting and declaring a system with SANITY does not have one=
=2E
>
> Perhaps roll Cygwin and Mingw into a single Windows category? I dunno=
=2E
The whole discussion actually started with Mac OS X,
and the conclusion was that Mac OS X should have SANITY set, but hadn't=
,
because  / is writable (if you install from scratch):

$gmane/262389
and especially:
$gmane/262456

The whole discussion ended up a fix for t5539, and, as a different impr=
ovement,
the lazy SANITY probing - which works for me on all systems I had the c=
hance to test it.

The code is OK (we can add more tests, as you suggested).
The only problem I can see is to put everything into a good commit-msg.
