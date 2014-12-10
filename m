From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] t1400: add some more tests of "update-ref --stdin"'s verify command
Date: Thu, 11 Dec 2014 00:47:51 +0100
Message-ID: <1418255272-5875-2-git-send-email-mhagger@alum.mit.edu>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqzI-0008I9-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758356AbaLJXsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:48:03 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:65096 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758335AbaLJXsC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 18:48:02 -0500
X-AuditID: 12074411-f79fa6d000006b8a-5e-5488dbb06151
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 41.90.27530.0BBD8845; Wed, 10 Dec 2014 18:48:01 -0500 (EST)
Received: from michael.fritz.box (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBANlut9003387
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 18:47:59 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqLvxdkeIwarDTBY710lYdF3pZrJo
	6L3CbPH25hJGi9sr5jNb9PZ9YrXYvLmdxYHd4+/7D0weO2fdZfdYsKnU4+Oz5eweFy8pe3ze
	JBfAFsVtk5RYUhacmZ6nb5fAnXFnRT9jwVvFiqOX+1kbGI9JdzFyckgImEhcaupnh7DFJC7c
	W8/WxcjFISRwmVHiyJ4PzBDOCSaJf++Os4BUsQnoSizqaWYCsUUE1CQmth1iASliFvjCKLF+
	3x+whLBAhMTe06vBbBYBVYmzt9eCreAVcJb4+3kp0FQOoHVyElvXeYOEOQVcJDbfWw5WLgRU
	cmvxTfYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRuYoSEm+AOxhkn
	5Q4xCnAwKvHwrrjaHiLEmlhWXJl7iFGSg0lJlLf3ekeIEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRHepBtAOd6UxMqq1KJ8mJQ0B4uSOC/fEnU/IYH0xJLU7NTUgtQimKwMB4eSBK/fLaBGwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBsxBcDowMkxQO09z9IO29xQWIuUBSi9RSj
	opQ4736QhABIIqM0D24sLIm8YhQH+lKYtxykigeYgOC6XwENZgIavHwL2OCSRISUVAPjPP1t
	D1umL2RldJ9TE9txfeFu/tliTy6evLIp63H4kizF6neip8I8eReoaT2yW2U9kWnmYY7C5krP
	u36vUkIzpJqmrz/Q+4EzLzDweVjSTQt++3sa2adu/d3ziN/rz0W17x7t9xpkWZyY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261262>

Two of the tests fail because

    verify refs/heads/foo

with no argument (not even zeros) actually *deletes* refs/heads/foo.
This problem will be fixed in the next commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
The two failing tests have to restore the $m reference when they're
done because otherwise the bug deletes it, causing subsequent tests
to fail.

 t/t1400-update-ref.sh | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7b4707b..6a3cdd1 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -619,6 +619,52 @@ test_expect_success 'stdin update/create/verify combination works' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+test_expect_success 'stdin verify succeeds for correct value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin verify succeeds for missing reference' '
+	echo "verify refs/heads/missing $Z" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin verify treats no value as missing' '
+	echo "verify refs/heads/missing" >stdin &&
+	git update-ref --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin verify fails for wrong value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $m~1" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin verify fails for mistaken null value' '
+	git rev-parse $m >expect &&
+	echo "verify $m $Z" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'stdin verify fails for mistaken empty value' '
+	M=$(git rev-parse $m) &&
+	test_when_finished "git update-ref $m $M" &&
+	git rev-parse $m >expect &&
+	echo "verify $m" >stdin &&
+	test_must_fail git update-ref --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin update refs works with identity updates' '
 	cat >stdin <<-EOF &&
 	update $a $m $m
@@ -938,6 +984,52 @@ test_expect_success 'stdin -z update/create/verify combination works' '
 	test_must_fail git rev-parse --verify -q $c
 '
 
+test_expect_success 'stdin -z verify succeeds for correct value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$m" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z verify succeeds for missing reference' '
+	printf $F "verify refs/heads/missing" "$Z" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin -z verify treats no value as missing' '
+	printf $F "verify refs/heads/missing" "" >stdin &&
+	git update-ref -z --stdin <stdin &&
+	test_must_fail git rev-parse --verify -q refs/heads/missing
+'
+
+test_expect_success 'stdin -z verify fails for wrong value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$m~1" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin -z verify fails for mistaken null value' '
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "$Z" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'stdin -z verify fails for mistaken empty value' '
+	M=$(git rev-parse $m) &&
+	test_when_finished "git update-ref $m $M" &&
+	git rev-parse $m >expect &&
+	printf $F "verify $m" "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin &&
+	git rev-parse $m >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stdin -z update refs works with identity updates' '
 	printf $F "update $a" "$m" "$m" "update $b" "$m" "$m" "update $c" "$Z" "" >stdin &&
 	git update-ref -z --stdin <stdin &&
-- 
2.1.3
