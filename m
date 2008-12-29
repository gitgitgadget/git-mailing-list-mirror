From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 18:18:25 +0100
Message-ID: <20081229171825.GB6200@atjola.homenet>
References: <gj7mmo$fvk$4@ger.gmane.org> <slrnglf3qh.c7j.sitaramc@sitaramc.homelinux.net> <gj96pl$885$4@ger.gmane.org> <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net> <gjauel$94s$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zorba <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:20:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLmf-0008Lf-T1
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 18:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbYL2RSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 12:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbYL2RSa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 12:18:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:55528 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751807AbYL2RS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 12:18:29 -0500
Received: (qmail invoked by alias); 29 Dec 2008 17:18:26 -0000
Received: from i577B9D9B.versanet.de (EHLO atjola.local) [87.123.157.155]
  by mail.gmx.net (mp028) with SMTP; 29 Dec 2008 18:18:26 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19/6VRKKaN/AfFYjgKjH8J6atrQ7OVFZgNdbRR8BI
	JtZR1KNSSU8jIj
Content-Disposition: inline
In-Reply-To: <gjauel$94s$4@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104115>

On 2008.12.29 16:38:30 -0000, Zorba wrote:
> so a detached HEAD is just a HEAD that is not sitting on a tip ?
>=20
> i.e. if I do $ git reset --hard HEAD^
>=20
> ...pointing HEAD to the previous committ
>=20
> this is a detached HEAD

No. At least that won't turn an "attached" HEAD into a detached HEAD.

Attached HEAD: HEAD is a symbolic ref to another ref.
Detached HEAD: HEAD is a non-symbolic ref to a commit.

So you can have:
HEAD -> refs/heads/master -> commitA  --> attached HEAD

Or:
HEAD -> commitA --> detached HEAD

Note how the commit object is the same in both cases.

What you "git reset [--hard] HEAD^" does, depends on the kind of HEAD
you have.

"git reset HEAD^" will (conceptually, implementation might differ):

Resolve HEAD^ to find a commit.

and

Resolve HEAD until it finds a non-symbolic ref, and update that ref to
reference the commit it found.

Looking at the cases from above:

Attached case:
HEAD -> refs/heads/master -> commitA

Resolve HEAD^:
HEAD^ =3D=3D> refs/heads/master^ =3D=3D> commitA^ =3D=3D> commitA_paren=
t

=46ind non-symbolic ref:
HEAD (symbolic) =3D=3D> refs/heads/master (non-symbolic)

So refs/heads/master gets updated to reference commitA_parent.


Now the detached case:
HEAD -> commitA

Resolve HEAD^:
HEAD^ =3D=3D> commitA^ =3D=3D> commitA_parent

=46ind non-symbolic ref:
HEAD (non-symbolic)

So HEAD gets updated to reference commitA_parent.


In other words, HEAD is what tells git what you have checked out. And
that's either a branch head (attached HEAD, symbolic ref) or a commit
(detached HEAD, non-symbolic ref).

In the symbolic ref case, operations like "commit" or "reset" work on
the branch you have checked out (found through the symbolic ref), in th=
e
non-symbolic ref case (detached HEAD), those operations work on HEAD
itself.

Bj=F6rn
