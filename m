From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 15:44:09 +0100
Message-ID: <20120112144409.GV30469@goldbirke>
References: <20120111173101.GQ30469@goldbirke>
	<CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 15:44:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlLt4-0006ak-1I
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 15:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab2ALOoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 09:44:13 -0500
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:52443 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2ALOoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 09:44:12 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 15:44:06 +0100
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 15:44:08 +0100
Content-Disposition: inline
In-Reply-To: <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188448>

Hi,


On Thu, Jan 12, 2012 at 02:31:30PM +0100, Christian Couder wrote:
> Hi all,
>=20
> 2012/1/11 SZEDER G=E1bor <szeder@ira.uka.de>:
> >
> > As far as I can tell, this buggy behavior is as old as multi-commit
> > cherry-pick itself, i.e. 7e2bfd3f (revert: allow cherry-picking mor=
e
> > than one commit, 2010-06-02).
>=20
> Thanks for the very detailed report!
>=20
> I didn't test nor even compiled anything but maybe this can be fixed
> by adding something like:
>=20
> opts->revs->topo_order =3D 1;
>=20
> in parse_args() or in prepare_revs()
>=20
> I will try to have a look tonight.

[Beware, I'm mostly clueless about git internals.]

I don't think that any commit reordering, whether it's based on
committer date, topology, or whatever, is acceptable.  Commits must be
picked in the exact order they are specified on the command line.

Besides, AFAICT, parse_args() sets opts->revs->no_walk =3D 1, which wil=
l
cause prepare_revision_walk() to return before it would reach the
topo_order condition, so opts->revs->topo_order =3D 1 wouldn't have any
effect.


Best,
G=E1bor
