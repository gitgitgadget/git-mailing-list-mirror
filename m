From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/5] t1500: test_rev_parse: facilitate future test enhancements
Date: Wed, 18 May 2016 16:15:42 -0400
Message-ID: <20160518201545.9113-3-sunshine@sunshineco.com>
References: <20160518201545.9113-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 22:16:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b37tK-00073n-7b
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 22:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbcERUQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 16:16:14 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:32809 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbcERUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 16:16:11 -0400
Received: by mail-io0-f196.google.com with SMTP id x35so11522995ioi.0
        for <git@vger.kernel.org>; Wed, 18 May 2016 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AbJIlnB8NuJ9ho75MR5h9pgB10wD0nRlldXWvhZ6nUc=;
        b=0jw/PlyibsXQPb7EmKaIdjvlQCHbn9j3pYSwRE2P9g9lZe0qPTLfyOhk8UpXZ37GCY
         NS4rxNyNwkwZubExs4tqvl7TfMFjNdZGwu7IvalbqIJIyaXvd9omVAAz5WroFIENfj52
         qkdXvwB9LbuIA2oBGQKuxnRvbOqCQ8vipf1jP2ILVOxfIPnBlmkDVmgGNXdkB2cpHtj0
         aJ0GVOGU/1wbZ7F67XjDzEwL/FcyOgzr4Z6888yHXxLk8bL80xJ/C/Xjs2MEQdKi+RRn
         BNMnxDEwwPynJqpBZExk9K59LBN2R9ULHXNMAzSVMq3PE8SvI6F9EzmJ/lPdsj+0Zwxk
         8vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=AbJIlnB8NuJ9ho75MR5h9pgB10wD0nRlldXWvhZ6nUc=;
        b=V1CHZcCkLx3N1ul9ZSoCV/p9GkEqnPLfkYC6/J/q77H4XHcTfH6QsosoVITtpEV4kG
         lQdczpEZhk9sd8GFriiZeYy1FL7/o+SqHQqy87Gh7OrJKM0gp2eWnUWJ8wo0w8dY+H7w
         RSGgV0IJx4Zo4WR/yUVTTcuTNnBU0GSaaVL2QVY/9qcCF4ahabUPIKA0xnlFY6VHxdwR
         4CtVD5+EI541OZNTzHivxwJdv8oYsdrJ71xNpepKiBvZciU4WVzvWOjG7DfHC+YLwc10
         JY9xm5egcijqJhKzkm8E0CmxHF770W03560OgytF1h6PF9/+pRhwR1UaTCG1iOd3JMS6
         xwlA==
X-Gm-Message-State: AOPr4FVCgepFYy/WewqgjlOUYpHfDCSju1uxdesoJBzNVopwfJcoAS6vhRkILt0+80M0Zg==
X-Received: by 10.107.186.6 with SMTP id k6mr6830347iof.136.1463602570267;
        Wed, 18 May 2016 13:16:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id q15sm3241137iod.6.2016.05.18.13.16.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 13:16:07 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.748.g927f425
In-Reply-To: <20160518201545.9113-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295003>

Tests run by test_rev_parse() are nearly identical; each invokes
git-rev-parse with a single option and compares the result against an
expected value. Such duplication makes it onerous to extend the tests
since any change needs to be repeated in each test. Avoid the
duplication by parameterizing the test and driving it via a for-loop.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 0194f54..ecc575b 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,38 +3,28 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
-test_rev_parse() {
+# usage: label is-bare is-inside-git is-inside-work prefix git-dir
+test_rev_parse () {
 	name=$1
 	shift
 
-	test_expect_success "$name: is-bare-repository" \
-	"test '$1' = \"\$(git rev-parse --is-bare-repository)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-git-dir" \
-	"test '$1' = \"\$(git rev-parse --is-inside-git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: is-inside-work-tree" \
-	"test '$1' = \"\$(git rev-parse --is-inside-work-tree)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: prefix" \
-	"test '$1' = \"\$(git rev-parse --show-prefix)\""
-	shift
-	[ $# -eq 0 ] && return
-
-	test_expect_success "$name: git-dir" \
-	"test '$1' = \"\$(git rev-parse --git-dir)\""
-	shift
-	[ $# -eq 0 ] && return
+	for o in --is-bare-repository \
+		 --is-inside-git-dir \
+		 --is-inside-work-tree \
+		 --show-prefix \
+		 --git-dir
+	do
+		test $# -eq 0 && break
+		expect="$1"
+		test_expect_success "$name: $o" '
+			echo "$expect" >expect &&
+			git rev-parse $o >actual &&
+			test_cmp expect actual
+		'
+		shift
+	done
 }
 
-# label is-bare is-inside-git is-inside-work prefix git-dir
-
 ROOT=$(pwd)
 
 test_expect_success 'setup' '
-- 
2.8.2.748.g927f425
