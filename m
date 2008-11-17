From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 17 Nov 2008 11:34:21 +0100
Message-ID: <492148AD.1090604@viscovery.net>
References: <200811121029.34841.thomas@koch.ro>	 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org>	 <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>	 <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil>	 <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org>	 <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org> <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21SM-0005yG-Na
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbYKQKec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbYKQKec
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:34:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45768 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYKQKeb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:34:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L21R3-0003H7-0r; Mon, 17 Nov 2008 11:34:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C1E6E54D; Mon, 17 Nov 2008 11:34:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101211>

Mike Ralphson schrieb:
> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>> This introduces make variable NO_PTHREADS for platforms that lack the
>>> support for pthreads library or people who do not want to use it for
>>> whatever reason.  When defined, it makes the multi-threaded index
>>> preloading into a no-op, and also disables threaded delta searching by
>>> pack-objects.
>> Ack. Makes sense.
> 
> I'd be minded to make this the default on AIX to keep the prerequisite
> list as small as possible, then people can opt-in for the performance
> benefits if required.

Is pthreads not a standard shipment on AIX? I would set NO_PTHREADS only
if we know in advance that there are many installations without pthreads.
(And I don't know what the situation is.)

BTW, this needs to be squashed in, because we don't have pthreads on Windows:

diff --git a/Makefile b/Makefile
index ffc9531..3a30b8c 100644
--- a/Makefile
+++ b/Makefile
@@ -769,6 +769,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	NO_PTHREADS = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	OLD_ICONV = YesPlease
 	NO_C99_FORMAT = YesPlease

-- Hannes
