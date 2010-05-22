From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/8] grep: add test script for binary file handling
Date: Sat, 22 May 2010 23:26:39 +0200
Message-ID: <4BF84C0F.8010907@lsrfire.ath.cx>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org> <4BF84B9E.7060009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 23:27:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFwDh-0000mK-RQ
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 23:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777Ab0EVV0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 17:26:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:51043 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758716Ab0EVV0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 17:26:52 -0400
Received: from [10.0.1.100] (p57B7F4C3.dip.t-dialin.net [87.183.244.195])
	by india601.server4you.de (Postfix) with ESMTPSA id 29D3C2F8069;
	Sat, 22 May 2010 23:26:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BF84B9E.7060009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147542>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t7008-grep-binary.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 t/t7008-grep-binary.sh

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
new file mode 100755
index 0000000..2320e74
--- /dev/null
+++ b/t/t7008-grep-binary.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='git grep in binary files'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' "
+	printf 'binary\000file\n' >a &&
+	git add a &&
+	git commit -m.
+"
+
+test_expect_success 'git grep ina a' '
+	echo Binary file a matches >expect &&
+	git grep ina a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -ah ina a' '
+	git grep -ah ina a >actual &&
+	test_cmp a actual
+'
+
+test_expect_success 'git grep -I ina a' '
+	: >expect &&
+	test_must_fail git grep -I ina a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -L bar a' '
+	echo a >expect &&
+	git grep -L bar a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -q ina a' '
+	: >expect &&
+	git grep -q ina a >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.1
