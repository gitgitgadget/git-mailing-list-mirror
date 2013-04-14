From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] rebase-am: fix regression with new cover-letter config
Date: Sun, 14 Apr 2013 17:27:04 -0500
Message-ID: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 00:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URVPT-0000i2-NG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 00:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3DNW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 18:28:17 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33508 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3DNW2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 18:28:16 -0400
Received: by mail-qc0-f180.google.com with SMTP id b40so36604qcq.39
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 15:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=sGLLyrONXk5MswYuXwfSYLltAlMRBuixMgM/GqKHnU8=;
        b=ZX6JWAg2vDmEtcik99/WEFbnfmBewMX8Zd0g/t5WGFMFROoej/xDKIkjkhWoZ4KHcA
         +n1VCSbF02r6z6Y8egPi5T6qlElJGZyU/znsI0qNv7nwni0sm3yeBu+9OjUkN8FDL4g0
         0X7TMn0/Gl1aR0Bx0qjHVpxCCXqn1CICf6I6tnnCmvf1CwJ5kw1hMlaA4j3tFL6DKFt7
         LU5o+TIlyxkP+Qv7HLzB2+rEMZ/4IPWqUD7hKwc+3vOJNZTWXYl4wHQE6XmlUU4VtcEd
         viPq6m7wKq0QxBMPyxuUNuFiT1eTO2QS2gPLX7Hx5WjsZGxn01czJG4cp3Hh3qYpdc2X
         QKqQ==
X-Received: by 10.224.72.83 with SMTP id l19mr20394615qaj.63.1365978492444;
        Sun, 14 Apr 2013 15:28:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id 10sm28747942qax.13.2013.04.14.15.28.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 15:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.643.ge3cc75d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221162>

If you have a cover-letter configuration set to anything other than
'false', 'git format-patch' might generate a cover letter, and 'git am'
doesn't seem to like that.

Ideally 'git am' should skip the cover-letter, but for now lets just fix
the regression.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--am.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 97f31dc..f84854f 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -31,8 +31,8 @@ else
 	rm -f "$GIT_DIR/rebased-patches"
 
 	git format-patch -k --stdout --full-index --ignore-if-in-upstream \
-		--src-prefix=a/ --dst-prefix=b/ \
-		--no-renames $root_flag "$revisions" >"$GIT_DIR/rebased-patches"
+		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+		$root_flag "$revisions" >"$GIT_DIR/rebased-patches"
 	ret=$?
 
 	if test 0 != $ret
-- 
1.8.2.1.643.ge3cc75d
