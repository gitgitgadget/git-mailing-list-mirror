From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 4/4] t1006: add tests for git cat-file --literally
Date: Sat,  4 Apr 2015 11:14:49 +0530
Message-ID: <1428126289-19239-1-git-send-email-karthik.188@gmail.com>
References: <551F7984.5070902@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 07:45:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeGtN-0007zJ-7k
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 07:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbDDFpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 01:45:08 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35975 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbbDDFpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 01:45:07 -0400
Received: by pdea3 with SMTP id a3so91662591pde.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7giQOJtCKaFcVFEzC8pLih2+xSq4CyRkULdNxNxGRxQ=;
        b=VgPjARfE+jRyQPEKxOsj6rg1eV62yuW+7RkJ0yjBgjBiRC8LYv4sXZJkR/YLAItcIv
         C5yNNxYweQ4GWtFvII3zJgNySTKf+RitoVRUEb8pRO11MVERwVYPQZyXQeY5ncDDRWaC
         wyMsv3K4QEooatwnn6Cz/7S9FZUgjSUiq29FAXFA9DeLJW7xy167BzWGnEWoL4uXswPT
         73onHx/T71AGuhY/crkYeEvaaDPiV+UlMnRGOOltwTSt8QwYD9/005AmF3Sx/QHLcu6a
         nUzJ9FApugV9bfcmcXGTtdPb01VojX9EX7q7jqpqQpUF/Yc4zGdlj59FUch79W/ar9nt
         tHMA==
X-Received: by 10.70.131.76 with SMTP id ok12mr9571575pdb.155.1428126307533;
        Fri, 03 Apr 2015 22:45:07 -0700 (PDT)
Received: from ashley.localdomain ([103.227.98.178])
        by mx.google.com with ESMTPSA id fg2sm9749633pbc.45.2015.04.03.22.45.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2015 22:45:06 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc1.249.g9f2ee54
In-Reply-To: <551F7984.5070902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266765>

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t1006-cat-file.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ab36b1e..5b74044 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -47,6 +47,18 @@ $content"
 	test_cmp expect actual
     '
 
+    test_expect_success "Type of $type is correct using --literally" '
+	echo $type >expect &&
+	git cat-file -t --literally $sha1 >actual &&
+	test_cmp expect actual
+    '
+
+    test_expect_success "Size of $type is correct using --literally" '
+	echo $size >expect &&
+	git cat-file -s --literally $sha1 >actual &&
+	test_cmp expect actual
+    '
+
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
 	maybe_remove_timestamp "$content" $no_ts >expect &&
@@ -296,4 +308,19 @@ test_expect_success '%(deltabase) reports packed delta bases' '
 	}
 '
 
+bogus_type="bogus"
+bogus_sha1=$(git hash-object -t $bogus_type --literally -w --stdin </dev/null)
+
+test_expect_success "Type of broken object is correct" '
+	echo $bogus_type >expect &&
+	git cat-file -t --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "Size of broken object is correct" '
+	echo "0" >expect &&
+	git cat-file -s --literally $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.0.rc1.249.g9f2ee54
