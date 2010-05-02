From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 2 May 2010 15:32:00 -0400
Message-ID: <19421.54064.178345.489772@winooski.ccs.neu.edu>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
	<20100502181854.GC16051@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 21:32:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8euO-00060E-S5
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 21:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282Ab0EBTcG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 15:32:06 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:51665 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755006Ab0EBTcE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 15:32:04 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O8etU-0006GN-7A; Sun, 02 May 2010 15:32:00 -0400
In-Reply-To: <20100502181854.GC16051@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146196>

On May  2, Jonathan Nieder wrote:
> Maybe --name-only or --name-status can help.
>=20
> Note that most conflicts will not show up here: if the merge result
> matches either parent, then git diff --cc and friends will not
> consider it interesting at all.

Isn't that a good definition of a trivial commit?  I'm not talking
about the whole commit -- just any file that is not identical to one
of its parents.


> A command to list conflicts and their resolutions would be expensive
> but valuable, I think.  A na=C3=AFve implementation would involve red=
oing
> the merge.
> [...]
> A =E2=80=9Cmerge diffstat=E2=80=9D sounds like an interesting idea, b=
ut the detailed
> semantics are not obvious to me (maybe separate counts for
> nontrivial added and removed lines from each parent?).

OK, thanks for clarifying that.  For my purpose, I basically just want
to know whether there was manual tweaking involved in the merge.  (For
my thing I don't even need to see those changes, since I show the
overall push diff only.)  What I ended up doing is pretty bad:

  git show --pretty=3Dshort --name-only "$r" | grep -q '^Merge: '
    --> test if it's a merge commit

  git show --pretty=3Dformat:"" --name-only "$r" | grep -q "."
    --> test if it's trivial

  git show --pretty=3Dformat:"" "$r" | diffstat -p1
    --> get the diffstated output

(My script generally "compensates" for git being fast by running a ton
of them for each email...)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
