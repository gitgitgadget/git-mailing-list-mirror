From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 00/21] git bisect improvements
Date: Sun, 10 Apr 2016 15:18:53 +0200
Message-ID: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFJ1-0000h0-Su
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbcDJNUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:20:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:61573 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbcDJNUD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:20:03 -0400
Received: from fermat.fritz.box ([92.76.224.62]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MPZuP-1atu6e3TiD-004gEd; Sun, 10 Apr 2016 15:19:50
 +0200
X-Mailer: git-send-email 2.8.1.137.g522756c
X-Provags-ID: V03:K0:XRdtjWkhbfZzd6UEH5Qyu+fRb0c3kTCUM/Hm4OPZ55p0NiZug6y
 L5ZACSr82hcwRtzP5DOVJdjkTAPExblCgXp55XPxKHRqr+yrCrbUW+4WahLNYVI2u3Ys0U0
 uTBOVo8ibZfgarKBMmlCKIK5ahIAwTIGu10f58zgdd8aoISM23HFtmk8o51cP9oIB6QsZTd
 EcZ0/19wbG3BZXzlPfDjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bO/4d02wdys=:/NkNC4ogFhC8dN261YZoFV
 323pRHvSDqqD5jB9wSea/sLEKqQQvUy0+erB/96ddI0F/6VZA1IXtY4825KJt9Mtkk+VyFkuf
 AWvNBybdv0VuOqrOQP/GciWhnZRslfjtZGqaUXtE9WSy/fLdL24KIglmF0Bxud38AxyRBdzI3
 9iU/2B3L4IvBFtI0qdEujpImgQmCrzOs5Gfu2SXjo8S0P8kCU6w9OoQAB/zHP4YUkzDLKUQ/s
 FOlcHBqURF/pODyQm7a0L4OhYNJk/7tqw2SKNlsv08NKCnRI5L0yxYRqLBm8fW0KsLsDAvTHD
 gOQx7sYCmXzDc7L1Dn4xUoh+5XUrfeWaLxnAvQejFv8kIpM4cfvSls7SjboNLlIid178gaMO4
 9EYKOp12T+k4lfvncsGcukSThymRVrZTXhAqA4IrWTs2wnEnxNKrPlyZvnmCAWyihjLHdgdK5
 1datigVo5he4ATwJhiQa6k7uMp9YtMi6qawwzzPuNEEiELo66quNC4fSW5VtHEk4w5WEju5a7
 Yce4ugjLQSThvtc4spFyH4umkFFG3XWK7moc+8QgwvSaVYGYF8SCodoTOF3E9jJuC5v1fg2oG
 YJVExWHkcX1AqZnscxlxRsjPHiP3KSQWiGxHOM2O3SMehyPEZjOVVwB22T3pmN2Rig+em5Y9N
 N0c9v2pJFzBJDDK9f+G/njGfKeYE+TDqKn4fmv7POTEH5FZSZ5wp9vRF/gVTm5bBYdKCgCjKy
 dBi8l99yTIX7b3j25lkJ/8kHl9SD/8H1rdX80XgCdfQlutkFj+90rmokISo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291163>

Hi,

a long time ago[1] I sent the first version of this patchset
to the list. Since then I wrote different variants of the algorithm,
fixed some bugs, made the tests work ;), and finally performed some
performance tests to pick the best version of the different variants.

For the performance tests I used the Git repositories of the Linux
kernel and of Git itself and performed whole-history bisections
with a bisect script that decided "good" or "bad" based on the hash
of a commit. And another bisect script that did the opposite.

I omit the details. The best variant uses a DFS for the traversal
without any further "smart" tricks: These tricks led to more
"administrative expense" than gain of performance.

I'm sorry that it took so long to prepare the 2nd patchset (mainly
vacation and other work in between). So I hope it's sufficiently
good for inclusion. :)

Cheers

 1. https://www.mail-archive.com/git@vger.kernel.org/msg86353.html


Stephan Beyer (21):
  bisect: write about `bisect next` in documentation
  bisect: allow 'bisect run' if no good commit is known
  t/test-lib-functions.sh: generalize test_cmp_rev
  t: use test_cmp_rev() where appropriate
  t6030: generalize test to not rely on current implementation
  bisect: add test for the bisect algorithm
  bisect: plug the biggest memory leak
  bisect: make bisect compile if DEBUG_BISECT is set
  bisect: make algorithm behavior independent of DEBUG_BISECT
  bisect: get rid of recursion in count_distance()
  bisect: use struct node_data array instead of int array
  bisect: replace clear_distance() by unique markers
  bisect: use commit instead of commit list as arguments when
    appropriate
  bisect: extract get_distance() function from code duplication
  bisect: introduce distance_direction()
  bisect: make total number of commits global
  bisect: rename count_distance() to compute_weight()
  bisect: prepare for different algorithms based on find_all
  bisect: use a bottom-up traversal to find relevant weights
  bisect: compute best bisection in compute_relevant_weights()
  bisect: get back halfway shortcut

 Documentation/git-bisect.txt              |  24 ++
 bisect.c                                  | 481 ++++++++++++++++++++----------
 git-bisect.sh                             |  32 +-
 t/t2012-checkout-last.sh                  |   8 +-
 t/t3308-notes-merge.sh                    |   8 +-
 t/t3310-notes-merge-manual-resolve.sh     |   8 +-
 t/t3311-notes-merge-fanout.sh             |   6 +-
 t/t3404-rebase-interactive.sh             |  38 +--
 t/t3407-rebase-abort.sh                   |   8 +-
 t/t3410-rebase-preserve-dropped-merges.sh |   4 +-
 t/t3411-rebase-preserve-around-merges.sh  |  10 +-
 t/t3414-rebase-preserve-onto.sh           |  12 +-
 t/t3501-revert-cherry-pick.sh             |   4 +-
 t/t3506-cherry-pick-ff.sh                 |   6 +-
 t/t3903-stash.sh                          |   6 +-
 t/t4150-am.sh                             |  18 +-
 t/t5404-tracking-branches.sh              |   2 +-
 t/t5505-remote.sh                         |   4 +-
 t/t5520-pull.sh                           |  36 +--
 t/t6022-merge-rename.sh                   |   2 +-
 t/t6030-bisect-porcelain.sh               | 228 +++++++-------
 t/t6036-recursive-corner-cases.sh         |  58 ++--
 t/t6042-merge-rename-corner-cases.sh      |  50 ++--
 t/t7003-filter-branch.sh                  |   8 +-
 t/t7004-tag.sh                            |   2 +-
 t/t7110-reset-merge.sh                    |  24 +-
 t/t7201-co.sh                             |  12 +-
 t/t7601-merge-pull-config.sh              |  17 +-
 t/t7603-merge-reduce-heads.sh             |  30 +-
 t/t7605-merge-resolve.sh                  |   5 +-
 t/t8010-bisect-algorithm.sh               | 155 ++++++++++
 t/t9162-git-svn-dcommit-interactive.sh    |   8 +-
 t/t9300-fast-import.sh                    |  12 +-
 t/test-lib-functions.sh                   |  14 +-
 34 files changed, 832 insertions(+), 508 deletions(-)
 create mode 100755 t/t8010-bisect-algorithm.sh

-- 
2.8.1.137.g522756c
