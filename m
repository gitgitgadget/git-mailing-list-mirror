From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2.1 resend] rev-list: estimate number of bisection step left
Date: Sat, 21 Feb 2009 18:12:55 +0100
Message-ID: <200902211812.56593.chriscool@tuxfamily.org>
References: <20090221092601.45691c3e.chriscool@tuxfamily.org> <7vy6w0qgwr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LavRZ-0005os-3A
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbZBURNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 12:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZBURNo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:13:44 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:57538 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbZBURNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 12:13:43 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id C0F864C81E4;
	Sat, 21 Feb 2009 18:13:34 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 899884C81C3;
	Sat, 21 Feb 2009 18:13:31 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy6w0qgwr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110966>

Le samedi 21 f=E9vrier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Here is a table to help analyse what should be the best estimate fo=
r
> > the number of bisect steps left.
> > ...
> > So the algorithm used in this patch calculates 2^n and x, and then
> > choose between returning n - 1 and n.
>
> Two dumb questions about the math (because I suck at math).
>
>  - Do you mean by "best estimate" the best case scenario, or somethin=
g
>    else (perhaps "the most accurate")?

I mean the number of steps that has the highest frequency of occurrence=
, if=20
we suppose that:

1) we are in the linear case, and that
2) the first bad revision has an equal chance of being any of the unkno=
wn=20
(Ux) and the bad (B) revisions.

>  - Is computing based on linear history a good enough approximation?

I think so. Before I sent patch v1, I tested it on some non linear case=
s and=20
it worked quite well in those cases as well. I think the bisect algorit=
hm=20
tries as best as possible to remove half the revisions from the set of =
the=20
possible first bad revisions and this means that all the algorithms bas=
ed=20
on log2(all) should be quite good in any case.

> I am not advocating to make things more precise nor saying your math =
is
> flawed.  I'd prefer simpler code for things like this --- after all, =
my
> understanding of this whole exercise is to give "this is more or less=
 the
> number you should expect" ballpack figure and nothing more (correct m=
e if
> that is not what you are aiming for).

Yes, that's what I am aiming for. And I thought that my first patch was=
=20
quite good at doing that, so when you said that "at the very low end th=
e=20
estimate is a bit too optimistic", I had another look and found out tha=
t=20
for "all =3D=3D 3" indeed the algorithm gave 0 when 1 was better, becau=
se 1=20
should happen on average 2 times out of 3.

So I came up with the algorithm in v2 which is better because it should=
=20
always give the best estimate (supposing 1) and 2)). It's also not much=
=20
more complex compared to v1 or anything based on log2(all), so I don't =
see=20
any reason to use something else.

Regards,
Christian.
