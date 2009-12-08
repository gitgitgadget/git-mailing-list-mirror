From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 18:49:04 +0200
Message-ID: <20091208164904.GB32204@redhat.com>
References: <20091208144740.GA30830@redhat.com> <20091208160822.GA1299@atjola.homenet> <20091208161142.GA32045@redhat.com> <20091208164113.GB2005@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 08 17:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI3I4-0000KM-JP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 17:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbZLHQvq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 11:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbZLHQvp
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 11:51:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57564 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932612AbZLHQvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 11:51:44 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nB8Gpma0009789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 8 Dec 2009 11:51:48 -0500
Received: from redhat.com (vpn2-9-36.ams2.redhat.com [10.36.9.36])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nB8GpkJd013957;
	Tue, 8 Dec 2009 11:51:47 -0500
Content-Disposition: inline
In-Reply-To: <20091208164113.GB2005@atjola.homenet>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134896>

On Tue, Dec 08, 2009 at 05:41:13PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.12.08 18:11:44 +0200, Michael S. Tsirkin wrote:
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
> > >=20
> > > Also, AFAICT this needs to be called like this:
> > > git rebase --revisions foo..bar HEAD
> > >=20
> > > Changing the meaning of the <upstream> argument and relying on th=
e fact
> > > that <newbase> defaults to <upstream>. If such a thing gets added=
, it
> > > should rather work like --root, not using <upstream> at all, but =
--onto
> > > <newbase> only. Maybe defaulting to HEAD for <newbase> and making=
 --onto
> > > optional, as it's reversed WRT what it does compared to the usual
> > > rebase.
> >=20
> > Sorry, I had trouble parsing the above.  Could you suggest e.g. how=
 the
> > help line should look?
>=20
> Current:
> git rebase [-i | --interactive] [options] [--onto <newbase>]
> 	<upstream> [<branch>]
> git rebase [-i | --interactive] [options] --onto <newbase>
> 	--root [<branch>]
>=20
> Add:
> git rebase [-i | --interactive] [options] --revisions <range> [<branc=
h>]
>=20
> (Thinking about it, I guess an explicit --onto makes no sense with th=
e
> --revisions flag)

I agree.
So this is different from what I implemented basically only in that
we should disallow combining --onto with --revisions. Right?

> > > But generally, I'd say it would be better to add such a range fea=
ture to
> > > cherry-pick than abusing rebase for that.
> >=20
> > The reason to use rebase is that I often want to combine
> > this with -i flag, editing patches as they are applied.
>=20
> Hm, well, your patch didn't touch git-rebase--interactive.sh ;-)
>=20
> Bj=F6rn

Ah, I was wondering why it doesn't work :)
