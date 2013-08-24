From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
Date: Sat, 24 Aug 2013 13:34:14 -0700
Message-ID: <20130824203414.GD2960@elie.Belkin>
References: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
 <1377316906-70338-4-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Sat Aug 24 22:34:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDKXP-0003Lu-HN
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 22:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab3HXUeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 16:34:19 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:40417 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab3HXUeT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 16:34:19 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so1933473pbc.8
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J4Tr6VGYmykogqhkeGFeQHak0UadAZA76WgMbvo0fEg=;
        b=FY3nPXODdcq1EASt4Wp9XApzKDHXKpwW9EhY9SQT4PsRJbaRRcpwIQoW3EexhqaVBg
         R9pq5pIhpdMLrq1mMi5MnTc5hD0l2FOEu7mi2birWyID2k+Ne/rntxzkEb8aZ3f5nzTP
         MCgxlzGae9tlxyXdSpqwT37FSaI1wE+mFCM62zIp+FNInEELfgp9BCXt+QTekflEPcXG
         UgQaaMQtxC2sbJ/YK85tq6RihFf/XIi6RBy1bwCh/xZyjLSYTOC5tBBAzkuNya+xBF7c
         E4xD/uHiRS1wTIJQFwdvAqtnZnPKLdwzCc8qvqB1rCWoyjH5kfj6/2AW9bejAk0GWUao
         EE+g==
X-Received: by 10.68.252.233 with SMTP id zv9mr6612348pbc.69.1377376458699;
        Sat, 24 Aug 2013 13:34:18 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ai6sm9517116pad.15.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 13:34:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377316906-70338-4-git-send-email-draenog@pld-linux.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232891>

Kacper Kornet wrote:

> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>

Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Here's a style cleanup on top.

-- >8 --
Subject: reset test: modernize style

Avoid command substitution and pipes to ensure that the exit status
from each git command is tested (and in particular that any segfaults
are caught).

Maintain the test setup (no commits, one file named "a", another named
"b") even after the last test, to make it easier to rearrange tests or
add new tests after the last in the future.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7106-reset-unborn-branch.sh | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index 499cd88c..af00ab4d 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -11,7 +11,10 @@ test_expect_success 'setup' '
 test_expect_success 'reset' '
 	git add a b &&
 	git reset &&
-	test "$(git ls-files)" = ""
+
+	>expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'reset HEAD' '
@@ -24,28 +27,42 @@ test_expect_success 'reset $file' '
 	rm .git/index &&
 	git add a b &&
 	git reset a &&
-	test "$(git ls-files)" = "b"
+
+	echo b >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success PERL 'reset -p' '
 	rm .git/index &&
 	git add a &&
-	echo y | git reset -p &&
-	test "$(git ls-files)" = ""
+	echo y >yes &&
+	git reset -p <yes &&
+
+	>expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'reset --soft is a no-op' '
 	rm .git/index &&
 	git add a &&
-	git reset --soft
-	test "$(git ls-files)" = "a"
+	git reset --soft &&
+
+	echo a >expect &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'reset --hard' '
 	rm .git/index &&
 	git add a &&
+	test_when_finished "echo a >a" &&
 	git reset --hard &&
-	test "$(git ls-files)" = "" &&
+
+	>expect &&
+	git ls-files >actual &&
+	test_cmp expect actual &&
 	test_path_is_missing a
 '
 
-- 
1.8.4.rc4
