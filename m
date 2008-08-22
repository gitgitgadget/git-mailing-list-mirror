From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 21:37:30 +0200
Message-ID: <20080822193730.GA1598@atjola.homenet>
References: <48A36838.3050309@hp.com> <20080819124602.9e8e69f7.akpm@linux-foundation.org> <48AEDD3D.4060507@hp.com> <20080822092549.ddcb7e79.akpm@linux-foundation.org> <20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Alan.Brunelle@hp.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 21:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWcT2-0005i8-FE
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 21:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYHVThf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 15:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYHVThf
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 15:37:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:54138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751029AbYHVThe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 15:37:34 -0400
Received: (qmail invoked by alias); 22 Aug 2008 19:37:32 -0000
Received: from i577B8611.versanet.de (EHLO atjola.local) [87.123.134.17]
  by mail.gmx.net (mp031) with SMTP; 22 Aug 2008 21:37:32 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18hQAxQi2ghHKXKEKShSFm2jfKMNFT/5GjbPkTDmq
	UuDxSEUGrXI8It
Content-Disposition: inline
In-Reply-To: <20080822105136.a8432875.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93348>

On 2008.08.22 10:51:36 -0700, Andrew Morton wrote:
> On Fri, 22 Aug 2008 19:16:51 +0200 Petr Baudis <pasky@suse.cz> wrote:
> > On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
> > > One (probably wrong) approach is to run
> > >=20
> > > 	gitk 1c89ac55017f982355c7761e1c912c88c941483d
> > >=20
> > > then peer at the output, work out which real commits were in that
> > > merge.
> > >=20
> > > It looks like the merge ended with
> > > b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
> > > 40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do
> > >=20
> > > 	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
> > > 	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4
> >=20
> > ...I don't quite get this - according to the bisection log,
> >=20
> > 	# good: [b1b135c8d619cb2c7045d6ee4e48375882518bb5] fix spinlock re=
cursion in hvc_console
> >=20
> > and now you want to mark it as bad?
>=20
> <what bisection log?>

Alan provided his bisection log as an attachment to the original bug
report.

> I assume that Alan's bisection search ended up saying that the merge
> commit (1c89ac55017f982355c7761e1c912c88c941483d) was the first bad
> commit.

Yep, and that's totally correct as far as bisect is concerned. The
parents of that merge commit are:
88fa08f67bee1a0c765237bdac106a32872f57d2
b1b135c8d619cb2c7045d6ee4e48375882518bb5

And Alan marked both of them as good.

So, unless Alan made a mistake during his bisection, each of the
branches is correct, but the merge did not lead to a correct result. So
while there were no textual conflicts, there were still incompatible
changes regarding the code semantics and compatibility was not restored
during the merge.

To get an overview over what got merged together you can can use
something like:
gitk --left-right 1c89ac55017^1...1c89ac55017^2

Which shows all commits that were on only one side of the merge, with
nice "arrows" that indicate from which side the commit is coming. The
conflict should be between one commit from the left and one commit from
the right side, obviously.

Bj=F6rn
