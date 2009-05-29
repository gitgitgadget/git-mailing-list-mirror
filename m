From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 10:37:39 +0200
Message-ID: <20090529083739.GB9760@diana.vm.bytemark.co.uk>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com> <20090528124817.GA22262@diana.vm.bytemark.co.uk> <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 10:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9xb2-0006yc-V9
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 10:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403AbZE2Ihk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 04:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbZE2Ihk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 04:37:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:38552 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbZE2Ihj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 04:37:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M9xat-00030Q-00; Fri, 29 May 2009 09:37:39 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120260>

On 2009-05-28 15:38:44 +0100, Catalin Marinas wrote:

> 2009/5/28 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-05-28 12:12:42 +0100, Catalin Marinas wrote:
> >
> > > The patch proposes a new StGit command called "publish". This
> > > command allows one to develop patches normally on a StGit branch
> > > but publish the stack changes to a separate, merge-friendly
> > > branch whose history is not re-writable.
> >
> > Hmm, interesting. I don't think I'd want to use a command like
> > this myself, but I can see how it might be useful.
>
> For me it is useful. I publish a kernel tree with over 100 patches.
> Later I find that one patch is buggy. The current merge-friendly
> solution is to add another patch but I may want to just update the
> buggy patch as it's easier when time comes to submit upstream. This,
> however, rewrites the history. So with the "publish" command I just
> generate another commit on top of the public branch and I always end
> up with the same tree as on my stack.

I think I would've kludged this by making --theirs merges from the
StGit branch to the public branch. But "stg publish" should definitely
make the kludge history less ugly.

> > Hmm. Couldn't the merge base conceivably be higher up in the
> > stack? Like, right at the beginning, don't we have public_head =3D=3D
> > stack.head? That would be caught by the "same tree" check" a bit
> > earlier, but after adding another patch, don't we have public_head
> > =3D=3D stack.head^ ? Which would give merge_base =3D=3D public_head=
=2E
>
> We could have public_head =3D=3D stack.head^... but that's not an iss=
ue.
> The merge_base above is checked against the base of the stack rather
> than the top as we assume that the base isn't volatile. So even if
> public_head is the same as some patch commit, the merge_base above
> would always be the base of the stack. Only if the stack base was
> updated, we get a different merge_base (equal to the previous stack
> base).

The situation I described looks like this:

    B--o--o--o--o--o--P--T

Time goes from left to right. B is the stack base, P the head of the
public branch, T the stack top. merge_base(P, T) is P, and not B.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
