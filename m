From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/14] Add test for fetch-pack
Date: Fri, 29 Apr 2016 16:34:45 -0700
Message-ID: <1461972887-22100-13-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwW-00010K-46
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbcD2XfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:14 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35458 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbcD2XfM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:12 -0400
Received: by mail-pa0-f43.google.com with SMTP id iv1so51227475pac.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A/1b37xQwbwZ3D9ky65rvsdOkPhJw+ZFnLubGGZLT18=;
        b=LQyTpSKYgVpl5h7spH/NzDcl9xy95J9jTGB0QLQSuWMzJn+V/debAfd6jw6gDdI/SH
         ez5c+uc48VvF8vWtEeWdz6jyrAT6ePX3VAvurMsnRKzL7rfEo4HHOW4K16///h9Wa8GC
         yQxlAK9snX1E2uHYA0ZHfGqqu40Z/9JXX21o7qK8alvQNfEgJYugDN6RBn7pAWyx6Fyb
         CjXuL/PneDT98I96qzbApTSqQaXKvONad6ehYeIv0pzHzojIoWXgOM9O7axj5F+xwjWF
         hV/5as36qO5SzZYEsKdX1zZmDhz8An5MXFTCZddbMddvrvO2kZmAHcxrXbs1+5iJ/WC/
         eXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A/1b37xQwbwZ3D9ky65rvsdOkPhJw+ZFnLubGGZLT18=;
        b=ljIFIhgYFd6F+7nR9hwiK2uLRZ8dGa0MZahaKADulVpLCMoe8CU5IjPM/e2gH9y7UQ
         eEyR2AO7/lGpTse0AymphQZ2u8gFTWkKOq5cU9/48EKtkCeJcG5rjnVs7p6gHaIgER3u
         hLO2yPvTf4dFUBTITmmmw8hiG3zvxoT6wTnY6h9mc/Cr/93/I/SWFXr2LxmrqZ8uLR0X
         uv1Sx3SENybggLxq/i35t39eU4vrdi18ARHen73mecpinqUp8t/e3yRPYgzmdDOhu24L
         QZM3vfmImliLQ1eHz9KDgmMcGRzItIzQQHKfpGYtrXgPHWZmciUJl63g4k2ap7m4pCeS
         aalg==
X-Gm-Message-State: AOPr4FWTJXE1amvGoxFYqNpqDnzfcg68XrwZ7yA3rdgwqDE9rpzX5Oh/x1xwVEmbfH0sKnvV
X-Received: by 10.67.4.225 with SMTP id ch1mr32973674pad.120.1461972911313;
        Fri, 29 Apr 2016 16:35:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id q129sm2964352pfb.16.2016.04.29.16.35.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:10 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293079>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5500-fetch-pack.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 91a69fc..2c704ef 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -519,6 +519,7 @@ test_expect_success 'test --all, --depth, and explicit tag' '
 '
 
 test_expect_success 'shallow fetch with tags does not break the repository' '
+	test_when_finished "rm -rf repo1" &&
 	mkdir repo1 &&
 	(
 		cd repo1 &&
@@ -547,6 +548,26 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'fetch-pack with protocol version 2' '
+	test_when_finished "rm -rf repo1" &&
+	mkdir repo1 &&
+	(
+		cd repo1 &&
+		git init &&
+		test_commit 1 &&
+		test_commit 2 &&
+		test_commit 3 &&
+		echo "$(git rev-parse master) refs/heads/master" >expected &&
+		mkdir repo2 &&
+		(
+			cd repo2 &&
+			git init &&
+			git fetch-pack --transport-version=2 --upload-pack=git-upload-pack-2 ../.git refs/heads/master >../actual
+		) &&
+		test_cmp expected actual
+	)
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
-- 
2.8.0.32.g71f8beb.dirty
