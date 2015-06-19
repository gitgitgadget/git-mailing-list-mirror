From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/3] Correct test-parse-options to handle negative ints
Date: Fri, 19 Jun 2015 10:10:57 +0100
Message-ID: <1434705059-2793-2-git-send-email-charles@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
To: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 19 11:37:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5sjx-0004yT-US
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 11:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbbFSJhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 05:37:33 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:51116 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbbFSJh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 05:37:29 -0400
Received: from hashpling.plus.com ([212.159.69.125]:41965)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z5sKQ-0006de-9U; Fri, 19 Jun 2015 10:11:14 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434705059-2793-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272117>

From: Charles Bailey <cbailey32@bloomberg.net>

Fix the printf specification to treat 'integer' as the signed type that
it is and add a test that checks that we parse negative option
arguments.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 t/t0040-parse-options.sh | 2 ++
 test-parse-options.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index b044785..ecb7417 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -151,6 +151,8 @@ test_expect_success 'short options' '
 	test_must_be_empty output.err
 '
 
+test_expect_success 'OPT_INT() negative' 'check integer: -2345 -i -2345'
+
 cat > expect << EOF
 boolean: 2
 integer: 1729
diff --git a/test-parse-options.c b/test-parse-options.c
index 5dabce6..7c492cf 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -82,7 +82,7 @@ int main(int argc, char **argv)
 	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
-	printf("integer: %u\n", integer);
+	printf("integer: %d\n", integer);
 	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
-- 
2.4.0.53.g8440f74
