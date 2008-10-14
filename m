From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH] t1301-shared-repo.sh: don't let a default ACL interfere
	with the test
Date: Tue, 14 Oct 2008 18:07:00 -0400
Message-ID: <1224022020.2699.4.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 00:11:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kps6Y-0005kh-C9
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbYJNWJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbYJNWJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:09:25 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:33333 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbYJNWJX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:09:23 -0400
Received: from jankymail-a3.g.dreamhost.com (sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 2B50E17A6DC
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 15:09:22 -0700 (PDT)
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a3.g.dreamhost.com (Postfix) with ESMTP id 443A1651D4;
	Tue, 14 Oct 2008 15:07:49 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98217>

This test creates files with several different umasks and expects the files to
be permissioned according to the umasks, so a default ACL on the test dir causes
the test to fail.  To avoid that, remove the default ACL if possible with
setfacl(1).  (Will work on many systems.)
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
