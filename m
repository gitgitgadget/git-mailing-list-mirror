From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: [PATCH v2] git-completion: Add support for git submodule options
Date: Mon, 11 Apr 2011 19:47:52 +0200
Message-ID: <4DA33EC8.5040704@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Shawn Pearce <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 19:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LDc-00031s-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 19:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1DKRsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 13:48:00 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:54788 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754720Ab1DKRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 13:47:59 -0400
Received: (qmail 30048 invoked by uid 503); 11 Apr 2011 17:35:56 -0000
Received: from b9.ovh.net (HELO mail637.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 11 Apr 2011 17:35:56 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 11 Apr 2011 19:52:03 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 11 Apr 2011 19:52:02 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
X-Ovh-Tracer-Id: 4594234571585347517
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171338>

Completion for git submodule only handled subcommands.
Add support for options of each subcommand

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
Changes:
 - Inlined local variables listing options.

 contrib/completion/git-completion.bash |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..20d0cf0 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2546,7 +2546,8 @@ _git_submodule ()
 	__git_has_doubledash && return
 
 	local subcommands="add status init update summary foreach sync"
-	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
+	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
 		local cur
 		_get_comp_words_by_ref -n =: cur
 		case "$cur" in
@@ -2558,6 +2559,35 @@ _git_submodule ()
 			;;
 		esac
 		return
+	else
+	    local cur
+	    _get_comp_words_by_ref -n =: cur
+	    case "$subcommand,$cur" in
+		 add,--*)
+		     __gitcomp "--branch= --force --reference="
+		     ;;
+		 status,--*)
+		     __gitcomp "--cached --recursive"
+		     ;;
+		 update,--*)
+		     __gitcomp "--init --no-fetch --rebase --reference= --merge --recursive"
+		     ;;
+		 summary,--*)
+		     __gitcomp "--cached --files --summary-limit="
+		     ;;
+		 summary,*)
+		     __gitcomp "$(__git_refs)"
+		     ;;
+		 foreach,--*)
+		     __gitcomp "--recursive"
+		     ;;
+		 sync,*)
+		     COMPREPLY=()
+		     ;;
+		 *)
+		     COMPREPLY=()
+		     ;;
+	    esac 
 	fi
 }
 
