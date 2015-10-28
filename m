From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/17] column: read lines with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:58 -0700
Message-ID: <1446071161-15610-15-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIL-0000sm-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbbJ1WeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:08 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754653AbbJ1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1779526A4F;
	Wed, 28 Oct 2015 18:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4PDb
	8wQr/VrTgeiqFLXpXmVBPpA=; b=QSCM04/9n23kRk7kUnPCz8tAXmuC4DOIV2SC
	qNuQ3Y0ogIob2Mph0upvieaMpWtDrVg3Ddu4s4sSqBDvtA7mq8wHhYjczMiABT0c
	vlav9bQz7jYT2HzobcZLDqRWGT/cef+FFgJTd9Il8u+GFZGQRwum3DbH4NnWAQ1u
	OT+dwzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QFDrqT
	06rRqA5JhlAi4Lk9Zk6f7kz2T0y0wOvzqYq9OocZGabR8NSpziQptNq04oxknFMH
	zHxfBPl7MEwzAO51g5VB4RtPl39otAYCtvAIUOTAQqk0HzMK7DzviMiqmzRG0vYI
	bZteD11KUD2cmZbv5mbC0biAhs1q0sqVbvedA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1050E26A4E;
	Wed, 28 Oct 2015 18:26:24 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8DC6E26A4D;
	Wed, 28 Oct 2015 18:26:23 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EBAF23EC-7DC2-11E5-8E1E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280415>

Multiple lines read here are concatenated on a single line to form a
multi-column output line.  We do not want to have a CR at the end,
even if the input file consists of CRLF terminated lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/column.c b/builtin/column.c
index 449413c..e9fe928 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -51,7 +51,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 			die(_("--command must be the first argument"));
 	}
 	finalize_colopts(&colopts, -1);
-	while (!strbuf_getline(&sb, stdin, '\n'))
+	while (!strbuf_gets(&sb, stdin))
 		string_list_append(&list, sb.buf);
 
 	print_columns(&list, colopts, &copts);
-- 
2.6.2-423-g5314b62
