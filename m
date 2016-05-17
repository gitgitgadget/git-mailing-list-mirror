From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/5] t1500: test_rev_parse: facilitate future test enhancements
Date: Tue, 17 May 2016 15:36:27 -0400
Message-ID: <20160517193630.10379-3-sunshine@sunshineco.com>
References: <20160517193630.10379-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:37:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2ko6-000071-C5
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbcEQThT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:37:19 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33037 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcEQThP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:37:15 -0400
Received: by mail-io0-f193.google.com with SMTP id x35so5523053ioi.0
        for <git@vger.kernel.org>; Tue, 17 May 2016 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PhPjxua3VRDLqy2mGhmuxrJIKhCkeZlWN+h+wpu7DfU=;
        b=ObeXWiPlTvNyCPBcNtCxOCYzRIFTqGVeRMMdqYEnil4fUwkw6bUzIDtS8/wDpJQasg
         /dFDw0nnmwu95xPPzCtgTAwwaxUogpHmwLq4mfr5fGvfRtz/1vzg4kuMLjcHnsd2Cg8E
         qLyYNGC7MnevFesslW12Fc7y2uu9CMEfkxK24mut0P7zXMX+cHiIDzeQxphsq/LPNWHc
         ktY5WZjKQ1sPyig/kVX3wqmGmOMTSsdWHrd0o+gbqtDqguQkESzAJopC4BSrwNjX1xum
         EEozTwLuhHWfh0yEO1uLi+daLKJNDlixZKJjo08m0ln2BKIErZVOT2Ed4PTfldo5NguM
         7anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=PhPjxua3VRDLqy2mGhmuxrJIKhCkeZlWN+h+wpu7DfU=;
        b=J4GTHozm1YxxrwpXJjGyMhJde1EX5xr4arbC+mN+5jNEffoXbRVM37Y52AL52RibJU
         0XbcmZuQdJYsPTg8EcyyZoDZdBJ/a1oF0DjYeIdUrM6q5hv37YsVtT4AIzEwzWsy/GzV
         DdVu9oNSiTSja5tdLoKUhfUnZuVPDaVzpgnqSrKVHu9n12PoCgtLMf1UvhPFSaxxDafz
         1YKpnmSc86+O1plX+pYvxrUMy7h8VZ0VtWc++jkon1fGcX3mmIJvkuZIfepMmFxXGc1S
         wzC812RHzMSMuxJZvkbSaxSR3B1iDXn0D4wVF8zKVEb02egFC2GJ1km/HALNGf5bxUOy
         C7qw==
X-Gm-Message-State: AOPr4FXmBtSHVd3J5J69GJpdShz74tl/t+2h8EHHtpLRlPWYFxCSq9H33YAEYM41kQHvZA==
X-Received: by 10.36.144.131 with SMTP id x125mr2370891itd.62.1463513834682;
        Tue, 17 May 2016 12:37:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id b67sm1506218iob.33.2016.05.17.12.37.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 May 2016 12:37:14 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.703.g78b384c
In-Reply-To: <20160517193630.10379-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294901>

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
index 0194f54..c84f5c3 100755
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
+	for o in is-bare-repository \
+		 is-inside-git-dir \
+		 is-inside-work-tree \
+		 show-prefix \
+		 git-dir
+	do
+		test $# -eq 0 && break
+		expect="$1"
+		test_expect_success "$name: $o" '
+			echo "$expect" >expect &&
+			git rev-parse --$o >actual &&
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
2.8.2.703.g78b384c
