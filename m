From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v2 2/4] t1500-rev-parse: add tests executed from sub path of the main worktree
Date: Fri, 22 Apr 2016 17:53:10 -0400
Message-ID: <1461361992-91918-3-git-send-email-rappazzo@gmail.com>
References: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com, pclouds@gmail.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:53:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atj0t-0001sL-Ch
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 23:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbcDVVxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 17:53:15 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35602 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbcDVVxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 17:53:03 -0400
Received: by mail-yw0-f196.google.com with SMTP id v81so16133769ywa.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 14:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tl3xcyCbR0tuA19qYLpNqlOk364Csz3Jpyl4yyMogQI=;
        b=W84n4cMWhBToh5kcWpLiaItSxqmlkvHVIFooye+MYWQO4fjxOc7YsH/3gdvb8Q1hoM
         JyaQLM+w6PVoNjUK4WCW9hAfzVuLLibaBmlD0sAPuKIXwp+VXm0MnyykRvWWRQ3mQ2kk
         Obvisk+ERS6R0gP8Y/VEqVPVfs3WvWCG8gdtkiKJAQXfnQsO8Qt2vI3cA+XOm16kls1w
         n2PdfnmChfz0wTEwONQLGPQXIJpTz9ue3YkaBl6XOW1pXw+RHoBFyoVbNEVYs2IKU+fp
         txPEr5MwStU41mAk9dI7lzaClyF73TiSAUCqL2ni9o8lgrapxkA2HSNnZ45Lo0S6HeS0
         9Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tl3xcyCbR0tuA19qYLpNqlOk364Csz3Jpyl4yyMogQI=;
        b=S9rUTfVboCIP5C5/LT+Sswh5qXB19r8ZwL+rJRUYiVAn/7nAAorvq2+1SfN8K1cUhr
         6iCwpyZn+6lTDx5LQJq7SkgPjleaX7f8YugayzEc6wCObtOmFUZV7photmjNCAA0EELV
         UH5Y0kwLGdsiTN+Ut8kqAo7F5LzkUxzbnmk8iobk4uj1iU/u4eE1wC1CCN7VgHH8zyCj
         kvrwpLokArTp78Pa5uByDFMwJf51DLD19UYGdMmVqk1otnqTTxTEDC+/bwxDx0vCBjXr
         kOokdIf/cELlnNnAqLFFBWgobT9F8LLWqkggl30H/DysgwpNtGbRDfcQUjs0mUVJs7Vu
         okWA==
X-Gm-Message-State: AOPr4FXUkSkJyNsqvcQC4gzU+RwMY1fbgPD23cNUcL6ZSniBJ3ZgVyIGke796uKN5SVB1g==
X-Received: by 10.37.223.210 with SMTP id w201mr14781175ybg.74.1461361982794;
        Fri, 22 Apr 2016 14:53:02 -0700 (PDT)
Received: from MRappazzo-8.local.com (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id m141sm5542104ywd.2.2016.04.22.14.53.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 14:53:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461361992-91918-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292273>

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 t/t1500-rev-parse.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..1e220f7 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -36,6 +36,7 @@ test_rev_parse() {
 # label is-bare is-inside-git is-inside-work prefix git-dir
 
 ROOT=$(pwd)
+original_core_bare=$(git config core.bare)
 
 test_rev_parse toplevel false false true '' .git
 
@@ -84,4 +85,40 @@ test_rev_parse 'GIT_DIR=../repo.git, core.bare = true' true false false ''
 git config --unset core.bare
 test_rev_parse 'GIT_DIR=../repo.git, core.bare undefined' false false true ''
 
+#cleanup from the above
+cd ..
+rm -r work
+mv repo.git .git || exit 1
+unset GIT_DIR
+unset GIT_CONFIG
+git config core.bare $original_core_bare
+
+test_expect_success 'git-common-dir from worktree root' '
+	echo .git >expect &&
+	git rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-common-dir inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
+	git -C path/to/child rev-parse --git-common-dir >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path from worktree root' '
+	echo .git/objects >expect &&
+	git rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git-path inside sub-dir' '
+	mkdir -p path/to/child &&
+	test_when_finished "rm -rf path" &&
+	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
+	git -C path/to/child rev-parse --git-path objects >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.8.0
