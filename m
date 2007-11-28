From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 17:04:10 +0100
Message-ID: <20071128160410.GB19302@diana.vm.bytemark.co.uk>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com> <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com> <20071128093403.GB12977@diana.vm.bytemark.co.uk> <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:27:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxPfL-0001uZ-Ni
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:21:35 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPV5-0000co-Pe
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:10:59 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPUr-0004lB-7w
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757713AbXK1QEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbXK1QEQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:04:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1650 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757486AbXK1QEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:04:15 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IxPOU-0005CO-00; Wed, 28 Nov 2007 16:04:10 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 967113978FC0E0E8F06D854B6842889BC0E79772
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 39 total 725224 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66369>

On 2007-11-28 10:06:57 -0500, Jon Smirl wrote:

> I did this:
> all pataches were applied
> git rebase

At this point, a simple "git reset --hard HEAD@{1}" should have fixed
the problem. Not much use knowing that now, I know, but still ... :-)

> stg repair -- partial repair, some patches empty, half are pushed

Modulo any bugs, this should have adjusted the appliedness of your
patches to match the new HEAD (patches are applied iff they are
reachable from HEAD) and made patches of any non-patch commits sitting
between a patch and HEAD. Nothing else. In particular, it doesn't
change your existing patches or change HEAD, so those empty patches
were empty even before the repair. (Modulo any bugs, of course, but
that kind of bug seems really unlikely.)

> moved HEAD back in front of rebase
> stg repair - it show all my patches as popped,

That sounds OK. You reset HEAD to a commit early enough in history
that no patches are reachable from it.

> but when I started doing command it complain that some commits that
> stg needed were not there.

That sounds seriously broken. What exactly was the complaint? Missing
commit objects?

> The complaint was caused by the first repair. The first repair
> altered some of the stg state to point at commits past the rebase.

Yes. It would have made patches out of some of the rebased commits, in
order to give you a consistent state. For example, assume you started
with the following situation:

(cN are commits, pN are commits that are also StGit patches)

   ...---c0---c1---p0---p1---p2---p3---p4:HEAD

You git-rebase, causing a situation like this:

   ...---c0---c1---p0---p1---p2---p3---p4
                         \
                          c2---c3---c4---c5---c6---c7---c8:HEAD

"stg repair" at this point will see that p2..p4 should be unapplied
since they aren't reachable from HEAD, and c2..c8 need to be made
patches since they are on top of p1.

Generally, what you want to do is to git-reset to the commit you want
HEAD to be, and _then_ run stg repair.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
