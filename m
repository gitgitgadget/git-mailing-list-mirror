From: Johan Herland <johan@herland.net>
Subject: Re: how to work in hirarchical git model?
Date: Wed, 17 Dec 2008 09:33:03 +0100
Message-ID: <200812170933.04080.johan@herland.net>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com>
 <4948AB14.8030004@viscovery.net> <753177.33978.qm@web112212.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gili Pearl <gili.pearl@yahoo.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 09:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrsK-0007h0-PF
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbYLQIeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 03:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbYLQIeF
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:34:05 -0500
Received: from smtp.getmail.no ([84.208.20.33]:33745 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbYLQIeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 03:34:04 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KC000J4LIGOCK00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 09:34:00 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC00059WIF49WC0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 09:33:04 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC000ILAIF4HE07@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 17 Dec 2008 09:33:04 +0100 (CET)
In-reply-to: <753177.33978.qm@web112212.mail.gq1.yahoo.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103317>

On Wednesday 17 December 2008, Gili Pearl wrote:
> ----- Original Message ----
>
> > From: Johannes Sixt <j.sixt@viscovery.net>
> > Gili Pearl schrieb:
> > > Here is one problem I saw when trying to work in the three-level
> > > model. At some point, I had the following setup:
> > >
> > > top-level : A----B----C----D
> > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > mid-level1:=A0 =A0 =A0 =A0 K----L----M
> > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > >=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > > low-level1:=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 X----Y
> > >
> > > The maintainer of mid-level1 has decided that commits K L M are r=
eady
> > > to be merged into the top-level repo. So he rebased on top-level
> > > before asking=A0'please pull', but after that the low-level was n=
ot
> > > able to rebase on the mid-level any more.
> >
> > In this model, the mid-level1 maintainer should *not* rebase agains=
t
> > top-level. Rather, he should ask the top-level maintainer to *merge=
*
> > K-L-M.
>
> But what if K-L-M conflict with C-D? The one who should take care abo=
ut
> it is=A0 the mid-level1 maintainer (or possibly one of the low-level1
> maintainers).

If there is a merge conflict, mid-level1 maintainer will typically merg=
e D=20
and M into a new merge commit N:

 top-level : A----B----C----D
               \              \
                \              \
 mid-level1:     K----L----M----N

=2E..and then ask top-level maintainer to merge N (which should have no=
=20
conflicts by now). The merge can also be done by low-level1 developer.

> > > So what is the right working flow for us?
> >
> > The only ones who should be allowed to rebase are developers at the
> > lowest level. Everyone else should only pull or merge.
>
> I still don't see clearly what happens next in the example above=A0wh=
en the
> low level developr wants to push X-Y upstream? On which branch should=
=A0he
> rebase? Need he rebase on mid-level (where K-L-M were already
> merged=A0upstream),=A0or maybe direclty on the top-level??

If you're a leaf developer (i.e. allowed to rebase), you should rebase=20
against your immediate upstream's branch. In this example, that is=20
mid-level1's branch.


Have fun!

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
