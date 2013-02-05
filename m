From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] t4038: add tests for "diff --cc --raw <trees>"
Date: Tue, 5 Feb 2013 21:39:49 +0000
Message-ID: <20130205213949.GY1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
 <7vip696i3v.fsf@alter.siamese.dyndns.org>
 <20130205202558.GX1342@serenity.lan>
 <7v8v72sczp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:40:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qFY-0002ol-Re
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 22:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348Ab3BEVj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 16:39:57 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:45720 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756247Ab3BEVj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 16:39:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B7C0A6064A7;
	Tue,  5 Feb 2013 21:39:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1o4s7JGElb2; Tue,  5 Feb 2013 21:39:56 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 2F0D86064CD;
	Tue,  5 Feb 2013 21:39:51 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v8v72sczp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215542>

Signed-off-by: John Keeping <john@keeping.me.uk>

---
Changes since v1:

- more spaces around '|'
- create trees with line feeds and use 'sed -e 4q'
---
 t/t4038-diff-combined.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 40277c7..614425a 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -89,4 +89,28 @@ test_expect_success 'diagnose truncated file' '
 	grep "diff --cc file" out
 '
 
+test_expect_success 'setup for --cc --raw' '
+	blob=$(echo file | git hash-object --stdin -w) &&
+	base_tree=$(echo "100644 blob $blob	file" | git mktree) &&
+	trees= &&
+	for i in `test_seq 1 40`
+	do
+		blob=$(echo file$i | git hash-object --stdin -w) &&
+		trees="$trees$(echo "100644 blob $blob	file" | git mktree)$LF"
+	done
+'
+
+test_expect_success 'check --cc --raw with four trees' '
+	four_trees=$(echo "$trees" | sed -e 4q) &&
+	git diff --cc --raw $four_trees $base_tree >out &&
+	# Check for four leading colons in the output:
+	grep "^::::[^:]" out
+'
+
+test_expect_success 'check --cc --raw with forty trees' '
+	git diff --cc --raw $trees $base_tree >out &&
+	# Check for forty leading colons in the output:
+	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
+'
+
 test_done
-- 
1.8.1.2.689.g36c777b
