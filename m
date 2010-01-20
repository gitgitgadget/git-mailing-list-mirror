From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/2] Make difftool.prompt fall back to mergetool.prompt
Date: Wed, 20 Jan 2010 16:30:58 +0100
Message-ID: <4B5721B2.5050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 16:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXcaZ-0001Jn-0s
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 16:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423Ab0ATPfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 10:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510Ab0ATPfS
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 10:35:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:53853 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245Ab0ATPfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 10:35:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXcaH-000191-5k
	for git@vger.kernel.org; Wed, 20 Jan 2010 16:35:05 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 16:35:05 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 16:35:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137553>

The documentation states that "git-difftool falls back to git-mergetool
config variables when the difftool equivalents have not been defined".
Until now, this was not the case for "difftool.prompt".

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-difftool--helper.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 57e8e32..a7185b2 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -11,8 +11,9 @@ TOOL_MODE=diff
 
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
-should_prompt () {
-	prompt=$(git config --bool difftool.prompt || echo true)
+should_prompt_diff () {
+	local prompt_merge=$(should_prompt_merge && echo true || echo false)
+	local prompt=$(git config --bool difftool.prompt || echo $prompt_merge)
 	if test "$prompt" = true; then
 		test -z "$GIT_DIFFTOOL_NO_PROMPT"
 	else
@@ -33,7 +34,7 @@ launch_merge_tool () {
 
 	# $LOCAL and $REMOTE are temporary files so prompt
 	# the user with the real $MERGED name before launching $merge_tool.
-	if should_prompt; then
+	if should_prompt_diff; then
 		printf "\nViewing: '$MERGED'\n"
 		printf "Hit return to launch '%s': " "$merge_tool"
 		read ans
-- 
1.6.5.1.1373.g71d1
