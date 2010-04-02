From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 3/6] whitespace: tests for git-diff --check with
 tab-in-indent error class
Date: Sat, 3 Apr 2010 00:37:15 +0100
Message-ID: <7a8a7a4054abc1f478c1d0faf025b033c598e812.1270250437.git.chris@arachsys.com>
References: <cover.1270250437.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 01:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxqQp-00051w-4l
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 01:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab0DBXhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 19:37:21 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:39390 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab0DBXhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 19:37:16 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxqQN-0004wO-J5; Sat, 03 Apr 2010 00:37:15 +0100
Content-Disposition: inline
In-Reply-To: <cover.1270250437.git.chris@arachsys.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143864>

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 t/t4015-diff-whitespace.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 90f3342..9e57f80 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -352,6 +352,48 @@ test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab:
 
 '
 
+test_expect_success 'check tabs as indentation (tab-in-indent: off)' '
+
+	git config core.whitespace "-tab-in-indent"
+	echo "	foo ();" > x &&
+	git diff --check
+
+'
+
+test_expect_success 'check tabs as indentation (tab-in-indent: on)' '
+
+	git config core.whitespace "tab-in-indent" &&
+	echo "	foo ();" > x &&
+	test_must_fail git diff --check
+
+'
+
+test_expect_success 'check tabs and spaces as indentation (tab-in-indent: on)' '
+
+	git config core.whitespace "tab-in-indent" &&
+	echo "	                foo ();" > x &&
+	test_must_fail git diff --check
+
+'
+
+test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
+
+	git config core.whitespace "tab-in-indent,indent-with-non-tab"
+	echo "foo ();" > x &&
+	test_must_fail git diff --check
+
+'
+
+test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
+
+	git config --unset core.whitespace
+	echo "x whitespace" > .gitattributes &&
+	echo "	  foo ();" > x &&
+	git diff --check &&
+	rm -f .gitattributes
+
+'
+
 test_expect_success 'line numbers in --check output are correct' '
 
 	echo "" > x &&
-- 
1.7.0.3
