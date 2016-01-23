From: Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH 2/2] Fix up the arguments for git stash.
Date: Sat, 23 Jan 2016 02:30:50 +0100
Message-ID: <20160123013049.GB28197@wagland.net>
References: <20160123012316.GA27965@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 02:30:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMn2X-0004T7-DR
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 02:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbcAWBay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 20:30:54 -0500
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:61643 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826AbcAWBax (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2016 20:30:53 -0500
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews09.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Sat, 23 Jan 2016 02:29:51 +0100
Received: from CPSMTPM-CMT104.kpnxchange.com ([195.121.3.20]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Sat, 23 Jan 2016 02:29:50 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by CPSMTPM-CMT104.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Sat, 23 Jan 2016 02:30:51 +0100
Received: from wagland.net (mijnmodem.kpn.lan [192.168.2.254])
	by kruimel.wagland.net (Postfix) with ESMTPSA id 2A53A6191FE
	for <git@vger.kernel.org>; Sat, 23 Jan 2016 02:30:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160123012316.GA27965@wagland.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	URIBL_BLOCKED autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 23 Jan 2016 01:30:52.0076 (UTC) FILETIME=[B24786C0:01D1557D]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284621>

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
+			if [ $cword -eq 3 ]; then
+			__gitcomp_nl "$(__git_refs)";
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
