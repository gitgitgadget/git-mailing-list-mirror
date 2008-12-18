From: Johan Herland <johan@herland.net>
Subject: Re: how to work in hirarchical git model?
Date: Thu, 18 Dec 2008 02:00:57 +0100
Message-ID: <200812180200.57847.johan@herland.net>
References: <703400.93370.qm@web112210.mail.gq1.yahoo.com>
 <200812170933.04080.johan@herland.net>
 <897592.56642.qm@web112219.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gili Pearl <gili.pearl@yahoo.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 02:02:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD7Hj-0003yO-2z
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 02:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbYLRBBV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Dec 2008 20:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYLRBBV
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 20:01:21 -0500
Received: from smtp.getmail.no ([84.208.20.33]:42869 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbYLRBBU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 20:01:20 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KC100I47S67V200@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Dec 2008 02:01:19 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC100B4JS5MC550@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Dec 2008 02:00:58 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KC100AFSS5MEFIQ@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Dec 2008 02:00:58 +0100 (CET)
In-reply-to: <897592.56642.qm@web112219.mail.gq1.yahoo.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103417>

On Wednesday 17 December 2008, Gili Pearl wrote:
> > From: Johan Herland <johan@herland.net>
> > On Wednesday 17 December 2008, Gili Pearl wrote:
> > > But what if K-L-M conflict with C-D? The one who should take care
> > > about it is=A0 the mid-level1 maintainer (or possibly one of the
> > > low-level1 maintainers).
> >
> > If there is a merge conflict, mid-level1 maintainer will typically
> > merge D and M into a new merge commit N:
> >
> > top-level : A----B----C----D
> > =A0 =A0 =A0 =A0 =A0 =A0  \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 \=A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > mid-level1:=A0 =A0 K----L----M----N
>
> There's one thing that still bothers me and I'd like to understand.
> What if someone looks both on top-level repo and mid-level1 repo, and=
 he
> want to=A0diff some local commit X against commit D. I didn't try it,=
 but I
> wonder how git knows against which=A0D to compare? On the top-level=A0=
D means
> A-B-C-D while on the mid-level1 C=A0means A-K-L-M-B-C-D (that is what
> git-log on mid-level shows). I'm probably missing something here...
> commit id cannot represent two different histories, right?

D will always be the same commit in both top-level repo and mid-level1 =
repo.=20
Remember that D precedes the merge commit N, so D is not changed by the=
=20
merge at all (then we could no longer call it D).

The diagram above is slightly misleading, in that it does not say wheth=
er=20
the merge commit N has been pulled into the top-level repo or not. Here=
 are=20
more descriptive illustrations:

A) Before the merge:

  A----B----C----D    <-- top-level
   \
    \
     K----L----M    <-- mid-level1

B) After mid-level1 has done the merge

  A----B----C----D    <-- top-level
   \              \
    \              \
     K----L----M----N    <-- mid-level1

C) After top-level has pulled the merge from mid-level1 (assuming top-l=
evel=20
has done nothing in the meantime, and can fast-forward to N)

  A----B----C----D
   \              \
    \              \
     K----L----M----N    <-- mid-level1 & top-level

> > ...and then ask top-level maintainer to merge N (which should have =
no
> > conflicts by now). The merge can also be done by low-level1 develop=
er.
>
> How can it be done by low-level1? you mean by bypassing mid-level and
> merging top-level directly?

No. low-level1 will do the merge commit in his repo (typically by creat=
ing a=20
new branch at M (thus keeping X & Y out of the way), and then merging D=
=20
into this new branch to produce N), and will then ask mid-level1 to pul=
l=20
the merge into her repo. From there, the situation is similar to the ab=
ove=20
diagrams.

In principle, it's possible for low-level1 to ask top-level directly to=
 pull=20
his merge commit, but this is probably frowned upon, because it breaks =
the=20
project conventions (although git itself has no problem with this).


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
