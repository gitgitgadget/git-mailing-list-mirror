From: martinvz <martin.von.zweigbergk@gmail.com>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Thu, 7 Jan 2010 15:38:05 -0800 (PST)
Message-ID: <1262907485376-4269422.post@n2.nabble.com>
References: <27059158.post@talk.nabble.com> <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com> <1262889864880-4268064.post@n2.nabble.com> <adf1fd3d1001071433j6cd36641sdd2dfd6a936d8483@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 00:38:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT1vi-0006oy-6B
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 00:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0AGXiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558Ab0AGXiH
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 18:38:07 -0500
Received: from kuber.nabble.com ([216.139.236.158]:33368 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0AGXiG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 18:38:06 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NT1vZ-00035I-CS
	for git@vger.kernel.org; Thu, 07 Jan 2010 15:38:05 -0800
In-Reply-To: <adf1fd3d1001071433j6cd36641sdd2dfd6a936d8483@mail.gmail.com>
X-Nabble-From: martinvz <martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136400>



Santi B=C3=A9jar-2 wrote:
>=20
> Is your upstream branch rebased?
>=20

Sorry, but I'm not sure I understand what that means. Most of the commi=
ts in
the upstream branch (the remote main branch) were rebased onto that bra=
nch
at some point in time before being pushed to our shared repository. The
remote branch itself was never rebased against any other branch (all
destructive operations disallowed in Gitosis). I hope that (possibly al=
ong
with the information below) answers your question.


Santi B=C3=A9jar-2 wrote:
>=20
> Can you provide, at least, a graph of your history (ala git log
> --graph --oneline for example)? And plot also the reflog entries and
> all the important commits.
>=20

$ git log --graph --format=3D%h --all
* 2038a46 # topic-2
* a7b93b2
* f2501ae # origin/main
* cd5aaa9
* cb232f3
=2E..
* 5ed0d06
* 3067862
| * 6eba2fa # topic-1
| * b09aaf4
| * bc3b72a
|/
| * 03d0d84 # topic-3
| * 5160773
| * 3c25642
|/
| * 6e9b12b # topic-4
| * 75f5ab2
| * bdd08ce
| * b5d5759
|/
* 486b580
* a021696
* 3ffe7df
* d0f55c5
=2E..

I have topic-1 checked out and run "git pull" and expect it to rebase (=
only)
commits bc3b72a, b09aaf4, 6eba2fa onto f2501ae, but it starts by applyi=
ng
a021696 and 486b580.

$ git reflog -g origin/main
f2501ae refs/remotes/origin/mai=7F=7Fn@{0}: fetch origin: fast forward
3ffe7df refs/remotes/origin/mai=7F=7Fn@{1}: fetch origin: fast forward
=2E..

I hope that's all that's all you need. It seems that the problem is tha=
t the
oldremoteref gets overwritten with the entry from the reflog. Is the pr=
oblem
that 3ffe7df appears in the reflog or that 486b580 doesn't appear there=
? I'm
not clear on what ends up in the reflog.

I just realized that I myself created a021696 and 486b580 (but not 3ffe=
7df),
probably by rebasing some now-dead branch against origin/main.

Something else that may or may not have something to do with the proble=
m is
that there is also a branch called origin/main-stable (pointing to the =
same
commit as origin/main). I also have a local main branch (also same comm=
it as
origin/main). I don't know if any of this could confuse Git. (To be
perfectly honest, it is actually the origin/main-stable branch I'm tryi=
ng to
pull from, just in case you think the branch name could have any impact=
=2E)


Thanks,
Martin

--=20
View this message in context: http://n2.nabble.com/Difference-between-p=
ull-rebase-and-fetch-rebase-tp4266164p4269422.html
Sent from the git mailing list archive at Nabble.com.
