From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Fri, 13 Nov 2015 03:57:43 -0500
Message-ID: <CAPig+cRjDVPHH3VH-Mv_KJTeOVyxV-6agHDk+bXqZ4kjJoaLJQ@mail.gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
	<CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
	<CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
	<56437F96.2070209@ramsayjones.plus.com>
	<71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:57:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxAB2-0006La-V8
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 09:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbbKMI5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 03:57:45 -0500
Received: from mail-yk0-f195.google.com ([209.85.160.195]:36157 "EHLO
	mail-yk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbbKMI5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 03:57:44 -0500
Received: by ykdr82 with SMTP id r82so12771361ykd.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 00:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NVnYY0PLb2JitvPIoJABCsC+xE6NCyNGrxy1FER626k=;
        b=grSdVsXL7mXswVxICgKYJ9TqwKk6Pf5G9Sf02cbePoErmGk1VimREbMixrn15mD+zu
         Y4DL4YryFKJNdP+YNSd90eYUUdFkimyaqFuXpwJAMViCXoEMqMWRd10CZXq5HTQcXfce
         f2soEsdGjS0G33ArgsZBsiAbOQ0YK/MJLAqI09WmUQ/1KgJ3gQROHCyIU7qYFsL/9duC
         dLlq46exExH4jeqb+RKdI0pYrww40YgIjQmAytQonBws9D5OVk2QU+AXdNm/O0E+liLB
         qmKQtz0BABTeN/8CpeHiX5zTQuGBlXVS9l/Gj5pcbJxL4ZZe3NlfJ8Pit+e4Dve2Sgyp
         oGMw==
X-Received: by 10.13.224.3 with SMTP id j3mr20517419ywe.246.1447405063936;
 Fri, 13 Nov 2015 00:57:43 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Fri, 13 Nov 2015 00:57:43 -0800 (PST)
In-Reply-To: <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com>
X-Google-Sender-Auth: I4rQ5Q4H4vl707fIWv-Cvu8KAto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281245>

On Fri, Nov 13, 2015 at 3:46 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> On 11/11/15 02:00, Stefan Beller wrote:
>>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>>> 02-11-2015) changed the type of some variables from long to off_t.
>>>>> The 32-bit build, which enables the large filesystem interface
>>>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>>>> integer, whereas long is a 32-bit integer. This results in a couple
>>>>> of printf format warnings.
>>>>
>>>> My machine is 64-bit, though, so perhaps it's misleading to
>>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>>> 'long long' on this machine, so it complains about the "long" format
>>>> specifier.
>>>
>>> I wonder if 32 bit compilation can be part of travis.
>>
>> Did this warning show up on the OS X build?
>
> Yes, I added CFLAGS="-Werror=format" to the my experimental TravisCI
> build and it breaks the build on OS X.
> See here (you need to scroll all the way down):
> https://travis-ci.org/larsxschneider/git/jobs/90899656
>
> BTW: I tried to set "-Werror" but then I got a bunch of macro redefined errors like this:
> ./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werror]
>
> Is this a known issue? Is this an issue at all?

Odd. I don't experience anything like that on my Mac.
