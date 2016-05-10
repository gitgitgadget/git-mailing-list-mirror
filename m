From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/3] perf: let's disable symlinks on Windows
Date: Tue, 10 May 2016 17:41:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605101738390.4092@virtualbox>
References: <cover.1462894344.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 17:42:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b09nf-000796-By
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 17:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbcEJPmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 11:42:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:54281 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbcEJPmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 11:42:11 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lr46Z-1bUpur3XsJ-00eadG; Tue, 10 May 2016 17:41:54
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462894344.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LhtX4LdJ4Z7PmgNtVtu3upoUjH6QBmolmiLPMf71pLvsoK9F8i/
 QxNOAwV+KEdzqAaLmtAChTCSzUoXFhUcvtcK5WFOOl5z6V5g8S/2kUWoeu4EoPQ9Y3Dpw49
 AJVc7pu6Q/BLajbq7w1sMsXy5udSvBjXBey7tgvhA1Nmdm0fTbtAWxDVMXW9ARP/eDFFz5/
 0Z6cIpWID1ppJQOavYkzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fXIrFra5aag=:/fwf5Vt8yX/jOTKT3VIQpv
 naQ5qUopngH43+f22ghnHsCJspI632qzpfigUhv5wI3uOPHfiH3niTZikNfLkLcvpOLEatcZl
 UVx7Wi30aTap+2LdFxrc5JS+tD2IfHk39kqNlTJyEMTx++D2PdOyw0CQmpJQ4NJHb5A19mpeT
 uZ6kdpGQPRKHd0wiRwwZN2LcG7GOgDgyXl2YZ19MnxxMy2yWJnrHKstqewaACAs8z40Akb7M+
 FyBxc+vtPDjDl0EJ6zqT7luFRbOAyfgd9FQESX/PTuXp5UsT5pbK9A1K4U6hB/TZ5iW42uAsp
 cOEhpIOhHJ++NvXldYkpXxUs4jNrC3uXbs6pvWLKB4gVc+uNi3XEW7ckFetLkcaNo3qJL8IXQ
 jPYI8KQwiOc8luT80vJZ161a9YrsN1Mxtlv7bvlkRMqXKy5MxE0oglJ1lDD4qgmpPQ9GWH7FB
 A/UXl4C2dSciliTjYZvjx+iuV1X8QNiPZ/2UoIZGQhrEJxy8cuTBEWbfbUypgQ9XFll2PaRKx
 6GsS5qeDwZ4F75/Gm7Wd2gcey48k3LFBiN8oiTZS9F2I9FhQ9UhXTg431p0goJerH3+L1w1Py
 qgiyZx8WC+vb0jwovANMIHHVUS23H34FqDfjyLlS1rmXyc3+HQoXqUV9YIKhweUWxEJOOehSY
 zqXufVIcjzBw8kQ9nyxBroDPrYJ1I9l6Gff2/64iT7ZqnCFU6cNN+EX6deOJ9eAwieW2V1y3Y
 OY/InI0K1VfeNtFa1EpRU67OATyhnffsL6EEYeOaC4yCiKp/WHyX3ILIPBK8Xmv/096zX2Fh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294151>

In Git for Windows' SDK, Git's source code is always checked out
with symlinks disabled. The reason is that POSIX symlinks have no
accurate equivalent on Windows [*1*]. More precisely, though, it is
not just Git's source code but *all* source code that is checked
out with symlinks disabled: core.symlinks is set to false in the
system-wide gitconfig.

Since the perf tests are run with the system-wide gitconfig *disabled*,
we have to make sure that the Git repository is initialized correctly
by configuring core.symlinks explicitly.

Footnote *1*:
https://github.com/git-for-windows/git/wiki/Symbolic-Links

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/perf/perf-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5cf74ed..e9020d0 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -97,6 +97,10 @@ test_perf_create_repo_from () {
 		done &&
 		cd .. &&
 		git init -q &&
+		if test_have_prereq MINGW
+		then
+			git config core.symlinks false
+		fi &&
 		mv .git/hooks .git/hooks-disabled 2>/dev/null
 	) || error "failed to copy repository '$source' to '$repo'"
 }
-- 
2.8.2.465.gb077790
