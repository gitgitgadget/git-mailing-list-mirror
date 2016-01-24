From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 11/19] tests: turn off git-daemon tests if FIFOs are not
 available
Date: Sun, 24 Jan 2016 16:44:59 +0100 (CET)
Message-ID: <71da2899ad82f527297a91d5362e6c38f10635cf.1453650173.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMqk-0001Fz-V8
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbcAXPpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:45:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:61853 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717AbcAXPpD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:45:03 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MLNpK-1aNv4r3hcw-000aZi; Sun, 24 Jan 2016 16:44:59
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453650173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:AKsS+JDemFvmvvDc6sPFnpm+mVcFaB6MMYekBFjFWyw3zN90Qzt
 BPPQM5HSxyqkl7c77VSctMC4lcDQsvrfpHPyvDDoBO3zjdl49xr72oB0qLw+pIAB52cpe6I
 BeqJu7yHCyyOhLKEDirQqxt0nskqslFADZ3BXse2aSFkcwHHuav1xIFInb/amysLISz91OT
 1uHPe1/g/H7rWDO9Cn+ow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:srD6B+ldAJ8=:OcqaUmWqHVIifMRLNZjTFW
 M9OKZOmhTRxsvsRMwpZPGdvdy908NZcBM4p7tFmjg7SAysbjr9rQtHnAJxww0uHq5Qc+NdyEF
 lGQ9njGNNZb+sCE9dc+dWQrkgUL/ofNIYgwgy41J3LUKJe6qc6Ovj8PmNwvg+b1Ug80ia4EyI
 fjjAOOSAR3MkpapJQqGsvPbez4/nVfMmJx6VX6YbJyhr/by5zyw/xyRJEyMmJCXkaIHzjnYSj
 99DRYa0t0Aua19YtBRfB0gOTOYIlyEQMEhZIxSpzQK+X73KnPRNnwrYaWHuZx6hy5M0kWxmUv
 KbW5e1VhvXwEy0xddpL8zk67s5H8xq53pxFK8XtYnS7M7vvzA9jdFxEKBDPfDOZTVhg5OliLH
 t/QL44EqbgjaW+Dpxl31XUlDFfpAmXzYkJeKM4M1O7FxWb4mI7gXgvyGlm9Ptlw98i8D6Dk3I
 2yBtEZ6Qc95zFY2fKbtR22eiXnUpAm+gFhpmel+lO7kd1LBEVfEiONq4zL68NpTDCJkSkS5J8
 +C/df153XHoEUMt2hhPG6k6ZWtQ4Hn3nnC8PYn/sDiAqY5FsbqxoJBosGwCfEMrUgukjsNeRe
 BckwCCitf0ZwP8T19K32dEKqRDZU+rmESG3ILwbu7+Jr/bz3xbvy8GQ2ielSQWE0gJJ2jsABD
 VtNgBzOCQCKq8+BonDElwOdavztnFz7r9w2sTv3fnocLegtFgcwf4YHIyRii3D4JmPa5wMScd
 MhDZwqQl4Uq+GpiRzxZTE5Guq0BLx7fr8b+m1UbY1x9cpmOksp+ELt0phQejkkk5PGvndUqA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284676>

The Git daemon tests create a FIFO first thing and will hang if said
FIFO is not available.

This is a problem with Git for Windows, where `mkfifo` is an MSYS2
program that leverages MSYS2's POSIX emulation layer, but
`git-daemon.exe` is a MINGW program that has not the first clue about
that POSIX emulation layer and therefore blinks twice when it sees
MSYS2's emulated FIFOs and then just stares into space.

This lets t5570-git-daemon.sh and t5811-proto-disable-git.sh pass.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-git-daemon.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index bc4b341..9b1271c 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -23,6 +23,11 @@ then
 	test_done
 fi
 
+if ! test_have_prereq PIPE
+then
+	test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
+fi
+
 LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
 
 GIT_DAEMON_PID=
-- 
2.7.0.windows.1.7.g55a05c8
