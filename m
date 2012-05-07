From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 4/6] completion: simplify command stuff
Date: Mon,  7 May 2012 03:23:18 +0200
Message-ID: <1336353800-17323-5-git-send-email-felipe.contreras@gmail.com>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 07 03:23:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRCg1-0004OI-U7
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab2EGBXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:40 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43046 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2EGBXj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:39 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq2so98201wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6xo1sQNaQoqZ/8Z9JuI2TAaQsMcMo7uUUVPkw2L6frE=;
        b=FKJ7XB2BQDdN4okjZLsQmxjpQ1FytA70GESWcYSp+8PxCyrAgO6RMpnBBCk0Xs/41/
         VgUJ6hTZ39JnJCZVzLdtR3WsFKtM1OVpLc+sJoTDU42syVhB5uaP7C/hY+bk5aO/QPmx
         ufBDSdeZgUcbpuKNAK8miRuT8mAcNaAMG8CyTN4jBddp2GVqLP6nBha/UABcQDhLwBAw
         XcIfs+CGXjQApkSheepqmskKubWAIB2V1nLpI3vlY94JYbxnCa88Rl2LEUypniEYiw4o
         /OOyoY+jo5uE0fqTr3ksZJh5nUwJNydDUPc0H66qyNDfEp+TAW5POCRKUGuDL0Gyk3eE
         RXnA==
Received: by 10.216.213.219 with SMTP id a69mr8118790wep.16.1336353818979;
        Sun, 06 May 2012 18:23:38 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id ca3sm18253652wib.6.2012.05.06.18.23.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197231>

No need to recalculate it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8de0358..e648d7c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -723,7 +723,7 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur_="$cur" cmd="${words[1]}"
+	local cur_="$cur"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
 	if [ "$cmd" = "remote" ]; then
 		((c++))
@@ -2603,22 +2603,22 @@ _git_whatchanged ()
 
 _git ()
 {
-	local i c=1 command __git_dir
+	local i c=1 cmd __git_dir
 
 	while [ $c -lt $cword ]; do
 		i="${words[c]}"
 		case "$i" in
 		--git-dir=*) __git_dir="${i#--git-dir=}" ;;
 		--bare)      __git_dir="." ;;
-		--help) command="help"; break ;;
+		--help) cmd="help"; break ;;
 		-c) c=$((++c)) ;;
 		-*) ;;
-		*) command="$i"; break ;;
+		*) cmd="$i"; break ;;
 		esac
 		((c++))
 	done
 
-	if [ -z "$command" ]; then
+	if [ -z "$cmd" ]; then
 		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
@@ -2642,10 +2642,10 @@ _git ()
 		return
 	fi
 
-	local completion_func="_git_${command//-/_}"
+	local completion_func="_git_${cmd//-/_}"
 	declare -f $completion_func >/dev/null && $completion_func && return
 
-	local expansion=$(__git_aliased_command "$command")
+	local expansion=$(__git_aliased_command "$cmd")
 	if [ -n "$expansion" ]; then
 		completion_func="_git_${expansion//-/_}"
 		declare -f $completion_func >/dev/null && $completion_func
-- 
1.7.10
