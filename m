From: Uwe Storbeck <uwe@ibr.ch>
Subject: [PATCH v3] test-lib.sh: do not "echo" externally supplied strings
Date: Tue, 18 Mar 2014 01:14:11 +0100
Message-ID: <20140318001410.GA4813@ibr.ch>
References: <20140314235735.GA6959@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 18 01:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPhfd-0002iN-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 01:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaCRAON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 20:14:13 -0400
Received: from gate.ibr.ch ([83.150.36.130]:56719 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751144AbaCRAOM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 20:14:12 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 924BB17F5F
	for <git@vger.kernel.org>; Tue, 18 Mar 2014 01:14:11 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP id AA12D153F6
	for <git@vger.kernel.org>; Tue, 18 Mar 2014 01:14:10 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 193F8D0895; Tue, 18 Mar 2014 01:14:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140314235735.GA6959@ibr.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244315>

In some places we "echo" a string that is supplied by the calling
test script and may contain backslash sequences. The echo command
of some shells, most notably "dash", interprets these backslash
sequences (POSIX.1 allows this) which may scramble the test
output.

Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
---

Commit message rewritten to avoid title continuation in the body.
Thanks Junio C Hamano for the hint.

 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1531c24..3c7cb1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -277,7 +277,7 @@ error "Test script did not set test_description."
 
 if test "$help" = "t"
 then
-	echo "$test_description"
+	printf '%s\n' "$test_description"
 	exit 0
 fi
 
@@ -328,7 +328,7 @@ test_failure_ () {
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
-	echo "$@" | sed -e 's/^/#	/'
+	printf '%s\n' "$*" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
 }
 
-- 
1.9.0
