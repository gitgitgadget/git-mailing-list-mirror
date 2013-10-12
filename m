From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 0/2] Version fixes and cleanups
Date: Sat, 12 Oct 2013 02:07:06 -0500
Message-ID: <1381561628-20665-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPR-0006OF-32
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab3JLHOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:38 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37644 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab3JLHNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:09 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3438233obc.37
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UGxbRPM1fddIIr7wiYyV3pFl69/dkdufWr5/UHssGBg=;
        b=QNSfnCrVrs8GqX+J1CcqzmDmETYTCafI5sx261jUlXxgutwsZ6S7Qam/tBlMgclxE2
         vollyUDp0tNWx/IKfJDF0ykh4Xfmrehk8t5qqaLg5LUTLt00GahZc2q7KtrUbO3XAFlM
         KESp84JH1fOHgCwMFMZbGvLjS6UKPXXDXBp+sz7mCOUztnPbtG8D3YHrgP8aulKQEgYS
         LypvXUjtdgREWfG9pZN7wXHfiUInj1+qtepKJdPiZcIQb3SxvEDN1WyRgDe46JBkA4Yx
         DmLhhRTQQG7zi9gipiFybaITRuL1rf3FjgKBNMnxZq0sLWWas3XI/NAviUSukWt0hOFJ
         Ay6A==
X-Received: by 10.60.52.244 with SMTP id w20mr17850542oeo.30.1381561989571;
        Sat, 12 Oct 2013 00:13:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm101396150oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236034>

Chances since v3:

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 19902e9..c04c4de 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,8 +26,10 @@ describe () {
 if test -f version
 then
        VN=$(cat version) || VN="$DEF_VER"
-elif test ! -d ${GIT_DIR:-.git} -a ! -f .git || ! describe
+elif test -d ${GIT_DIR:-.git} -o -f .git && describe
 then
+       VN=$(echo "$VN" | sed -e 's/-/~/g')
+else
        VN="$DEF_VER"
 fi
 
diff --git a/Makefile b/Makefile
index 7a8bee7..3588ca1 100644
--- a/Makefile
+++ b/Makefile
@@ -2426,7 +2426,7 @@ quick-install-html:
 ### Maintainer's dist rules
 
 git.spec: git.spec.in GIT-VERSION-FILE
-       sed -e 's/@@VERSION@@/$(subst -,~,$(GIT_VERSION))/g' < $< > $@+
+       sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
        mv $@+ $@
 
 GIT_TARNAME = git-$(GIT_VERSION)

Felipe Contreras (2):
  version-gen: cleanup
  version-gen: fix versions

 GIT-VERSION-GEN | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
1.8.4-fc
