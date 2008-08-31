From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t6013: replace use of 'tac' with equivalent Perl
Date: Mon,  1 Sep 2008 00:31:37 +0200
Message-ID: <1220221897-6081-1-git-send-email-trast@student.ethz.ch>
References: <1220212998-90810-1-git-send-email-benji@silverinsanity.com>
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 00:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZvZg-0003GV-2h
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 00:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbYHaWby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 18:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbYHaWby
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 18:31:54 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:14677 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbYHaWbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 18:31:53 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 00:31:52 +0200
Received: from localhost.localdomain ([84.75.158.234]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 00:31:51 +0200
X-Mailer: git-send-email 1.6.0.1.282.g3cc57
In-Reply-To: <1220212998-90810-1-git-send-email-benji@silverinsanity.com>
X-OriginalArrivalTime: 31 Aug 2008 22:31:51.0699 (UTC) FILETIME=[5D2F0E30:01C90BB9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94512>

'tac' is not available everywhere, so substitute the equivalent Perl
code 'print reverse <>'.  Noticed by Brian Gernhardt.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Thanks for pointing this out.  However, I tried to avoid hardcoding
those results by recommendation of t/README (last paragraph):

  ... If all the test scripts hardcoded the object IDs like
  t0000-basic.sh does, that defeats the purpose of t0000-basic.sh,
  which is to isolate that level of validation in one place.  Your
  test also ends up needing updating when such a change to the
  internal happens, so do _not_ do it and leave the low level of
  validation to t0000-basic.sh.

So I would favour this fix.  I think this should be ok because we
depend on Perl anyway.

- Thomas


 t/t6013-rev-list-reverse-parents.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index d294466..59fc2f0 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -25,7 +25,7 @@ test_expect_success 'set up --reverse example' '
 
 test_expect_success '--reverse --parents --full-history combines correctly' '
 	git rev-list --parents --full-history master -- foo |
-		tac > expected &&
+		perl -e "print reverse <>" > expected &&
 	git rev-list --reverse --parents --full-history master -- foo \
 		> actual &&
 	test_cmp actual expected
@@ -33,7 +33,7 @@ test_expect_success '--reverse --parents --full-history combines correctly' '
 
 test_expect_success '--boundary does too' '
 	git rev-list --boundary --parents --full-history master ^root -- foo |
-		tac > expected &&
+		perl -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		master ^root -- foo > actual &&
 	test_cmp actual expected
-- 
1.6.0.1.282.g3cc57
