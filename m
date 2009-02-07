From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Article about "git bisect run" on LWN
Date: Sat, 7 Feb 2009 05:41:29 +0100
Message-ID: <200902070541.29955.chriscool@tuxfamily.org>
References: <200902050747.50100.chriscool@tuxfamily.org> <20090205141336.GA28443@elte.hu> <200902060623.16046.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Jeff Garzik <jeff@garzik.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bill Lear <rael@zopyra.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sat Feb 07 05:43:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVf2Y-0005xH-Di
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 05:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbZBGEmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 23:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbZBGEmJ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 23:42:09 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:45625 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752813AbZBGEmH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 23:42:07 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EB2A64B0032;
	Sat,  7 Feb 2009 05:41:54 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id C842F4B0080;
	Sat,  7 Feb 2009 05:41:50 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200902060623.16046.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108810>

Le vendredi 6 f=E9vrier 2009, Christian Couder a =E9crit :
> Le jeudi 5 f=E9vrier 2009, Ingo Molnar a =E9crit :
>
> > - Feature: better "git bisect next" support.
>
> You probably mean "git bisect skip" here.
>
> >   Sometimes a commit wont build. In that case we have "git bisect
> > next", but last i checked that only jumps a single commit - and bui=
ld
> > breakages often have a large scope - full trees that got merged
> > upstream, etc. Most of the time those build breakages are uninteres=
ting
> > and the build-broken window does not contain the bad commit.
> >
> >   So it would be nice to have a "git bisect next --left=3D20%" type=
 of
> >   feature. This would jump 20% commits to the "left" from the bisec=
tion
> >   point, towards the 'known bad' set of commits, but still within t=
he
> >   bisection window.
> >
> >   Similarly, "git bisect next --right=3D20%" would jump towards the
> > known-good edge of the bisection window (but still within the bisec=
tion
> > window).
>
> In the following thread, H. Peter Anvin suggested an algorithm to dea=
l
> with this kind of problem:
>
> http://thread.gmane.org/gmane.comp.version-control.git/98164/
>
> And I suggested a simpler one, that might be implemented without havi=
ng
> to port "git bisect skip" code to C first, but I did not work on it y=
et.
>
> >   Currently when i hit a build error during auto-bisection, it abor=
ts
> > and i have to intervene manually. But with a bigger jump distance i
> > could use git-bisect-next reliably in scripts too.
> >
> >   Likewise, users too hit build breakages often, and find it hard t=
o
> > get out of the window of breakage. With the high-order tree structu=
re
> > of the kernel repository that is rather non-intuitive to do as well=
,
> > and often people make mistakes and test the wrong commit.
>
> I am working slowly on "git replace" these days and, if everything go=
es
> well, it should make it possible to use "replace" refs when bisecting=
, so
> that people could bisect on commit trees where many breakages have be=
en
> removed. And as refs can be shared, this means that users and develop=
ers
> should be able to easily share these improved trees.
>
> Another way to work around breakages could be to have a list of commi=
ts
> and ranges of commits that should always be skipped and always pass t=
hem
> to "git bisect skip" before using "git bisect run". Something like th=
at
> perhaps:
>
> $ git bisect start <bad> <good>
> $ git bisect skip $(cat always_skipped.txt)
> $ git bisect run ./my_test_script.sh

It might be useful to have a list of always good commits too, and use i=
t=20
like this:

$ git bisect start <bad> <good> $(cat always_good.txt)
$ git bisect skip $(cat always_skipped.txt)
$ git bisect run ./my_test_script.sh

or you may want to use grafts in your bisection repository. See the=20
following thread about bisection breakage in the btrfs history:

http://thread.gmane.org/gmane.comp.version-control.git/105186/

Regards,
Christian.
