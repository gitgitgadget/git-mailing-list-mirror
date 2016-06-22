Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E492018B
	for <e@80x24.org>; Wed, 22 Jun 2016 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbcFVPCe (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 11:02:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:58364 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcFVPCS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 11:02:18 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Likl3-1bny5g3gOj-00cyrl; Wed, 22 Jun 2016 17:02:13
 +0200
Date:	Wed, 22 Jun 2016 17:02:13 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 10/10] Ensure that log respects --output=<file>
In-Reply-To: <cover.1466607667.git.johannes.schindelin@gmx.de>
Message-ID: <3c348a91842a38cbf3631fea11a832785d76a6ea.1466607667.git.johannes.schindelin@gmx.de>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o+D/rHD+ApGaZvnJyiiqpaYlvMtfk7grDyb5nnKpe0WJYQfFioM
 SmiKr9EVIGXcm9jx6wcJ3HKyZI0TKU4s3sIa89o2y2LC360xS716qFbw0hIPy6cnupqfl5O
 3DVN6i2Nwg9elmwBtFkYw7oDLruIoiyGkRBDPnULohfLCa53lT0s7i2ik44bndXj9J5QWgs
 fQ4TIbAyqvSA3HBo1A6JQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uFtVy6YnaIc=:aNUC9q77k6neIwA5I9AiLz
 1xO3hehimVp5gmBKFZHX1mVx7J8D+5+rfIR82a1qm1Oo8oDZ3WzSsek9yJXas1ydfzW7HYMO0
 YSLJjL1BjCSj4T+eSjG4yriysqTHwEwWZBHCDyA/Yxajv8CYWkrJSRJ8Vjxl0X5O5wsBpVqNY
 n+WTBzNE44tcCBVWPIQdJ/QBJIJK2QGIgBB5R6TE31PJKXYxcfBvLCVUsDV642sWyzGYzOu/s
 PybiSpGKpG9aq/O0fy1hw2H0vU9Gc5aKchATm1DNmyo+PWugKwslouEIZ0fU0H9EYN6IN4jbz
 Qc7pCwU/vQR9vBpracOkpsKTVSC3oYAuDaMWXNlLA8pAR36wjNUV3i2q2Sy3gFHNpbleIAa6i
 ULNJYWvDt6iPUPIDelISj0Tm02BEo6E1kL9NaxKV4sJ1IBYtr7ESfRee1Lth0u8Ghpd0Glud0
 HUMRcCWnsemOunccTklM3hO4COyDnrUVr4OsIwvtEOsIBEguYjIgYUi3t4ohd3r1AHOyR3W3o
 W2xxV5fKVhi2/rih32L3FKIbbYsJUOMeFAGRfdAgFbbqTwe2Cv1Et2y4LT7z4M22mmnefe1k2
 KQYu4RiCIIYy6GbbvL2TLGERdGRbkgDv36hba4NPflgzMLTEkAwqh4Bwp60Qvuowe/zeKDJ3h
 QkVFfSZ+U7l5TTrzHGWQQb38CsoOr5jbztTP+2Z75qtXteeW2Y5+LR3ZAOZOWzwD3Lsv7VauR
 B+pf3AIAD0XljBcupQBc+hHTWpOtGYPgwKUFA+9GXS8OQmo9ZvI2x8FSeebDq+TpW73bL2LkQ
 BIq5Uey
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The test script t4202-log.sh is already pretty long, and it is a good
idea to test --output with a more obscure option, anyway. So let's
test it in conjunction with line-log.

The most important part of this test, of course, is to ensure that the
file is not closed after writing the diff, but only at the very end
of the log output. That is the entire reason why the test tries to
generate a log that covers more than one commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4211-line-log.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 4451127..9d87777 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -99,4 +99,11 @@ test_expect_success '-L with --first-parent and a merge' '
 	git log --first-parent -L 1,1:b.c
 '
 
+test_expect_success '-L with --output' '
+	git checkout parallel-change &&
+	git log --output=log -L :main:b.c >output &&
+	test ! -s output &&
+	test_line_count = 70 log
+'
+
 test_done
-- 
2.9.0.118.g0e1a633
