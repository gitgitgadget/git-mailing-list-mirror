From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] prompt: do not double-discriminate detached HEAD
Date: Tue, 18 Jun 2013 22:43:25 +0530
Message-ID: <1371575608-9980-3-git-send-email-artagnon@gmail.com>
References: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 19:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UozWZ-0003FH-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238Ab3FRRQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 13:16:43 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:62894 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab3FRRQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:16:42 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so4190305pab.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=HlfNY46/pT/GKO91oxLHslBqPRirIERsD8BogoEk714=;
        b=0vsQrNJkq4/Yt5fRoay3iLH2j3iFvxxeS7vs6wjDS7FFaxZ40hZXTwJYPQz9a9CA5p
         WkKx6cpOgmTGGAD8o4Bp/ZCic8SPtZndzUBevG3C+3iSgnQPvkdP/0M6fRKMp14IkXW0
         7vGlYghjYXMGkKHCKxyFU1a5dwAzg6Wo4rPEz9uYrycmxO4zY/lwAAWocHqyDGERtqaE
         EvZBtrvWuZeij354OjWE8gFovujaF8fulKzTzZ6pNNRSyQx6Oss8oOXIVCHPtztMt419
         YgBlwOaT0Qp1aw2szxbnyd/yVOIONwhPiQg7E6j8jYALwLdjEK7XX2cvPzLYV+CodYkl
         kgDg==
X-Received: by 10.66.67.41 with SMTP id k9mr2880578pat.211.1371575801784;
        Tue, 18 Jun 2013 10:16:41 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id vz8sm20498303pac.20.2013.06.18.10.16.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 10:16:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.456.gb7f4cb6.dirty
In-Reply-To: <1371575608-9980-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228282>

When GIT_PS1_SHOWCOLORHINTS is turned on, there is no need to put a
detached HEAD within parenthesis: the color can be used to discriminate
the detached HEAD.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-prompt.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 9ed6ff1..a127d3b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -392,7 +392,11 @@ __git_ps1 ()
 					test -z $b && b="$(git rev-parse --short HEAD)"
 					;;
 				esac
-				b="($b)"
+
+				# if there is no color, use
+				# parenthesis to indicate that the
+				# HEAD is detached
+				test -n "${GIT_PS1_SHOWCOLORHINTS-}" || b="($b)"
 			}
 		fi
 
-- 
1.8.3.1.456.gb7f4cb6.dirty
