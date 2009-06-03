From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/4] make it possible to skip away from broken commits
Date: Wed, 3 Jun 2009 08:32:01 +0200
Message-ID: <200906030832.01898.chriscool@tuxfamily.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org> <7vmy8qe4ru.fsf@alter.siamese.dyndns.org> <4A25EA85.5090208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:32:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBk1I-0003LC-O9
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 08:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbZFCGcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 02:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbZFCGcF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 02:32:05 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:60412 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753587AbZFCGcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 02:32:04 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id BDCED4C816B;
	Wed,  3 Jun 2009 08:31:58 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id D5B084C8014;
	Wed,  3 Jun 2009 08:31:55 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A25EA85.5090208@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120585>

Le Wednesday 03 June 2009, H. Peter Anvin a =C3=A9crit :
> Junio C Hamano wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >> This patch series adds a "--ratio=3Dx/y" option to "git bisect ski=
p" so
> >> that it is possible to skip away from an area were the commits can=
not
> >> be tested.
> >>
> >> Note that in this series "--ratio=3D4" means the same as "--ratio=3D=
1/4".
> >> But I am not sure if this shortcut is worth it.
> >
> > Actually my gut feeling is that a tweakable knob itself is worth it=
,
> > because the user can never tell what the right value should be.
> >
> > Especially without any documentation updates that explains what thi=
s
> > ratio refers to ;-), but I suspect, unless the user is very familia=
r
> > with how the revision graph bisection internally works, such an
> > explanation would not help him find a skip ratio that is closer to =
the
> > optimum than a random guess.  Why not use a constant ratio (or perh=
aps
> > a pair of alternating ratios) on "bisect skip" without any new opti=
ons?
>
> I would agree with this assessment.  It's hard enough to teach a user
> how to use "git bisect" as it is... and being able to have a *user*
> bisect a problem is worth its weight in gold.
>
> If the algorithm I proposed earlier is too complex, here is a very
> simple approximation:
>
> start:
> 	num =3D 1
> 	den =3D 2
>
> again:
> 	run test (num/den)
> 	if (!skip)
> 		goto start
>
> 	num =3D num + 2
> 	if (num > den)
> 		num =3D 1
> 		den =3D den * 2
>
> 	goto again
>
>
> This creates test ratios in the following sequence:
>
> 1/2 1/4 3/4 1/8 3/8 5/8 7/8 1/16 3/16 ...
>
> When one gets down to a small number of points this could get weird, =
but
> as long as skip points are filtered (which looks like it's already be=
ing
>  done) it should converge.

I agree. I will have a look.

Thanks,
Christian.
