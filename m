From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/7] am: tighten a conditional that checks for $dotest
Date: Tue, 23 Apr 2013 19:32:00 +0530
Message-ID: <1366725724-1016-4-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:00:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdm8-0001CS-3I
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab3DWOAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:44 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38659 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3DWOAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:43 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so454703pdj.27
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Jzh6yiS3GjPse2M8NrmVdHnsrevNbDdLKb4QYhQNckU=;
        b=aWr51o9QrNRJYRsdMb4IodM9AvweU/QnKiforNUJGIBNoDbk4/qy28SXwy+UXEuxCP
         b02SRbip9Hj0JQcjhat+QTDiCjb3vzIv5lJGGom9xnxgFAPeAkDR17g+lOiDZcvtHARm
         /ATs5rZ8nw8hiXpiHVFjhtQTOVyUj3T3vGMB+6HTl1dzd2+fKjiGvUfKu33ZRh+R+tGd
         JBWJW002hWP7g7+rnbBYA9ld04/5uuRMBXaAvvZ+dIQS4j5zs/O33U56Qu/0D3KS/TCD
         gUf+Dr25u2aWivyQHReRdticUm/jSzIilh+C2jNGdKrGVydFKGtW7enyECzIgu3ELxOU
         4IcA==
X-Received: by 10.68.189.230 with SMTP id gl6mr41091634pbc.196.1366725642890;
        Tue, 23 Apr 2013 07:00:42 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.40
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222158>

We currently assume that, if a $dotest directory exists, an am had
been called earlier.  This assumption might get our conditional to
match a stray $dotest directory created somewhere else, and result in
failures down the line. So, tighten the conditional by additionally
looking for the file $dotest/last.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 88aa438..f4ef8fc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -454,7 +454,7 @@ then
    rm -fr "$dotest"
 fi
 
-if test -d "$dotest"
+if test -d "$dotest" && test -f "$dotest/last"
 then
 	case "$#,$skip$resolved$abort" in
 	0,*t*)
-- 
1.8.2.1.578.ga933817
