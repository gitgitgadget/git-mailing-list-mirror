From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add testcase for merge.log
Date: Thu, 10 Jul 2008 10:32:22 +0200
Message-ID: <1215678742-14042-1-git-send-email-vmiklos@frugalware.org>
References: <7v7ibuqisc.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 10:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGraN-0006xb-Oz
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 10:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYGJIcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYGJIcI
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 04:32:08 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:40278 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbYGJIcI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 04:32:08 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 013691DDC5B;
	Thu, 10 Jul 2008 10:32:03 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 25CF01A9833; Thu, 10 Jul 2008 10:32:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.450.g8d367.dirty
In-Reply-To: <7v7ibuqisc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87959>

Make sure that the merge.log boolean config setting is the same as --log
and --no-log.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jul 10, 2008 at 12:50:59AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> The command forgot the configuration variable when rewritten in C.

Thanks. Here is a testcase.

 t/t7600-merge.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index dfddd86..a3c17a9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -456,6 +456,17 @@ test_expect_success 'merge log message' '
 	verify_diff msg.log msg.act "[OOPS] bad merge log message"
 '
 
+test_expect_success 'merge log message (from config)' '
+	git reset --hard c0 &&
+	git merge c2 &&
+	git show -s --pretty=format:%b HEAD >msg.act &&
+	verify_diff msg.nolog msg.act "[OOPS] bad merge log message" &&
+	git config merge.log true &&
+	git merge c3 &&
+	git show -s --pretty=format:%b HEAD >msg.act &&
+	verify_diff msg.log msg.act "[OOPS] bad merge log message"
+'
+
 test_debug 'gitk --all'
 
 test_done
-- 
1.5.6.2.450.g8d367.dirty
