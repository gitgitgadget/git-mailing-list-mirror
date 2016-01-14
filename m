From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/21] hash-object: read --stdin-paths with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:25 -0800
Message-ID: <1452815916-6447-11-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnr-0003ph-G8
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbcANX66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932085AbcANX6z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF7473CD7D;
	Thu, 14 Jan 2016 18:58:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tkiM
	XfEa4pD/KLVuerOTXTwpe1Y=; b=Kdbsx+DuqfBAjhjZR9XKwSeeq1V8hr5ylPXL
	LNn0qnVsEwB4i8IknV1dqXlnr8NFyOSs4T+KFg0MCPpWiK5bp6AmanrWORlYHNWu
	pprzYMeWvWLqfu5wLJhxVh0+hJ9KBoQYYJMu4rpZOr52fCugv3/zeTljTSFWXLLT
	JhxF7yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	XfhJBu0C9YS3IhdlZlhh0F+rf1narVJ7AmE1vEua9SK6X+ickzaqvev5eK+j9ZSc
	xTMSRR3fAt+BdbkMlXelM8RX5d56v2M9AKkxjFJh7vUF6JUFgpituTjgZ5XmIu5L
	5CoxVgmIq1wMse9YlLNYlCut+mtipLi2sg0onlFlYLY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D577E3CD7C;
	Thu, 14 Jan 2016 18:58:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B5F43CD7A;
	Thu, 14 Jan 2016 18:58:54 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C465F1C2-BB1A-11E5-84B7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284120>

The list of paths could have been written with a DOS editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 3bc5ec1..ff20395 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -60,7 +60,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 {
 	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&nbuf);
 			if (unquote_c_style(&nbuf, buf.buf, NULL))
-- 
2.7.0-250-ge1b5ba3
