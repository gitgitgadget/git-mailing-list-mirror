From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 02/10] t9903: put the Bash pc mode prompt test cases in a function
Date: Tue, 27 May 2014 03:40:52 -0400
Message-ID: <1401176460-31564-3-git-send-email-rhansen@bbn.com>
References: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
 <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Cc: rhansen@bbn.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 09:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpC17-0003lX-SE
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 09:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaE0Hlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 03:41:39 -0400
Received: from smtp.bbn.com ([128.33.0.80]:35807 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbaE0Hlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 03:41:31 -0400
Received: from socket.bbn.com ([192.1.120.102]:50699)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WpC0n-000PGy-Mc; Tue, 27 May 2014 03:41:29 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 59C1D40217
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1401176460-31564-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250151>

This is a step toward invoking the same pc mode test cases twice:
once with PS1 parameter expansion enabled and once with it disabled.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t9903-bash-prompt.sh | 236 +++++++++++++++++++++++++------------------------
 1 file changed, 120 insertions(+), 116 deletions(-)

diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 335383d..c691869 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -451,130 +451,134 @@ test_expect_success 'prompt - format string starting with dash' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - pc mode' '
-	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmaster" >expected &&
-	printf "" >expected_output &&
-	(
-		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
-		test_cmp expected_output "$actual" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+run_pcmode_tests () {
+	test_expect_success 'prompt - pc mode' '
+		printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\nmaster" >expected &&
+		printf "" >expected_output &&
+		(
+			__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
+			test_cmp expected_output "$actual" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - branch name' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
-	(
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" >"$actual"
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - branch name' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmaster" >expected &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" >"$actual"
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - detached head' '
-	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
-	git checkout b1^ &&
-	test_when_finished "git checkout master" &&
-	(
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - detached head' '
+		printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
+		git checkout b1^ &&
+		test_when_finished "git checkout master" &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmaster" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
-	echo "dirty index" >file &&
-	test_when_finished "git reset --hard" &&
-	git add -u &&
-	echo "dirty worktree" >file &&
-	(
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmaster" >expected &&
+		echo "dirty index" >file &&
+		test_when_finished "git reset --hard" &&
+		git add -u &&
+		echo "dirty worktree" >file &&
+		(
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		cd otherrepo &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmaster" >expected &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			cd otherrepo &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - inside .git directory' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
-	echo "dirty" >file &&
-	test_when_finished "git reset --hard" &&
-	(
-		GIT_PS1_SHOWDIRTYSTATE=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		cd .git &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - inside .git directory' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
+		echo "dirty" >file &&
+		test_when_finished "git reset --hard" &&
+		(
+			GIT_PS1_SHOWDIRTYSTATE=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			cd .git &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - stash status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
-	echo 2 >file &&
-	git stash &&
-	test_when_finished "git stash drop" &&
-	(
-		GIT_PS1_SHOWSTASHSTATE=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - stash status indicator' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmaster" >expected &&
+		echo 2 >file &&
+		git stash &&
+		test_when_finished "git stash drop" &&
+		(
+			GIT_PS1_SHOWSTASHSTATE=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
 
-test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
-	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
-	(
-		GIT_PS1_SHOWUNTRACKEDFILES=y &&
-		GIT_PS1_SHOWCOLORHINTS=y &&
-		__git_ps1 "BEFORE:" ":AFTER" &&
-		printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
-	) &&
-	test_cmp expected "$actual"
-'
+	test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
+		printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmaster" >expected &&
+		(
+			GIT_PS1_SHOWUNTRACKEDFILES=y &&
+			GIT_PS1_SHOWCOLORHINTS=y &&
+			__git_ps1 "BEFORE:" ":AFTER" &&
+			printf "%s\\n%s" "$PS1" "${__git_ps1_branch_name}" >"$actual"
+		) &&
+		test_cmp expected "$actual"
+	'
+}
+
+run_pcmode_tests
 
 test_done
-- 
1.9.3
