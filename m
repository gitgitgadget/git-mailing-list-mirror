From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 4/2] grep: turn off threading for non-worktree
Date: Sat, 10 Dec 2011 08:13:05 -0500
Message-ID: <20111210131305.GA13344@arf.padd.com>
References: <cover.1322830368.git.trast@student.ethz.ch>
 <4EDE9BBA.2010409@lsrfire.ath.cx>
 <4EDE9ED1.8010502@lsrfire.ath.cx>
 <201112070912.54766.trast@student.ethz.ch>
 <4EDF9BA0.2080204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Dec 10 14:13:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMjr-0008Eg-Mg
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055Ab1LJNNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 08:13:11 -0500
Received: from honk.padd.com ([74.3.171.149]:45824 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750836Ab1LJNNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 08:13:09 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id E4BFEEE;
	Sat, 10 Dec 2011 05:13:07 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 43BCD313EE; Sat, 10 Dec 2011 08:13:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EDF9BA0.2080204@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186777>

rene.scharfe@lsrfire.ath.cx wrote on Wed, 07 Dec 2011 18:00 +0100:
> Am 07.12.2011 09:12, schrieb Thomas Rast:
> > Ren=E9 Scharfe wrote:
> >> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.t=
xt
> >> index 47ac188..e981a9b 100644
> >> --- a/Documentation/git-grep.txt
> >> +++ b/Documentation/git-grep.txt
> >> @@ -228,8 +228,9 @@ OPTIONS
> >>  	there is a match and with non-zero status when there isn't.
> >> =20
> >>  --threads <n>::
> >> +	Run <n> search threads in parallel.  Default is 8 when searching
> >> +	the worktree and 0 otherwise.  This option is ignored if git was
> >> +	built without support for POSIX threads.
> > [...]
> >> -		nr_threads =3D (online_cpus() > 1) ? THREADS : 0;
> >> +		nr_threads =3D (online_cpus() > 1 && !list.nr) ? THREADS : 0;
> >=20
> > It would be more consistent to stick to the pack.threads convention
> > where 0 means "all of my cores", so to disable threading the user
> > would set the number of threads to 1.  Or were you trying to measur=
e
> > the contention between the worker thread and the add_work() thread?
>=20
> Yes, indeed, the cost for the threading overhead does interest me.  T=
he
> documentation should perhaps mention --no-threads explicitly to avoid
> confusion.
>=20
> Currently there is no way to specify "as many threads as there are
> cores" here.  Previous measurements indicated that it wasn't too usef=
ul,
> however, because I/O parallelism was beneficial even for machines wit=
h
> less than eight cores and more threads didn't pay off.

Right.  Even for single CPU machines this is true, so the
nr_threads calculation above should still use all 8 THREADS
regardless of the number of online_cpus().

		-- Pete
