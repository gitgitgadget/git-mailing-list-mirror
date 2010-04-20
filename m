From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 11:10:14 -0400
Message-ID: <20100420151014.GA11785@coredump.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <loom.20100420T085842-887@post.gmane.org>
 <20100420115124.GB22907@coredump.intra.peff.net>
 <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
 <20100420142444.GA8851@coredump.intra.peff.net>
 <g2u76718491004200752gcf73abf1se05e89bd605e77a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <yann.dirson@bertin.fr>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 17:10:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4F69-0002Gc-Dc
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 17:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab0DTPKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 11:10:45 -0400
Received: from peff.net ([208.65.91.99]:47082 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394Ab0DTPKp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 11:10:45 -0400
Received: (qmail 3515 invoked by uid 107); 20 Apr 2010 15:10:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Apr 2010 11:10:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Apr 2010 11:10:14 -0400
Content-Disposition: inline
In-Reply-To: <g2u76718491004200752gcf73abf1se05e89bd605e77a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145383>

On Tue, Apr 20, 2010 at 10:52:42AM -0400, Jay Soffian wrote:

> On Tue, Apr 20, 2010 at 10:24 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Apr 20, 2010 at 09:33:42AM -0400, Jay Soffian wrote:
> > I like how the user would interact with that, but what happens with=
:
> >
> > =C2=A0git checkout -b topic/subtopic
> >
> > The reflog of the deleted branch is in the way.
>=20
> Handle it just as gracefully as we do today. This is what happens whe=
n
> you try to create a branch with a similar collision:
>=20
> $ git branch foo/bar
> $ git branch foo
> error: there are still refs under 'refs/heads/foo'
> fatal: Failed to lock ref for update: Is a directory

Yeah, but my next step would be "branch -d foo/bar"; under your proposa=
l
that no longer works. Now I have to do "branch -m foo/bar foobar" where
"foobar" is some name that I know means "the old reflog for foo/bar".

So I think it makes more sense to come up with that naming scheme
ourselves and make using it semi-transparent.

> $ git branch topic/subtopic
> error: there are still logs under 'logs/refs/heads/topic'
> fatal: Failed to lock log for update: Is a directory
>=20
> I think it's an edge case; thus I think it's okay to fail as long as
> we give a reasonable error and a way to rename it.

It is an edge-case, but I'd rather just have a scheme that works nicely
in the normal case and "degrades" only in the error case. Like if
creating "foo/bar" we see that we have "foo", but that the last reflog
entry is deletion, we move "foo" to "foo-1" or something. It's ugly, bu=
t
it just doesn't come up that much.

-Peff
