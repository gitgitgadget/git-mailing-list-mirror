From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 11/20] tests: turn off git-daemon tests if FIFOs are not
 available
Date: Wed, 27 Jan 2016 17:19:48 +0100 (CET)
Message-ID: <35b05b7e0d01bf550b698d3c6ecc577eb80d4149.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSp5-0002OW-Vo
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933965AbcA0QT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:56 -0500
Received: from mout.gmx.net ([212.227.17.22]:55445 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933818AbcA0QTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LxcbX-1a0rGA0og7-017Dew; Wed, 27 Jan 2016 17:19:49
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:IghgtyXNwTJw/478shDqGR5t6pcK0VLWrEWv9gFGbw0Fz9O6M/b
 blCA1PRcFbh8ZX0O2sLrGbK0by9iaD9tC9PeOP6fZJrQib0zCyHVI73Fug+nQMvkbsje27n
 jiGBMPxxNGQHoXAnqmk9jhcsTiGNqDruWJUBJdqPYw+5QqV0OV4T4aQYqYn6GmjCuhdz5wx
 ZtXUc8vDr5246dPEbmQEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GgNO0kCKlRY=:b8yamowuBtQMJUf1r7rBKq
 HYAwHRRBE40Za/EbyPloGuLiKrR+CI+gp9bXZ3nQ/3YgD8xIeJyzVXmk8PzU+Xlr0s52tCt+q
 uAdI4X6pDaqMHURRd+OpnOAI+fOj7BMmkp9WmhK4ExEe+nsUjPWivhiJ6x1u0gh9kMvyvmZKC
 jZQTnA769W9mvLtb5MGR73sLCo9xqfysNER7kHMNY/70q4b5TB6x4a5zwH9I0GtXq+2KToBQQ
 wz+AWRqRUh//LvIXb8OMFUbo9ZdTZKJhTIjamhQXjgXS9He3JO5WeEFaCaX2cdH4dlF3vaV56
 ecgN2ujgbRGp6xml1Aa9Phseg8kaEiR840tvK3ePJcOd5+lrKJ+KGHC+dYeYrXhNCt6Jhllq5
 8g2aq3p4D751JDd7s/AqGFzv6fdaRnQKdFJguIFL9TbcNImgjXt0rdlMPk4NkXJ+qLyx3vJxD
 3QjaHP2Q4LzwwIwJx0vnrrDENk6KYLfuSuUGT6na13KBslcL3xKkTUst1xyRsfQNPIo7DvOP+
 nadTmO+Ax5PU557b5enL0tLw8X21913HcYi8mzeKCfFwPNtaBoyLjXT/ozFd21B4rXqWQh8SS
 P27FILt5lwDUFbNLQGDBWEl2AtSu3G2F0N9i6qJPyY80soqEHSFnrth7WBiNOOjmOCBgyXMG6
 pCtlR4rqniGSX6i3bzmyvD3/YaiWudJrq8WopKMM0l1oIw5wAOceN8M7PRwTWbIq/0d5D3R0P
 Od8SkHyxsIExD4Yh+YcGY5PPakygBzbN14VuenvnI79mjjYu/v2RrZZQD9qveI7HgqSTlMkX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284928>

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
