From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 5/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Wed, 10 Jun 2009 00:17:20 -0700
Message-ID: <7v63f4tv5r.fsf@alter.siamese.dyndns.org>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
	<1244410857-920-4-git-send-email-markus.heidelberg@web.de>
	<7vhbyo1vr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEI3u-0008U7-Fw
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 09:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZFJHRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 03:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbZFJHRV
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 03:17:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52746 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbZFJHRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 03:17:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610071721.NTFY17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jun 2009 03:17:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 27HL1c0034aMwMQ037HLn6; Wed, 10 Jun 2009 03:17:20 -0400
X-VR-Score: -62.00
X-Authority-Analysis: v=1.0 c=1 a=COURJG6UegQA:10 a=VqIWn-QgypsA:10
 a=ybZZDoGAAAAA:8 a=A1X0JdhQAAAA:8 a=fDOIlMP_eIBrm5cMrcIA:9
 a=lycm9mWphSe_Z8_kftM5y6wVryoA:4 a=5N_Nib3jKbIA:10 a=XTUYKXyG0EEA:10
 a=5KVauyKsRKMA:10 a=qIVjreYYsbEA:10 a=Y6qChIQXU1wA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121258>

From: Markus Heidelberg <markus.heidelberg@web.de>
Date: Mon, 8 Jun 2009 08:37:31 +0200

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be applied on top of:
   - applying 1/6, 2/6 and 3/6 to maint
   - applying 4/6 to 15da108; then
   - merging the above two together.
   to demonstrate the fix in 4/6

 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2ce24cd..4f67de3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,15 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'threading but no chain-reply-to' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--thread \
+		--nochain-reply-to \
+		$patches $patches >stdout &&
+	grep "In-Reply-To: " stdout
+'
+
 test_done
-- 
1.6.3.2.214.gf4f78e
