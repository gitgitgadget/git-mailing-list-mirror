From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/17] update-index: read --index-info with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:47 -0700
Message-ID: <1446071161-15610-4-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZHk-0000NQ-9k
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbbJ1Wdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:31 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751968AbbJ1Wd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C70F426A17;
	Wed, 28 Oct 2015 18:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=V8Nn
	SGzWqayWwqEYsLmOGgWO7iM=; b=bnxMl1sOY9+7OuS4GcCuSe+w8i3WtDm06ugr
	OOgOmG+pXqH7fZgcfrpLdiB+vkbynVLjEZD8lKAVkEd+Uh1x/Rgw/x2uP3sm3RFc
	dA+vd0w4kWbPj8MK9deCJHPoJPrTJscCgwytfvFzhHj+xBWL4AGuODuGB61XH6WC
	9oyx9lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hWsIM0
	xqICM1st2Qv7nDmpru8xwlXgyodaljdj6jk8PWdhRckMMmOaGo94xmOuj1BxjHpO
	KjSGjwEpZOV3W59GacpkMbYj80KJ32USaGx7+6GtpJtz+GtWs7O9Om8SWcj9iwfC
	uV8ww6OacP7qjqRuF+7HiXlmHcigpailsfHM8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C053726A16;
	Wed, 28 Oct 2015 18:26:07 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B59326A15;
	Wed, 28 Oct 2015 18:26:07 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1FC6080-7DC2-11E5-B22E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280404>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..dfc65a8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -473,7 +473,9 @@ static void read_index_info(int line_termination)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
 
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+	while ((line_termination
+		? strbuf_gets(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
 		unsigned char sha1[20];
-- 
2.6.2-423-g5314b62
