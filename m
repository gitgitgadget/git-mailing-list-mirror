From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] Use is_absolute_path() in diff-lib.c, lockfile.c, setup.c, trace.c
Date: Mon, 26 Nov 2007 07:45:55 +0100
Message-ID: <F8F93DBB-F0F5-440A-BA0C-434422C8122A@zib.de>
References: <11960297431954-git-send-email-prohaska@zib.de> <7vy7clhd9z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 07:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwXiQ-0005wy-UX
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 07:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbXKZGot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 01:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752703AbXKZGot
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 01:44:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:52052 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbXKZGos (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 01:44:48 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAQ6iixS020126;
	Mon, 26 Nov 2007 07:44:44 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a9f4.pool.einsundeins.de [77.177.169.244])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAQ6ihNO009745
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 26 Nov 2007 07:44:44 +0100 (MET)
In-Reply-To: <7vy7clhd9z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66049>


On Nov 26, 2007, at 4:54 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Using the helper function to test for absolute paths makes porting  
>> easier.
>
> These probably make sense.  I obviously do not see any downside  
> from the
> POSIX side, and can imagine that treating "C:\" prefix as "absolute
> paths" at these four places will not have any ill effect on the  
> Windows
> side (IOW, the codepaths that follow these four places seem to do a
> sensible thing even if the "absolute path" prefix is not a single '/',
> but would work fine as-is).
>
> I am a bit surprised that there are only four places you needed to
> touch, though.

Yes, I was a bit surprised, too.  I used grep to find these places.
Maybe my regular expression was not good enough.  On the other side,
is_absolute_path() is already used at 11 places before this patch.
I also cross checked with the msysgit code base.  It does not use
is_absolute_path() at more places.


>> BTW, what happend to the msysgit related patches:
>>
>> [PATCH 1/3] sha1_file.c: Fix size_t related printf format warnings
>> [PATCH 2/3] builtin-init-db: use get_git_dir() instead of getenv()
>>
>> I never received comments about them, nor do I find them on pu.
>
> Lack of comments was probably due to mixture of bad timing and general
> lack of interests.  Many people are busy working on their turkeys than
> hacking this time of the year ;-)

Yeah, list traffic was quiet low.


> I am reluctant to queue msysgit/gitwin related patches without seeing
> positive comments from other people involved on the Windows side,  
> unless
> they are trivial and obvious improvements.
>
>  * [1/3] seems without harm but on the other hand does not seem so
>    urgent either.

I did not find a simpler way to achieve a compile free warning on
mingw, without introducing more complex ifdefs.  I'm currently trying
to reduce the differences between git.git, mingw, and msysgit.


>  * [2/3] may introduce chicken-and-egg problem (use of get_git_dir()
>    inside git-init feels quite iffy, as it calls setup_git_env(),  
> which
>    does repository discovery), without an obvious and clear advantage.

I see.  I'll rethink 2/3 and 3/3.  Either I come up with more
convincing arguments or I'll try if the changes can be reverted
in the msysgit code base.


> For these reasons, both of them disqualify from being trivial and
> obvious improvements, so I did not pick them up unilaterally before
> seeing positive comments from other people.

	Steffen
