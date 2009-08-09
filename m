From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Document 'stash clear' recovery via unreachable commits
Date: Sun, 9 Aug 2009 04:21:35 +0200
Message-ID: <20090809022134.GA4141@atjola.homenet>
References: <9e8ddf7c6c4d4df4150bff0467b461bfff92a401.1249778711.git.trast@student.ethz.ch>
 <7veirlbwws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 04:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZy2q-0007Dg-4v
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 04:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbZHICVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 22:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZHICVl
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 22:21:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:35306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750867AbZHICVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 22:21:40 -0400
Received: (qmail invoked by alias); 09 Aug 2009 02:21:39 -0000
Received: from i59F565F1.versanet.de (EHLO atjola.homenet) [89.245.101.241]
  by mail.gmx.net (mp006) with SMTP; 09 Aug 2009 04:21:39 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/gkA1KbnTgQIoqZDULhDPfdeInEa4B5owrkKtK6L
	VbSXmt0gaK+RSd
Content-Disposition: inline
In-Reply-To: <7veirlbwws.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125316>

On 2009.08.08 18:25:55 -0700, Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > Add an example to the stash documentation that shows how to quickly
> > find candidate commits among the 'git fsck --unreachable' output.
>=20
> Thanks.
>=20
> > Unless you have merges of branch names containing WIP, or edit your
> > merge messages to say WIP, there will be no false positives.
>=20
> That may be true, but I suspect that people's stash entries that are =
worth
> saving are given their own messages with "git stash save 'message'" a=
nd do
> not necessarily say WIP.  I wish if there were a better way to identi=
fy
> them, but I do not think of any offhand.

Here's what I have now:

git fsck --unreachable | grep commit | cut -d\  -f3 |
xargs git log --no-walk --merges \
	--grep=3D'^\(WIP on \|On \)\((no branch)\|[^ ]\+\):'

Should catch stashes with and without user-supplied messages and avoid
most false-positives. Drop the "WIP on " option from the grep to captur=
e
just those that have a user-supplied message.

To try really really hard to get stash stuff only, one could add some
extra stuff to verify that the second parent's commit message is
"index on \2:" (\2 being the second group from the above --grep). But
that's probably total overkill...

Bj=F6rn
