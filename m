From: Wolfgang Rohdewald <wolfgang@rohdewald.de>
Subject: Re: git blame --follow
Date: Tue, 15 Mar 2011 19:26:58 +0100
Message-ID: <201103151926.58449.wolfgang@rohdewald.de>
References: <201103151644.44360.wolfgang@rohdewald.de> <7vy64g9tqs.fsf@alter.siamese.dyndns.org>
Reply-To: wolfgang@rohdewald.de
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 19:26:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzYwS-0002nK-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 19:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228Ab1COSZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2011 14:25:54 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:30462 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab1COSZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 14:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1300213549; l=2080;
	s=domk; d=rohdewald.de;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:In-Reply-To:
	References:Cc:Date:Subject:To:Reply-To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=f1gMbSl4innOQKQqgn8NnenKG4w=;
	b=jYdOGab3/LqbI2CMJkUDdkGymdAH9rLWI2MNs1G0n3FWWJyIyIcHqBPzu00xJd0i8Qt
	gkBOP9sOkshk7fkc+j+v2FZl4eqoT5d/bpY8dzKQ1FN2xTEzXRqRzbybrgnTDCatZNkGh
	BjFa6EcQJ7dfVJpzKIRwpsSI/lKvsKUK9mU=
X-RZG-AUTH: :O2MIc0epdfgAjoV+frHI3UhxNCLBO5P+YS73lHhJYRD2uAuzaM+5N8MTpuriRg==
X-RZG-CLASS-ID: mo00
Received: from i5.rohdewald.de (p5B3E0509.dip0.t-ipconnect.de [91.62.5.9])
	by post.strato.de (mrclete mo39) (RZmta 25.8)
	with ESMTPA id q07250n2FHF4CR ; Tue, 15 Mar 2011 19:25:49 +0100 (MET)
Received: from i5.localnet (localhost.localdomain [127.0.0.1])
	by i5.rohdewald.de (Postfix) with ESMTP id DAA13EA010E;
	Tue, 15 Mar 2011 19:26:59 +0100 (CET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-27-generic; KDE/4.6.1; x86_64; ; )
In-Reply-To: <7vy64g9tqs.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	shortcircuit=no autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on i5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169084>

On Dienstag 15 M=E4rz 2011, Junio C Hamano wrote:
> Wolfgang Rohdewald <wolfgang@rohdewald.de> writes:
> > git log --follow filename
> >=20
> > shows the full history, while
> >=20
> > git blame --follow filename
> >=20
> > blames everything to the latest commit (which was
> > a file rename)
>=20
> Huh?
>=20
>     $ git checkout master^0
>     $ git mv COPYING RENAMING
>     $ git commit -m renamed
>     $ git blame --follow RENAMING
>=20
> gives everything blamed to 075b845a COPYING (but that is
> probably by accident, see below).  FYI,
>=20
>     $ git blame RENAMING
>=20
> should also blame everything to the same commit and the same
> COPYING file. If you get a different behaviour out of the
> above command sequence, there is something else going on.

I get the same - except that only most is attributed to 075b845a,
some is attributed to 703601d6. But git blame and git
blame --follow return the same output with your example

> I didn't know "blame" even accepted "--follow".  It is
> entirely out of the scope of its design to take "--follow"
> option, as the "blame" command itself has its own and real
> "follow" logic that is enabled by default (i.e. it follows a
> whole file rename without any option)

so if I rename a parent directory of myfile and do git blame=20
myfile, blaming should ignore the renaming. This works
with the git repo

git mv xdiff xxx
git ci -m'mv xdiff xxx'
cd xxx
git blame xemit.c

But with my repository (which I cannot share),
this does not happen. git blame attributes everything to=20
the renaming commit. If I checkout the commit before, git
blame shows everything correctly.

So there must be something special with my repo. How could
I debug that? BTW the renaming happened in svn, it is the
last svn commit for this file before I imported this svn
repo into git (like described in the Pro Git book)

And - for directories below the renamed one git log --follow=20
cannot cross this barrier either but if the "follow" logic
is different I suppose this is not related

--=20
Wolfgang
