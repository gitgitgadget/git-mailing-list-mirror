From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 01 Dec 2008 09:29:12 +0100
Message-ID: <4933A058.3050101@viscovery.net>
References: <200811121029.34841.thomas@koch.ro>	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>	 <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>	 <492148AD.1090604@viscovery.net> <e2b179460811170245t1845cc66h7cb2a18c43a79359@mail.gmail.com> <4921548E.6070802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 09:30:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L74B0-0005To-Sq
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 09:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbYLAI30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 03:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbYLAI30
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 03:29:26 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16607 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbYLAI3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 03:29:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L749Z-0005tA-A7; Mon, 01 Dec 2008 09:29:13 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 161BC69F; Mon,  1 Dec 2008 09:29:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4921548E.6070802@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Johannes Sixt schrieb: > Mike Ralphson schrieb: >> 2008/11/17
	Johannes Sixt <j.sixt@viscovery.net>: >>> Mike Ralphson schrieb: >>>> 2008/11/15
	Linus Torvalds <torvalds@linux-foundation.org>: >>>>> On Sat, 15 Nov 2008,
	Junio C Hamano wrote: >>>>>> This introduces make variable NO_PTHREADS for
	platforms that lack the >>>>>> support for pthreads library or people who
	do not want to use it for >>>>>> whatever reason. When defined, it makes
	the multi-threaded index >>>>>> preloading into a no-op, and also disables
	threaded delta searching by >>>>>> pack-objects. >>>>> Ack. Makes sense.
	>>>> I'd be minded to make this the default on AIX to keep the prerequisite
	>>>> list as small as possible, then people can opt-in for the performance
	>>>> benefits if required. >>> Is pthreads not a standard shipment on AIX?
	I would set NO_PTHREADS only >>> if we know in advance that there are many
	installations without pthreads. >>> (And I don't know what the situation
	is.) >> I should have dug a bit further, it seems to be present on my 5.3
	>> machines but I still need to determine whether it got installed by >> default.
	Either way it must need some other link flags... > > I tried compiling with
	THREADED_DELTA_SEARCH=Yes, and it fails with > > CC builtin-pack-objects.o
	> In file included from /usr/include/sys/pri.h:29, > from /usr/include/sys/sched.h:38,
	> from /usr/include/sched.h:52, > from /usr/include/pthread.h:43, > from
	builtin-pack-objects.c:22: > /usr/include/sys/proc.h:203: parse error before
	"crid_t" > /usr/include/sys/proc.h:212: parse error before "p_class" > /usr/include/sys/proc.h:355:
	parse error before '}' token > > :-( Maybe NO_PTHREADS is indeed the safer
	choice? I'm not going to dig > into this today, though. (I'm on AIX 4.3.something.)
	> >>> BTW, this needs to be squashed in, because we don't have pthreads on
	Windows: >>> >>> diff --git a/Makefile b/Makefile >>> index ffc9531..3a30b8c
	100644 >>> --- a/Makefile >>> +++ b/Makefile >>> @@ -769,6 +769,7 @@ ifneq
	(,$(findstring MINGW,$(uname_S))) >>> NO_STRCASESTR = [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102003>

Johannes Sixt schrieb:
> Mike Ralphson schrieb:
>> 2008/11/17 Johannes Sixt <j.sixt@viscovery.net>:
>>> Mike Ralphson schrieb:
>>>> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>>>>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>>>>> This introduces make variable NO_PTHREADS for platforms that lack the
>>>>>> support for pthreads library or people who do not want to use it for
>>>>>> whatever reason.  When defined, it makes the multi-threaded index
>>>>>> preloading into a no-op, and also disables threaded delta searching by
>>>>>> pack-objects.
>>>>> Ack. Makes sense.
>>>> I'd be minded to make this the default on AIX to keep the prerequisite
>>>> list as small as possible, then people can opt-in for the performance
>>>> benefits if required.
>>> Is pthreads not a standard shipment on AIX? I would set NO_PTHREADS only
>>> if we know in advance that there are many installations without pthreads.
>>> (And I don't know what the situation is.)
>> I should have dug a bit further, it seems to be present on my 5.3
>> machines but I still need to determine whether it got installed by
>> default. Either way it must need some other link flags...
> 
> I tried compiling with THREADED_DELTA_SEARCH=Yes, and it fails with
> 
>     CC builtin-pack-objects.o
> In file included from /usr/include/sys/pri.h:29,
>                  from /usr/include/sys/sched.h:38,
>                  from /usr/include/sched.h:52,
>                  from /usr/include/pthread.h:43,
>                  from builtin-pack-objects.c:22:
> /usr/include/sys/proc.h:203: parse error before "crid_t"
> /usr/include/sys/proc.h:212: parse error before "p_class"
> /usr/include/sys/proc.h:355: parse error before '}' token
> 
> :-( Maybe NO_PTHREADS is indeed the safer choice? I'm not going to dig
> into this today, though. (I'm on AIX 4.3.something.)
> 
>>> BTW, this needs to be squashed in, because we don't have pthreads on Windows:
>>>
>>> diff --git a/Makefile b/Makefile
>>> index ffc9531..3a30b8c 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -769,6 +769,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>>        NO_STRCASESTR = YesPlease
>>>        NO_STRLCPY = YesPlease
>>>        NO_MEMMEM = YesPlease
>>> +       NO_PTHREADS = YesPlease
>>>        NEEDS_LIBICONV = YesPlease
>>>        OLD_ICONV = YesPlease
>>>        NO_C99_FORMAT = YesPlease
>>>
>> Ta. Ok to add your S-o-B on a squashed patch?
> 
> Sure. Use this address please:
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Mike,

you said you would resend the patch, but I think you forgot about it.
Would you do that now, please?

-- Hannes
