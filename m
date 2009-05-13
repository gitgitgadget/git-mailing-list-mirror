From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Wed, 13 May 2009 12:32:31 -0700
Message-ID: <7vy6t03ik0.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<7v7i0scvcf.fsf@alter.siamese.dyndns.org>
	<op.utlq3vgx1e62zd@merlin.emma.line.org>
	<7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
	<7vskje6wsy.fsf@alter.siamese.dyndns.org> <op.utva2vxh1e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Matthias Andree" <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 21:33:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4KC3-0003gi-Af
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 21:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbZEMTcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbZEMTcc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 15:32:32 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:36033 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbZEMTcb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 15:32:31 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513193233.OSAR20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Wed, 13 May 2009 15:32:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id r7YY1b0034aMwMQ047YY2D; Wed, 13 May 2009 15:32:32 -0400
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=ybZZDoGAAAAA:8 a=Za3uejtpZuJxlrPZdx4A:9 a=34D2mfsSMp7ZJH377c8A:7
 a=v7WiYWL4YHPYcJWctcQ04a05LywA:4 a=_RhRFcbxBZMA:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <op.utva2vxh1e62zd@balu> (Matthias Andree's message of "Wed\, 13 May 2009 14\:17\:09 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119091>

"Matthias Andree" <matthias.andree@gmx.de> writes:

> Am 09.05.2009, 18:55 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:
>
>> "Matthias Andree" <matthias.andree@gmx.de> writes:
>>
>>>> Fine then.  Or you could just append "." to the $PATH ;-)
>>>
>>> "." in the super user's PATH? Cool stuff, and so innovative.
>>
>> I didn't mean to suggest PATH=$PATH:. *in the user's environment* ;-).
>> You do that inside GIT-VERSION-FILE, which is essentially the same thing
>> as running ./git$X from there.
>
> No, it is not -- the scope of the GIT variable is much narrower than
> doing  PATH=$PATH:. in the script.

If you cannot trust the top of your build directory you build git in (that
is why PATH=$PATH:. while running GIT-VERSION-FILE may be scary) and
anticipate a malicious third-party can somehow put random things (like
"test" or "cat", perhaps) there, you are already lost, don't you think?

That is where my "essentially the same" came from.

> For any approach taken, we'll have to touch both the shell and the
> Makefile, unless we want to manually redo things in the
> GIT-VERSION-GEN  script that were already done automatically or
> programmatically in  Makefile.

I actually like the rationale you mentioned in the thread (perhaps in the
original proposed commit message as well) that we should ask the freshly
built git to describe the version if available, falling back to whichever
git of random vintage found on the original $PATH.

If it weren't for $X [*1*], my preference would have been (as I said in
the discussion) to run ./git if available locally.

But I think your "deal with details like $X to figure out the name of the
freshly built git binary is in the Makefile, and pass it via GIT variable
to GIT-VERSION-GEN" is a sensible approach.  I do not remember if your
patch gave precedence to an installed git on the original $PATH or a
freshly built one, though---the precedent probably does not matter in
practice, and favoring the one found on $PATH over freshly built one does
have an advantage if we were to support cross compilation (I have a
suspicion that the current setup does not).

Thanks.


[Footnote]

*1* ... and perhaps VPATH as you mentioned earlier, but I do not know if
our current Makefile is set up to allow a layout that separates build
products from the source material, as I've never attempted to build git in
a setting where VPATH is involved.
