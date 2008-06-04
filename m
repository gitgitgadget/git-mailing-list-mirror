From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 20:09:31 +0200
Message-ID: <20080604180931.GA31188@atjola.homenet>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <7vmym1zny4.fsf@gitster.siamese.dyndns.org> <18c1e6480806040013l72da09aem30f91183e4fcbe41@mail.gmail.com> <m3mym1zkus.fsf@localhost.localdomain> <18c1e6480806040130k3851a89an3fcf986feb661226@mail.gmail.com> <D11EAC1A-B59E-4857-A31F-809809310E40@wincent.com> <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xRO-0007pZ-IC
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181AbYFDSJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 14:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbYFDSJh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:09:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:60545 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755428AbYFDSJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:09:36 -0400
Received: (qmail invoked by alias); 04 Jun 2008 18:09:33 -0000
Received: from i577BBDC9.versanet.de (EHLO atjola.local) [87.123.189.201]
  by mail.gmx.net (mp012) with SMTP; 04 Jun 2008 20:09:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/hhBRaoNfh6KXMQIphCHz9O1qMl6XY/U+ioWwIHa
	j+gzJBirjjnqr0
Content-Disposition: inline
In-Reply-To: <18c1e6480806040302k74156d47p4e878fef62d21b87@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83805>

On 2008.06.04 12:02:13 +0200, David wrote:
> On Wed, Jun 4, 2008 at 11:39 AM, Wincent Colaiuta <win@wincent.com> w=
rote:
> > El 4/6/2008, a las 10:30, David escribi=F3:
> >
> >> Thanks :-) This still isn't what I had in mind (see my earlier pos=
t
> >> with examples), but I realise now, thanks to your post, that I can
> >> probably do it like this:
>=20
> [snip]
>=20
> >
> > Sounds like it would definitely work but it also sounds like a lot =
of
> > repetitive "busy work"[1] which could be avoided by using finer-gra=
ined
> > topic branches in the first place.
> >
>=20
> It isn't always easy to fix the problems in master (that you're seein=
g
> in topic) by changing back to master and making another topic. Maybe
> you can only (easily) find & detect the problems in master because of
> other changes in topic (eg: WIP unit tests) that you aren't ready to
> merge yet.
>=20
> So you would probably have to jump back and forth between your topic,
> and your new 'fix problems in master' branch a lot to track down the
> issues and get the fixes into master. This sounds like a lot more
> 'busy work' than simply cherry-picking (multiple) those fixes out of
> your topic branch into master, and then rebasing your topic branch :-=
)

The unit tests example is a pretty good use-case for rebase --onto.
Simply start your new topic on top of the WIP topic, you don't always
have to branch from master. Then you have the all the code around. Fix
the bug, and finally rebase your new topic onto master.

git checkout -b bug_fix_branch wip_branch
# work work work, commit commit commit
git rebase --onto master wip_branch bug_fix_branch

Eventually, you'll have to add stuff to your wip_branch while doing the
bug_fix, but that's relatively straight forward.

git checkout wip_branch
# work work work, commit commit commit
git rebase wip_branch bug_fix_branch

And then you can continue to work on the bug fix branch and at some
point end up at the rebase --onto from above.

Of course for stronger dependencies between wip_branch and
bug_fix_branch, that's not possible, but then you most likely wouldn't
want to cherry-pick the bug fix stuff into master anyway.

Bj=F6rn
