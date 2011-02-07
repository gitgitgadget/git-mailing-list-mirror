From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 7 Feb 2011 19:34:12 +0100
Message-ID: <20110207183412.GB1900@neumann>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
	<20110207055314.GA5511@sigill.intra.peff.net>
	<7vhbcguytf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 19:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmVuo-0001so-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 19:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab1BGSeQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 13:34:16 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:41682 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1BGSeP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 13:34:15 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 7 Feb
 2011 19:34:08 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Mon, 7 Feb
 2011 19:34:11 +0100
Content-Disposition: inline
In-Reply-To: <7vhbcguytf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166267>

On Sun, Feb 06, 2011 at 10:46:20PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Is "git add -p" broken, then? It takes pathspecs relative to the cu=
rrent
> > directory, but "git add -p" without arguments operates from the roo=
t,
> > not from the current subdirectory.
>=20
> I would say so; "add -p" was an ill-executed afterthought.  The codep=
ath
> was originally meant to be used from "-i" as the top-level interface =
that
> was a fully interactive way to prepare for the next commit, which is =
an
> operation that is inherently full-tree.
>=20
> There are two schools of thought in previous threads discussing full-=
tree
> vs current-directory-relative.  I think each side has merits.
>=20
> If we defaulted to the current directory (i.e. "git grep"), that woul=
d
> feel more natural as it is more consistent with how tools that are no=
t git
> aware (e.g. "GNU grep" run in the same directory) behave.  A downside=
 is
> when you are somewhere deep in a working tree, you have to know how d=
eep
> you are and repeat "../" that many times, i.e. "git grep pattern ../.=
=2E/"
>=20
> If we defaulted to the root-level (i.e. "git diff"), you do not have =
that
> downside (iow, "git diff" run from a deep directory is a full tree
> operation), and you can limit the scope to the current directory by a
> single dot, i.e. "git diff .".  A huge downside is that this may feel
> awkward for new people who do not yet breath git [*1*], as no other g=
it
> aware tool would behave like this, limiting its scope to some directo=
ry
> that is higher above.
>=20
> In the past, I have took the third position, saying that tools that
> semantically needs to be full-tree should be full-tree (i.e. ones tha=
t
> make or format commits), and others should be relative to the current
> directory (i.e. ones that are used to inspect your progress, such as
> grep), but that is not a very understandable guideline that people ca=
n
> easily follow.  If we have to choose between the two and make things
> consistent, my personal preference is to make everything relative to =
the
> current working directory.

_Everything_ relative to the current working directory?  I can't
imagine how would that work in practice.  Could you explain what would
the following commands do, for example, when they are relative to the
current working directory?

  $ cd t
  $ git checkout next
  $ git merge somebranch
  $ git reset HEAD^


Best,
G=E1bor
