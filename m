From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2] Add Code Compare v2.80.4 as a merge / diff tool for Windows
Date: Fri, 10 Aug 2012 10:21:06 +0200
Message-ID: <5024C472.50505@gmail.com>
References: <5022CC90.3060108@gmail.com> <7v1ujhrs7e.fsf@alter.siamese.dyndns.org> <CAHGBnuOaze=opbK+hH2s92enHuN2NUuKOVsTY4ZKgc3aWsX2-g@mail.gmail.com> <7vipcsoxwa.fsf@alter.siamese.dyndns.org> <CAHGBnuPT+ULpPtO_QxqUY8qxfbRT==fACQdM+TG2CyhbcKM-_w@mail.gmail.com> <CAJDDKr7uHXajcy-jLrg7PToh6cFH3wVYvuX8E7_tq+s2n+b+LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 10:21:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzkTK-00077n-11
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 10:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022Ab2HJIVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 04:21:24 -0400
Received: from plane.gmane.org ([80.91.229.3]:59100 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757952Ab2HJIVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 04:21:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SzkT2-0006cK-Hb
	for git@vger.kernel.org; Fri, 10 Aug 2012 10:21:14 +0200
Received: from 192.100.123.82 ([192.100.123.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 10:21:12 +0200
Received: from sschuberth by 192.100.123.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 10:21:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 192.100.123.82
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CAJDDKr7uHXajcy-jLrg7PToh6cFH3wVYvuX8E7_tq+s2n+b+LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203212>

Code Compare is a commercial file comparison tool for Windows, see

    http://www.devart.com/codecompare/

Version 2.80.4 added support for command line arguments preceded by a
dash instead of a slash. This is required for Git for Windows because
slashes in command line arguments get mangled with according to these
rules:

    http://www.mingw.org/wiki/Posix_path_conversion

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |    2 +-
 mergetools/codecompare                 |   25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)
 create mode 100644 mergetools/codecompare

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ffedce7..222b804 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1071,7 +1071,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f730253..54cb708 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -126,7 +126,7 @@ list_merge_tool_candidates () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/codecompare b/mergetools/codecompare
new file mode 100644
index 0000000..3f0486b
--- /dev/null
+++ b/mergetools/codecompare
@@ -0,0 +1,25 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	touch "$BACKUP"
+	if $base_present
+	then
+		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" -BF="$BASE" \
+			-RF="$MERGED"
+	else
+		"$merge_tool_path" -MF="$LOCAL" -TF="$REMOTE" \
+			-RF="$MERGED"
+	fi
+	check_unchanged
+}
+
+translate_merge_tool_path() {
+	if merge_mode
+	then
+		echo CodeMerge
+	else
+		echo CodeCompare
+	fi
+}
-- 
1.7.9.6 (Apple Git-31.1)
