From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 06/11] t9903: move PS1 color code variable definitions to lib-bash.sh
Date: Wed,  4 Jun 2014 17:01:22 -0400
Message-ID: <1401915687-8602-7-git-send-email-rhansen@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
 <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:02:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsIK4-0005VM-CU
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 23:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbaFDVBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 17:01:54 -0400
Received: from smtp.bbn.com ([128.33.1.81]:26192 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbaFDVBu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 17:01:50 -0400
Received: from socket.bbn.com ([192.1.120.102]:36568)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsIJt-000DMb-A7; Wed, 04 Jun 2014 17:02:01 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 6A5C23FFFC
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1401915687-8602-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250786>

Define a new 'set_ps1_format_vars' function in lib-bash.sh that sets
the c_red, c_green, c_lblue, and c_clear variables.  Call this
function from run_pcmode_tests().  This is a step toward moving the
shell prompt tests to a separate library file so that they can be
reused to test prompting in Zsh.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/lib-bash.sh          | 6 ++++++
 t/t9903-bash-prompt.sh | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index a0f4e16..9d428bd 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -18,5 +18,11 @@ shellname=Bash
 
 ps1_expansion_enable () { shopt -s promptvars; }
 ps1_expansion_disable () { shopt -u promptvars; }
+set_ps1_format_vars () {
+	c_red='\\[\\e[31m\\]'
+	c_green='\\[\\e[32m\\]'
+	c_lblue='\\[\\e[1;34m\\]'
+	c_clear='\\[\\e[0m\\]'
+}
 
 . ./test-lib.sh
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 27135a1..fe60cf9 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -10,10 +10,7 @@ test_description='test git-specific bash prompt functions'
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
-c_red='\\[\\e[31m\\]'
-c_green='\\[\\e[32m\\]'
-c_lblue='\\[\\e[1;34m\\]'
-c_clear='\\[\\e[0m\\]'
+set_ps1_format_vars
 
 test_expect_success "setup for $shellname prompt tests" '
 	git init otherrepo &&
-- 
2.0.0
