From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v13 3/6] t0040-parse-options: improve test coverage
Date: Sat, 9 Apr 2016 12:23:20 +0000
Message-ID: <01020153faf9fcbf-e99e4a5b-b892-4e4a-8de5-84ee4315f01d-000000@eu-west-1.amazonses.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 14:23:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aorvM-0004iC-D6
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388AbcDIMX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 08:23:26 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:40614
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753080AbcDIMXX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 08:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460204600;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=6P476ldkn1H7NZV/MIa9ROE8Q1ZCAlf2LTBzpX2bqK0=;
	b=J7bjLbiTtTglVUQO7t1sy463sX5lZ5Qq+/79fdaeylLoug/+F6qIpT5gUXNfltrz
	IghHUs2OCITpRY8wBmXsAtUhN416vQIx8Zq5JU3b2UTB6M9I2ICStvzwdicGduKBqGy
	V6p/ZkvnO7zW2PMK6WlELbovUNMSdi9RrDZ0QScY=
In-Reply-To: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.09-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291095>

Include tests to check for multiple levels of quiet and to check if the
'--no-quiet' option sets it to 0.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t0040-parse-options.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 450da45..c913d1c 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -476,4 +476,41 @@ test_expect_success '--no-list resets list' '
 	test_cmp expect output
 '
 
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: 3
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success 'multiple quiet levels' '
+	test-parse-options -q -q -q >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
+cat >expect <<\EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: 0
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success '--no-quiet sets quiet to 0' '
+	test-parse-options --no-quiet >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
 test_done

--
https://github.com/git/git/pull/218
