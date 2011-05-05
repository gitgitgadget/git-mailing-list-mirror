From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH for maint branch] git-completion: fix zsh support
Date: Thu,  5 May 2011 17:24:18 +0300
Message-ID: <1304605458-1483-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 16:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHzTi-0004wX-Ty
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 16:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab1EEOYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 10:24:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58032 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab1EEOYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 10:24:25 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so686476ewy.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 07:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=q+DqzyfMUMcdmwyEzN062cH06W4kY4QML3htnuRGZt4=;
        b=fa/guYEJSxwZrWV/iI+R1dKyk2hsAPKcXhxJaoVRMpP0UHbgc3riEbyrjWRTAgLcY5
         43MAGe6Y/cVHFt733JoSexihTCb156icGUdTSId4835n8sLL7kj/2dnquV6xCVdyOvGU
         EWE4h9Sg+FfFOf7AbCcN7sTZYj7O2ehxY0cg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Enao1tfBOVhm1CRHRrsSfYCFiJh/mWCXNjxYi0n6e+LRNeSjxojppZ9g8Skv2RXCoU
         hrq0rV0oedNfJ06xH3bJJFEOIXzL71f6896I0EUleHFvguSeNry+xQdcRWwcHMLqLCp2
         wrcnyyNovhRtWqq51n1RvjQ4Bzo+pNh9G0vzA=
Received: by 10.14.121.9 with SMTP id q9mr1247628eeh.102.1304605464469;
        Thu, 05 May 2011 07:24:24 -0700 (PDT)
Received: from localhost (gw3.cosmicparrot.net [217.152.255.6])
        by mx.google.com with ESMTPS id l35sm534137eea.1.2011.05.05.07.24.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2011 07:24:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.1.g638e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172833>

It turns out 'words' is a special variable used by zsh completion.

There's probably a bug in zsh's bashcompinit:
http://article.gmane.org/gmane.comp.shells.zsh.devel/22546

But in the meantime we can workaround it this way.

Currently zsh is completely broken after commit da48616 (bash: get
--pretty=m<tab> completion to work with bash v4), which introduced
_get_comp_words_by_ref() that comes from debian's bash_completion
scripts, and relies on the 'words' variable to behave like any normal
variable.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

This patch is meant for the maintenance branch, so Szeder's patches are not
needed.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 840ae38..8d5eae7 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2710,6 +2710,9 @@ _git ()
 	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
+
+		# 'words' has special meaning in zsh; override that
+		typeset -h words
 	fi
 
 	local cur words cword
-- 
1.7.5.1.1.g638e6
