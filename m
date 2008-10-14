From: Matt McCutchen <matt@mattmccutchen.net>
Subject: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL
	interfere with the test
Date: Tue, 14 Oct 2008 18:10:16 -0400
Message-ID: <1224022216.2699.5.camel@mattlaptop2.local>
References: <1224022020.2699.4.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 00:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kps9b-0006wx-42
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbYJNWMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbYJNWMh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:12:37 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:52136 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782AbYJNWMg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:12:36 -0400
Received: from jankymail-a4.g.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 2BDA117ACF6
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 15:12:35 -0700 (PDT)
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id C2044181124;
	Tue, 14 Oct 2008 15:11:04 -0700 (PDT)
In-Reply-To: <1224022020.2699.4.camel@mattlaptop2.local>
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98218>

This test creates files with several different umasks and expects the files to
be permissioned according to the umasks, so a default ACL on the test dir causes
the test to fail.  To avoid that, remove the default ACL if possible with
setfacl(1).  (Will work on many systems.)

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---
This time with a signoff.

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
