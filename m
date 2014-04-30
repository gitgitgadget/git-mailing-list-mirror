From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/6] completion: bash: remove zsh wrapper
Date: Wed, 30 Apr 2014 06:07:41 -0500
Message-ID: <1398856065-2982-3-git-send-email-felipe.contreras@gmail.com>
References: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 13:18:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfSX3-0003IN-0y
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 13:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbaD3LS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 07:18:29 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:54578 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbaD3LS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 07:18:28 -0400
Received: by mail-yh0-f49.google.com with SMTP id t59so1447060yho.8
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4eJU6BNmxMCiCDy0nJS3yD5s5BT55uRqAF/Ku4s+0xg=;
        b=p7M2emEPu73FunW9u18Ei6pHE5oSX9Q6DHoG1mAi+ekDb/EEIXejxY94kc2TFW+BbX
         qqGKaL9jMlXXU0V/1PzTfU7NcouwWXSzk3NLw4cAb77Cc1+Cp2Iv8oOxzRXIrAW+j5uO
         uUWLAMoJ3/eJKNY7k0ux7/bL8JgfW4zi7uNMk1E5rDGhG26aMoEEPq53jJCnKCtwpdgf
         AV8UmFdsteamYh+f74mqfl2GU8E8pb1fvvNJCNSnS/LCZIpasN0gm0S2lw9HtrttJDpM
         DboXtVQFiVPrtP4b/yjMiHgHj/gvIvxriJXNS10G/y4biFJweR6X0jnagdiQhmwjncs3
         VEyg==
X-Received: by 10.236.31.40 with SMTP id l28mr4838806yha.17.1398856707769;
        Wed, 30 Apr 2014 04:18:27 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c66sm42277399yhk.23.2014.04.30.04.18.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 04:18:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.11.g71fb719
In-Reply-To: <1398856065-2982-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247699>

It has been deprecated for one year and a half. It's time to move on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 64 ----------------------------------
 1 file changed, 64 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e331d2..be0ea36 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2574,70 +2574,6 @@ __gitk_main ()
 	__git_complete_revlist
 }
 
-if [[ -n ${ZSH_VERSION-} ]]; then
-	echo "WARNING: this script is deprecated, please see git-completion.zsh" 1>&2
-
-	autoload -U +X compinit && compinit
-
-	__gitcomp ()
-	{
-		emulate -L zsh
-
-		local cur_="${3-$cur}"
-
-		case "$cur_" in
-		--*=)
-			;;
-		*)
-			local c IFS=$' \t\n'
-			local -a array
-			for c in ${=1}; do
-				c="$c${4-}"
-				case $c in
-				--*=*|*.) ;;
-				*) c="$c " ;;
-				esac
-				array[${#array[@]}+1]="$c"
-			done
-			compset -P '*[=:]'
-			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
-			;;
-		esac
-	}
-
-	__gitcomp_nl ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
-	}
-
-	__gitcomp_file ()
-	{
-		emulate -L zsh
-
-		local IFS=$'\n'
-		compset -P '*[=:]'
-		compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
-	}
-
-	_git ()
-	{
-		local _ret=1 cur cword prev
-		cur=${words[CURRENT]}
-		prev=${words[CURRENT-1]}
-		let cword=CURRENT-1
-		emulate ksh -c __${service}_main
-		let _ret && _default && _ret=0
-		return _ret
-	}
-
-	compdef _git git gitk
-	return
-fi
-
 __git_func_wrap ()
 {
 	local cur words cword prev
-- 
1.9.2+fc1.11.g71fb719
