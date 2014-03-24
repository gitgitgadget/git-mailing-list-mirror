From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/27] parse_cmd_verify(): Copy old_sha1 instead of evaluating <oldvalue> twice
Date: Mon, 24 Mar 2014 18:56:41 +0100
Message-ID: <1395683820-17304-9-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS996-0002Oo-WA
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbaCXR5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:43460 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753779AbaCXR50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:26 -0400
X-AuditID: 1207440c-f79656d000003eba-46-533072058404
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 92.AF.16058.50270335; Mon, 24 Mar 2014 13:57:25 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xe028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:23 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqMtaZBBs8P20isXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO2Nv333WgrnsFU/mnGBvYGxg62Lk5JAQMJF4tOo9
	E4QtJnHh3nqgOBeHkMBlRomXc48wQjgnmCS+LH/PDlLFJqArsainGaxDREBNYmLbIRaQImaB
	K4wSVz5uB3I4OIQFkiTefHIBqWERUJXY8HcpK4jNK+Ai8XbFBqhtchJTfi8Am8kp4Cqxtf0w
	M4gtBFSz42Mv0wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQkKP
	Zwfjt3UyhxgFOBiVeHgjjA2ChVgTy4orcw8xSnIwKYnysuUChfiS8lMqMxKLM+KLSnNSiw8x
	SnAwK4nwWoYD5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxhhUCN
	gkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdorwNIO29xQWIuUBSi
	9RSjopQ477UCoIQASCKjNA9uLCyhvGIUB/pSmDcBpJ0HmIzgul8BDWYCGhzepAcyuCQRISXV
	wJjKGvFyweS9l1ocM0PNbt9+7Wy/aBGHmt++vQ9k4tkNZ1orWa1QtJz2oan4tl1wtu4V57K8
	N+u/65obpGf5Gv4qYcy4etFPnfHNUa1O5vRNnJfeT6hsdTPWUn6zd82sS6eNfKP9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244848>

Aside from avoiding a tiny bit of work, this makes it transparently
obvious that old_sha1 and new_sha1 are identical.  It is arguably a
bit silly to have to set new_sha1 in order to verify old_sha1, but
that is a problem for another day.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5f197fe..51adf2d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -249,7 +249,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	if (!parse_next_arg(input, &next, &value)) {
 		update_store_old_sha1(update, value.buf);
-		update_store_new_sha1(update, value.buf);
+		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", ref.buf);
 
-- 
1.9.0
