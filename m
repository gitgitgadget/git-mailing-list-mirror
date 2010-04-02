From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 6/6] whitespace: tests for git-apply --whitespace=fix with
 tab-in-indent
Date: Sat, 3 Apr 2010 00:37:37 +0100
Message-ID: <0efb5aca7f738403283ec97ad53c645d8f7240eb.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqRL-0005Es-9e
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab0DBXhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:42 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39401 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0DBXhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:39 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQj-0004y1-N0; Sat, 03 Apr 2010 00:37:38 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143867>

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 t/t4124-apply-ws-rule.sh |   53 +++++++++++++++++++++++++--------------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index fb9ad24..8d46df6 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -11,21 +11,22 @@ prepare_test_file () {
 	#   	!  trailing-space
 	#   	@  space-before-tab
 	#   	#  indent-with-non-tab
+	#   	%  tab-in-indent
 	sed -e "s/_/ /g" -e "s/>/	/" <<-\EOF
 		An_SP in an ordinary line>and a HT.
-		>A HT.
-		_>A SP and a HT (@).
-		_>_A SP, a HT and a SP (@).
+		>A HT (%).
+		_>A SP and a HT (@%).
+		_>_A SP, a HT and a SP (@%).
 		_______Seven SP.
 		________Eight SP (#).
-		_______>Seven SP and a HT (@).
-		________>Eight SP and a HT (@#).
-		_______>_Seven SP, a HT and a SP (@).
-		________>_Eight SP, a HT and a SP (@#).
+		_______>Seven SP and a HT (@%).
+		________>Eight SP and a HT (@#%).
+		_______>_Seven SP, a HT and a SP (@%).
+		________>_Eight SP, a HT and a SP (@#%).
 		_______________Fifteen SP (#).
-		_______________>Fifteen SP and a HT (@#).
+		_______________>Fifteen SP and a HT (@#%).
 		________________Sixteen SP (#).
-		________________>Sixteen SP and a HT (@#).
+		________________>Sixteen SP and a HT (@#%).
 		_____a__Five SP, a non WS, two SP.
 		A line with a (!) trailing SP_
 		A line with a (!) trailing HT>
@@ -39,7 +40,6 @@ apply_patch () {
 }
 
 test_fix () {
-
 	# fix should not barf
 	apply_patch --whitespace=fix || return 1
 
@@ -130,20 +130,25 @@ do
 		for i in - ''
 		do
 			case "$i" in '') ti='#' ;; *) ti= ;; esac
-			rule=${t}trailing,${s}space,${i}indent
-
-			rm -f .gitattributes
-			test_expect_success "rule=$rule" '
-				git config core.whitespace "$rule" &&
-				test_fix "$tt$ts$ti"
-			'
-
-			test_expect_success "rule=$rule (attributes)" '
-				git config --unset core.whitespace &&
-				echo "target whitespace=$rule" >.gitattributes &&
-				test_fix "$tt$ts$ti"
-			'
-
+			for h in - ''
+			do
+				[ -z "$h$i" ] && continue
+				case "$h" in '') th='%' ;; *) th= ;; esac
+				rule=${t}trailing,${s}space,${i}indent,${h}tab
+
+				rm -f .gitattributes
+				test_expect_success "rule=$rule" '
+					git config core.whitespace "$rule" &&
+					test_fix "$tt$ts$ti$th"
+				'
+
+				test_expect_success "rule=$rule (attributes)" '
+					git config --unset core.whitespace &&
+					echo "target whitespace=$rule" >.gitattributes &&
+					test_fix "$tt$ts$ti$th"
+				'
+
+			done
 		done
 	done
 done
-- 
1.7.0.3
