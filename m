From: Jan Hudec <bulb@ucw.cz>
Subject: Auto detaching head options (update) (Re: Working copy revision
	and push pain)
Date: Sat, 29 Mar 2008 09:27:57 +0100
Message-ID: <20080329082757.GA4920@efreet.light.src>
References: <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src> <20080325232424.GB5273@coredump.intra.peff.net> <7v3aqde2wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 09:29:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWR0-000134-Nz
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 09:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbYC2I2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 04:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbYC2I2N
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 04:28:13 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:42043 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbYC2I2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 04:28:11 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id EF42257300;
	Sat, 29 Mar 2008 09:28:06 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id FPsR1MHtz6YE; Sat, 29 Mar 2008 09:28:02 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id F0F92572E5;
	Sat, 29 Mar 2008 09:28:00 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1JfWPt-00031c-Qs; Sat, 29 Mar 2008 09:27:57 +0100
Content-Disposition: inline
In-Reply-To: <7v3aqde2wn.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78452>

Hello All,

Since the original proposal is not quoted here, I should repeat it:
On Tue, Mar 25, Jan Hudec wrote:
>     Also I believe that it would be very useful to have a ref defined "the
>     revision your work tree is derived from", be it HEAD or not. It would:
>      - make the behaviour of push to non-bare repository defined.
>      - make additional work trees for a repository (created by
>        contrib/workdir/git-new-workdir) safe (the mechanizm could than be an
>        option for submodules).

First of all, I should apologise for proposing to introduce something that
already exists. It's been resting in the reflog all the time.

Excluding push to non-bare repository and extra work trees, the local
branches are only ever updated through the HEAD. And as long as they are
updated with update-ref, it writes the value to the reflog, so HEAD^{0}
should always equal HEAD.

Therefore the option to prevent users shooting themselves in the foot when
using multiple worktrees for the same repository (the more useful case) or
pushing to a non-bare repo (which is usually just shooting oneselves in the
feet because of lack of knowledge) would be to introduce an option to commit
to verify, that rev-parse HEAD and rev-parse HEAD^{0} give the same revision.

That would have only one casuality -- currently to create a new parentless
commit in non-new repository, one has to modify the HEAD manually. But that
just needs a command-line override to disable the check for cases when one
knows what he's doing.

On Wed, Mar 26, 2008 at 11:49:44 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > FWIW, I also initially thought this was only a "HEAD" problem, but I
> > think Junio's recent argument makes a lot of sense: the problem is not
> > one of working tree and HEAD sync, nor even of detached versus ref HEAD.
> > The problem is that somebody is using the non-bare repository to do
> > stuff (why else would it be non-bare), and you are changing the state
> > behind their back.
> 
> For people who are overwhelmed by the volume of the list traffic, the
> relevant thread is:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/77955/focus=78062

Thanks for the pointer.

There are actually two use-cases for this. One is this pushing to non-bare
repo, which is indeed just shooting oneself in the foot out of lack of
knowledge most of the time. Though it would still be nice to ask user "do you
really want to shoot yourself in the foot?" if we can find out.

But the other usecase is using additional work trees
(contrib/workdir/git-new-workdir), which is rather useful for many people.
There it again does not make sense to commit to the same branch from two
work-trees, but it may easily happen by accident. Being able to check and
prevent such accidents would improve support for extra work-trees a lot,
maybe even to a point it could be made official.

> > Isn't this essentially the 'base' index extension that Junio did a
> > while back? It was eventually reverted (or perhaps never merged, I don't
> > recall).
> 
> It was in 'next' for a while but was reverted before it hit 'master':
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/44360/focus=44508

Again, thanks for the pointer.

> > But maybe you are referencing it here:
> >
> >>    It would really be similar to the revision number in index proposal,
> >>    except less invasive and I actually believe there is a case (some form of
> >>    checkout or reset), where we want to read-tree, but not change this ref.
> >
> > I don't recall the reasons the base extension was not accepted, but I
> > think it would make sense to frame your argument as "this is like X;
> > people didn't like X for reason Y, but my proposal fixes this by..."
> 
> But if you take the position "work tree belongs to the repository owner
> and nobody has any business pushing into it sideways; push into acceptance
> branch and let the work tree owner merge it when able", the history of the
> failed index base experiment becomes irrelevant.

Ok. This proposal is indeed similar to the base-in-index one, but has some
significant differences. See below.

Besides whith the update above, I no longer propose to keep any new
information -- just to add a safety-check.

On 2007-04-15 19:56:55 GMT, Junio C Hamano wrote:
> [...]
> This is primarily because updating the branch tip is not tied
> closely to writing out a commit, and writing out a commit is not
> tied closely to writing out a tree (to be contained in that
> commit) out of the index.
> [...]

This is a big difference between the base-in-index and
base-somewhere-separately. The reflog is indeed tied to updating of the
branch tip, which is what we need here. It also does not add any new logic to
the low-level plumbing (read-tree, write-tree), that the base-in-index
proposal did.

For the BASE ref proposal, it would be equally tied to update of the branch
tip, except that all porcelain that does it would have to be changed, while
the reflog it already updates.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
