From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 00:46:22 +0100
Message-ID: <20051122234622.GD2916@steel.home>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net> <4383A053.8020100@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Nov 23 00:48:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehqO-0007PT-CO
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVKVXqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 18:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbVKVXqd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:46:33 -0500
Received: from devrace.com ([198.63.210.113]:28942 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030257AbVKVXqc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:46:32 -0500
Received: from tigra.home (p54A0E32F.dip.t-dialin.net [84.160.227.47])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAMNkO4B004575;
	Tue, 22 Nov 2005 17:46:24 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EehqA-0000gE-00; Wed, 23 Nov 2005 00:46:22 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EehqA-0000wO-By; Wed, 23 Nov 2005 00:46:22 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <4383A053.8020100@etek.chalmers.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12588>

Lukas Sandstr=F6m, Tue, Nov 22, 2005 23:48:51 +0100:
> >>Subject: [PATCH] speedup allocation in pack-redundant.c
> >>Reuse discarded nodes of llists
> >>Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
> >=20
> > I think making allocation/deallocation to the central place is a
> > good cleanup, but I am not sure about the free-nodes reusing.
> > Does this make difference in real life?  If so, it might be
> > worth doing the slab-like allocation, since free-nodes are very
> > small structure and malloc overhead is not ignorable there.
> >=20
> I have done some tests, and unfortunatley I saw approx. zero
> improvement with Alex's patch. (less than 10ms difference when
> total runtime is 1.850s, tested on http://home.arcor.de/fork0/downloa=
d/idx.tar.gz)

Can I suggest you try it in a really really weird environment? Like
Cygwin. And switch some virus scanner on.

> Did someone else notice an improvement?

My test case had over 100k files in it (just don't ask why. Weird
environments, weird projects, ...)

> It's a nice idea though. I'll look into doing slab-allocation
> for the fun of it, but I'm not really sure that malloc is the
> bottleneck.

Yes, it usually is not a bottleneck. I think, it just another
exception.
