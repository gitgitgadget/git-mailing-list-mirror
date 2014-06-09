From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/7] test: turn EXPENSIVE into a lazy prerequisite
Date: Mon,  9 Jun 2014 16:22:49 -0700
Message-ID: <1402356175-7249-2-git-send-email-gitster@pobox.com>
References: <1402356175-7249-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 01:23:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu8uO-0004Aw-02
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 01:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934427AbaFIXXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 19:23:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55298 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaFIXXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 19:23:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 688141D3F7;
	Mon,  9 Jun 2014 19:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vSzn
	fG35tadwNzIfeAR3YyRep/4=; b=BP8XuCdy4M/lU+E7Qm8y1bk9ZW5qNK3OfWpo
	/kChJPvKN1VgpuBrMJLAb/gT63v00GDFA6Kmg9vPb3O0Jfp/EWyiYcmA3S9h0DAo
	sAclqsDTMPC7kzAbaV5hm0dr+RtYdkPsOSIy7USqjfr0IjIO97prnmoNCt3VU02R
	30t9vnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=U5ecBA
	DJqWJpHCEZI26J8xixICBToJVoEvhKA7TUKhCDh71qA+F9Sj4/+jGhKMwJUhMV+P
	6RIKRhad6m+q4lXRsMGB/RcdDtUTMwcf2l2xUX+fNoWkYWiPUem9k+p40VxqMrxB
	0QLmE3vbVkb4f4adG1D+WPo83v7WDburEkQDk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F6671D3F6;
	Mon,  9 Jun 2014 19:23:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7867A1D3F2;
	Mon,  9 Jun 2014 19:23:02 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-483-g1a584c4
In-Reply-To: <1402356175-7249-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0091EF9E-F02D-11E3-BE02-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251132>

Two test scripts (t0021 and t5551) had copy & paste code to set
EXPENSIVE prerequisite.  Use the test_lazy_prereq helper to define
them in the common t/test-lib.sh.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0021-conversion.sh | 2 --
 t/t5551-http-fetch.sh | 2 --
 t/test-lib.sh         | 4 ++++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index b92e6cb..f890c54 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -190,8 +190,6 @@ test_expect_success 'required filter clean failure' '
 	test_must_fail git add test.fc
 '
 
-test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
-
 test_expect_success EXPENSIVE 'filter large file' '
 	git config filter.largefile.smudge cat &&
 	git config filter.largefile.clean cat &&
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index afb439e..d697393 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -214,8 +214,6 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
-test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
-
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b25249e..d70d05e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -855,6 +855,10 @@ test_lazy_prereq AUTOIDENT '
 	git var GIT_AUTHOR_IDENT
 '
 
+test_lazy_prereq EXPENSIVE '
+	test -n "$GIT_TEST_LONG"
+'
+
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
 test -w / || test_set_prereq SANITY
-- 
2.0.0-435-g307a092
