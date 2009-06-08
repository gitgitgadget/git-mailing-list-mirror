From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2 4/6] add a test for git-send-email for non-threaded mails
Date: Mon, 8 Jun 2009 08:41:59 +0200
Message-ID: <200906080842.00357.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <1244410857-920-5-git-send-email-markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 08:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDYYi-0003MY-QW
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 08:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbZFHGl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 02:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbZFHGl5
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 02:41:57 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53027 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZFHGl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 02:41:56 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id A29AD104BB288;
	Mon,  8 Jun 2009 08:41:58 +0200 (CEST)
Received: from [89.59.71.255] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDYYQ-0003tS-00; Mon, 08 Jun 2009 08:41:58 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1244410857-920-5-git-send-email-markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19VoqfTAOpDmc8FeIXRj5HVromz2hEVnYsnWEcR
	J/hkI7Ail4Vo1JRSIZ85J5aDenG7yuyHZSSAHhc8ZHpayLAnbV
	QNYS8XSoYUj2VuZJf6wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121037>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Differences to v1:
* dump stdout into a file and grep this
* use "test_must_fail grep" instead of "!git send-email"
  I'm not sure about this. When should test_must_fail be used and when
  is !command OK?

 t/t9001-send-email.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 990dd1a..4a4fa7f 100755
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
+	test_must_fail grep "In-Reply-To: " stdout
+'
+
 test_expect_success 'threading but no chain-reply-to' '
 	git send-email \
 		--dry-run \
-- 
1.6.3.2.220.gb421
