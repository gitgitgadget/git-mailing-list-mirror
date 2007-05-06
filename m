From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Sun, 6 May 2007 16:22:33 +0200
Message-ID: <20070506142233.GA20017@diana.vm.bytemark.co.uk>
References: <20070504081021.14786.77675.stgit@yoghurt> <20070506122116.GA18883@diana.vm.bytemark.co.uk> <20070506131554.GF19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070506133909.GG19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun May 06 16:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkhde-0004Tm-8d
	for gcvg-git@gmane.org; Sun, 06 May 2007 16:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbXEFOWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754310AbXEFOWx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 10:22:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2341 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbXEFOWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 10:22:53 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkhdB-0005HV-00; Sun, 06 May 2007 15:22:33 +0100
Content-Disposition: inline
In-Reply-To: <20070506133909.GG19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46337>

On 2007-05-06 15:39:09 +0200, Yann Dirson wrote:

> Well, this case clearly falls in the category of "actions outside
> stgit that make it possible to rebase without a loss". But then it
> is also clear that the action of tagging makes the committed patch
> reachable, and thus the rebase loss-less.
>
> The safety check could be possibly be rewritten as "check if current
> base is reachable without using any refs from current series".

Yes, I like that idea _much_ better. That's what we _should_ be
testing for, given that the objective is to keep all commits
reachable.

So, how can we do that? gitk displays, when you view a commit, the
heads through which that commit is reachable. How does it compute
that? Hmm, it seems like this type of construct works for selecting
only those commits that are only reachable through a given ref:

  gitk origin/pu --not $(git show-ref | grep -v refs/remotes/origin/pu|=
 cut -f 1 -d ' ')

Of course, one could use git log instead of gitk if it turns out to be
too hard to write an x-windows parser for stgit. :-)

However, I'm not sure even this is necessary; reflogs are enabled by
default nowadays. But if it's cheap enough, we might as well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
