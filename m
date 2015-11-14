From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Sat, 14 Nov 2015 20:14:47 +0100
Message-ID: <8823C17E-3F5C-492B-B600-2A73819ECD08@gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com> <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com> <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com> <56437F96.2070209@ramsayjones.plus.com> <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com> <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com> <564641CF.5050008@ramsayjones.plus.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 20:15:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxgIC-0000Mi-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 20:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbbKNTOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 14:14:53 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37800 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbKNTOw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Nov 2015 14:14:52 -0500
Received: by wmww144 with SMTP id w144so70848689wmw.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2015 11:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=p6iJWMaluLawPVI2WEzy4b6R4bgSGpNoOFDyL9AHhH0=;
        b=k9K6peGpYfHAm/NZ6xDMIAnK5Eg3o7di6mNQKYpRulQxCtD+yiNON8lbLa9lZTEVox
         ZVvA7AoFoYlimhZnN4RR9QHFj0EEzuElcI96eNPvL3f5Lu5NykkhmckBxgdY92iU0Umv
         0sNTOcM8ABgsVzsKrf3b7xUWfCRxniXpuD5uYHWy/kdxaQDeWA1IEXOKtPVFCMpBpwVa
         obVptioHbtLqQbmWH2vQdtr7iZRZ/V19ikeiG6tAvr+HLt9k5chpcpZEXG8FWC5UgSUh
         W7R8KvT/AEa9fTbku2/vO701rv3tnyRSzZS7vwdCyveTTcgreZoZTT0Fnr/MrOGYrpmq
         HWkw==
X-Received: by 10.28.46.137 with SMTP id u131mr10097728wmu.61.1447528490797;
        Sat, 14 Nov 2015 11:14:50 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4A30.dip0.t-ipconnect.de. [93.219.74.48])
        by smtp.gmail.com with ESMTPSA id k133sm2350625wmg.18.2015.11.14.11.14.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Nov 2015 11:14:50 -0800 (PST)
In-Reply-To: <564641CF.5050008@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281309>


On 13 Nov 2015, at 21:02, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> 
> 
> On 13/11/15 08:57, Eric Sunshine wrote:
>> On Fri, Nov 13, 2015 at 3:46 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>> On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>>>> On 11/11/15 02:00, Stefan Beller wrote:
>>>>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>>>>> 02-11-2015) changed the type of some variables from long to off_t.
>>>>>>> The 32-bit build, which enables the large filesystem interface
>>>>>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>>>>>> integer, whereas long is a 32-bit integer. This results in a couple
>>>>>>> of printf format warnings.
>>>>>> 
>>>>>> My machine is 64-bit, though, so perhaps it's misleading to
>>>>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>>>>> 'long long' on this machine, so it complains about the "long" format
>>>>>> specifier.
>>>>> 
>>>>> I wonder if 32 bit compilation can be part of travis.
>>>> 
>>>> Did this warning show up on the OS X build?
>>> 
>>> Yes, I added CFLAGS="-Werror=format" to the my experimental TravisCI
>>> build and it breaks the build on OS X.
>>> See here (you need to scroll all the way down):
>>> https://travis-ci.org/larsxschneider/git/jobs/90899656
>>> 
>>> BTW: I tried to set "-Werror" but then I got a bunch of macro redefined errors like this:
>>> ./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werror]
>>> 
>>> Is this a known issue? Is this an issue at all?
>> 
>> Odd. I don't experience anything like that on my Mac.
>> 
> 
> Hmm, from the output, it looks like the configure script is
> not detecting that 'strlcpy' is available (so setting
> NO_STRLCPY=YesPlease in the config.mak.autogen file).
> However, it seems to be a 'macro redirect' set in the
> /usr/include/secure/_string.h header file (presumably it
> redirects between a more or less secure version ;-)
> 
> Unfortunately, I don't have access to a mac - so I can't
> help you with the debugging. :(
> 

I don't have any experience with autotools at all. However, here is what I found out on OS X Mavericks (10.9.5):
1.) In config.mak.uname, line 103, "NO_STRLCPY = YesPlease" is set for some old OS X version. However, it looks like these settings have no impact at all.
2.) In configure.ac, line 1010, the AC_CHECK_FUNC macros (via GIT_CHECK_FUNC) is used to detect strlcpy. That detection fails on OS X Mavericks.
3.) I tried to use "AC_CHECK_DECLS" to detect strlcpy declarations on OS X and this works.

Can you give me a few hints how to debug this further? Why do have the values in config.mak.uname no impact? My idea was to detect OS X Mavericks there and unset NO_STRLCPY. Could that work?

Thanks,
Lars 
