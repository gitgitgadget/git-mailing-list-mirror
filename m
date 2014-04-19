From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] transport-helper: remove barely used xchgline()
Date: Sat, 19 Apr 2014 00:00:39 -0700
Message-ID: <1397890843-27035-2-git-send-email-gitster@pobox.com>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 08:59:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbPFA-0006zt-EC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 08:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbaDSG7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 02:59:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36795 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbaDSG7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 02:59:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CDD6E602;
	Sat, 19 Apr 2014 02:59:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=2FX2
	czPdpQY+5rLUWPbRjNTnc0w=; b=sfD/xjHEz6md+kPyo0HhFE7WO6uCFjAkDEK3
	rRvP+bEkPsmV5Ifb9zDr7zMWjTFGy530jbUdgtSDwf03aXYQF7b1SFJk+MnwIQlK
	pWSAdZdgMT549n7To8xlvnTuZ7Z1CofOYD1uQQikn+BaTVDcyeMQ6MjSlwWFkazE
	sB41vdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Cf+dxgAqnIeOif9WJ4EFzU9vbeGf7YmrfvgI0jF/RF62FmWtgJyC72ZCMGO+cBaP
	Zff9KSe+vmSMXTQhkq1Bugv+HN/ev8fGbOh/NyOZ2eVowju0TtQhqQBZnw22t5mD
	1Os6/2sTvRQvkW3ZmCw8FMtDHNELm6/jMYGeRk0g5pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E6326E601;
	Sat, 19 Apr 2014 02:59:11 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C70B6E600;
	Sat, 19 Apr 2014 02:59:09 -0400 (EDT)
X-Mailer: git-send-email 1.9.2-459-g68773ac
In-Reply-To: <1397890843-27035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1ADFCC24-C790-11E3-8784-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246503>

From: Felipe Contreras <felipe.contreras@gmail.com>

It's only used once, we can just call the two functions inside directly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 86e1679..892107c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -71,12 +71,6 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 	return recvline_fh(helper->out, buffer, helper->name);
 }
 
-static void xchgline(struct helper_data *helper, struct strbuf *buffer)
-{
-	sendline(helper, buffer);
-	recvline(helper, buffer);
-}
-
 static void write_constant(int fd, const char *str)
 {
 	if (debug)
@@ -307,7 +301,8 @@ static int set_helper_option(struct transport *transport,
 		quote_c_style(value, &buf, NULL, 0);
 	strbuf_addch(&buf, '\n');
 
-	xchgline(data, &buf);
+	sendline(data, &buf);
+	recvline(data, &buf);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
-- 
1.9.2-459-g68773ac
