From: Scott Chacon <schacon@gmail.com>
Subject: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Wed, 28 Oct 2009 14:39:32 -0700
Message-ID: <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <20091027230043.GA11607@hashpling.org>
	 <20091028090022.GA90780@gmail.com>
	 <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 22:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3GF1-0003wy-1k
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 22:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbZJ1Vj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbZJ1Vj3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 17:39:29 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62395 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZJ1Vj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 17:39:28 -0400
Received: by yxe17 with SMTP id 17so1095122yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4acPcnXvsTxzDEg3vEncQRPLU0Vn2vz3Q9srUfJ1NzI=;
        b=JCJxhCGvP6ihRP+ragQ/VH+PawVkZoJYiu8it5JKa3M3ty97lOCCjtpMXKnfENgJQ2
         KkkZA1oiBRMrBCxd17xqUpP8t4baQoVFUKytyAZfG2sF4Qyq5rPavRbNvE6wK5XH/TgY
         sUs7XlEXAUqrSeHbPU5SZPvUu2VmUXpNJ9VBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=w7hLuTfIbgPSePfmvBD6PRSClY/mC8IF3pCsUvaliQ4fFfJwFavvPZ1vQpDXc8DXcT
         +prSh6e0FVdtgXOHTnI9ZVrj+ftPuGUHuj8bNqMvIfFNIeiFlNktwgqerKDS6xLe2Jfe
         GF+ZqFtyrcf77wG1zhNgBn4SrI148p5Lgje0w=
Received: by 10.101.159.36 with SMTP id l36mr711681ano.14.1256765973133; Wed, 
	28 Oct 2009 14:39:33 -0700 (PDT)
In-Reply-To: <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131499>

p4merge is now a built-in diff/merge tool.
This adds p4merge to git-completion and updates
the documentation to mention p4merge.

Signed-Off-By: Scott Chacon <schacon@gmail.com>
---

This is the same patch, but I tested it on Linux as well as Mac and it
works fine as long as the [difftool|mergetool].p4merge.path configs
are set or it's in your path.

 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    2 +-
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |   17 +++++++++++++++--
 5 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 96a6c51..8e9aed6 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -31,7 +31,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse, opendiff and araxis.
+	ecmerge, diffuse, opendiff, p4merge and araxis.
 +
 If a diff tool is not specified, 'git-difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 68ed6c0..4a6f7f3 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge, opendiff and araxis.
+	diffuse, tortoisemerge, opendiff, p4merge and araxis.
 +
 If a merge resolution program is not specified, 'git-mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index c0f96e7..a403155 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -23,7 +23,7 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", "araxis", and
+	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
 	"opendiff".  Any other value is treated is custom merge tool
 	and there must be a corresponding mergetool.<tool>.cmd option.

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index d3fec32..5fb6017 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -953,7 +953,7 @@ _git_diff ()
 }

 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge
 "

 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index bfb01f7..f7c571e 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -46,7 +46,7 @@ check_unchanged () {
 valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis)
+	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -130,6 +130,19 @@ run_merge_tool () {
 			"$merge_tool_path" "$LOCAL" "$REMOTE"
 		fi
 		;;
+	p4merge)
+		if merge_mode; then
+		    touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
+			else
+				"$merge_tool_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
 	meld)
 		if merge_mode; then
 			touch "$BACKUP"
@@ -323,7 +336,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
 	fi
 	if echo "${VISUAL:-$EDITOR}" | grep emacs > /dev/null 2>&1; then
 		# $EDITOR is emacs so add emerge as a candidate
-- 
1.6.5.2.75.gad2f8
