From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/34] t4001-diff-rename: wrap file creations in a test
Date: Sun,  3 Apr 2016 10:23:28 -0700
Message-ID: <1459704240-28792-2-git-send-email-gitster@pobox.com>
References: <1459704240-28792-1-git-send-email-gitster@pobox.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 19:24:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amll2-0006kJ-0o
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 19:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcDCRYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 13:24:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751280AbcDCRYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 13:24:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB78A50F7B;
	Sun,  3 Apr 2016 13:24:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=62IH
	pGwqLevJcOkl88cAyA1g02Y=; b=lsnW6Vu+5C5Aw9IbcnF+nJVFhAXFJgVH9bAb
	gPLQxI9pjWfEI9tsr2oYElpHY/o0uYK98Y1kFc6G0DEG750s8BPw0IT7ABuGeVfo
	XaAn9AuFNsHUGZRsFhC9WMU+RL7jTPoA6kw6fR9Dx/AETg4lebkWswojlcxx8pgB
	FjvWkpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	GEyDCDfyGrEOYh7WRf404Wf5i3E8Cp3nfEPoiQcCMzzYwKHe00UOtZ5/GZyml/Up
	8B2S3diWILDls/fj70rSQ9GAAEEnOtA0zzbf86EgJClm3xQqAx3/Qb5iX8UZ7U84
	kRnPACS7NYomyysxMblHnkZj++nR+nVa2Uyxk++XN+k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C2B4350F79;
	Sun,  3 Apr 2016 13:24:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4981750F77;
	Sun,  3 Apr 2016 13:24:04 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-246-g1783343
In-Reply-To: <1459704240-28792-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DD1961BA-F9C0-11E5-9A27-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290641>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4001-diff-rename.sh | 66 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 2f327b7..06b8828 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -9,21 +9,40 @@ test_description='Test rename detection in diff engine.
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-echo >path0 'Line 1
-Line 2
-Line 3
-Line 4
-Line 5
-Line 6
-Line 7
-Line 8
-Line 9
-Line 10
-line 11
-Line 12
-Line 13
-Line 14
-Line 15
+test_expect_success 'setup' '
+	cat >path0 <<-\EOF &&
+	Line 1
+	Line 2
+	Line 3
+	Line 4
+	Line 5
+	Line 6
+	Line 7
+	Line 8
+	Line 9
+	Line 10
+	line 11
+	Line 12
+	Line 13
+	Line 14
+	Line 15
+	EOF
+	cat >expected <<-\EOF
+	diff --git a/path0 b/path1
+	rename from path0
+	rename to path1
+	--- a/path0
+	+++ b/path1
+	@@ -8,7 +8,7 @@ Line 7
+	 Line 8
+	 Line 9
+	 Line 10
+	-line 11
+	+Line 11
+	 Line 12
+	 Line 13
+	 Line 14
+	EOF
 '
 
 test_expect_success \
@@ -43,22 +62,7 @@ test_expect_success \
 test_expect_success \
     'git diff-index -p -M after rename and editing.' \
     'git diff-index -p -M $tree >current'
-cat >expected <<\EOF
-diff --git a/path0 b/path1
-rename from path0
-rename to path1
---- a/path0
-+++ b/path1
-@@ -8,7 +8,7 @@ Line 7
- Line 8
- Line 9
- Line 10
--line 11
-+Line 11
- Line 12
- Line 13
- Line 14
-EOF
+
 
 test_expect_success \
     'validate the output.' \
-- 
2.8.0-246-g1783343
