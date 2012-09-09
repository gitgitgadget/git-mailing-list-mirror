From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 9/8] t0060: split absolute path test in two to exercise some
 of it on Windows
Date: Sun, 09 Sep 2012 17:42:20 +0200
Message-ID: <504CB8DC.90202@kdbg.org>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 17:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAjeb-0001cn-9B
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 17:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab2IIPmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 11:42:25 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:13989 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753255Ab2IIPmY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 11:42:24 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3CEEBCDF87;
	Sun,  9 Sep 2012 17:42:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205083>

Only the first half of the test works only on POSIX, the second half
passes on Windows as well.

A later test "real path removes other extra slashes" looks very similar,
but it does not make sense to split it in the same way: When two slashes
are prepended in front of an absolute DOS-style path on Windows, the
meaning of the path is changed (//server/share style), so that the test
cannot pass on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 The series passes for me as is, but one test needs POSIX only in
 the first half. This patch splits it in two.

 t/t0060-path-utils.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index e40f764..4ef2345 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -148,10 +148,14 @@ test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-test_expect_success POSIX 'real path works on absolute paths' '
+test_expect_success POSIX 'real path works on absolute paths 1' '
 	nopath="hopefully-absent-path" &&
 	test "/" = "$(test-path-utils real_path "/")" &&
-	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
+	test "/$nopath" = "$(test-path-utils real_path "/$nopath")"
+'
+
+test_expect_success 'real path works on absolute paths 2' '
+	nopath="hopefully-absent-path" &&
 	# Find an existing top-level directory for the remaining tests:
 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
 	test "$d" = "$(test-path-utils real_path "$d")" &&
-- 
1.7.12.1493.g247bc0e
