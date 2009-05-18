From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 17 May 2009 20:18:20 -0700
Message-ID: <1242616700-26022-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, markus.heidelberg@web.de,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 18 05:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5tO3-0003fX-EC
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 05:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925AbZERDT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 23:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZERDT0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 23:19:26 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:1756 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbZERDT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 23:19:26 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1773814wfd.4
        for <git@vger.kernel.org>; Sun, 17 May 2009 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Dzy2ZG7lh2H7irFyJE4ZpfOQP8El3kSWb5fM7wjxmnQ=;
        b=khWvTep/1Btjp1fb/a4KayFHsYy4e0PndVxJQD2GMsy2NSVBjzjTCUb9spKc7LuWlt
         DrrFmGjggF23ROhLlF2OxgFoiCraHXTHC/kRQORYrYqC9o92ZdQyvRwtMvzfUXnAuZ+l
         J6VS/wuA1PS6hsU/YHK/91Y5PI1qkZaHoqReU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nupH5MTzbupbiYfveEuhZG26wjm459Vxkl2EFbYeODVJ3ZMF/b9fEX8+0U5wgMyNDO
         +Cj1h6uRrjvWFf34xv0f9NON8jSaWPuTDPYEhzz/dHXnbtDUhWE3JYoB3QmSecBvuqYS
         eYJ3tp6gmEhhuunyQ7GNYkEf43Ds+AFsUucnY=
Received: by 10.142.77.7 with SMTP id z7mr1905358wfa.272.1242616767436;
        Sun, 17 May 2009 20:19:27 -0700 (PDT)
Received: from localhost (adsl-75-50-171-106.dsl.lsan03.sbcglobal.net [75.50.171.106])
        by mx.google.com with ESMTPS id 24sm7845577wfc.37.2009.05.17.20.19.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 20:19:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.30.g55524
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119413>

Araxis merge is now a built-in diff/merge tool.
This adds araxis to git-completion and updates
the documentation as well.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This applies on top of the da/mergetool-lib branch
currently in pu.

This is a rework of a patch to add araxis support
to mergetool which originated on the msysgit list.
The commented-out "-titleN:" options were
intentionally left out of this patch because
no amount of shell-quoting could get it to work
when the title contained spaces.

http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7

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
index 1683e6d..ead530d 100755
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
index 8b5e6a8..e771b63 100644
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
1.6.3.1.30.g55524
