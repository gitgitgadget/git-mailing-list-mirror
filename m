From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Tue, 18 Dec 2007 13:45:57 +0100
Message-ID: <4767C105.8080607@viscovery.net>
References: <20071217192306.5da48540@pc09.procura.nl> <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org> <20071217232259.0b41a3bf@pc09.procura.nl> <7vbq8o370k.fsf@gitster.siamese.dyndns.org> <476781C6.6050507@viscovery.net> <Pine.LNX.4.64.0712181234520.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bq8-0000Ye-Ev
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbXLRMqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbXLRMqE
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:46:04 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33441 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbXLRMqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:46:03 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4bpu-0000Ti-2Z; Tue, 18 Dec 2007 13:46:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DEF4754D; Tue, 18 Dec 2007 13:45:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0712181234520.23902@racer.site>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68741>

Johannes Schindelin schrieb:
> Hi,
> 
> On Tue, 18 Dec 2007, Johannes Sixt wrote:
> 
>> Junio C Hamano schrieb:
>>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>>>
>>>> On Mon, 17 Dec 2007 13:00:22 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>>>>>
>>>>>> HP-UX does not have select.h, but it offers all select () 
>>>>>> functionality. The defines are in <sys/types.h> and <X11/fd.h>
>>>>> Will apply the patch as-is for now, only because I do not want major 
>>>>> surgery during rc period, but I think is can be improved.
>>>> ...
>>>>> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test 
>>>>> macros
>>>> That is defined in GNU gcc. I did not pass it with -D...
>>> Actually I changed my mind.  I won't be applying this as is.
>>>
>>> For the selective inclusion of <sys/select.h>, I would prefer it see 
>>> it done like the attached.
>> Is select() actually needed? The one instance in pager.c can easily be 
>> replaced by poll(), which I've already done in my own tree. The other 
>> one in http.c is only used as a timer, but I don't know how to get rid 
>> of that. Maybe a setitimer()/pause() combo?
> 
> I'd be cautious about using poll().  AFAIK MacOSX 10.2.8 does not have 
> poll(), and IIRC I had problems finding it in MinGW, too.  I know, we use 
> it in daemon, upload-archive and upload-pack, but these are not typically 
> functions performed by a client, so I would not know if it worked on my 
> (now-dead) iBook, or on msysGit.

So what? If we use poll() already in daemon, upload-archive and
upload-pack, and no MacOSX 10.2.8 user has spoken up with a proposal for
replacement, then yet another use won't raise a complaint, either.

And if it were a problem for msysGit, I wouldn't have suggested it ;) The
particular use in pager.c would be inside #ifndef __MINGW32__ #endif anyway.

-- Hannes
