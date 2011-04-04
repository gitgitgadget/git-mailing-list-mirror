From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: [PATCH] git-completion: Add support for git submodule options
Date: Mon, 04 Apr 2011 13:15:33 +0200
Message-ID: <4D99A855.1050605@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 14:40:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6j5C-0008P2-FR
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 14:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab1DDMka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 08:40:30 -0400
Received: from 9.26.mail-out.ovh.net ([46.105.56.220]:49215 "HELO
	26.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753970Ab1DDMkE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 08:40:04 -0400
Received: (qmail 4772 invoked by uid 503); 4 Apr 2011 11:10:39 -0000
Received: from b9.ovh.net (HELO mail95.ha.ovh.net) (213.186.33.59)
  by 26.mail-out.ovh.net with SMTP; 4 Apr 2011 11:10:38 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 4 Apr 2011 13:15:35 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 4 Apr 2011 13:15:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
X-Ovh-Tracer-Id: 12129882647591182302
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170808>

Completion for git submodule only handled subcommands.
Add support for options of each subcommand

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 contrib/completion/git-completion.bash |   38 +++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..a7040e1 100755
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
@@ -2558,6 +2559,41 @@ _git_submodule ()
 			;;
 		esac
 		return
+	else
+	    local add_opts="--branch= --force --reference="
+	    local status_opts="--cached --recursive"
+	    local update_opts="--init --no-fetch --rebase --reference= --merge --recursive"
+	    local summary_opts="--cached --files --summary-limit="
+	    local foreach_opts="--recursive"
+
+	    local cur
+	    _get_comp_words_by_ref -n =: cur
+	    case "$subcommand,$cur" in
+		 add,--*)
+		     __gitcomp "$add_opts"
+		     ;;
+		 status,--*)
+		     __gitcomp "$status_opts"
+		     ;;
+		 update,--*)
+		     __gitcomp "$update_opts"
+		     ;;
+		 summary,--*)
+		     __gitcomp "$summary_opts"
+		     ;;
+		 summary,*)
+		     __gitcomp "$(__git_refs)"
+		     ;;
+		 foreach,--*)
+		     __gitcomp "$foreach_opts"
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
 
