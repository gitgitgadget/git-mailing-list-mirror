From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 17:38:30 +0200
Message-ID: <20071004153830.GA21717@diana.vm.bytemark.co.uk>
References: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com> <20071004083304.GB17778@diana.vm.bytemark.co.uk> <9e4733910710040606j75caa6bcn1e97e59c1285eb4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 17:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdSms-0000HT-5S
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 17:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851AbXJDPik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbXJDPik
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 11:38:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2976 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbXJDPih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 11:38:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdSmU-0005tg-00; Thu, 04 Oct 2007 16:38:30 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910710040606j75caa6bcn1e97e59c1285eb4b@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59965>

On 2007-10-04 09:06:22 -0400, Jon Smirl wrote:

> On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Mmmph. This is not the only StGit command that's apparently not
> > safe to run from a subdirectory. See e.g.
> > https://gna.org/bugs/?9986.
> >
> > I plan to do some StGit hacking this weekend. I guess subdirectory
> > safeness ought to be at the top of my list ...
>
> Isn't a rollback log fairly easy to implement? Is there a single SHA
> after each operation? If so just record the commands and the sha to
> rollback.

Yeah, conceptually it's simple. The only major complication there is
if you want to allow undo both at the whole-stack level and on single
patches.

> I have also messed things up more than once using 'git merge linus'
> instead of 'stg rebase linus'. Should 'git merge' have a check to
> see if stg is active and refuse to run?

I've always felt that git shouldn't have to know about third-party
tools.

stg will detect that you've made git commits on top of the stack.
There's a command to turn them into patches -- but not if they are
merges, of course. In a sufficiently bleeding-edge StGit, assimilate
will tell you something like,

  14 patches are hidden below the merge commit 4711abcd,
  and will be considered unapplied.

at which point you can easily git-reset to below the merge and run
assimilate again.

This is of course less user-friendly than having git refuse to commit
a merge in the first place. Hmmm, a commit hook could probably do
magic here ... it could even turn regular commits into patches on the
fly. I'll have to look up how commit hooks work.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
