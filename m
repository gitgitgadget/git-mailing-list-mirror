From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor of bad rev
Date: Fri, 11 Jul 2008 00:36:17 +0200
Message-ID: <200807110036.17504.chriscool@tuxfamily.org>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807102126.37567.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:33:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4hc-0008U9-I0
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834AbYGJWc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 18:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYGJWc1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:32:27 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:36667 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753699AbYGJWc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jul 2008 18:32:26 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1203C1AB2D4;
	Fri, 11 Jul 2008 00:32:25 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CCE4E1AB2CC;
	Fri, 11 Jul 2008 00:32:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vd4llpkxq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88019>

Le jeudi 10 juillet 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Yeah, in that case...
> >
> >> The whole idea of "bisect" relies on that idea, that any ancestor =
of a
> >> good commit is good.  Otherwise you'd have to check the commits on=
e by
> >> one, not in a bisecting manner.
>
> Didn't we already discuss this at length?

Yes, the thread is there:

http://thread.gmane.org/gmane.comp.version-control.git/86951

> > No, you just need to check that the merge bases between the bad rev=
 on
> > one side and each good rev on the other side are good too. And if t=
hat
> > is the case, then you can be sure that bisection will point to a fi=
rst
> > bad commit.
> >
> > So the choice is between a simple and fast but not fully reliable
> > bisect, or a more complex and slower but fully reliable bisect.
>
> I have not looked at your implementation, but I do think:
>
>  - The current one is not "fully reliable"; the user needs to know wh=
at
>    he is doing.  You might call it "prone to user errors".

I agree.

>  - "Test this merge-base before going forward, please" will add typic=
ally
>    only one round of check (if you have more merge bases between good=
 and
>    bad, you need to test all of them are good to be sure), so it is n=
ot
>    "slower nor more complex".

By "slower" I meant that it would need more rounds of check on average.
By "more complex" I meant that more code is needed.

And I think you are right, all the merge bases need to be tested so I w=
ill=20
send a patch on top of the patch discussed here.

Another idea to fix the problem, might be to bisect as usual and at the=
 end=20
before saying "X is first bad commit" to check if some of X parents are=
=20
merge bases between the bad rev and a good rev. If that is the case, th=
en=20
we could ask the user to check that these parents are all good. On aver=
age=20
this would probably reduce the number of revs the user must check.

Regards,
Christian.

=20
