From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v14 3/6] t0040-parse-options: improve test coverage
Date: Tue, 12 Apr 2016 23:02:17 +0000
Message-ID: <010201540cb60965-887d5e4b-b12d-4477-8271-eefa349ceddd-000000@eu-west-1.amazonses.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:02:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7KD-0002bS-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395AbcDLXCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:02:20 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:35716
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933588AbcDLXCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460502137;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=6P476ldkn1H7NZV/MIa9ROE8Q1ZCAlf2LTBzpX2bqK0=;
	b=ERtsnU9J0nUBVtk4DOhu2ahcuuHsn4aVE8FEIzVhrdCSfV3RuTMvHN/6KGxX/07z
	6DVoZ2EcPDPZZCh4B/vC2WCYnYxnI6mZO56atDkQeXSmvGLvQQr+uBzEPW7zb97gCY1
	btmiUJ7KHBcKr44yThysXGcsNVP4ziWQigU36VqU=
In-Reply-To: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.12-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291310>

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
