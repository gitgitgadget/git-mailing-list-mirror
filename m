From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: add support for araxis merge
Date: Sat,  2 May 2009 18:18:01 -0700
Message-ID: <1241313481-17923-1-git-send-email-davvid@gmail.com>
Cc: spearce@spearce.org, markus.heidelberg@web.de,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	charles@hashpling.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, snowcoder@gmail.com
X-From: git-owner@vger.kernel.org Sun May 03 03:18:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0QLX-0006TG-EX
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 03:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbZECBSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 21:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753039AbZECBSQ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 21:18:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:9734 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbZECBSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 21:18:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1666942wah.21
        for <git@vger.kernel.org>; Sat, 02 May 2009 18:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=991ykIktH5iKQh5mzbI7F8BA01SMTdsvhfCfxh34V4s=;
        b=AUWPqpmXzXHsq1NoZY/zD3T8gwkO4a3yTjnE3w4nlbbZCcXHoZIHNpvRPSAX+sj93v
         CF7kW+xLOzang0oYuvy9eGwCnKuKrO3trMczJ1tiCbAE3vFwpUd6x0eSk9xbpWtIrWrz
         4NiGTqqbGkqOAmNBhXo2ePX6PBd+B/WU44gm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MZB/EpZf7/Hyz/KRJ489uQXh6rjHsCD7N6+Ngyo2A5kspD7MNCxTC7ELgSzjlK2Kq+
         w9oRZMb3mx+Qc2+0p7UbGrR2poXAXvMxl8sRgmhXIG8f+z79E54QDO9BNT6kjgn5iqXd
         3Dqi684oDoxx5VIG15jJ66ojbTDMdY0GKdzJw=
Received: by 10.114.159.5 with SMTP id h5mr3121329wae.190.1241313494617;
        Sat, 02 May 2009 18:18:14 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j39sm7434504waf.10.2009.05.02.18.18.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 18:18:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118158>

Araxis merge is now a built-in diff/merge tool.
This adds araxis to git-completion and updates
the documentation as well.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This patch is a result of the discussion on the msysgit list:

http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7

'compare' is the command-line utility that is provided
on MacOS.  Users on other platforms may have to manually
set their mergetool.araxis.path.


 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |   24 ++++++++++++++++++++++--
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 15b247b..96a6c51 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse and opendiff
+	ecmerge, diffuse, opendiff and araxis.
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index ff9700d..68ed6c0 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge and opendiff
+	diffuse, tortoisemerge, opendiff and araxis.
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 4832bc7..c0f96e7 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", and
+	"diffuse", "ecmerge", "tortoisemerge", "araxis", and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1a90cb8..dfd128b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -911,7 +911,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff
+			tkdiff vimdiff gvimdiff xxdiff araxis
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index a16a279..f3c63ef 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -18,6 +18,9 @@ translate_merge_tool_path () {
 	emerge)
 		echo emacs
 		;;
+	araxis)
+		echo compare
+		;;
 	*)
 		echo "$1"
 		;;
@@ -43,7 +46,7 @@ check_unchanged () {
 valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -263,6 +266,23 @@ run_merge_tool () {
 			status=1
 		fi
 		;;
+	araxis)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" -wait -merge -3 -a1 \
+					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
+			else
+				"$merge_tool_path" -wait -2 \
+					"$LOCAL" "$REMOTE" "$MERGED" \
+					>/dev/null 2>&1
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
+				>/dev/null 2>&1
+		fi
+		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
@@ -302,7 +322,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge"
+		tools="$tools gvimdiff diffuse ecmerge araxis"
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
 		# $EDITOR is emacs so add emerge as a candidate
-- 
1.6.3.rc4
