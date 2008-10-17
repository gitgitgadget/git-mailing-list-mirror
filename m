From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH try 3] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Thu, 16 Oct 2008 22:28:47 -0400
Message-ID: <1224210527.2952.41.camel@mattlaptop2.local>
References: <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 04:30:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqf6P-0004dx-HR
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 04:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYJQC2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 22:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYJQC2t
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 22:28:49 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:38312 "EHLO
	jankymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751517AbYJQC2t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2008 22:28:49 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a5.g.dreamhost.com (Postfix) with ESMTP id 6E3A813EA9;
	Thu, 16 Oct 2008 19:28:48 -0700 (PDT)
In-Reply-To: <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98444>

This test creates files with several different umasks and expects thei
permissions to be initialized according to the umask, so a default ACL on the
trash directory (which overrides the umask for files created in that directory)
causes the test to fail.  To avoid that, remove the default ACL if possible with
setfacl(1).

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
 t/t1301-shared-repo.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index dc85e8b..2275caa 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -7,6 +7,9 @@ test_description='Test shared repository initialization'
 
 . ./test-lib.sh
 
+# Remove a default ACL from the test dir if possible.
+setfacl -k . 2>/dev/null
+
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	mkdir sub && (
-- 
1.6.0.2.530.gb503b
