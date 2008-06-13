From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 14:40:50 +0200
Message-ID: <19C06D62-966A-4626-A620-2281A7CAA2B6@wincent.com>
References: <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:42:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K78c0-0003Xj-DR
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 14:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbYFMMlk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 08:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755589AbYFMMlk
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 08:41:40 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:48519 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbYFMMlk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 08:41:40 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5DCeqU8004418
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 13 Jun 2008 08:40:54 -0400
In-Reply-To: <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84871>

El 13/6/2008, a las 11:47, Junio C Hamano escribi=F3:

> If there is a strong correlation between the two, one possible =20
> solution
> would be to introduce refs/stashes/$branch/ namespace that holds each
> stash as an individual, numbered ref under it.  They will live foreve=
r
> until the user explicitly asks for their removal.  If we go this =20
> route, we
> would need a few niceties such as a way to move a "quick stash" that =
=20
> is
> represented as a reflog entry into a "longlived stash" that is =20
> represented
> as an individual ref under refs/stashes/$branch/.
>
> But let's not talk nor think about per-branch stash for now.  How =20
> does the
> "keep" thing sound to people?


Sounds a little bit over-engineered to me.

So, "stash" is intended for short-term storage, but by adding a "keep" =
=20
option you're officially blessing it for long-term storage as well. =20
And the interface that you propose, explicitly marking stuff as "for =20
keeps" and being able to move stuff from "temp" to "keep" sounds quite =
=20
complicated.

I honestly think that the simplest solution from both an =20
implementation and a usage perspective is just to keep everything that =
=20
is stashed until the user clears it out. If you use a push/pop model =20
then your stash will never get cluttered up with garbage, and if you =20
do abuse it for long-term storage you'll start to notice that the =20
stash list is inconveniently large, thus hinting that perhaps you are =20
abusing stash in ways that the designers never intended.

Cheers,
Wincent
