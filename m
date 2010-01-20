From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/2] Allow to override mergetool.prompt with $GIT_MERGETOOL*_PROMPT
Date: Wed, 20 Jan 2010 16:30:26 +0100
Message-ID: <4B572192.2020606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: davvid@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 16:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXcWh-0007L3-Vr
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 16:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab0ATPbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 10:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191Ab0ATPbO
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 10:31:14 -0500
Received: from lo.gmane.org ([80.91.229.12]:34798 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab0ATPbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 10:31:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXcWM-00077z-3v
	for git@vger.kernel.org; Wed, 20 Jan 2010 16:31:02 +0100
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 16:31:02 +0100
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 16:31:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137552>

This is for symmetry with git-difftool, and to make should_prompt_merge ()
reusable from within git-difftool--helper.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-mergetool--lib.sh |    9 +++++++++
 git-mergetool.sh      |    3 ++-
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 5b62785..16b0343 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -7,6 +7,15 @@ merge_mode() {
 	test "$TOOL_MODE" = merge
 }
 
+should_prompt_merge () {
+	local prompt=$(git config --bool mergetool.prompt || echo true)
+	if test "$prompt" = true; then
+		test -z "$GIT_MERGETOOL_NO_PROMPT"
+	else
+		test -n "$GIT_MERGETOOL_PROMPT"
+	fi
+}
+
 translate_merge_tool_path () {
 	case "$1" in
 	vimdiff)
diff --git a/git-mergetool.sh b/git-mergetool.sh
index b52a741..d453cb0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -202,7 +202,8 @@ merge_file () {
     return 0
 }
 
-prompt=$(git config --bool mergetool.prompt || echo true)
+should_prompt_merge
+prompt=$?
 
 while test $# != 0
 do
-- 
1.6.5.1.1373.g71d1
