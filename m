From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 12/20] mingw: skip test in t1508 that fails due to path
 conversion
Date: Wed, 27 Jan 2016 17:19:52 +0100 (CET)
Message-ID: <a5809c91c0afb70955a70c9d2371c15ba6c79c39.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpM-0002e1-It
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938AbcA0QUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:58532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbcA0QTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:55 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvzF3-1a1PDo0RAb-017pLx; Wed, 27 Jan 2016 17:19:53
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gZIZLeewdgibMMfeTVRfjPsAVKPx1xhVftGL1dY9qfgBigVTyg6
 Rm4GlOV1AaCrM0mHmwMREaGanm7s+ZcTECSlQ8rZgfwD0dtcwd1rbxJ8SP0MP8fCY8K30Ds
 8ERXq2m1kgqyuOMxbPts/9yULDn7GaeZD05oD2uRkYaAW+3wR3MnyJuAv+D2rsmctZ1XdBY
 XkglRtvVjf5IOqkdfz7Tg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mChx07pq27I=:nBXu8sh5Sj00QpImm7KLJ5
 xmMsdWykIpkcikA9itPqi9gbMqdc9sUdKsU4gdhqKf74Nmp9nxjdXa3HsjaSSc8L8FGynV9/H
 fNafYKOR9uE1TllQfhXw2RJvDrUYf0Cl4a+S00mCEfieGzInj6ENG/fwqnKghKyR+l+A7MS6h
 rzTDDkX8iIXoXJoWOFvvZBxOGh+g2dDTjMU2/HYH1YtrYj2Q+xM6G4BFNWri5uGw4B8NN/An7
 EAtK1Ep4GpHv57NK1T/o0ZaIRA4WoLJF2BszKz7GhmufrsPwtak2Ohn6Z91FuU2+yUqG9h2BJ
 FK+dKmSTrwI6vBshqMGcOMMmHSXEPzs3g8S8LCFzsBhTH/wZxsFLLZtW2EkagfWrX+xPG1knV
 itEEscuIvXKNiuvf+LVYNMPfozZhUWaV+TNJeJ2hYKykntjpEYPnHjZ91je0Iqt14o0Xr9XM+
 ggY+ScMtNN0wjLpJvvnmXLYWHE85Kw/ZtqikI2UoQTwaTgfoV59FGdXQAdCmpiuXGHgKxn8Xc
 SYb+IZSuyxGP1tZN9ys3OXnZH0jo0H3SLUIYkz/ydJJ7tjis8banPXWyiq3vUPzlIAE9iM06z
 bt2ViVmKAdfdyOkPWcmZyioOquaRtbn3le3sAPdNdgR1iRPpM7B7PGBvmGBg4/uv2caGIRy34
 5pI3kl09+DzNMojJVf583uMWlib3gi2cZFJddJd0kgVKPq6AKwoR/JmWATcjXXtmmPYdjOFOQ
 z1UhDeEhj5y6minoYxrZiYkISB66Udkf7pjnaiv5vTxCYbUDf+QMFVwptWqHxCXzxQ6Drmeg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284931>

In Git for Windows, the MSYS2 POSIX emulation layer used by the Bash
converts command-line arguments that looks like they refer to a POSIX
path containing a file list (i.e. @<absolute-path>) into a Windows path
equivalent when calling non-MSYS2 executables, such as git.exe.

Let's just skip the test that uses the parameter `@/at-test` that
confuses the MSYS2 runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1508-at-combinations.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 078e119..4a9964e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -35,7 +35,10 @@ test_expect_success 'setup' '
 	git checkout -b upstream-branch &&
 	test_commit upstream-one &&
 	test_commit upstream-two &&
-	git checkout -b @/at-test &&
+	if test_have_prereq !MINGW
+	then
+		git checkout -b @/at-test
+	fi &&
 	git checkout -b @@/at-test &&
 	git checkout -b @at-test &&
 	git checkout -b old-branch &&
@@ -64,6 +67,7 @@ check "@{-1}@{u}@{1}" commit master-one
 check "@" commit new-two
 check "@@{u}" ref refs/heads/upstream-branch
 check "@@/at-test" ref refs/heads/@@/at-test
+test_have_prereq MINGW ||
 check "@/at-test" ref refs/heads/@/at-test
 check "@at-test" ref refs/heads/@at-test
 nonsense "@{u}@{-1}"
-- 
2.7.0.windows.1.7.g55a05c8
