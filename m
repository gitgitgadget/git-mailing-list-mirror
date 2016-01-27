From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 17/20] mingw: avoid illegal filename in t9118
Date: Wed, 27 Jan 2016 17:20:11 +0100 (CET)
Message-ID: <e691d638d1099e1146a4550034c925983a2caecc.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpe-0002ul-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933679AbcA0QUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:59342 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934018AbcA0QUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:19 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MVui8-1aZMvM3MgC-00X76l; Wed, 27 Jan 2016 17:20:12
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:GX8R9sV7h5Ba0GG9YQJqgp/TSKtmUaMTe2WJmyMNT4ebZHtTMUQ
 hqoElOkNxoPl4mvtHHfRXf7+XyT5rVUwKxJie9vzHtYtBLx+Zn1VX+CXQRNY4MmSWlopp90
 LkcciZGC1otoFE5UuRpljTq5G1Fy8FzpTNid+VaRenf3sbtv7ZqWptmOXrLfTLY7E01QD9K
 KhT1MWcZ1tIAMMqTBtpbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cAxyx9PdD1o=:tJCddb7huJYEwSKaKudNND
 X+Sv+pQ+v9sy0nFYKBUvUL96JYpzp5F4xYM1So3TXpPMSSl1Mq2kRiuAOtJoUv6GXoYRawrVZ
 5BOsH9NonytZdBN/qjURdq+Et4sXC3cBpJylMpyhIO5/zFPH1bJkNTuE4u9l2z5pHO5NUp8aj
 MWKrbmtornnqtIiGoCW8jsX3WhSGaCrJmifmCMQWthLhAKf5dOS7Ctpv0Etq9xQVidbg/QiBS
 bhMDrBqZzVskiZJPPe2PRdKd4OzVKvykkTdXFm7qYPtnF7MsvE+NEPpQ5zVj4EYLn0kWGxKUF
 Y6aZAumjeTeP9gSio4LSCtBR6kHuDJXQTDr5fteOdozH73ebAxWeQeZf64BNwlH3EMACt4c2E
 pPIUeVno2vuyTEJcvLzgdaimMPB0Oa8+ckQ1aMKiJvpgkozXacfB6x49tAdlrFbcMlXLKjgLn
 1YQO7U1nhkotYLK2uOJy3AcYmo3Q1opvA60HpkX1XB5vQw67rkSTv2A7OdqoytYl5RDDAgpP9
 JO/17alxkqiMso66qTv6/zUDe5O+9F6nTOvsUXYOejSxarAaWy8yv9TfK5TW/UXoICyNMcg+n
 oy0uBJYIWGkIfpes7c4jHEAkN0ugDYmtxSWlB9Dwb1B+AJYmuYmmxM2k4BTHv2bxeaxVWbdlt
 OQLmu2Wg+P/cY89eI4v/vW/ekfm33eYx4FwDDh25sTSPQhvU6jir/wbP/5KNIz3vs6287Qoro
 aoy1o4FtEA10+Q854H5xMzFizVrxFZznE73neIhzbQPYs8FfqiwDbLBGWhyj4B010nS+6SSi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284934>

On Windows' file systems, file names with trailing dots are forbidden.
The POSIX emulation layer used by Git for Windows' Subversion emulates
those file names, therefore the test adding the file would actually
succeed, but when we would ask git.exe (which does not leverage the
POSIX emulation layer) to check out the tree, it would fail.

Let's just guard the test using a filename that is illegal on Windows
by the MINGW prereq.

This lets t9118-git-svn-funky-branch-names.sh pass in Git for Windows'
SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9118-git-svn-funky-branch-names.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index a221915..ecb1fed 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -23,8 +23,11 @@ test_expect_success 'setup svnrepo' '
 	              "$svnrepo/pr ject/branches/$scary_uri" &&
 	svn_cmd cp -m "leading dot" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/.leading_dot" &&
-	svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
-			"$svnrepo/pr ject/branches/trailing_dot." &&
+	if test_have_prereq !MINGW
+	then
+		svn_cmd cp -m "trailing dot" "$svnrepo/pr ject/trunk" \
+			"$svnrepo/pr ject/branches/trailing_dot."
+	fi &&
 	svn_cmd cp -m "trailing .lock" "$svnrepo/pr ject/trunk" \
 			"$svnrepo/pr ject/branches/trailing_dotlock.lock" &&
 	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
@@ -45,7 +48,10 @@ test_expect_success 'test clone with funky branch names' '
 		git rev-parse "refs/remotes/origin/more%20fun%20plugin!" &&
 		git rev-parse "refs/remotes/origin/$scary_ref" &&
 		git rev-parse "refs/remotes/origin/%2Eleading_dot" &&
-		git rev-parse "refs/remotes/origin/trailing_dot%2E" &&
+		if test_have_prereq !MINGW
+		then
+			git rev-parse "refs/remotes/origin/trailing_dot%2E"
+		fi &&
 		git rev-parse "refs/remotes/origin/trailing_dotlock%2Elock" &&
 		git rev-parse "refs/remotes/origin/$non_reflog"
 	)
-- 
2.7.0.windows.1.7.g55a05c8
