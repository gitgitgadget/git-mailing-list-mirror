From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 2/2] t0001-init: split the existence test from the permission
 test
Date: Sun, 09 Aug 2009 18:02:55 +0200
Message-ID: <4A7EF32F.6080408@kdbg.org>
References: <4A7EED5C.8050707@kdbg.org> <4A7EEDA7.30301@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 18:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaArT-0008Hu-Q1
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 18:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbZHIQC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 12:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbZHIQC4
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 12:02:56 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29168 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbZHIQCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 12:02:55 -0400
Received: from [192.168.1.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 971152C400E;
	Sun,  9 Aug 2009 18:02:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A7EEDA7.30301@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125350>

The test for correct permissions after init created a deep directory
must be guarded by POSIXPERM. But testing that the deep dirctory exists
is good even on platforms that do not provide the POSIXPERM prerequiste.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
  Sorry, the first version was the result of mindless copying. This version
  removes the sub-shell (parentheses).

  -- Hannes

  t/t0001-init.sh |    6 ++++++
  1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 07e011d..5386504 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -244,6 +244,12 @@ test_expect_success 'init recreates a new bare directory' '

  test_expect_success 'init creates a new deep directory' '
  	rm -fr newdir &&
+	git init newdir/a/b/c &&
+	test -d newdir/a/b/c/.git/refs
+'
+
+test_expect_success POSIXPERM 'init creates a new deep directory (umask vs. shared)' '
+	rm -fr newdir &&
  	(
  		# Leading directories should honor umask while
  		# the repository itself should follow "shared"
-- 
1.6.4.1186.g1d9a

	
