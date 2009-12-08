From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 8 Dec 2009 17:37:37 +0100
Message-ID: <20091208163737.GA2005@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <20091208160822.GA1299@atjola.homenet>
 <20091208161406.GB32045@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 18:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI40X-0005RN-NR
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 18:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937357AbZLHRhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937353AbZLHRhi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 12:37:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:57030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937349AbZLHRhf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 12:37:35 -0500
Received: (qmail invoked by alias); 08 Dec 2009 16:37:42 -0000
Received: from i59F55883.versanet.de (EHLO atjola.homenet) [89.245.88.131]
  by mail.gmx.net (mp045) with SMTP; 08 Dec 2009 17:37:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+wLiEsLWewElGX88cLfqewq5IZpnkuWXi/Pd0zio
	wcK6g+48ZQhO63
Content-Disposition: inline
In-Reply-To: <20091208161406.GB32045@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134899>

On 2009.12.08 18:14:07 +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 08, 2009 at 05:08:22PM +0100, Bj=F6rn Steinbrink wrote:
> > On 2009.12.08 16:47:42 +0200, Michael S. Tsirkin wrote:
> > > Add --revisions flag to rebase, so that it can be used
> > > to apply an arbitrary range of commits on top
> > > of a current branch.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >=20
> > > I've been wishing for this functionality for a while now,
> > > so here goes. This isn't yet properly documented and I didn't
> > > write a test, but the patch seems to work fine for me.
> > > Any early flames/feedback?
> >=20
> > This pretty much reverses what rebase normally does. Instead of "re=
base
> > this onto that" it's "'rebase' that onto this". And instead of upda=
ting
> > the branch head that got rebased, the, uhm, "upstream" gets updated=
=2E
>=20
> The last sentence is wrong I think - it is still the branch head that
> is updated.

But you don't rebase the branch head. Before the rebase, the branch hea=
d
doesn't reference the commits that get rebased. For example:

git checkout bar
git rebase --revisions foo bar

You "rebase" the commits in foo's history, but you update bar.

WRT the result, the above command should be equivalent to:
git checkout bar
git reset --hard foo
git rebase --root --onto ORIG_HEAD;

And here, the commits currently reachable through "bar" are rebased, an=
d
"bar" also gets updated.

Bj=F6rn
