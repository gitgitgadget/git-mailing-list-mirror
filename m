From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Mon, 26 Oct 2015 14:15:15 +0100 (CET)
Message-ID: <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqhcV-0000wS-1K
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbbJZNPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:59424 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbbJZNPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:19 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0M936L-1ZeqZk03PJ-00CNuM;
 Mon, 26 Oct 2015 14:15:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:a2IuonvNBLQXTTLjQJRotVUga8Fo6sEPe0YUcNeNeCuaXEhkoth
 n9CpXopJxVGs/fpa2bS5xAx3rzTrAhmlSHKmSnLTi2HXqRPMPHkGUKBeJtiNgVFb/QJHuMq
 RCOm+TAFXUCqujj9Wcf2Zcl2D++Ix9df62R5a4DIdaWzwN2njFmUaxuM02i6TXjAM+wzsFe
 SgdMU8wLoaLQfNeo6a6rA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sKVjvnF/89I=:0ejQABZh7JY/1y9Bbb89Ro
 tyAgHrUrzbYV3xRxd+vkJEzy72ei6fUjhekzWBmRtRhFy5QQHleVZItWnzLhMI488K12Vjz5Q
 AC34gQJ6sU4D3bAxpRWhV32iCQmYKDoSwM2gpGUHUFG0Jb89zUYMToWwxCZ1SzO/FvZL2mSED
 HlFGPN9LLo81yHalZbzwbaqzoR4ByIlYbflvmxA9//9/PRSaO9u0uX9X/f/XFWU3sNr2hnRUY
 XwzfBTsu3EzAgvh6kpJClh1KCC0FdYWwNxDrtz9gIB9nFOHGzVyx57oKt8qGOJuv6X3rgSLdw
 9PL/v5zMAOCzghYBkTtRzo0pEX/QjTi1iXYYkqlLh1YoFgiXLpgqKbTcegx0ok3/5o9l2bwlX
 tezRhhlQltL/uELx+orA1bgnlEfUse3RtABNsisWgQ8FhMuirx29ZCoptbEjmIcflcsG5a0pP
 mejD8aTAJFFFQXBXb+QqolFg4w9jMinF5SKidn/F1/OPf5PHvLnSlIlvxi8Lk8kOZQ9I49tTE
 HGUhvVpFNyrWKkqPn3f26viL3bqi0PxWuvSLzhcXbX81UvxcNfQOSfJqw0JP6LKFdM0RRsKyU
 G3Rs86EBHhZG4OmDKG9Xf7E0zMP/P6SeoGzw3blm/O7oiFWkTnMguh1jhF3hRRPdzFK7iCl7O
 XqYCf9OXzgmjpBVG1M8SEZ8yow0PA+OTn5Swkht3tvm/f0jQDhjGtQoqFQTxtz76cyFOT1/lx
 T0dXj6OZ/vkiPPta+uy4IL95pSGs9AZUaYDhqQxP3MxxzA5stY/jWk9mAF5B6CfMk15Uae2d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280192>

When prefixing a Git call in the test suite with 'TEST_GDB_GIT=1 ', it
will now be run with GDB, allowing the developer to debug test failures
more conveniently.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wrap-for-bin.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 701d233..a151c95 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -19,4 +19,11 @@ GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
+if test -n "$TEST_GDB_GIT"
+then
+	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	echo "Could not run gdb -args ${GIT_EXEC_PATH}/@@PROG@@ $*" >&2
+	exit 1
+fi
+
 exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-- 
2.1.4
