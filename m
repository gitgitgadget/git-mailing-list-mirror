From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make git-pack-redundant non-horribly slow on large sets of packs
Date: Thu, 17 Nov 2005 21:39:15 +0100
Message-ID: <20051117203915.GB3013@steel.home>
References: <20051116230956.GA21444@steel.home> <437BBF5D.5040105@etek.chalmers.se> <81b0412b0511162345g1483e7cfia768b18ba3eb1db@mail.gmail.com> <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <437C819C.4040507@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Nov 17 21:43:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcqXs-0003Fh-7j
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 21:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVKQUjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 15:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVKQUjo
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 15:39:44 -0500
Received: from devrace.com ([198.63.210.113]:59656 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964844AbVKQUjn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 15:39:43 -0500
Received: from tigra.home (p54A0D1FB.dip.t-dialin.net [84.160.209.251])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAHKdLxS015669;
	Thu, 17 Nov 2005 14:39:23 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EcqXP-0000Y1-00; Thu, 17 Nov 2005 21:39:19 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EcqXN-0004tO-MR; Thu, 17 Nov 2005 21:39:18 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <81b0412b0511162345g1483e7cfia768b18ba3eb1db@mail.gmail.com> <437C819C.4040507@etek.chalmers.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12151>

Lukas Sandstr=F6m, Thu, Nov 17, 2005 14:11:56 +0100:
> Change the smallest-set detection algortithm so that when
> we have found a good set, we don't check any larger sets.

I used latest git (a575603af20a795584d79b32c30bda10fcae5d3f Merge
branch 'tojunio' of http://locke.catalyst.net.nz/git/git-martinlanghoff=
)
and the patch on top.

Alex Riesen, Thu, Nov 17, 2005 08:45:46 +0100:
> > Could you try updating to the latest snapshot? There was a bug in a
> > list handling function which was fixed recently, perhaps your probl=
em
> > is related.
>=20
> will try, but I didn't realize yesterday that it might be a good idea
> to keep the old repository around. The lot of packs was automatically
> created by incremental repacking after every pull. Sorry...

ok, pack-redundant --all in a repository with 25 packs completed in
1.346 sec. That's definitely an improvement.

But, the repository (a clone of Linus' kernel) didn't have a
superpack. I created one (git repack -a) and started
"pack-redundant --all". And almost oomed the system (it has 1Gb RAM +
512Mb(historically) swap, BTW): oom-killer killed git-pack-redundant.
Peak memory usage was around 1.3Gb, than everything stopped. The
repository had 140718 objects.
