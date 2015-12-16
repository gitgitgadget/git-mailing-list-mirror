From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/17] hash-object: read --stdin-paths with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:07 -0800
Message-ID: <1450303398-25900-7-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KBD-0001uL-2V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967105AbbLPWEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:04:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966684AbbLPWDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A876B325C3;
	Wed, 16 Dec 2015 17:03:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Nqra
	McXXKjLHUXopH5OkNPv1brk=; b=cJXpjqcboTaExcHpjKd3imar/YnIvcapNLoV
	xSfCuIUk5+a3+L2lgSOfiRWp3zxZIFtcbMKTU7aR1JYucygTQuYahiuc+sl07Ccj
	ORDlDxsiSnDgwIUmmrW/gnv1fDHZBCzRwtO15t2GjTWxa/ZsiplUzM9D6OWhbyw8
	mgkQQ9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QOP5MJ
	wXsl16ZCHtOaAJLZComGfHYBe5prpefZkzbItqRbAMq7oFNKyXlvp5Fudy28ac9W
	a3HrQwK97GPrxuL+k5uz1g6GP5PPPF1sCVHqurZ9i8GNBK7ZLxIFOS+abBAwWVB3
	56izkCgv3oQzPjVXJ4P8CZqdTZSIgdsko3LAE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F05C325C2;
	Wed, 16 Dec 2015 17:03:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 21643325C1;
	Wed, 16 Dec 2015 17:03:29 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D6B1A79A-A440-11E5-8BD1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282613>

The list of paths could have been written with a DOS editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 43b098b..57c743d 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline_crlf(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
-- 
2.7.0-rc1-83-ga8b6b9e
