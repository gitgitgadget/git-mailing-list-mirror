From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH v2 1/3] shell prompt: add bash.showUntrackedFiles option
Date: Wed, 13 Feb 2013 12:01:58 +0100
Message-ID: <1360753321-5002-1-git-send-email-martinerikwerner@gmail.com>
References: <1360753138.25490.10.camel@mas>
Cc: git@vger.kernel.org, trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 13 12:02:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5a70-0000dU-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 12:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785Ab3BMLCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 06:02:24 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:39089 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3BMLCW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 06:02:22 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so1038413lab.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fTf+pzankhhziSF+Tdp9tPBADaXxbxBysjQ8v9wXDnM=;
        b=e+JscGWgOdsmaOIKRVubS3BHtzmLru4MW3uIlUDvFWHLPQWKmboeE52doapRWQv3rM
         6rX3sol2QxeAONSklfaQlQv0iotCP+IyXlPHaJg2kHyxVWhy3klm8tYUwpZ3V9EDXKLz
         5/hAdm7ViweH/n7GzDxEsQ+721fWt4/BEc6Sgwf8oz/njRTCFYjCDxwUdrxI6gXJNXK2
         2fcbXP7GqFE3bUrgPaEWlACCPwCF7AB6U2VLS3zIhc0hTzqitueupr9UOsDjvlf3dMvP
         EUvM3wE9nItIUDGi2c3qc4aaDXxETbPd85LQ5fVfs7gOyvSBbNCWOZ3RA7bpuIgZoGLe
         uV5w==
X-Received: by 10.112.9.134 with SMTP id z6mr1254765lba.72.1360753341050;
        Wed, 13 Feb 2013 03:02:21 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id t7sm15251208lbf.12.2013.02.13.03.02.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 03:02:19 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5a6T-0001Jr-K5; Wed, 13 Feb 2013 12:02:17 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360753138.25490.10.camel@mas>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216246>

Add a config option 'bash.showUntrackedFiles' which allows enabling
the prompt showing untracked files on a per-repository basis. This is
useful for some repositories where the 'git ls-files ...' command may
take a long time.

Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
---
 contrib/completion/git-prompt.sh |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9bef053..9b2eec2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -43,7 +43,10 @@
 #
 # If you would like to see if there're untracked files, then you can set
 # GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
-# files, then a '%' will be shown next to the branch name.
+# files, then a '%' will be shown next to the branch name.  You can
+# configure this per-repository with the bash.showUntrackedFiles
+# variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
+# enabled.
 #
 # If you would like to see the difference between HEAD and its upstream,
 # set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
@@ -332,8 +335,10 @@ __git_ps1 ()
 			fi
 
 			if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
-				if [ -n "$(git ls-files --others --exclude-standard)" ]; then
-					u="%"
+				if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
+					if [ -n "$(git ls-files --others --exclude-standard)" ]; then
+						u="%"
+					fi
 				fi
 			fi
 
-- 
1.7.10.4
