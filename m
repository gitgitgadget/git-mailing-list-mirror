From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Mon, 3 Nov 2008 14:05:04 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031358460.3419@nehalem.linux-foundation.org>
References: <200811031439.12111.brian.foster@innova-card.com>  <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>  <alpine.LFD.2.00.0811031132520.3419@nehalem.linux-foundation.org>  <alpine.LFD.2.00.0811031133590.3419@nehalem.linux-foundation.org>
  <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org>  <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org> <adf1fd3d0811031345j4582e109jaf95aede0f33eff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 23:07:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7Zl-0006pB-AG
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 23:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbYKCWFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 17:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752937AbYKCWFz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 17:05:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56277 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752324AbYKCWFy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 17:05:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3M55v7032695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 14:05:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3M54Nt026442;
	Mon, 3 Nov 2008 14:05:05 -0800
In-Reply-To: <adf1fd3d0811031345j4582e109jaf95aede0f33eff7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.94 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100002>



On Mon, 3 Nov 2008, Santi B=E9jar wrote:
>=20
> I tried it once, but I had problems simplifying the merges, and it is=
 trivial...

It depends on the new --simplify-merges code which does that.

> Not that it matters a lot, but if you try it on master you get some
> extra merges without a ref like:
>=20
> 373a273 (Merge git-gui 0.11.0, 2008-08-17)

Umm? Your point is?

That merge itself doesn't have a ref, but it's required becase there ar=
e=20
refs along both legs of the merge - one side has the "gitgui-0.11.0" ta=
g,=20
while the other has (for example) v16.0-rc3.

> f44bc33 (Sync with 1.5.6.5, 2008-08-06)

Again, the merge doesn't have a ref, but it's needed because there are=20
refs on both parents (v1.5.6.5 vs v1.6.0-rc[01]).

So no, --simplify-namespace in no way guarantees that all resulting=20
commits will have refs pointing to them, because it also needs to retur=
n=20
enough of the merges to make it a real and meaningful DAG.

The one thing I note is that when you have lots and lots of refs in the=
=20
gitk output, the gitk window itself becomes very ugly. I'd love to get =
rid=20
of the black line between the ref (tag or branch name) and the circle,=20
because with "gitk --simplify-namespace" it ends up looking like some k=
ind=20
of insane "ladder" due to all those vertical lines.

And they really aren't necessary, and it would probably be better to ju=
st=20
make selecting a commit highlight the whole row (and thus avoid any=20
ambiguity between that highlighted commit message and the circle in the=
=20
graph it goes with if you have a very wide graph).

But I can't read tcl/tk enough to even figure out where it's being=20
painted.

			Linus
