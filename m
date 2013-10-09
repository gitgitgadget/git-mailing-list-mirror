From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] checkout tests: enable test with complex relative path
Date: Wed,  9 Oct 2013 16:35:11 +0200
Message-ID: <1381329311-5920-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Wed Oct 09 16:35:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTur5-0001kW-8T
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab3JIOfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 10:35:07 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:51703 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab3JIOfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:35:06 -0400
Received: by mail-ee0-f43.google.com with SMTP id e52so462668eek.30
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MDzaKzlo5bamjW1tKmANH/BnUs2L3QJDpKwrEXFun1M=;
        b=R7S8C9u7/i0yemEa6iqG+MeEHJ7OJDFAo+fHwOk/C///yLsQt1wkfqWmZ1r1ZM+ag9
         RJvZQENzl+uD6LN8bih4Cdre4+XhI3D4xZ0EP2cWl0xyTIIyCMPfaNO65Q6RSW0oizmX
         8cKUzJgJrQKYVr2p+IdaMgvJj1JsB0d5v56S2pPac4l/6i8vA+FxuY4rPr66sMgRP+t4
         dOGZgPhzOZAVInuSmTg6tB/m3hRMshefvj6DpkYcqg9WEoiRXb5JRCdJlmyj0/7NWSZq
         6HL3e0Fz2SqBbWYLRWupNtHaA0jFxg3UD7xkwvxhFuPvyn0pfDu3gn0h2CyEj+vhmsi4
         qvHA==
X-Received: by 10.15.81.137 with SMTP id x9mr661914eey.77.1381329304194;
        Wed, 09 Oct 2013 07:35:04 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id f49sm89512605eec.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:35:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.471.g53f64e4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235812>

This test was put in, but commented out in fed1b5ca (2007-11-09,
git-checkout: Test for relative path use.)
It's been a while since 2007 and the intended test case works now.
(I could not find the enabling commit in ls-files however.)

The code in question however did not change into the sub directory,
so we still need to add a 'cd'. Also a test for the file content has been
added. This is already part of the other tests for checkout.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 t/t2008-checkout-subdir.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 3e098ab..399655f 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -58,13 +58,14 @@ test_expect_success 'checkout with simple prefix' '
 
 '
 
-# This is not expected to work as ls-files was not designed
-# to deal with such.  Enable it when ls-files is updated.
-: test_expect_success 'checkout with complex relative path' '
-
-	rm file1 &&
-	git checkout HEAD -- ../dir1/../dir1/file1 && test -f ./file1
-
+test_expect_success 'checkout with complex relative path' '
+	(
+		cd dir1 &&
+		rm file1 &&
+		git checkout HEAD -- ../dir1/../dir1/file1 &&
+		test -f file1 &&
+		test "hello" = "$(cat file1)"
+	)
 '
 
 test_expect_success 'relative path outside tree should fail' \
-- 
1.8.4.1.471.g53f64e4.dirty
