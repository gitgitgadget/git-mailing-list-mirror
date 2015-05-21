From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Thu, 21 May 2015 12:06:35 +0200
Organization: gmx
Message-ID: <86b89ca969ff967f600f955f1990cdca@www.dscho.org>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
 <1432112843-973-2-git-send-email-davvid@gmail.com>
 <xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
 <CAHGBnuPyhG4y5ooR7KH0KrEhRYFu9BB+HKnnn+XhU5xL2TnL=w@mail.gmail.com>
 <xmqq8ucjm0bo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 12:06:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvNNP-00028t-5L
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbbEUKGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 06:06:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:52739 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753001AbbEUKGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 06:06:49 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mcyxq-1YeOUA3wYs-00IC8b; Thu, 21 May 2015 12:06:37
 +0200
In-Reply-To: <xmqq8ucjm0bo.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:CnHimmG+d8wDypXk3Jp6wVxUs6e7Ww+EaC01qFgJyBpFtoSeoT3
 tVlrNlw2YkDTA35eTf4jrJ8x+6pquyOsULow3jGaOyRjJ6nWT2xszyr/JJSDqOdnyOZAyVF
 yTo/Xt0cbdAEEVH97WgljzbAjRpBJKxJgbOnzqa7FntZcP4WVoCLKXU7iio1yLzAVI6xa9a
 wSZtxYCEA9MmjkyT+/Pdw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269577>

Hi Junio,

On 2015-05-20 23:00, Junio C Hamano wrote:
> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
>> On Wed, May 20, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> David Aguilar <davvid@gmail.com> writes:
>>>
>>>> +     for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
>>>> +             cut -d '=' -f 2- | sort -u)
>>>
>>> Is the final "sort" really desired?  I am wondering if there are
>>> fixed precedence/preference order among variants of %PROGRAMFILES%
>>> environment variables that the users on the platform are expected
>>> to stick to, but the "sort" is sorting by the absolute pathnames of
>>> where these things are, which may not reflect that order.
>>
>> I did add the sort (and -u) by intention, to ensure that "C:\Program
>> Files" (which is what %PROGRAMFILES% expands to by default) comes
>> before "C:\Program Files (x86)" (which is what %PROGRAMFILES(X86)%
>> expands to by default), so that programs of the OS-native bitness are
>> preferred.
> 
> Yuck.  So even though %PROGRAMFILES% and %PROGRAMFILES(X86)% look as
> if they are variables that can point at arbitrary places, they in
> reality don't?  Otherwise %PROGRAMFILES% may point at D:\Program
> while %PROGRAMFILES(X86)% may piont at C:\X86 and the latter would
> sort before the former, which would defeat that "logic".

Well, you are correct, theoretically an administrator could set the registry values (which are the source of the environment variables in question) of the `ProgramFilesDir` key in both

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion

and

HKEY_LOCAL_MACHINE\Software\WOW64\Microsoft\Windows\CurrentVersion

to wildly different locations as you outlined. However, it is not supported by Microsoft to change those locations via the registry:

https://support.microsoft.com/en-us/kb/933700

Ciao,
Dscho
