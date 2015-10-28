From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/17] hash-object: read --stdin-paths with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:50 -0700
Message-ID: <1446071161-15610-7-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZI8-0000ek-7T
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbbJ1Wdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:50 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932084AbbJ1Wd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56ACB26A2A;
	Wed, 28 Oct 2015 18:26:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=PfJc
	P95hSmvFKflDTvP89NNJm68=; b=YuJgxNUNpQyr7flcpg4EyKI17emhAcQI8T9l
	DOWRQucaZEGAIzt05pCFsjIzejmlxwHZsNKuVyiZKLxZh1lolLeLoHb82GUVqLat
	leo7c/sEN8+XQ2WCFVvA9IVspxGCKvQkW9M1y6ymPTMSIRmHa0XJEAHjVcpoZ7dx
	USEiJpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=JE05uX
	MNTRCqrCc+tDH33/bNVCUtl+Ep9ViVeppLzdK8iWgMD03gBEJqX7vBom6pCNGUtZ
	8w9ujKN8eOkcNpiFp07ZGp3I4GICKaDMEwvyoI4ojmzoY+dGk9+wZduHydOt/Ixh
	MxQjuJofrlRXt4qH5SNMmX2UDz4P93F4jiXRE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4EFDD26A29;
	Wed, 28 Oct 2015 18:26:12 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B065F26A28;
	Wed, 28 Oct 2015 18:26:11 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E49E21FC-7DC2-11E5-AB1D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280409>

The list of paths could have been written with a DOS editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 43b098b..46d55e5 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_gets(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
-- 
2.6.2-423-g5314b62
