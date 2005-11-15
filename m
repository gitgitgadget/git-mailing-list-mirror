From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Tue, 15 Nov 2005 23:33:40 +0100
Message-ID: <20051115223340.GA3951@steel.home>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Nov 15 23:35:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9NT-0001Pc-36
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbVKOWeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 Nov 2005 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVKOWeH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:34:07 -0500
Received: from devrace.com ([198.63.210.113]:17170 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932205AbVKOWeG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 17:34:06 -0500
Received: from tigra.home (p54A0F755.dip.t-dialin.net [84.160.247.85])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAFMXhKX082610;
	Tue, 15 Nov 2005 16:33:44 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Ec9N0-0000Uw-00; Tue, 15 Nov 2005 23:33:42 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Ec9Mz-00014l-1V; Tue, 15 Nov 2005 23:33:41 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <437A560E.8020500@etek.chalmers.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11955>

Lukas Sandstr=F6m, Tue, Nov 15, 2005 22:41:34 +0100:
> >>llist_sorted_difference_inplace didn't handle the match in the firs=
t
> >>sha1 correctly and the lists went wild everywhere.
> >=20
> > This wasn't enough. It never (>5 min on 2.4GHz PIV) finishes on
> > my local mirror of git, which has 22 packs by now.
>=20
> If the patch I just sent out doesn't fix the problem, and you don't

Sorry, it doesn't. The code loops here:

401             /* find the permutations which contain all missing obje=
cts */
402             perm_all =3D perm =3D get_all_permutations(non_unique);
403             while (perm) {
404                     if (is_superset(perm->pl, missing)) {
405                             new_perm =3D xmalloc(sizeof(struct pll)=
);
406                             new_perm->pl =3D perm->pl;
407                             new_perm->next =3D perm_ok;
408                             perm_ok =3D new_perm;
(gdb)=20
409                     }
410                     perm =3D perm->next;
411             }
412
413             if (perm_ok =3D=3D NULL)


> want to debug it yourself, could you please publish the .idx files
> so I could have a look at them?

Of course: http://home.arcor.de/fork0/download/idx.tar.gz
