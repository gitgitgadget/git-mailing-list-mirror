From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH v2 2/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Mon, 8 Jun 2009 08:37:31 +0200
Message-ID: <200906080837.31548.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <7v7hznaaji.fsf@alter.siamese.dyndns.org> <200906080747.18233.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 08:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDYUM-0000Ia-Li
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 08:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbZFHGha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 02:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZFHGh3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 02:37:29 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48171 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbZFHGh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 02:37:28 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 33BEF104BB1A5;
	Mon,  8 Jun 2009 08:37:30 +0200 (CEST)
Received: from [89.59.71.255] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDYU5-0002c9-00; Mon, 08 Jun 2009 08:37:30 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200906080747.18233.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18dI+JZBcsvUoEFsfhA4/mK+lKRSPNB/XqQbCz8
	oiilrC3XN/LaYtNSScFmMbuAkwBzeoByj4D2EI8G22Q+ENXbf/
	rLRTy1klfkHAOgFak9Cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121036>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

Markus Heidelberg, 08.06.2009:
> Junio C Hamano, 08.06.2009:
> > Markus Heidelberg <markus.heidelberg@web.de> writes:
> > 
> > > +test_expect_failure 'threading but no chain-reply-to' '
> > > +	git send-email \
> > > +		--dry-run \
> > > +		--from="Example <nobody@example.com>" \
> > > +		--to=nobody@example.com \
> > > +		--thread \
> > > +		--nochain-reply-to \
> > > +		$patches $patches |
> > > +	grep "In-Reply-To: "
> > > +'
> > 
> > Thanks, but this is not a very good style, as it won't catch if "git
> > send-email" dumps core or otherwise fails, exiting with a non-zero status.
> > 
> > Same comments applies to [PATCH 4/6] as well.
> 
> OK, this was my first attempt in writing a test and I just used the last
> test 'in-reply-to but no threading' as template.
> 
> What can be done to make the test better?

Is this change sufficient? Dumping the stdout into a file and grepping
this.


 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..8f810ab 100755
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
1.6.3.2.220.gb421
