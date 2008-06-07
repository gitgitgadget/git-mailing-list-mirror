From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Sat, 7 Jun 2008 11:06:36 +0200
Message-ID: <20080607090636.GB32647@diana.vm.bytemark.co.uk>
References: <20080604210655.32531.82580.stgit@localhost.localdomain> <20080604211334.32531.74258.stgit@localhost.localdomain> <20080605070126.GC23209@diana.vm.bytemark.co.uk> <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com> <20080605130415.GB28995@diana.vm.bytemark.co.uk> <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uP4-0002Lc-Vx
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:08:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901AbYFGJGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbYFGJGn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:06:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4479 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733AbYFGJGm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:06:42 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4uNg-0000GW-00; Sat, 07 Jun 2008 10:06:36 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84187>

On 2008-06-06 09:44:37 +0100, Catalin Marinas wrote:

> 2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > We'll have to be watchful against attempts to create objects other
> > than via the officially designated factories, though. Python
> > doesn't really have any mechanisms that help us here.
>
> Doesn't need to be enforced. The Stack and Branch objects can be
> initialised by themselves provided that the repository is passed as
> argument at construction. The factory is more for convenience,
> passing the repository to the newly created object.

Those classes cache stuff. So if you have, say, two PatchOrder objects
representing the same underlying files, an update in one will not be
reflected in the other. An important role of the factory is to make
sure that if an object is asked for twice, the _same_ object is
returned to both callers.

The Commit, Tree, and Blob objects produced by Repository are another
example where we rely on there being no more than one Python object
representing the same underlying data.

> If you really want enforcing this, it can probably be done by
> hacking __new__ and __init__.

No, I reckon you're right -- it's overkill. StGit is small enough that
we can probably enforce the relevant restrictions by hand.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
