From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Fri, 14 Aug 2009 21:34:10 -0500
Message-ID: <MecVLMUB15cEJQiZpwSBg9ysnmFSB1QYZfIQuSOStnFx2KoeScNXGQ@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain> <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil> <7v8whl7ss9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, nico@cam.org,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 04:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc9L0-0005w0-Kc
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 04:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbZHOCek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 22:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbZHOCek
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 22:34:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36592 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZHOCej (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 22:34:39 -0400
Received: by mail.nrlssc.navy.mil id n7F2YBUr026570; Fri, 14 Aug 2009 21:34:11 -0500
In-Reply-To: <7v8whl7ss9.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 15 Aug 2009 02:34:10.0501 (UTC) FILETIME=[DEBD2F50:01CA1D50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125978>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Linus Torvalds wrote:
>>> I suspect it might as well be cast to "const char *", and then 
>>> hopefully you only need one cast.
>>>
>>> So maybe it could be written as
>>>
>>> 	data = (const char *) data + len;
>>>
>>> instead, and avoid the second cast (because the assignment should be ok, 
>>> since it's assigning back to a "const void *").
>> Yep, that's enough.  It produces an identical binary on all platforms
>> except Solaris x86 using SUNWspro compiler.
> 
> Casting to "const char *" to tell compilers that we are interested in byte
> address differences/increments makes sense to me,

Yes, I agree.

> but I do not know how to interpret your last comment.
> Do you mean that SUNWspro compiler misbehave with the "cast to char *" and
> do you meed your "casting to uintptr_t to explicitly compute byte
> addresses as int" to make it behave?

No, sorry, the SUNWspro compiler produces a working binary with any of the
three versions: the original, cast to uintptr_t, or cast to const char*.
Though it emits a warning with the original.

I was just pointing out that the SUNWspro compiler does not produce an
identical binary on x86 for each of the three versions like the GNU
compiler does.

Sorry for the confusion.  Linus's suggestion of casting to "const char*"
should be adopted.

-brandon
