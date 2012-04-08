From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/12] completion: simplify command stuff
Date: Sun,  8 Apr 2012 06:07:54 +0300
Message-ID: <1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGiVR-0007R6-F1
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab2DHDIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:08:55 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54731 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab2DHDIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:08:31 -0400
Received: by mail-lb0-f174.google.com with SMTP id gg6so1342002lbb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ehm3R5k3o0F8RxQmw0SnEeWfk+XU9LmjnP/d9nZhFHU=;
        b=Q1m7V30LjI9aEI+TpefJHUy6ZLgC+Fi0bOstKokrvnxL7c0gIQkCp5Y7senXGOyA2S
         QK0XAiUN4EV7RGAY1GHp9zXul72PdSk/bFhzhsuGPhFwWK+Ph5/MFsb8RDUjf8dY+MpX
         ITiVsGh5GPej3mZ7Epuy1UDpDtOVYwmPFa2Mi/YN7wJDbiOTwUnM+HeW8RNXHLJdWIiv
         u7kTwi5ZrCBLUJT1afGemz71/noJt7+pW6EfRFHSNiEfx+yynai0eMiYehdfd+XeRWFe
         PQlP4NguuCnJkiZgNNdSu4t1r8I3arM3Tq5I1+R9MkqY10jKybqVFa4c9Sj6E0a4Lc5r
         DlbQ==
Received: by 10.152.145.135 with SMTP id su7mr4817494lab.5.1333854510748;
        Sat, 07 Apr 2012 20:08:30 -0700 (PDT)
Received: from localhost (84-231-195-184.elisa-mobile.fi. [84.231.195.184])
        by mx.google.com with ESMTPS id b3sm15508436lby.7.2012.04.07.20.08.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 20:08:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3.g5a738d
In-Reply-To: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194969>

No need to recalculate it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c9672b2..1fe11f4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -721,7 +721,7 @@ __git_complete_revlist ()
 
 __git_complete_remote_or_refspec ()
 {
-	local cur_="$cur" cmd="${words[1]}"
+	local cur_="$cur"
 	local i c=2 remote="" pfx="" lhs=1 no_complete_refspec=0
 	if [ "$cmd" = "remote" ]; then
 		((c++))
@@ -2599,7 +2599,7 @@ _git_whatchanged ()
 
 _git ()
 {
-	local i c=1 command __git_dir
+	local i c=1 cmd __git_dir
 
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
@@ -2625,13 +2625,13 @@ _git ()
 		-p|--paginate|--no-pager) ;;
 		--exec-path=*|--html-path|--info-path) ;;
 		--work-tree=*|--namespace=*|--no-replace-objects) ;;
-		--help) command="help"; break ;;
-		*) command="$i"; break ;;
+		--help) cmd="help"; break ;;
+		*) cmd="$i"; break ;;
 		esac
 		((c++))
 	done
 
-	if [ -z "$command" ]; then
+	if [ -z "$cmd" ]; then
 		case "$cur" in
 		--*)   __gitcomp "
 			--paginate
@@ -2654,10 +2654,10 @@ _git ()
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
1.7.10.3.g5a738d
