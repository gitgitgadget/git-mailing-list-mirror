From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting to a new platform
Date: Fri, 10 Aug 2012 18:59:37 +0200
Message-ID: <004301cd7719$86b810b0$94283210$@schmitz-digital.de>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com> <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com> <20120810132608.GA29609@hmsreliant.think-freely.org> <003901cd7708$fa482c10$eed88430$@schmitz-digital.de> <7v1ujelnvm.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzsZU-0001RW-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab2HJRAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:00:18 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:64432 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab2HJRAR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 13:00:17 -0400
Received: from DualCore (dsdf-4db5242c.pool.mediaWays.net [77.181.36.44])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0Lv4go-1Tib453q8w-010PdC; Fri, 10 Aug 2012 18:59:48 +0200
In-Reply-To: <7v1ujelnvm.fsf_-_@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJHr2cA9VHKYTIzC/tsBXVJAGXt/AGsh1lhAh0jVpECFyKZkQFwebValiRA7LA=
Content-Language: de
X-Provags-ID: V02:K0:dUk9jkTvyRMNJfyNMeEH/6NhAfOuUnl3ly5/8MvENHg
 QvaTwQ7JqwFwsuTA/V5mqQlGdKz2Z++JpOelZ+xonTH3pvCX0W
 TyfscmOU/M83DhjBJKSVcViDF7xIOCkUjcpUSFkxkQ/pVmKhcp
 mhKlGg2SNm6HUho0pMzuzLl2SK3M1c1aOQZ32LG/TKkeAEkIby
 7P4wXd8SV3dvWtSWp0ejfc1Z550px6hwrmit7eZZpkDEqn9ask
 y5xQ/2dHbh9ktf+fZH5Gzqjxe/jSQbt0v/oWLBoAyX1bsSPV/c
 6cLvs/gj4yV/Y9ImG8gwTro4flxLu/A/L0BalZi++smhpSf/0S
 8CKkWyPoyOC8XvUTpqlRO5i4yzzkBzcAPKTXqqDewzS0f2XRNS
 DpC1Z6ApbgKhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203235>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, August 10, 2012 6:21 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Porting to a new platform
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > - HP NonStop is lacking poll(),...
> > - HP NonStop is lacking getrlimit(), fsync(), setitimer()...
> 
> I would check compat/win32 and friends and see what other platforms that
lack
> this and that do, if I were you.

Hmm, in compat/win32/poll.c I found exactly the same code I stole' for my
implementation (GNUlib's implementation) so I just managed to reinvent the
wheel :-(
Thanks anyway for telling me about it.

For getrlimit(RLIMIT_NOFILE, ...), I'm now using sysconf(_SC_OPEN_MAX), does
that sound reasonable?

I found no replacement for fsync() and setitimer(), but have my ones since
long, so no real need.

Also would compat/pread.c, another API HP NonStop is missing, but I had my
own implementation for that since quite a while already (and it looks pretty
similar to git's one).

I don't quite understand though why neither compat/pread.c nor
compat/win32/poll.c are used automatically after having been proven absent
in configure?
Ahh, I see, it could be done by adding a HP NonStop specific section in
Makefile ("ifeq ($(uname_S),NONSTOP_KERNEL)"), right?
I'll have a deeper look and see whether I can come up with something useful
to feed back into git.

> > so telling configure to search for c99  should help here.
> 
> In general, the top-level Makefile is designed to be usable without ever
> worrying about "configure" mess.  Just define CC for the platform section
there,

Yes, that's what I did, sort of, I just set CC to c99 prior to executing
configure.
I've seen other configure though, that explicitly test for C99, so why not
this one?

> and optionally add a support to flip the same in configure.ac.  This
applies
> equally to other conditional compilation options you may have to add to
> support your platform.

Bye, Jojo
