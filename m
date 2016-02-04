From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Thu, 4 Feb 2016 11:34:59 +0100
Message-ID: <56B32953.2010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 11:36:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRHGf-0003Hk-4L
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 11:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbcBDKgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 05:36:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:42072 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932974AbcBDKfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 05:35:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aRHFg-00022z-Hg
	for git@vger.kernel.org; Thu, 04 Feb 2016 11:35:04 +0100
Received: from 131.228.216.134 ([131.228.216.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:35:04 +0100
Received: from sschuberth by 131.228.216.134 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 11:35:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 131.228.216.134
X-Mozilla-News-Host: news://news.gmane.org:119
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285450>

This avoids output like

    warning: ignoring broken ref refs/remotes/origin/HEAD

while completing branch names.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 15ebba5..7c0549d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -317,7 +317,7 @@ __git_heads ()
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/heads
+			refs/heads 2>/dev/null
 		return
 	fi
 }
@@ -327,7 +327,7 @@ __git_tags ()
 	local dir="$(__gitdir)"
 	if [ -d "$dir" ]; then
 		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
-			refs/tags
+			refs/tags 2>/dev/null
 		return
 	fi
 }
@@ -355,14 +355,14 @@ __git_refs ()
 			;;
 		esac
 		git --git-dir="$dir" for-each-ref --format="%($format)" \
-			$refs
+			$refs 2>/dev/null
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout
 			# Try to find a remote branch that matches the completion word
 			# but only output if the branch name is unique
 			local ref entry
 			git --git-dir="$dir" for-each-ref --shell --format="ref=%(refname:short)" \
-				"refs/remotes/" | \
+				"refs/remotes/" 2>/dev/null | \
 			while read -r entry; do
 				eval "$entry"
 				ref="${ref#*/}"
@@ -1835,7 +1835,7 @@ _git_config ()
 		remote="${remote%.push}"
 		__gitcomp_nl "$(git --git-dir="$(__gitdir)" \
 			for-each-ref --format='%(refname):%(refname)' \
-			refs/heads)"
+			refs/heads 2>/dev/null)"
 		return
 		;;
 	pull.twohead|pull.octopus)
-- 
2.7.0.windows.1
