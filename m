From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v4 6/6] completion: add public _GIT_complete helper
Date: Mon,  7 May 2012 03:23:20 +0200
Message-ID: <1336353800-17323-7-git-send-email-felipe.contreras@gmail.com>
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
	id 1SRCg2-0004OI-SK
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 03:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab2EGBXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 21:23:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43046 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2EGBXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 21:23:46 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq2so98201wib.1
        for <git@vger.kernel.org>; Sun, 06 May 2012 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aMc5QBRiha+41XvD+Q8yTodg6CM633FEnGc6iuZmt8g=;
        b=prv9DdP4oZF+dX302arK/BFzA3YcK6lyAldpiXv0PfzsUVWp+jt4g0x7bXjlBDesrL
         I0/1N9LxXPVFGp2Dmjxyx4K9uuv3qwyZChn9fEK237CWSo2KaUEJOOzblu64Z1Z2AyUi
         qFqEPpqBx6NEQzYpBi6akEMQ3YpPnn8rh/1qSYi440jUFM2J9zHeTw8TtboxkO79Hxx/
         22S4m3Qq7bQ3iCbN04TEP0uwemtN4Z+/rLr31yYUcx8oJCAwyp2UmwLzIK7iogltM5vT
         z6uGwp48Gy0YdN48E5YtDj0olC8rQZtkZgJwAzp17uIrbTiXdwRW5sy+VjHzWjK+EXjI
         tVqw==
Received: by 10.180.24.35 with SMTP id r3mr30657978wif.7.1336353826175;
        Sun, 06 May 2012 18:23:46 -0700 (PDT)
Received: from localhost (ip-109-43-0-55.web.vodafone.de. [109.43.0.55])
        by mx.google.com with ESMTPS id e6sm18251836wix.8.2012.05.06.18.23.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 18:23:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197230>

So that users can easily define aliases, such as:

 _GIT_complete gf git_fetch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   10 +++++-----
 t/t9902-completion.sh                  |    9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 049110e..2b7ef02 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2678,6 +2678,7 @@ _gitk ()
 
 __git_func_wrap ()
 {
+	local cmd="${1#git_}" cmd_pos=1
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
@@ -2695,8 +2696,7 @@ __git_func_wrap ()
 	_$1
 }
 
-# this is NOT a public function; use at your own risk
-__git_complete ()
+_GIT_complete ()
 {
 	local name="${2-$1}"
 	local wrapper="_${name}_wrap"
@@ -2705,13 +2705,13 @@ __git_complete ()
 		|| complete -o default -o nospace -F $wrapper $1
 }
 
-__git_complete git
-__git_complete gitk
+_GIT_complete git
+_GIT_complete gitk
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-__git_complete git.exe git
+_GIT_complete git.exe git
 fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 6904594..2037452 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -63,7 +63,7 @@ run_completion ()
 	local _cword
 	_words=( $1 )
 	(( _cword = ${#_words[@]} - 1 ))
-	_git_wrap && print_comp
+	${comp_wrap-_git_wrap} && print_comp
 }
 
 test_completion ()
@@ -316,4 +316,11 @@ test_expect_success 'global options extra checks' '
 	test_completion "git --no-pager tag -d v" "v0.1 "
 '
 
+test_expect_success 'aliases' '
+	local comp_wrap=_git_fetch_wrap &&
+	_GIT_complete gf git_fetch &&
+	test_completion "gf o" "origin " &&
+	test_completion "gf origin m" "master:master "
+'
+
 test_done
-- 
1.7.10
