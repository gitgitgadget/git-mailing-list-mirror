From: Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/2] git-p4 tests: cd to testdir before running python
Date: Sat, 23 Apr 2016 15:13:45 +0100
Message-ID: <1461420826-4416-2-git-send-email-luke@diamand.org>
References: <1461420826-4416-1-git-send-email-luke@diamand.org>
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Sam Hocevar <sam@hocevar.net>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 16:11:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atyHL-0001cG-M0
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 16:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbcDWOLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 10:11:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34404 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbcDWOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 10:11:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so12265034wmn.1
        for <git@vger.kernel.org>; Sat, 23 Apr 2016 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KF/K485Xc7ASR1KJ9EAj35iXOy9ZnXEEGiIwU9JiipI=;
        b=atJL13FWWCejWWIDz1vj6VYxMNsP7dKImtE/3joBsKGao2HsAj92TmALx++NJHAIs2
         N1bNwJ+w6RWSghEba8XWZKTwppeCDg2hAKzpPCNFfVWxdEEM4DSayiS7bewjXvIVr5Ll
         Ra6suUoJhlghpUQtsC39tgf4aPSnvniXrULaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KF/K485Xc7ASR1KJ9EAj35iXOy9ZnXEEGiIwU9JiipI=;
        b=jhs3w1YDpjZ+9cZmBp5haW/1+w6IrC+OJn/Y4xonPeShxehWxGL/NkZTeDJVGqoIE2
         e4xjqcbyN+xcIiL5MKRKh7s4GgMk7VsqQRGyoZhSVVwT8/1ylT0dlKzLM4amqV9ZutdC
         2oxIAWN4hXACdojBxEBckDbov798MHrZR/L3RoO1DPHgmuWGIL3w4loa6mBv36HH2LQG
         I52YZ1kXSGXbbriuECSulK/8CafqBb8jPj6vuk/LayhQcUlfUEX+Ncj+p+U+icpOlT92
         hML4sBPhwpSWDIW6Zr3V3d+zKrEC/ca8FM1f6uh9oLOtjuna/cDd29opSDbq/Nk2F6Fa
         NvHg==
X-Gm-Message-State: AOPr4FWXqFZRchLghkwgLzCOcePvMWSWmW2OJ6SqyycoC0atWvB7neSu8GAhq3tp7FDFBw==
X-Received: by 10.194.84.100 with SMTP id x4mr29135476wjy.169.1461420670489;
        Sat, 23 Apr 2016 07:11:10 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id u3sm8537920wmg.15.2016.04.23.07.11.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 23 Apr 2016 07:11:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.218.gd2cea43.dirty
In-Reply-To: <1461420826-4416-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292301>

The python one-liner for getting the current time prints out
error messages if the current directory is deleted while it is
running if using python3.

Avoid these messages by switching back to the test directory
before running python3, instead of remaining in the trash
directory.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index f9ae1d7..77802fe 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -50,7 +50,7 @@ native_path() {
 # at runtime (e.g. via NTP). The 'clock_gettime(CLOCK_MONOTONIC)'
 # function could fix that but it is not in Python until 3.3.
 time_in_seconds() {
-	python -c 'import time; print int(time.time())'
+	(cd "$TEST_DIRECTORY" && python -c 'import time; print(int(time.time()))')
 }
 
 # Try to pick a unique port: guess a large number, then hope
-- 
2.8.1.218.gd2cea43.dirty
