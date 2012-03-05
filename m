From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Bug: pull --rebase with =?utf-8?Q?=C3=A9?= in name
Date: Mon, 5 Mar 2012 14:04:37 +0100
Message-ID: <87ipijkxlm.fsf@thomas.inf.ethz.ch>
References: <FECFDD4D-6EC3-4DE1-8A08-B4477345C4AA@habr.de>
	<20120305102657.GB29061@sigill.intra.peff.net>
	<87399nqqog.fsf@thomas.inf.ethz.ch>
	<F5A485EA-7EAD-4D8B-87C4-7185F713318C@habr.de>
	<20120305115815.GA4550@sigill.intra.peff.net>
	<0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Will Palmer <wmpalmer@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Haber <rene@habr.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 14:04:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Xan-0002rH-QT
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 14:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001Ab2CENEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 08:04:41 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:12377 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756983Ab2CENEk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 08:04:40 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:04:38 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 14:04:37 +0100
In-Reply-To: <0E2B8DE3-1ABD-453F-BCAA-0D693ECA5987@habr.de> (=?utf-8?Q?=22?=
 =?utf-8?Q?Ren=C3=A9?= Haber"'s
	message of "Mon, 5 Mar 2012 13:46:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192233>

Ren=C3=A9 Haber <rene@habr.de> writes:

> sh -c '                                  =20
>    . /sw/lib/git-core/git-sh-setup
>     get_author_ident_from_commit 16b94413cbce12531e8f946286851598449d=
3913
>  '
> GIT_AUTHOR_NAME=3D'Ren'=C3=A9 Haber
> GIT_AUTHOR_EMAIL=3D'rene@habr.de'
> GIT_AUTHOR_DATE=3D'@1329212923 +0100'

I think this is the same issue that we recently discussed on #git-devel=
,
where some broken versions of sed will fail to match "any character"
with '.' even under LC_ALL=3DC.  Will "shruggar" Palmer (cc) had this
issue under OS X with a build of GNU sed that ignored LC_*.

You can verify that this is the problem by looking at

  printf "\370\235\204\236\n" | LC_CTYPE=3DC sed 's/./x/g' | xxd

It should say

  0000000: 7878 7878 0a                             xxxx.

That is, the garbage (if you try to read it as UTF-8) in the printf
string was matched and replaced byte-by-byte with 'x'.  However,
Will was getting the unreplaced results

  0000000: f89d 849e 0a                             .....

I'm not sure he has followed up on that problem; the only hope may be t=
o
get a better 'sed'.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
