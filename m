From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 15/17] send-pack: read list of refs with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:59 -0700
Message-ID: <1446071161-15610-16-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZI7-0000ek-Kd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbbJ1Wdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:51 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755485AbbJ1Wd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8700D26A54;
	Wed, 28 Oct 2015 18:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=oXYt
	tFNyOPNHuGuNLaYK+iRsYrY=; b=fTSZ8wJtFxoDw/18gNdbkKnUhsfGuaULEmaW
	CDnATAo3++ct5jGlcjaW2yElryEChpxhqdK+a9Cs4d2ElL4mzJSQSLJpnAL+AVfl
	dF5ud2hrlV54K+WLxLQn1XsgxUeEdmiyHp0aSfBptY9gFv01UFg8o+BXj66e+cgy
	dE8nyv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qwhvZd
	THcnRrkmG2QhxPQ53MEzct55g/kw+gRmBqOD1OMfhlsbVdJGUsIMOk0PvHi0rcxF
	Xh7k5f8Noxear24UPC0E6oq7DumeB4XIVvXqUXBi0PFljy/u98KfDrs86wD4HsnI
	MXpKY7Tji8DjCa8Znzgt/fQHS8wLH/GhaCaB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8007626A53;
	Wed, 28 Oct 2015 18:26:25 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A09E26A51;
	Wed, 28 Oct 2015 18:26:24 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC8DC066-7DC2-11E5-8499-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280408>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f6e5d64..ba318c9 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				argv_array_push(&all_refspecs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline(&line, stdin, '\n') != EOF)
+			while (strbuf_gets(&line, stdin) != EOF)
 				argv_array_push(&all_refspecs, line.buf);
 			strbuf_release(&line);
 		}
-- 
2.6.2-423-g5314b62
