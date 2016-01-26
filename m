From: Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH v2 2/4] completion: update completion arguments for stash
Date: Tue, 26 Jan 2016 10:37:19 +0100
Message-ID: <20160126093718.GC77046@wagland.net>
References: <20160123012316.GA27965@wagland.net>
 <20160126093429.GA77046@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:37:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO046-0001wM-Qx
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbcAZJhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:37:25 -0500
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:59871 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756461AbcAZJhX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 04:37:23 -0500
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews05.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:36:18 +0100
Received: from CPSMTPM-CMT108.kpnxchange.com ([195.121.3.24]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:36:18 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by CPSMTPM-CMT108.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Tue, 26 Jan 2016 10:37:21 +0100
Received: from wagland.net (net06.redwood.com [91.233.6.246])
	by kruimel.wagland.net (Postfix) with ESMTPSA id 7294561C966;
	Tue, 26 Jan 2016 10:37:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160126093429.GA77046@wagland.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 26 Jan 2016 09:37:21.0629 (UTC) FILETIME=[27D918D0:01D1581D]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284794>


Add --all and --include-untracked to the git stash save completions.
Add --quiet to the git stash drop completions.
Update git stash branch so that the first argument expands out to the
possible branch names, and the other arguments expand to the stash
names.

Signed-off-by: Paul Wagland <paul@kungfoocoder.org>
---
 contrib/completion/git-completion.bash | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63754bc..043d5bb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2382,7 +2382,7 @@ _git_show_branch ()
 
 _git_stash ()
 {
-	local save_opts='--keep-index --no-keep-index --quiet --patch'
+	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
 	local subcommands='save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
@@ -2404,9 +2404,20 @@ _git_stash ()
 		apply,--*|pop,--*)
 			__gitcomp "--index --quiet"
 			;;
-		show,--*|drop,--*|branch,--*)
+		drop,--*)
+			__gitcomp "--quiet"
 			;;
-		show,*|apply,*|drop,*|pop,*|branch,*)
+		show,--*|branch,--*)
+			;;
+		branch,*)
+		  if [ $cword -eq 3 ]; then
+  			__gitcomp_nl "$(__git_refs)";
+			else
+				__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
+						| sed -n -e 's/:.*//p')"
+			fi
+			;;
+		show,*|apply,*|drop,*|pop,*)
 			__gitcomp_nl "$(git --git-dir="$(__gitdir)" stash list \
 					| sed -n -e 's/:.*//p')"
 			;;
-- 
2.7.0
