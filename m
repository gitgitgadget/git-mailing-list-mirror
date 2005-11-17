From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Thu, 17 Nov 2005 08:08:52 +0100
Message-ID: <20051117070852.GA4921@c165.ib.student.liu.se>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <Pine.LNX.4.64.0511151552400.11232@g5.osdl.org> <437BA6A6.8080900@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <raa.lkml@gmail.com>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Nov 17 08:09:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcdtK-0008Sg-Vm
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 08:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbVKQHJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 02:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbVKQHJA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 02:09:00 -0500
Received: from [85.8.31.11] ([85.8.31.11]:50588 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1161155AbVKQHJA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 02:09:00 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 0E9C340FF; Thu, 17 Nov 2005 08:17:46 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Ecdt6-0001Kw-00; Thu, 17 Nov 2005 08:08:52 +0100
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <437BA6A6.8080900@etek.chalmers.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12088>

On Wed, Nov 16, 2005 at 10:37:42PM +0100, Lukas Sandstr=F6m wrote:
> Linus Torvalds wrote:
> >=20
> > On Tue, 15 Nov 2005, Alex Riesen wrote:
> >=20
> >>Sorry, it doesn't. The code loops here:
> >>
> >>401             /* find the permutations which contain all missing =
objects */
> >>402             perm_all =3D perm =3D get_all_permutations(non_uniq=
ue);
> >=20
> >=20
> > Looks like the whole thing is exponential.
> >=20
> Slightly less, but not far from.
> > A good way to do sane pack handling is to keep a _sorted_ list of a=
ll=20
> > objects each pack has. At that point it becomes much easier to see =
which=20
> > objects only exist in one particular pack.
> >=20
> git-pack-redundant already does this.
> > The sorting itself is O(nlogn), and the "does this pack have any un=
ique=20
> > objects" (or "is this pack a superset of all other packs") question=
 should=20
> > then be O(n).
> >=20
> Ah, but the question is: "Does this set of packs contain a superset o=
f
> all objects available in packfiles?" The answer to the question for a
> certain set is indeed O(n), but the number of sets which have to be t=
ested
> are ~ O(e**n). (Where n is the number of non-unique packs.)
>=20

If haven't looked closely at neither the packing nor the pack
redundant code, but the problem looks very similar to Minimum Set
Cover (see http://www.nada.kth.se/~viggo/wwwcompendium/node146.html
for more information), which is NP-hard. So, if Minimum Set Cover is
the problem we are trying to solve we can't hope to find a polynomial
time algorithm. However, there is a quite simple greedy approximation
algorithm in [1] which is referenced from the URL above.


- Fredrik

[1]: Johnson, D. S. (1974), "Approximation algorithms for
     combinatorial problems", J. Comput. System Sci. 9, 256-278.
