From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Sun, 6 May 2007 15:15:54 +0200
Message-ID: <20070506131554.GF19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070504081021.14786.77675.stgit@yoghurt> <20070506122116.GA18883@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 15:16:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkgbb-0003LG-Ap
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbXEFNQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 09:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbXEFNQm
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:16:42 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33168 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbXEFNQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 09:16:41 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1B04B5EA6B;
	Sun,  6 May 2007 15:16:39 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 805331F160; Sun,  6 May 2007 15:15:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070506122116.GA18883@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46333>

On Sun, May 06, 2007 at 02:21:16PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-04 10:13:21 +0200, Karl Hasselstr=F6m wrote:
>=20
> >   2. Try to commit a patch, and then rebase. This doesn't work,
> >      because "stg rebase" aborts if orig-base !=3D base, and "stg
> >      commit" doesn't update orig-base. (It does work if "stg rebase=
"
> >      is given the --force flag.)
> >
> > (2) shows a bug in "stg rebase"'s safety logic. I'm not sure how to
> > fix it, because I don't know how it's supposed to work in the first
> > place. (An obvious fix would be to update it whenever the base
> > changes, but that'll take some work, and I'm not convinced it can't
> > be done with les work. Yes, I'm lazy.) Yann, could you explain?

The idea of the safety logic is that by default stgit should not loose
a commit without the user knowing.  That is, if you used "stg commit",
the patch you committed is most probably only reachable through the
head of your stack, and rebasing may make it unreachable (unless you
have explicitely added a new ref to it, in which case you know what
you're doing and you know you can "rebase --force").

> Another reason why this is impractical is that it's not only stgit
> that's allowed to change the base. For example, doing "stg pop -a &&
> git reset --hard foobar && stg rebase qwrtflsptk" will also trigger
> the alarm.

Sure, but "pop -a && git reset" is exactly a "rebase -n".  If you use
stgit in this case instead of the plumbing, the rebase safety will not
trigger.  If you use the plumbing, you're out the scope of stgit which
cannot guess what you really want, and you should use --force because
you're supposed to know better.

But well, that's the general idea, and this safety mechanism is quite
young, it is surely possible to make it better.  But IMHO the base
principle when dealing with this is that we should make every effort
so the user does not unkwingly loose a commit (which was the case
without the safety).  OTOH, it is sure that the safety must not be
overly zealous, or we'll just end up teaching users to --force without
thinking.

That said, I have not looked at your testcase yet, I'll try to do this
soon.

Best regards,
--=20
Yann.
