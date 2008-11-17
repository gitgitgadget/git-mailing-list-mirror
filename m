From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: purging unwanted history
Date: Mon, 17 Nov 2008 03:27:14 +0100
Message-ID: <20081117022714.GC3911@atjola.homenet>
References: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com> <20081117022412.GB3911@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 03:28:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1tqr-000335-9X
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 03:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYKQC1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2008 21:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbYKQC1S
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 21:27:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:57564 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751497AbYKQC1S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 21:27:18 -0500
Received: (qmail invoked by alias); 17 Nov 2008 02:27:15 -0000
Received: from i577BB07E.versanet.de (EHLO atjola.local) [87.123.176.126]
  by mail.gmx.net (mp009) with SMTP; 17 Nov 2008 03:27:15 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+7EpEKfga7tpkQsRHJfD6AfSEu/kSqbKMDy9nJyh
	8Bdp9+gwkFJMVw
Content-Disposition: inline
In-Reply-To: <20081117022412.GB3911@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101193>

On 2008.11.17 03:24:12 +0100, Bj=F6rn Steinbrink wrote:
> On 2008.11.17 10:56:23 +1030, Geoff Russell wrote:
> > I have a repository with 5 years worth of history, I only want to k=
eep
> > 1 year, so I want to purge the first 4 years. As it happens, the
> > repository only has a single branch which should simplify the probl=
em.
>=20
> Use filter-branch to drop the parents on the first commit you want to
> keep, and then drop the old cruft.
>=20
> Let's say $drop is the hash of the latest commit you want to drop. To
> keep things sane and simple, make sure the first commit you want to
> keep, ie. the child of $drop, is not a merge commit. Then you can use=
:
>=20
> git filter-branch --parent-filter "sed -e 's/-p $drop//'" \
> 	--tag-name-filter cat -- \
> 	--all ^$drop
>=20
> The above rewrites the parents of all commits that come "after" $drop=
=2E
>=20
> Check the results with gitk.
>=20
>=20
> Then, to clean out all the old cruft.
>=20
> First, the backup references from filter-branch:
>=20
> git for-each-ref --format=3D'%(refname)' refs/original | \
> 	while read ref
> 	do
> 		git update-ref -d "$ref"
> 	done
>=20
> Then clean your reflogs:
> git reflog expire --expire=3D0 --all
>=20
> And finally, repack and drop all the old unreachable objects:
> git repack -ad
> git prune # For objects that repack -ad might have left around
>=20
> At that point, everything leading up to and including $drop should be
> gone.

Hm, on second thought, if you have tags referencing some of the old
history, they'll still be around, I think. Just delete those before you
start the rewriting.

And of course do the above with a copy of your repo. Just in case.

Bj=F6rn
