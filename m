From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH v3 4/6] add a test for git-send-email for non-threaded mails
Date: Mon, 8 Jun 2009 09:13:16 +0200
Message-ID: <200906080913.16894.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <200906080842.00357.markus.heidelberg@web.de> <7vd49f8b1f.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 09:13:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDZ2r-00052t-R8
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 09:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbZFHHNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 03:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbZFHHNO
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 03:13:14 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47360 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZFHHNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 03:13:13 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 97EC1FF0AC27;
	Mon,  8 Jun 2009 09:13:15 +0200 (CEST)
Received: from [89.59.71.255] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDZ2h-0002SB-00; Mon, 08 Jun 2009 09:13:15 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vd49f8b1f.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19i8SKS/A2OP/vsTxPs+5k/NmSqp4X1S4baTgDx
	C5ayNuynPYV10b1YqcNDT5ZLdq9/EXtGcu5/Svf2Nz8MJq8/cL
	JQ5IG5VW1k5AW1HnpsRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121042>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Junio C Hamano, 08.06.2009:
> Generally, we protect "git" (i.e. what we write ourselves) with test_must_fail
> so that we can catch stupid segfaulting crash we introduce ourselves
> (unlike "! git foo", "test_must_fail git foo" says "oh, no, it did not
> correctly fail" if git segfaults).  We do not expect "grep" to segfault
> (iow we are not testing "grep"), so it is customary to say "! grep".

Thanks for the explanation.

Differences to v2:
* "! grep" instead of "test_must_fail grep"


 t/t9001-send-email.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 990dd1a..20efdc1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,6 +621,16 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'no in-reply-to and no threading' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--nothread \
+		$patches $patches >stdout &&
+	! grep "In-Reply-To: " stdout
+'
+
 test_expect_success 'threading but no chain-reply-to' '
 	git send-email \
 		--dry-run \
-- 
1.6.3.2.224.gaa543
