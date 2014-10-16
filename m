From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 4/5] t7610-mergetool: use test_config to isolate tests
Date: Wed, 15 Oct 2014 22:30:04 -0700
Message-ID: <1413437404-23810-1-git-send-email-davvid@gmail.com>
References: <xmqqwq81ujlw.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 07:29:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeddA-0004Cj-0f
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 07:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbaJPF3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 01:29:39 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56646 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbaJPF3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 01:29:38 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so2575647pdi.19
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9XvHegy4zMRzYyPZv51xnr+Y+epw3b3tb+ymI9/8CgE=;
        b=XKQAqDPfjX9HMNDsWcyPOEjRPoKSSnxi1/noRK0n+SksosBhIPXMcv0JqysypISiij
         honIoskanvQ1IECb0TGbIzYuLMWcbnlO9KYp3g1YYcV9HDszpFvG06V8H1uNTO61mhL4
         pM73+PTfT6/JQiLVW1LKC/83dne49TEXPuawfrlQFOniONGM+RfczRm3uy0ruEcJHgkO
         KJBfuA5knEwuZp29dwJTf46F707sCPk7I2MdM767Ay3eAFsUqwKJIMjBCmPcnu8hWiS7
         rCc/Nt70I83KYzWbADg6PLsV329XJrXPMjUQcQPoeAj8zG7CizXWlOtAtQ38SYWmWEg4
         JVBg==
X-Received: by 10.68.216.70 with SMTP id oo6mr2373958pbc.124.1413437378270;
        Wed, 15 Oct 2014 22:29:38 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id r8sm2916023pds.35.2014.10.15.22.29.35
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 22:29:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
In-Reply-To: <xmqqwq81ujlw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is a replacement patch for
"t7610-mergetool: prefer test_config over git config"
in da/mergetool-tests.

Changes since v1:

The changes are more surgical and the commit message mentions
why we are using test_config.

 t/t7610-mergetool.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 1a15e06..4fec633 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -112,7 +112,7 @@ test_expect_success 'custom mergetool' '
 '
 
 test_expect_success 'mergetool crlf' '
-	git config core.autocrlf true &&
+	test_config core.autocrlf true &&
 	git checkout -b test2 branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
@@ -505,14 +505,12 @@ test_expect_success 'file with no base' '
 
 test_expect_success 'custom commands override built-ins' '
 	git checkout -b test14 branch1 &&
-	git config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
-	git config mergetool.defaults.trustExitCode true &&
+	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
+	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool defaults -- both &&
 	echo master both added >expected &&
 	test_cmp both expected &&
-	git config --unset mergetool.defaults.cmd &&
-	git config --unset mergetool.defaults.trustExitCode &&
 	git reset --hard master >/dev/null 2>&1
 '
 
-- 
2.1.2.453.g1b015e3
