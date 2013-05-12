From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] am: tighten a conditional that checks for $dotest
Date: Sun, 12 May 2013 17:26:35 +0530
Message-ID: <1368359801-28121-2-git-send-email-artagnon@gmail.com>
References: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 12 13:56:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbUsw-0001wz-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 13:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505Ab3ELL4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 07:56:11 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36092 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3ELL4K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 07:56:10 -0400
Received: by mail-pd0-f180.google.com with SMTP id t10so3766814pdi.39
        for <git@vger.kernel.org>; Sun, 12 May 2013 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=WIUJzOMNojRDakTJmFI1knDevuecTmwN30Z6npbEZTY=;
        b=GTj2EQi5q+HNfVsTr2JJ0xvojClNZRmfyj66Z/768Eac+32cFbdIrBxiqzF+POBmlp
         P4BxjLLic8HGa98zhCQKcbj7bQ+WGEKCP1AEnpaI84yhMJXqSJI/c9yyM2xEwQFiboKK
         HZbcXGBSFitGjCd4yQxofat+WZTCo+6MQ9EaQ+FrSH1+GGp5otCR0dRuZo8gDta2l/TK
         DSRVLfyAPUYtadXc954/UzDBu0H0gmm5nKQB8RRdt6bZzrttSKn49z4c0Kg/H9NzpS42
         3FHZAqLTGV5zunSxlzp6/9WBcyJJs+U5Re9YMZ6+UjxNZs7seJVtX2goW0G0XzOj4EZa
         Kfxg==
X-Received: by 10.68.164.226 with SMTP id yt2mr24883997pbb.203.1368359769700;
        Sun, 12 May 2013 04:56:09 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.41])
        by mx.google.com with ESMTPSA id iy2sm9911078pbb.31.2013.05.12.04.56.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 04:56:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.51.gd7a04de
In-Reply-To: <1368359801-28121-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224036>

In preparation for a later patch that creates $dotest/autostash in
git-rebase.sh before anything else happens, don't assume that the
presence of a $dotest directory implies the existence of the
$dotest/next and $dotest/last files.  Look for them explicitly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index c092855..ccb854a 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -446,6 +446,8 @@ done
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
+   test -f "$dotest/last" &&
+   test -f "$dotest/next" &&
    last=$(cat "$dotest/last") &&
    next=$(cat "$dotest/next") &&
    test $# != 0 &&
@@ -454,7 +456,7 @@ then
    rm -fr "$dotest"
 fi
 
-if test -d "$dotest"
+if test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"
 then
 	case "$#,$skip$resolved$abort" in
 	0,*t*)
-- 
1.8.3.rc1.51.gd7a04de
