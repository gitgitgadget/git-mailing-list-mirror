From: Eric Wong <normalperson@yhbt.net>
Subject: Re: svn clone Checksum mismatch question
Date: Sat, 28 Mar 2009 23:08:58 -0700
Message-ID: <20090329060858.GB15773@dcvr.yhbt.net>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet> <83dfc36c0903260735q3231ce96h5949d1123858995f@mail.gmail.com> <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Anton Gyllenberg <anton@iki.fi>
X-From: git-owner@vger.kernel.org Sun Mar 29 08:10:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnoE7-0007eg-FW
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 08:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbZC2GJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Mar 2009 02:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZC2GJB
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 02:09:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38045 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbZC2GJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 02:09:00 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07EE4113088;
	Sun, 29 Mar 2009 06:08:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <83dfc36c0903270418q59a81290xcb8043b8c037be18@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114999>

Anton Gyllenberg <anton@iki.fi> wrote:
> I hope I didn't hijack the thread with an unrelated issue.

No worries if you did.  You helped me find a stupid bug in git-svn
that's been there for 3 years.  I couldn't help the original poster at
all since he was working on a private repo and I can't support git-svn
under Windows.

> 2009/3/26 Anton Gyllenberg <anton@iki.fi>:
> > I don't know if this is the same issue, but the I get a similar err=
or
> > on the public twisted-python repository on both windows and linux,
> > with several different versions and plenty of free disk space. As t=
his
> > is a publicly accessible repository it should be easy to reproduce:
> >
> > git svn init -s svn://svn.twistedmatrix.com/svn/Twisted twisted
> > cd twisted
> > git svn fetch -r 13611:HEAD
> >
> > This ultimately dies with the following error:
> > W: +empty_dir: trunk/doc/core/howto/listings/finger/finger
> > r13612 =3D f6d995ac255e3dfa08a517a6e72fbcfe63feaaa0 (trunk)
> > Checksum mismatch:
> > branches/foom/--omg-optimized/twisted/internet/cdefer/cdefer.pyx
> > 264b0c5f7b3a00d401d1a5dcce67a3734f0eede3
> > expected: c7ccddd195f132926e20bab573da7ef3
> > =A0 =A0 got: f006323ff4714ca52c0228ce6390d415
>=20
> is branches/foom/--omg-optimized (like with the branch name being
> foom/--omg-optimized), not just branches/foom. Is think git-svn relie=
s
> on the standard layout being branches directly under the branches/
> directory, but I don't see how this would get the paths mixed up like
> this.

Root problem: I misused "git ls-tree" for 3 years and nobody noticed.
At least I'm glad the checksum verification every step of the way caugh=
t
this bug and prevented propagating it into repository corruption.

> Looking at what was done around this commit one finds odd stuff, like
> deleting directories in trunk and then copying from a previous
> revision of trunk to under the branch:
> http://twistedmatrix.com/trac/changeset/13611
>=20
> I created a local test svn repository and tried to do something
> similar but git-svn had no problem with my test.

I was fooled by the weird copy sequences, too.

> This is issue is not critical for me in any way but if somebody wants
> to look into it I am happy to help out.

I guess few folks in the UNIX world are crazy enough to make pathnames
prefixed with dashes :)  But I do wonder how/if many repositories out
there failed and nobody bothered to report it...

Patch in reply

--=20
Eric Wong
