From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 2/3] rev-parse: add tests for git rev-parse --flags.
Date: Mon, 27 Sep 2010 00:44:06 +1000
Message-ID: <1285512247-15600-3-git-send-email-jon.seymour@gmail.com>
References: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 26 16:41:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzsPu-00071L-FI
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 16:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150Ab0IZOlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 10:41:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57008 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 10:41:09 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so988030pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/RW+ksEsn6wA/AUgRxnkesaNaM1OkMjkT5k8SM8RAcQ=;
        b=xBvMA9oqBKfhTyGYdNVAwquhNwa7zs+y/CSNG7BUM9O8eKOVqDhUhKKOAmmugjp/wm
         e3azmuzFUNtvzyvXmoNe7b0sJweYPfM7HLk6KcZkii+gWpxI6jCUG2ocIQXe8wXuumXw
         +FXuxpzImwZM/w+9wK8lhqBUMvGgJtiZ8q9Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sE0Nxd/xyAP1gC9fR/0J3A4aIzxviYSDOQIeJQflfd5C4vhapgEZse3NSAEOLrSpoT
         oGxwHQBkBf5ZKTfM63zmJxao7LzCBTb54ASGO2FAwdT43nThKAGJ6benmm2PpoCBs/Jl
         LSlCwhuLzSHvEB0kpe2j17olB0Bay7ltKlWTQ=
Received: by 10.143.33.3 with SMTP id l3mr5183415wfj.203.1285512069354;
        Sun, 26 Sep 2010 07:41:09 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id o9sm5877375wfd.4.2010.09.26.07.41.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 07:41:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.g9129b6
In-Reply-To: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157229>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1510-rev-parse-flags.sh |  174 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100755 t/t1510-rev-parse-flags.sh

diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
new file mode 100755
index 0000000..e327b96
--- /dev/null
+++ b/t/t1510-rev-parse-flags.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jon Seymour
+#
+
+test_description='test git rev-parse --flags'
+. ./test-lib.sh
+
+test_commit "A"
+
+test_expect_success 'git rev-parse --flags -> ""' \
+'
+	>expected &&
+	git rev-parse --flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
+'
+	>expected &&
+	git rev-parse --no-revs --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags HEAD -> sha1 of HEAD' \
+'
+	git rev-parse HEAD > expected &&
+	git rev-parse --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -X -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -- -q --> ""' \
+'
+	>expected &&
+	git rev-parse --flags -- -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -> "-X"' \
+'
+	printf "%s\n" -X > expected &&
+	git rev-parse --flags -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X -- Y -Z -> "-X"' \
+'
+	printf "%s\n" -X > expected &&
+	git rev-parse --flags -X -- Y -Z >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-flags --flags -X -> ""' \
+'
+	>expected &&
+	git rev-parse --no-flags --flags -X >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --symbolic --no-flags --flags HEAD -> "HEAD"' \
+'
+	echo HEAD >expected &&
+	git rev-parse --symbolic --no-flags --flags HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -q -> ""' \
+'
+	>expected &&
+	git rev-parse --flags -q >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags --no-flags -> ""' \
+'
+	>expected &&
+	git rev-parse --flags --no-flags >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs file -> "file"' \
+'
+	echo foo >file &&
+	echo file >expected &&
+	git rev-parse --no-revs file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags -X file -> "-X"' \
+'
+	echo foo >file &&
+	printf "%s\n" "-X" >expected &&
+	git rev-parse --flags -X file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs -- not-a-file -> "-- not-a-file"' \
+'
+	cat >expected <<-EOF &&
+--
+not-a-file
+	EOF
+	git rev-parse --no-revs -- not-a-file >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags --all -> list of revs' \
+'
+	cat >expected <<-EOF &&
+commit
+	EOF
+	git cat-file -t $(git rev-parse --flags --all | head -1) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'git rev-parse --no-revs --all -> list of revs' \
+'
+	cat >expected <<-EOF &&
+commit
+	EOF
+	git cat-file -t $(git rev-parse --no-revs --all | head -1) >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs --min-age=20100203 -> ""' \
+'
+	>expected &&
+	git rev-parse --no-revs --min-age=20100203 > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --flags --min-age=20100203 -> "--min-age=20100203" ' \
+'
+	printf "%s\n" "--min-age=20100203" >expected &&
+	git rev-parse --flags --min-age=20100203 > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git rev-parse --no-revs --flags --all -> ""' \
+'
+	>expected &&
+	git rev-parse --no-revs --flags --all >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.3.3.g9129b6
