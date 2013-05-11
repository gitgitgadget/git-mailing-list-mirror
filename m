From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 07/10] t3203: Add testcase for fix in 1603ade81352a526ccb206f41ff81ecbc855df2d
Date: Sat, 11 May 2013 18:21:17 +0200
Message-ID: <1368289280-30337-8-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYN-0007Zt-Mb
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab3EKQVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:40 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:52063 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3EKQVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:38 -0400
Received: by mail-we0-f172.google.com with SMTP id w60so5026355wes.3
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5JWK5fqgygwNaaU9fSPVMZDSJfRJrjfdvQCc1qQxUxU=;
        b=o+jAHNCYLwsQRuoz/kK4iyFXHABWU7tCU+tnXoPMWZ9Md7vSsiaaPzJPR+WzD5f0HD
         ZiGI1scJ1Jmuf0tw0nJgO9WEZNqWOUi4SbF5xXOOOiHN4XfOifnHon16DG4VEC6wE7V1
         jPaPX4wkXyk3M+x9bZP9PEGEo+vltBOeFNtOKQiSFImC7nCw8DmrQ2pvlt/WKWDmHNrN
         +4fbYqE/AB0hxOhJ7E6Ji/fZGa8C5rL06ppwjgxAEtwuaXdgli1C8BCp3mcNlOQADAVJ
         kCdGarREVA95iGm24jvkqVALTVTIGIXSAU5qdjhR5S++GIpWGxRQngNr4J0u4FNjlAsc
         0Rhw==
X-Received: by 10.180.72.227 with SMTP id g3mr10068534wiv.1.1368289297632;
        Sat, 11 May 2013 09:21:37 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223986>

This adds a testcase for some behavior that I very nearly broke while
refactoring some stuff in builtin/branch.c.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3203-branch-output.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index ba4f98e..c312d3a 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -106,4 +106,19 @@ EOF
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'git branch -a --merged handles broken refs gracefully' '
+	cat >expect <<EOF &&
+  branch-one
+  branch-two
+* master
+  remotes/origin/HEAD -> origin/branch-one
+  remotes/origin/branch-one
+  remotes/origin/branch-two
+EOF
+	git checkout master &&
+	echo "broken ref" > .git/refs/heads/broken &&
+	test_must_fail git branch -a --merged >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.1.3.704.g33f7d4f
