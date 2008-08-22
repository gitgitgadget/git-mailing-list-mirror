From: Jeff King <peff@peff.net>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 15:48:46 -0400
Message-ID: <20080822194846.GA31356@coredump.intra.peff.net>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org> <20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org> <20080822193730.GA1598@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>, Alan.Brunelle@hp.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcdt-0001HX-42
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYHVTst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYHVTst
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:48:49 -0400
Received: from peff.net ([208.65.91.99]:1046 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbYHVTss (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:48:48 -0400
Received: (qmail 24369 invoked by uid 111); 22 Aug 2008 19:48:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 22 Aug 2008 15:48:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Aug 2008 15:48:46 -0400
Content-Disposition: inline
In-Reply-To: <20080822193730.GA1598@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93352>

On Fri, Aug 22, 2008 at 09:37:30PM +0200, Bj=C3=B6rn Steinbrink wrote:

> Yep, and that's totally correct as far as bisect is concerned. The
> parents of that merge commit are:
> 88fa08f67bee1a0c765237bdac106a32872f57d2
> b1b135c8d619cb2c7045d6ee4e48375882518bb5
>=20
> And Alan marked both of them as good.
>=20
> So, unless Alan made a mistake during his bisection, each of the
> branches is correct, but the merge did not lead to a correct result. =
So
> while there were no textual conflicts, there were still incompatible
> changes regarding the code semantics and compatibility was not restor=
ed
> during the merge.

One thing that I have seen proposed (but never tried myself) is that yo=
u
can linearize the changes using "rebase -i" (or cherry-picking), and
then bisect that result. That is, given a history

A-B-C-D
 \   /
  E-F

where the merge "D" introduces the bug, you could try creating:

  A-B-C-E'-F'

and bisecting that. And you should know that C is good from your
previous bisection, but that F' probably is not, since it should be
textually the same as D (unless, of course, you had textual conflicts
during the rebase that you fixed up differently).

So in essence you are testing each of E and F, but based on the other
work. So you should be able to find the one patch that causes the
conflict. And depending on the conflict, you may get more information b=
y
doing it the other way. I.e.,:

  A-E-F-B'-C'

-Peff
