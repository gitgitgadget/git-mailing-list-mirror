From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/2] t3404: demonstrate =?UTF-8?Q?CHERRY=5FPICK=5FHEAD?=
 =?UTF-8?Q?=20bug?=
Date: Thu, 18 Jun 2015 18:38:44 +0200
Organization: gmx
Message-ID: <66bd04e531ae5db6a06d370a0f7e4370ef4e1539.1434645436.git.johannes.schindelin@gmx.de>
References: <cover.1434627492.git.johannes.schindelin@gmx.de>
 <cover.1434645436.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, szeder@ira.uka.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 18:39:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cqG-0002JV-E8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbbFRQiw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2015 12:38:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:60824 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118AbbFRQit (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:38:49 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LsCAp-1YzcPy0a9n-013ryW; Thu, 18 Jun 2015 18:38:45
 +0200
In-Reply-To: <cover.1434645436.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:khhnjcMMRvpA97i11qTPkn4PfRZY6iOwA9kKMVWnjlCZtZe3nR5
 ue54y2p5EPDIKusyyq1p4sFaeyC6wPD0aXf23gf9cXparur7NalewBDNkH1g1Ly2BdvH7eh
 ec3l0/wON9rK5m9nBhMKFTKXlMQ4bOZAtpJjqopKSh0xQPgHzYmRwKo29PoQGrDteVnYsaf
 XCVDQ8PRph+q0yav3w+bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RavCjfOn3XE=:tQlK2w1dzOViKWau6bxZ0a
 bON4FdBb8JMhGvH0O1WCe9io9E3SLxXhhhzDepQ7EbNFUdLrDA3xxDyQNUbXYOjcmWTJ+2Dzq
 GsKdN1zAFatr55Ck5tLxnmw3Ax41bsWWeIWnfep/h+OHN1E6ikK7SW85tkSuXOVgx+iQSxyj1
 P2QfKGOkyh8os309h0qxd5SZBkdHOfv4NJEjZlPTIw4Vy8qAu9xJG6v1IfriOY6hLa+l5WwVC
 pMTbY7aKo9Td6PMrLmaabtXJdvdVWxSupQOOliHetCOAfz2Sy77nsC2/zKiW3fIJySeWeriw2
 QKIA/mrcorknxucuGSzIJGecnoaB+90iONS4S671eygpJ0OxNsQqFjy/nQowI1zeNAsaKEWti
 siyvueRTPdDV+qg6cbNhfGLkrX8PtzpehK7p7Q97qeiGoptG/IQPcWDLg9KFibeM+ZARN0McV
 wWhmvk4H/mhJmCK8GeE5hUtpzwEHmj1tKSkaN370DogGgkf501L3E+eTJkDy8P+2PJayXE8Kq
 WzhFwvD/nwpbAwvV106EaHT+AAY09/pNi8gSrFEGC4MllCK+qEfSdqTIitCW+Hr4RV+xDSKIT
 VKq97KiQZUCggDYtf76gjmzd2EC5oXaMEw6QzwNosUf52hvvUrs8U4OLgg6N8M8sk6iHrNszI
 YBEDuUSADjLpXuGFEhYaar/SO/La+kUYKC3pLmDYN2DsKIzmdN+FIFhtCUoIeG73VxUU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272025>

When rev-list's --cherry option does not detect that a patch has alread=
y
been applied upstream, an interactive rebase would offer to reapply it =
and
consequently stop at that patch with a failure, mentioning that the dif=
f
is empty.

Traditionally, a `git rebase --continue` simply skips the commit in suc=
h a
situation.

However, as pointed out by G=C3=A1bor Szeder, this leaves a CHERRY_PICK=
_HEAD
behind, making the Git prompt believe that a cherry pick is still going
on. This commit adds a test case demonstrating this bug.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index ac429a0..6fe6c47 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1102,4 +1102,25 @@ test_expect_success 'rebase -i commits that over=
write untracked files (no ff)' '
 	test $(git cat-file commit HEAD | sed -ne \$p) =3D I
 '
=20
+test_expect_failure 'rebase --continue removes CHERRY_PICK_HEAD' '
+	git checkout -b commit-to-skip &&
+	for double in X 3 1
+	do
+		seq 5 | sed "s/$double/&&/" >seq &&
+		git add seq &&
+		test_tick &&
+		git commit -m seq-$double
+	done &&
+	git tag seq-onto &&
+	git reset --hard HEAD~2 &&
+	git cherry-pick seq-onto &&
+	set_fake_editor &&
+	FAKE_LINES=3D test_must_fail git rebase -i seq-onto &&
+	test -d .git/rebase-merge &&
+	git rebase --continue &&
+	git diff --exit-code seq-onto &&
+	test ! -d .git/rebase-merge &&
+	test ! -f .git/CHERRY_PICK_HEAD
+'
+
 test_done
--=20
2.3.1.windows.1.9.g8c01ab4
