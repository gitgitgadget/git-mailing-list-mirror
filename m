From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 18:44:49 +0200
Message-ID: <20091208164449.GA32204@redhat.com>
References: <20091208144740.GA30830@redhat.com> <20091208160822.GA1299@atjola.homenet> <20091208161406.GB32045@redhat.com> <20091208163737.GA2005@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI3EH-0006o2-RR
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbZLHQrv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 11:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756007AbZLHQru
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:47:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbZLHQrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 11:47:49 -0500
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB8GlXip008933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Dec 2009 11:47:33 -0500
Received: from redhat.com (vpn2-9-36.ams2.redhat.com [10.36.9.36])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB8GlVGL016759;
	Tue, 8 Dec 2009 11:47:32 -0500
Content-Disposition: inline
In-Reply-To: <20091208163737.GA2005@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134895>

On Tue, Dec 08, 2009 at 05:37:37PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.08 18:14:07 +0200, Michael S. Tsirkin wrote:
> > On Tue, Dec 08, 2009 at 05:08:22PM +0100, Bj=F6rn Steinbrink wrote:
> > > On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> > > > Add --revisions flag to rebase, so that it can be used
> > > > to apply an arbitrary range of commits on top
> > > > of a current branch.
> > > >=20
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >=20
> > > > I've been wishing for this functionality for a while now,
> > > > so here goes. This isn't yet properly documented and I didn't
> > > > write a test, but the patch seems to work fine for me.
> > > > Any early flames/feedback?
> > >=20
> > > This pretty much reverses what rebase normally does. Instead of "=
rebase
> > > this onto that" it's "'rebase' that onto this". And instead of up=
dating
> > > the branch head that got rebased, the, uhm, "upstream" gets updat=
ed.
> >=20
> > The last sentence is wrong I think - it is still the branch head th=
at
> > is updated.
>=20
> But you don't rebase the branch head. Before the rebase, the branch h=
ead
> doesn't reference the commits that get rebased. For example:
>=20
> git checkout bar
> git rebase --revisions foo bar
>=20
> You "rebase" the commits in foo's history, but you update bar.

Yes, that's the who point of the patch.  The above applies a single
commit, foo, on top of current branch bar.

> WRT the result, the above command should be equivalent to:
> git checkout bar
> git reset --hard foo
> git rebase --root --onto ORIG_HEAD;
>=20
> And here, the commits currently reachable through "bar" are rebased, =
and
> "bar" also gets updated.
>=20
> Bj=F6rn

So this=20
1. won't be very useful, as you show it is easy
   to achieve with existing commands.
2. interprets "foo" as branch name as opposed to
   revision range.

OTOH, rebase --revisions as I implemented is a "smarter cherry-pick" wh=
ich
can't easily be achieved with existing commands, especially if you add
"-i".


--=20
MST
