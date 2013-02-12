From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: [PATCH 1/2] bash completion: add bash.showUntrackedFiles option
Date: Tue, 12 Feb 2013 21:12:15 +0100
Message-ID: <1360699936-28688-2-git-send-email-martinerikwerner@gmail.com>
References: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
Cc: trsten@science-computing.de,
	Martin Erik Werner <martinerikwerner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 21:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MET-0007qI-Gg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 21:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab3BLUNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 15:13:15 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:34935 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3BLUNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 15:13:15 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so479515lab.30
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 12:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fTf+pzankhhziSF+Tdp9tPBADaXxbxBysjQ8v9wXDnM=;
        b=UnUfqCNnJYY8qXWqFrah2F0Up1TcnJJhfo2DM+Kg0zFPudnnFius4elKoikcjCTSbS
         MlS0tZ4x8+OEfwpSRraQIwwktuvlPcVuRRGXebbpJ6p1JlvQjHuklji/Bgrfk3zofBxn
         0CVIRpntmG+/sx5fb9dY+thf8hCuJ3uXoAMbRIgTYrGiw7monYCO50MrTh1199MBS8xv
         k41sCQmtgHEopCXZpk/Q9RsSUzC+BAUSfSPXXO9RNLUf6e09zrdosufEPWtPuGJpgUXj
         ZhSm22grubAxgqdPAQRj/rVBeACZM10l7OHvmfaMHsjR7UM9BwoW85aYGhX3OoHB6T45
         ll1w==
X-Received: by 10.112.27.106 with SMTP id s10mr7639513lbg.27.1360699993137;
        Tue, 12 Feb 2013 12:13:13 -0800 (PST)
Received: from mas (nl107-187-0.student.uu.se. [130.243.187.0])
        by mx.google.com with ESMTPS id o2sm14616452lby.11.2013.02.12.12.13.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 12:13:12 -0800 (PST)
Received: from arand by mas with local (Exim 4.80)
	(envelope-from <arand@mas>)
	id 1U5MDw-0007Us-5v; Tue, 12 Feb 2013 21:13:04 +0100
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1360699936-28688-1-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216184>

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
