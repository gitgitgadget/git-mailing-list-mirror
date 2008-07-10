From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Thu, 10 Jul 2008 21:26:37 +0200
Message-ID: <200807102126.37567.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807101201210.3135@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH1kq-0005BB-0T
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 21:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758998AbYGJTWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758923AbYGJTWr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 15:22:47 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:42478 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757987AbYGJTWq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 15:22:46 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D836D1AB2D6;
	Thu, 10 Jul 2008 21:22:44 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 870B31AB316;
	Thu, 10 Jul 2008 21:22:44 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807101201210.3135@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87999>

Hi,

Le jeudi 10 juillet 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Thu, 10 Jul 2008, Christian Couder wrote:
> > Before this patch, "git bisect", when it was given some good revs t=
hat
> > are not ancestor of the bad rev, didn't check if the merge bases we=
re
> > good. "git bisect" just supposed that the user knew what he was doi=
ng,
> > and that, when he said the revs were good, he knew that it meant th=
at
> > all the revs in the history leading to the good revs were also
> > considered good.
>
> Well, it is not completely relying on the user.

Yeah it's relying on statistics too.

> The common scenario before a bisect is this: something used to work _=
all
> the time_, and all of a sudden, it does not anymore.

I agree that it is the most common scenario, perhaps 95% or perhaps eve=
n 99%=20
or more. But mistakes and special cases happens too.

=46or example people can forget to apply in the trunk a fix that is in =
a side=20
branch. Or they can revert in a side branch a big buggy feature just be=
fore=20
making a minor release; but in the trunk the big buggy feature is still=
=20
there and may very well have introduced regressions.

> So it is expected that there is no fix in the history.  Not in the
> current branch, not in the "good" branch, not wherever.
>
> In that case, you are literally guaranteed that all ancestors of a go=
od
> commit are good, too, because if there was a bad one, there would be =
a
> fix, too.

Yeah, in that case...

> The whole idea of "bisect" relies on that idea, that any ancestor of =
a
> good commit is good.  Otherwise you'd have to check the commits one b=
y
> one, not in a bisecting manner.

No, you just need to check that the merge bases between the bad rev on =
one=20
side and each good rev on the other side are good too. And if that is t=
he=20
case, then you can be sure that bisection will point to a first bad com=
mit.

So the choice is between a simple and fast but not fully reliable bisec=
t, or=20
a more complex and slower but fully reliable bisect.

Regards,
Christian.
