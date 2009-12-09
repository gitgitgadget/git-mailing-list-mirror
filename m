From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 9 Dec 2009 14:41:33 +0100
Message-ID: <20091209134133.GA30596@atjola.homenet>
References: <20091208144740.GA30830@redhat.com>
 <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0912090941420.470@ds9.cixit.se>
 <20091209093758.GA2977@redhat.com>
 <alpine.DEB.2.00.0912091150470.470@ds9.cixit.se>
 <20091209112237.GA27740@atjola.homenet>
 <alpine.DEB.2.00.0912091414460.470@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Dec 09 14:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIMna-0002vK-CX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 14:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897AbZLINlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 08:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755885AbZLINle
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 08:41:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:38411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755748AbZLINld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 08:41:33 -0500
Received: (qmail invoked by alias); 09 Dec 2009 13:41:39 -0000
Received: from i59F5468C.versanet.de (EHLO atjola.homenet) [89.245.70.140]
  by mail.gmx.net (mp054) with SMTP; 09 Dec 2009 14:41:39 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/XTg4bTqbXEu6kk3IWDFXATLOnDo3rzjgIxzfQTC
	O/RlVp9QU8SNzD
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912091414460.470@ds9.cixit.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134968>

On 2009.12.09 14:20:23 +0100, Peter Krefting wrote:
> Bj=F6rn Steinbrink:
>=20
> >Err, no. "git merge --squash foo" merges all changes from the
> >merge base of HEAD and foo up to foo. "git cherry-pick foo" takes
> >just the changes
> > from foo^ to foo.
>=20
> Exactly!
>=20
> What I meant to say in the original message was that conceptually,
> the difference between a "git rebase --reverse A..B", a "git
> cherry-pick A..B" and a "git merge --squash A..B" is minute.
>=20
> And when continuing the thought experiment, the step from "git merge
> --squash A..B" to "git merge A..B" is not very large either, just (a
> lot) more difficult to implement.

"git merge" is about merging histories. --squash and the A..B you
suggest make it degenerate into merging changes (and you can't record
that using the commit DAG). So that messes things up conceptually.

Implementing probably wouldn't be that hard, IIRC it should be a matter
of messing with the fake merge base that cherry-pick uses to get its jo=
b
done. While "git cherry-pick foo" uses foo^ as the merge base, you'd
just make "git merge --squash A..B" work like "git cherry-pick B" but
use A as the fake merge base. It's been a while since I looked at the
cherry-pick code though, so I might be off here.

(Kind of ironic though that I didn't think of that when I said that
"cherry-pick --squash" would be hard to do...)

Anyway, "git merge" with a range simply makes no sense at all given how
git's merge works (opposed to svn's idea of merging, which is about
changes, not about histories). If you want a squash flag, tell
cherry-pick to handle ranges and teach such a flag to it.

Bj=F6rn
