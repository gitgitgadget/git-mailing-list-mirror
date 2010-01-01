From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 7/6] t0021: use $SHELL_PATH for the filter script
Date: Fri, 01 Jan 2010 23:14:06 +0100
Message-ID: <4B3E73AE.6050003@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230110335.GF22959@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 01 23:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQpoJ-0000lJ-H6
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 23:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037Ab0AAWRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 17:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949Ab0AAWRT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 17:17:19 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:53108 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751800Ab0AAWRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 17:17:18 -0500
Received: from [77.117.209.219] (77.117.209.219.wireless.dyn.drei.com [77.117.209.219])
	by bsmtp.bon.at (Postfix) with ESMTP id 7D902A7EAE;
	Fri,  1 Jan 2010 23:17:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091230110335.GF22959@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136014>

On Windows, we need the shbang line to correctly invoke shell scripts via
a POSIX shell, except when the script is invoked via 'sh -c' because
sh (a bash) does "the right thing". Since nowadays the clean and smudge
filters are not always invoked via 'sh -c' anymore, we have to mark the
the one in t0021-conversion with #!$SHELL_PATH.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  t/t0021-conversion.sh    |    3 ++-
  t/t4030-diff-textconv.sh |    6 ++++--
  2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 8fc39d7..6cb8d60 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,7 +4,8 @@ test_description='blob conversion via gitattributes'

  . ./test-lib.sh

-cat <<\EOF >rot13.sh
+cat <<EOF >rot13.sh
+#!$SHELL_PATH
  tr \
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
    'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index c16d538..3cb7e63 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -19,10 +19,12 @@ cat >expect.text <<'EOF'
  +1
  EOF

-cat >hexdump <<'EOF'
-#!/bin/sh
+{
+	echo "#!$SHELL_PATH"
+	cat <<'EOF'
  perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
  EOF
+} >hexdump
  chmod +x hexdump

  test_expect_success 'setup binary file with history' '
-- 
1.6.6.1073.gd853b.dirty
