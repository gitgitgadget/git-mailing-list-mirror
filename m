From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Mon, 5 Dec 2011 10:02:21 +0100
Message-ID: <201112051002.22138.trast@student.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch> <5328add8b32f83b4cdbd2e66283f77c125ec127a.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Herman <eric@freesa.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 05 10:02:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXURY-00039d-Dy
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 10:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980Ab1LEJC1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 04:02:27 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:8799 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab1LEJC0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 04:02:26 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 10:02:22 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Dec
 2011 10:02:22 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4ED8F9AE.8030605@lsrfire.ath.cx>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186280>

Ren=E9 Scharfe wrote:
> Am 02.12.2011 14:07, schrieb Thomas Rast:
> > Measuring grep performance showed that in all but the worktree case
> > (as opposed to --cached,<committish>  or<treeish>), threading
> > actually slows things down.  For example, on my dual-core
> > hyperthreaded i7 in a linux-2.6.git at v2.6.37-rc2, I got:
> >
> > Threads       worktree case                 | --cached case
> > -------------------------------------------------------------------=
-------
> > 8 (default) | 2.17user 0.15sys 0:02.20real  | 0.11user 0.26sys 0:00=
=2E11real
> > 4           | 2.06user 0.17sys 0:02.08real  | 0.11user 0.26sys 0:00=
=2E12real
> > 2           | 2.02user 0.25sys 0:02.08real  | 0.15user 0.37sys 0:00=
=2E28real
> > NO_PTHREADS | 1.57user 0.05sys 0:01.64real  | 0.09user 0.12sys 0:00=
=2E22real
>=20
> Are the columns mixed up?

Indeed, sorry.

In case you were wondering why this table is different from the
numbers given in the cover letter: I noticed at some point that I had
an incomplete checkout (apparently 'git checkout -- .' is really not
the same as 'git reset --hard'... sigh).  Then I saw that while the
numbers were different, the conclusion was not, so I forgot to update
it.

> This is a bit radical.  I think the underlying issue that=20
> read_sha1_file() is not thread-safe can be solved eventually and then=
=20
> we'd need to readd that code.

I'm also scared of sha1_file.c, especially when it gets down to
packfiles.  But perhaps it wouldn't be *too* hard to do it in parallel
iff the object can be read from the loose object store.

> PS: Patches one and three missed a signoff.

Oops, thanks, turns out I had a misconfigured alias ...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
