From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] ws.c: add a helper to format comma separated messages
Date: Fri, 27 May 2011 15:48:51 -0700
Message-ID: <7vr57jrc8c.fsf_-_@alter.siamese.dyndns.org>
References: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
 <7vzkm9unu0.fsf@alter.siamese.dyndns.org>
 <BANLkTi=hYR4ow1eMR3rHkMuVRsHJ=TFDZA@mail.gmail.com>
 <m262owhyuy.fsf@igel.home>
 <BANLkTimPfN6LQBhWj6rW3Zcm9JHPsMWsjA@mail.gmail.com>
 <7vipswro57.fsf@alter.siamese.dyndns.org>
 <7vboyorm4i.fsf@alter.siamese.dyndns.org>
 <BANLkTinwOr5Yzp_N6BNyNK5Y1FcVtdtbUw@mail.gmail.com>
 <7vy61rrcae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 28 00:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ5q7-0004gV-MW
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 00:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab1E0WtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 18:49:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab1E0WtB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 18:49:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F2595AA3;
	Fri, 27 May 2011 18:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FqAEZ12zWI8RBbXA9y947rowYkk=; b=a4TGqy
	Vs83GNN6etd0OG1RqiFogi53HaJdQw/seE8pNG8W7b0TwfLD/iIhuiArjpowSf67
	GXwsgoENRyaQe2xPsWV3qumj88xAX4ukp7P3Mkv4kttOjxONJEVkimDnaDaD9ry2
	jVHCxRT3RjDOqSMyPPn72CJZdVCSHGsjLQWeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AJuXJ0z+GP6NHx5BA9HRiS7J5XmblCJD
	ufJNYhnlpcgI0suhHP/DWqapXJFKiY9R8+wyAznQRs76rVLDGazyqytSpLkugJRp
	WnoQqvRqe6x6ePzC+bmuDjUf+xCWT+kn1mXnP1DQgsAPoqVru+KPtkr1uAFSmvYE
	uEi8AvBz7KI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C8785AA1;
	Fri, 27 May 2011 18:51:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C3A015AA0; Fri, 27 May 2011
 18:50:59 -0400 (EDT)
In-Reply-To: <7vy61rrcae.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 27 May 2011 15:47:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD00510E-88B3-11E0-A186-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174651>

We can find more than one class of whitespace errors on a single line,
and we concatenate a message per class in a strbuf, separated with a
colon. Use a small helper function to make the code easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Just a trivial clean-up before waging a "War on nbsp"

 ws.c |   43 +++++++++++++++++++------------------------
 1 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/ws.c b/ws.c
index 9fb9b14..3058be4 100644
--- a/ws.c
+++ b/ws.c
@@ -116,36 +116,31 @@ unsigned whitespace_rule(const char *pathname)
 	}
 }
 
+static void add_err_item(struct strbuf *err, const char *message)
+{
+	if (err->len)
+		strbuf_addstr(err, ", ");
+	strbuf_addstr(err, message);
+}
+
 /* The returned string should be freed by the caller. */
 char *whitespace_error_string(unsigned ws)
 {
 	struct strbuf err = STRBUF_INIT;
-	if ((ws & WS_TRAILING_SPACE) == WS_TRAILING_SPACE)
-		strbuf_addstr(&err, "trailing whitespace");
-	else {
+	if ((ws & WS_TRAILING_SPACE) == WS_TRAILING_SPACE) {
+		add_err_item(&err, "trailing whitespace");
+	} else {
 		if (ws & WS_BLANK_AT_EOL)
-			strbuf_addstr(&err, "trailing whitespace");
-		if (ws & WS_BLANK_AT_EOF) {
-			if (err.len)
-				strbuf_addstr(&err, ", ");
-			strbuf_addstr(&err, "new blank line at EOF");
-		}
-	}
-	if (ws & WS_SPACE_BEFORE_TAB) {
-		if (err.len)
-			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "space before tab in indent");
-	}
-	if (ws & WS_INDENT_WITH_NON_TAB) {
-		if (err.len)
-			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "indent with spaces");
-	}
-	if (ws & WS_TAB_IN_INDENT) {
-		if (err.len)
-			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "tab in indent");
+			add_err_item(&err, "trailing whitespace");
+		if (ws & WS_BLANK_AT_EOF)
+			add_err_item(&err, "new blank line at EOF");
 	}
+	if (ws & WS_SPACE_BEFORE_TAB)
+		add_err_item(&err, "space before tab in indent");
+	if (ws & WS_INDENT_WITH_NON_TAB)
+		add_err_item(&err, "indent with spaces");
+	if (ws & WS_TAB_IN_INDENT)
+		add_err_item(&err, "tab in indent");
 	return strbuf_detach(&err, NULL);
 }
 
-- 
1.7.5.3.503.g893a4
