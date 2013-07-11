From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] t4203: consolidate test-repository setup
Date: Thu, 11 Jul 2013 10:55:28 -0400
Message-ID: <1373554528-15775-5-git-send-email-sunshine@sunshineco.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 16:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxIIK-0000E8-0e
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 16:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592Ab3GKO4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 10:56:21 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:58427 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549Ab3GKO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 10:56:18 -0400
Received: by mail-ye0-f179.google.com with SMTP id r3so2845585yen.10
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 07:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=T5u8Kldy6RHNdS0lLB2TCWXuBpuUEJmxpf6aVImx0gs=;
        b=B3CzBQk8+F5/TQ5kSzNV1WbBHxAn04Mu4wCxEzjOqA2M72CtfcdBgTlsQaZ0kcRTKB
         EobmXXH0FW+OZB6MIodsF7JVBPJPM/NFItiB/U0kk04ArX8+WXkh3IPY1m+SF7WT+BqK
         qQ78v1XWi7VDYPGTMcJoqAfe6SJqF/ELMjA1yBt6OknAGVV0CpFgH7BRV5C+Z8QQyyKj
         w1jvs2kRjW/PO6NDBbm2gR/56Pu0WUXG5Vj+LfNMlmL1q+R2nbQfMPTDYhouUgnl+zdK
         JJUf/FFetL6Y4SmXSyqyXyP/hoJdaVTHVv3OBFBoOWKXcdofDH6d3YYQP6I7QYDax5KR
         Tnpg==
X-Received: by 10.236.28.226 with SMTP id g62mr21031020yha.143.1373554578073;
        Thu, 11 Jul 2013 07:56:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id s29sm60841065yhf.6.2013.07.11.07.56.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jul 2013 07:56:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230103>

The simple two-commit test-repository created by 'setup' is no longer
needed by any of the tests retrofitted to use check-mailmap. Subsequent,
more complex tests of git-shortlog, git-log, and git-blame functionality
expand the repository by adding five commits. Consolidate the creation
of this seven-commit repository into a single setup function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4203-mailmap.sh | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 48a000b..9c3c83a 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -22,10 +22,36 @@ test_expect_success setup '
 	git add one &&
 	test_tick &&
 	git commit -m initial &&
+
 	echo two >>one &&
 	git add one &&
 	test_tick &&
-	git commit --author "nick1 <bugs@company.xx>" -m second
+	git commit --author "nick1 <bugs@company.xx>" -m second &&
+
+	echo three >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick2 <bugs@company.xx>" -m third &&
+
+	echo four >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick2 <nick2@company.xx>" -m fourth &&
+
+	echo five >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "santa <me@company.xx>" -m fifth &&
+
+	echo six >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "claus <me@company.xx>" -m sixth &&
+
+	echo seven >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "CTO <cto@coompany.xx>" -m seventh
 '
 
 test_expect_success 'check-mailmap no arguments' '
@@ -276,31 +302,6 @@ Some Dude <some@dude.xx> (1):
 EOF
 
 test_expect_success 'Shortlog output (complex mapping)' '
-	echo three >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick2 <bugs@company.xx>" -m third &&
-
-	echo four >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "nick2 <nick2@company.xx>" -m fourth &&
-
-	echo five >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "santa <me@company.xx>" -m fifth &&
-
-	echo six >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "claus <me@company.xx>" -m sixth &&
-
-	echo seven >>one &&
-	git add one &&
-	test_tick &&
-	git commit --author "CTO <cto@coompany.xx>" -m seventh &&
-
 	mkdir -p internal_mailmap &&
 	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
 	echo "<cto@company.xx>                       <cto@coompany.xx>" >> internal_mailmap/.mailmap &&
-- 
1.8.3.2
