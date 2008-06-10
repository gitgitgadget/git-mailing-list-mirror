From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH 1/2] Add testcases for verifying that staged files in a conflict are CRLF, when core.autocrlf = true
Date: Tue, 10 Jun 2008 09:40:07 +0200
Message-ID: <2e371261399563d49665f26eb06dd19fd3b071cb.1213084587.git.marius@trolltech.com>
References: <cover.1213084587.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:14:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5yzg-0006ET-QL
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbYFJINA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753284AbYFJINA
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:13:00 -0400
Received: from hoat.troll.no ([62.70.27.150]:34168 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753499AbYFJIMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 04:12:55 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id B0E9720AF8;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 93EE2209E4;
	Tue, 10 Jun 2008 10:12:49 +0200 (CEST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84481>

When you 'git show :2:<file>' in a conflict, the file should have CRLF EOLs,
if the repo is configured with core.autocrlf = true.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 t/t6033-merge-crlf.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t6033-merge-crlf.sh b/t/t6033-merge-crlf.sh
index 75d9602..f161b40 100755
--- a/t/t6033-merge-crlf.sh
+++ b/t/t6033-merge-crlf.sh
@@ -49,4 +49,22 @@ test_expect_success 'Check that conflict file is CRLF' '
 	test_cmp file file.temp
 '
 
+test_expect_failure 'Check that staged file :1: is CRLF' '
+	git show :1:file >staged.temp1 &&
+	git show :1:file | remove_cr | append_cr >staged.temp2 &&
+	test_cmp staged.temp1 staged.temp2
+'
+
+test_expect_failure 'Check that staged file :2: is CRLF' '
+	git show :2:file >staged.temp1 &&
+	git show :2:file | remove_cr | append_cr >staged.temp2 &&
+	test_cmp staged.temp1 staged.temp2
+'
+
+test_expect_failure 'Check that staged file :3: is CRLF' '
+	git show :3:file >staged.temp1 &&
+	git show :3:file | remove_cr | append_cr >staged.temp2 &&
+	test_cmp staged.temp1 staged.temp2
+'
+
 test_done
-- 
1.5.6.rc2.158.g3478
