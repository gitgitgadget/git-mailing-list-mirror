From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Fri, 11 Jul 2008 01:45:33 +0200
Message-ID: <200807110145.33820.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness> <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5md-0001dg-Oi
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756597AbYGJXln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbYGJXln
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:41:43 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50213 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbYGJXlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 19:41:42 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 424711AB2B8;
	Fri, 11 Jul 2008 01:41:41 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 092F31AB2B3;
	Fri, 11 Jul 2008 01:41:40 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7ibtnx09.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88057>

Le vendredi 11 juillet 2008, Junio C Hamano a =E9crit :
>
> But in real life, things are more like "Today's master does not work,=
 but
> I am sure it used to work at 1.5.6.2".  I happen to always merge all =
of
> 'maint' to 'master' before pushing them out, so a good topology is
> guaranteed, but not everybody does this (it takes careful planning wh=
at
> to apply to 'maint' and where to fork topics from, and maintainers ar=
e
> not perfect):
>
>               Good
>           ?---o (maint)
>          /
>      ---?---?---?---?---x (master)
>         MB              Bad
>
> People _will_ face such a topology.  If the users Know Better, they w=
ill
> test MB=3D$(merge-base master maint) first to see if it is broken, an=
d then
> the world will have two possibilities:
>
>     (1)       Good
>           ?---o (maint)
>          /
>      ---o---?---?---?---x (master)
>         Good            Bad
>
>     (2)       Good
>           ?---o (maint)
>          /
>      ---x---?---?---?---x (master)
>         Bad             Bad
>
>
> If (1), you go ahead with the usual bisection.  If (2), you cannot ev=
en
> bisect.  Instead, you flip good and bad to find the "fix" in the side
> branch (the answer has to be either the tip of maint or one previous =
in
> the picture) to forward port to, either by merging 'maint' to 'master=
' or
> cherry-picking.
>
> The idea to check merge-base first is about automating this process (=
I
> admit I still haven't looked at Christian's patch text yet).

Well in case (2) my patch does:

-------
		cat >&2 <<EOF
The merge base $_badmb is bad.
This means the bug has been fixed between $_badmb and $_g.
EOF
		exit 3
-------

but this can be improved upon in some latter patches.

Thanks,
Christian.
