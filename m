X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/10] Hide plumbing/transport commands from bash completion.
Date: Mon, 27 Nov 2006 03:41:01 -0500
Message-ID: <20061127084101.GB19745@spearce.org>
References: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:41:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <de7beb117fb963e68e1085b773593be326ffd495.1164616814.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32392>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goc36-0007Uo-T4 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757410AbWK0IlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbWK0IlJ
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:41:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:63115 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757410AbWK0IlG
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:41:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Goc2u-0004QS-UI; Mon, 27 Nov 2006 03:41:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 69D9120FB7F; Mon, 27 Nov 2006 03:41:01 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Users generally are not going to need to invoke plumbing-level commands
from within one line shell commands.  If they are invoking these commands
then it is likely that they are glueing them together into a shell script
to perform an action, in which case bash completion for these commands is
of relatively little use.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   62 +++++++++++++++++++++++++++++---
 1 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 28bd0e3..b55431f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -125,6 +125,58 @@ __git_complete_file ()
 	esac
 }
 
+__git_commands ()
+{
+	local i IFS=" "$'\n'
+	for i in $(git help -a|egrep '^ ')
+	do
+		case $i in
+		check-ref-format) : plumbing;;
+		commit-tree)      : plumbing;;
+		convert-objects)  : plumbing;;
+		cvsserver)        : daemon;;
+		daemon)           : daemon;;
+		fetch-pack)       : plumbing;;
+		hash-object)      : plumbing;;
+		http-*)           : transport;;
+		index-pack)       : plumbing;;
+		local-fetch)      : plumbing;;
+		mailinfo)         : plumbing;;
+		mailsplit)        : plumbing;;
+		merge-*)          : plumbing;;
+		mktree)           : plumbing;;
+		mktag)            : plumbing;;
+		pack-objects)     : plumbing;;
+		pack-redundant)   : plumbing;;
+		pack-refs)        : plumbing;;
+		parse-remote)     : plumbing;;
+		patch-id)         : plumbing;;
+		peek-remote)      : plumbing;;
+		read-tree)        : plumbing;;
+		receive-pack)     : plumbing;;
+		rerere)           : plumbing;;
+		rev-list)         : plumbing;;
+		rev-parse)        : plumbing;;
+		runstatus)        : plumbing;;
+		sh-setup)         : internal;;
+		shell)            : daemon;;
+		send-pack)        : plumbing;;
+		show-index)       : plumbing;;
+		ssh-*)            : transport;;
+		stripspace)       : plumbing;;
+		symbolic-ref)     : plumbing;;
+		unpack-file)      : plumbing;;
+		unpack-objects)   : plumbing;;
+		update-ref)       : plumbing;;
+		update-server-info) : daemon;;
+		upload-archive)   : plumbing;;
+		upload-pack)      : plumbing;;
+		write-tree)       : plumbing;;
+		*) echo $i;;
+		esac
+	done
+}
+
 __git_aliases ()
 {
 	local i IFS=$'\n'
@@ -355,11 +407,11 @@ _git ()
 	done
 
 	if [ $c -eq $COMP_CWORD -a -z "$command" ]; then
-		COMPREPLY=($(compgen \
-			-W "--git-dir= --version \
-				$(git help -a|egrep '^ ') \
-			    $(__git_aliases)" \
-			-- "${COMP_WORDS[COMP_CWORD]}"))
+		COMPREPLY=($(compgen -W "
+			--git-dir= --version --exec-path
+			$(__git_commands)
+			$(__git_aliases)
+			" -- "${COMP_WORDS[COMP_CWORD]}"))
 		return;
 	fi
 
-- 
1.4.4.1.ge3fb
