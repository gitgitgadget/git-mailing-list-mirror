From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 1/7] tests: test number comes first in 'not ok $count -
 $message'
Date: Thu, 20 Dec 2012 19:12:32 -0800
Message-ID: <1356059558-23479-2-git-send-email-gitster@pobox.com>
References: <1356059558-23479-1-git-send-email-gitster@pobox.com>
Cc: Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 04:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlt2i-0008TT-Mz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 04:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab2LUDMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 22:12:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690Ab2LUDMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 22:12:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFB05A80E;
	Thu, 20 Dec 2012 22:12:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; s=sasl; bh=vVZ7g7k5NNRgNB3e4xs+xHyWCKY=; b=kAAl9vKm
	zibuJVdb3zJWAQ8YnIMfmcwdc8B4z1uVujelVM12asELZ6tZb+4NZlexSSJ41p3c
	Oo7cE8AkEpLvWDgKHeUXNrEXB3QAA+krWe98WuLZL1gGsjmkQFcgOypNVnkRWkPP
	PsuQFb1252a7YzkSJ98+AK3m7HQkEx0HskM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; q=dns; s=sasl; b=e4o83waFlJzbFgcGe5wkY3RGkrjNfzNAR8
	ifeEKuC2/HkhtReuRV1jkm9Vmshy8gVYw4hRGgfGFf4znY50eLV2mZHSLqWX0/Lf
	dAJgH1ACV5bgAZUPFu53PZlXG9c2KmRSWCZmbT4J/p4xBqFOEioLTDR1k28B7Bo0
	qYfLrdR0c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD5F6A80D;
	Thu, 20 Dec 2012 22:12:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FCEDA80C; Thu, 20 Dec 2012
 22:12:42 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.225.g8d36ab4
In-Reply-To: <1356059558-23479-1-git-send-email-gitster@pobox.com>
In-Reply-To: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
X-Pobox-Relay-ID: 487FA344-4B1C-11E2-A0B9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211943>

From: Adam Spiers <git@adamspiers.org>

The old output to say "not ok - 1 messsage" was working by accident
only because the test numbers are optional in TAP.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0000-basic.sh | 4 ++--
 t/test-lib.sh    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae6a3f0..c6b42de 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -167,13 +167,13 @@ test_expect_success 'tests clean up even on failures' "
 	! test -s err &&
 	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
 	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
-	> not ok - 1 tests clean up even after a failure
+	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
 	> #	test_when_finished rm clean-after-failure &&
 	> #	(exit 1)
 	> #	Z
-	> not ok - 2 failure to clean up causes the test to fail
+	> not ok 2 - failure to clean up causes the test to fail
 	> #	Z
 	> #	test_when_finished \"(exit 2)\"
 	> #	Z
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..03b86b8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -268,7 +268,7 @@ test_ok_ () {
 
 test_failure_ () {
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok - $test_count $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
-- 
1.8.1.rc2.225.g8d36ab4
