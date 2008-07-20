From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/2] git-add -a: tests
Date: Sat, 19 Jul 2008 20:32:38 -0700
Message-ID: <7vej5pgrhl.fsf_-_@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <20080717155538.GE11759@fieldses.org>
 <alpine.DEB.1.00.0807171915420.8986@racer>
 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm>
 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	"Jay Soffian" <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 05:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKPgB-0007q8-C2
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 05:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbYGTDcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 23:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYGTDcs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 23:32:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755292AbYGTDcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 23:32:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6FA363C32A;
	Sat, 19 Jul 2008 23:32:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A8ABB3C329; Sat, 19 Jul 2008 23:32:40 -0400 (EDT)
In-Reply-To: <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Sat, 19 Jul 2008 20:29:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83F4DEF8-560C-11DD-A1E3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89156>

And here is a small test script that makes sure that:

 - both modified and new files are included, and
 - no ignored files are included.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2202-add-addremove.sh |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
new file mode 100755
index 0000000..7bf8eda
--- /dev/null
+++ b/t/t2202-add-addremove.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git add -a'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo .gitignore >expect &&
+	(
+		echo actual
+		echo expect
+		echo ignored
+	) >.gitignore &&
+	git add -a &&
+	test_tick &&
+	git commit -m initial &&
+	git ls-files >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git add -a' '
+	(
+		echo .gitignore
+		echo not-ignored
+		echo "M	.gitignore"
+		echo "A	not-ignored"
+	) >expect &&
+	>ignored &&
+	>not-ignored &&
+	echo modification >>.gitignore &&
+	git add -a &&
+	git update-index --refresh &&
+	git ls-files >actual &&
+	git diff-index --name-status --cached HEAD >>actual &&
+	test_cmp expect actual
+'
+
+test_done
