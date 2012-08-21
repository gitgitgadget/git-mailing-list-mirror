From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCHv2 1/2] t6300: test sort with multiple keys
Date: Tue, 21 Aug 2012 09:46:06 +0200
Message-ID: <91678e1e50f23bdb2c3b2c5716f92d870a233e77.1345534654.git.draenog@pld-linux.org>
References: <e5b3ab37553f384235f3cb14e42f7e2b56507bde.1345410836.git.draenog@pld-linux.org>
 <7vk3wuo0sa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 09:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3jAW-0006W7-E4
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 09:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab2HUHq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 03:46:27 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34306 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab2HUHqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 03:46:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 59C445F0048;
	Tue, 21 Aug 2012 09:47:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Wbgw7ZBx+bhg; Tue, 21 Aug 2012 09:47:08 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 0B3C75F0047;
	Tue, 21 Aug 2012 09:47:08 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 9399446745; Tue, 21 Aug 2012 09:46:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk3wuo0sa.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203950>

Documentation of git-for-each-ref says that --sort=<key> option can be
used multiple times, in which case the last key becomes the primary key.
However this functionality was never checked in test suite and is
currently broken. This commit adds appropriate test in preparation for fix.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 t/t6300-for-each-ref.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 1721784..a0d82d4 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -456,4 +456,14 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+cat >expected <<\EOF
+408fe76d02a785a006c2e9c669b7be5589ede96d <committer@example.com> refs/tags/master
+90b5ebede4899eda64893bc2a4c8f1d6fb6dfc40 <committer@example.com> refs/tags/bogo
+EOF
+
+test_expect_failure 'Verify sort with multiple keys' '
+	git for-each-ref --format="%(objectname) %(taggeremail) %(refname)" --sort=objectname --sort=taggeremail \
+		refs/tags/bogo refs/tags/master > actual &&
+	test_cmp expected actual
+'
 test_done
-- 
1.7.12.rc3


-- 
  Kacper Kornet
