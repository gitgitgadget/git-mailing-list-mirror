From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/4] t3400 (rebase): move lone statement into a test
Date: Fri, 10 May 2013 19:59:37 +0530
Message-ID: <1368196178-5807-4-git-send-email-artagnon@gmail.com>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 16:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaoJB-00020i-In
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 16:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab3EJO2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 10:28:09 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41725 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846Ab3EJO2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 10:28:06 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so2847038pdj.36
        for <git@vger.kernel.org>; Fri, 10 May 2013 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Z0VWEHT1YSDs4wpHEY9rETWLPkc806ovQy5YLGO6BSA=;
        b=ZCbiNqjLgvy40mHNKXr6c1195sFRNVzHVZAXIEtYKToDEfs8zlG1k6QGtXECGALvvo
         0JKBzHpryrfn5hdig2CDOi3GFyqsG0KQa/siuByG2MCMveROTTNGqvvsti3xX95zO80U
         ZWMLiwMA+UfQVcfM6ci218Rl5qLEEnhZdszlMaomZbsbWsis5BlPBuMUS2O6mSkB1XvU
         ST8xTWa2EEgloQdK8YYgp6g2LvVMWxl39DQDyqOWuyeVYmtQL8lnCbdbnjB1WkYYW+eY
         hvEdr6Rp6mk9Rhd78GpsfP0blv5z116aMwOUqaR++OPemlGtVt3FPNQwXsa4CDcmcsLi
         m1Bg==
X-Received: by 10.66.177.46 with SMTP id cn14mr18508556pac.4.1368196085982;
        Fri, 10 May 2013 07:28:05 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id ih1sm2885215pbb.44.2013.05.10.07.28.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 07:28:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.52.gc14258d
In-Reply-To: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223849>

'rm -f B' is a lone statement that isn't contained inside any
test_expect_* block.  Use test_when_finished to execute it after the
preceding test has finished.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3400-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index cb4234a..0841a12 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -154,11 +154,11 @@ test_expect_success 'setup: recover' '
 
 test_expect_success 'show verbose error when HEAD could not be detached' '
 	>B &&
+	test_when_finished rm -f B &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
 	grep "The following untracked working tree files would be overwritten by checkout:" output.err &&
 	grep B output.err
 '
-rm -f B
 
 test_expect_success 'fail when upstream arg is missing and not on branch' '
 	git checkout topic &&
-- 
1.8.3.rc1.52.gc14258d
