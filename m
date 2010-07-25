From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC/PATCH 0/9] commit: more focused advice in the no-changes-staged case
Date: Sun, 25 Jul 2010 11:22:40 +0200
Message-ID: <201007251122.41166.trast@student.ethz.ch>
References: <20100725005443.GA18370@burratino> <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 11:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcxQB-0003sx-Ix
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 11:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab0GYJWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 05:22:45 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:49501 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab0GYJWo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 05:22:44 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 11:22:41 +0200
Received: from thomas.localnet (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 11:22:41 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151718>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Sun, Jul 25, 2010 at 00:54, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> > Hi,
> >
> > When last seen[1], this series was a single patch in very rough for=
m,
> > but there have been almost no functional changes since then.
> >
> > The patches suppress most output when =E2=80=9Cgit commit=E2=80=9D =
is run without
> > stages changed.  So instead of
> >
> >        $ git commit
> >        # On branch master
> >        # Changed but not updated:
[...]
> >        # Untracked files:
[...]
> >        no changes added to commit (use "git add" and/or "git commit=
 -a")
> >
> > which may cause a newcomer to panic, you get
> >
> >        $ git commit
> >        no changes added to commit (use "git add" and/or "git commit=
 -a")
> >
> > which would just cause her to scratch her head or say =E2=80=9Coh, =
right!=E2=80=9D
> > instead.  Hopefully these patches will at least provide a reminder =
to
> > improve the various "no changes" advice messages.
[...]
> I'm not so sure about 9/9. Every time I make this mistake with "git
> commit" I find it helpful to be able to just look up to see what I
> need to stage. But perhaps the wall of text can be confusing to
> newbies, I don't have a strong opinion on whether it should be
> included or not.

I tend to agree with =C3=86var.  I was trying a different direction
yesterday, it's still WIP but you can try it from here:

  git://repo.or.cz/git/trast.git t/color-porcelain-message-output

It does not have any effect in this case because wt-status.c just
printf()s "no changes added to commit", but the idea would be that it
should end up in the error color (bold red by default) so that it
stands out clearly.

[I actually wrote it because for git-rebase it's even worse: if you
have fixed one conflict and immediately hit another, the output is

  Recorded resolution for 'dir/a'.
  [detached HEAD aa9ae6b] related change                          (1)
   1 files changed, 1 insertions(+), 1 deletions(-)
  Automatic cherry-pick failed.  After resolving the conflicts,
  mark the corrected paths with 'git add <paths>', and
  run 'git rebase --continue'
  Recorded preimage for 'dir/a'
  Could not apply 649420f... second                               (2)

(1) is the subject of the just-applied commit, whereas (2) is the
subject of the now-conflicted commit.  In my case (1) caught my eye
for some reason and I had to look three times to figure out that (2)
was the interesting part.  Now it's in red!]

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
