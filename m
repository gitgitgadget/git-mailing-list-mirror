From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: How to update a cloned git repository
Date: Tue, 11 Sep 2012 13:17:09 +0200
Message-ID: <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 11 13:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBOT7-0003xM-G0
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757954Ab2IKLRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:17:17 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:57174 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab2IKLRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 07:17:16 -0400
Received: from DualCore (dsdf-4db532aa.pool.mediaWays.net [77.181.50.170])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LhifF-1TxfVC1DlZ-00maQk; Tue, 11 Sep 2012 13:17:15 +0200
In-Reply-To: <vpq7gs0es4f.fsf@bauges.imag.fr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKMBvoOU6gFyfWBzbsL0abxuS38eAGIfo3NlfvJ6DA=
Content-Language: de
X-Provags-ID: V02:K0:LtgxZoVNTO5O6YUw0xM/020vrI7pufwJXV7GRwU7XcV
 EjufCFZ4E8qnmBt3b4ZI7fDHdO3qYoUsIVR/61lDYN7nBNN7iU
 vpjU4gqNq4JH8fRityBIW1957Oz1x7XrwC10XbC6N3EhP3Jn6U
 SZeajAneuNChsVi/dcS2KRAJCvIWC2KktekqJPxDqsFa0Ia2mI
 TQbCzyu1DGGMO6x8EjFv8LQhPkrtOxkKdv4Jz8h+tSVgl+OtMb
 F40hLslCLpSMvHc2OXzuJHB3yIwMmvDeZJmnxv1VQqeFTDoM09
 078y9tcrUXA2OY6bD4oV0ppQSvBmy3OGfYnNGPYglWdA0FEY+e
 OgO0RgHUI7VcqbkP91FrLWVeiE76Gf5hyJ9MxBkdn1y0GpDk2r
 vazqYYxZhQXgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205218>

> From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]
> Sent: Tuesday, September 11, 2012 1:06 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: How to update a cloned git repository
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Hi folks
> >
> > Probably a beginner's question...
> >
> > If I did a
> >    git clone git://guthub.com/git/git.git
> > and worked on some own branches of pu
> >    git checkout pu;git checkout -p mybranch;
> 
> I guess you meant "git checkout -b mybranch" (not -p).

Yes, of course...

> > hack;hack;...;git commit -a -s
> >
> > how to update my repository once the the one on github changed? A
> > plain git pull or git fetch;git merge keeps failing on my with lots of
> > conflicts, none of which relate to any of the changes I did (and hence
> > wouldn't know how to resolve)
> 
> Short answer: don't work on pu. Work on master unless you have a good
> reason not to.

There are some changes in pu, that I need as the basis, namely my setitimer patch and my 2nd mkdir patch, which haven't yet made it
into the master branch (and in the setitimer case not out of pu)

> Longer answer: the pu branch in git.git is often re-written, hence the
> commit on which you started hacking once existed in git.git's pu, but it
> probably no longer is.
> 
> You cloned this:
> 
> --A---B---C <-- origin/pu
> 
> Hacked to this
> 
>          origin/pu
>           |
>           v
> --A---B---C---D---E <-- mybranch
> 
> and the next fetch resulted in something like this:
> 
>     B'---C'---D'---F <-- origin/pu
>    /
> --A---B---C---D---E <-- mybranch
> 
> while you could have expected that if origin/pu had just been
> fast-forwarded with a new commit F:
> 
>             F <-- origin/pu
>            /
> --A---B---C---D---E <-- mybranch
> 
> As a result, "git merge" computes a common ancestor very far backward in
> history. Instead of merging only your changes with new pu content, it
> merges the old history of pu (plus your changes) with the new history of
> pu, and you get spurious conflicts.
> 
> The solution is to rebase your changes (and only yours). My advice is to
> rebase them on master, like this (replace 42 by the number of commits
> you want to rebase in HEAD~42):
> 
>   git rebase HEAD~42 --onto origin/master

For pu this would be similar?

> Once you did this, you can start using "git pull" (or "git pull
> --rebase") as usual.


Like this?
git pull --rebase HEAD~42

So far I create patches, wiped out the entire repository, cloned, forked and applied the changes, pretty painful.
