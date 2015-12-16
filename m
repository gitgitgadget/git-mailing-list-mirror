From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/17] column: read lines with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:15 -0800
Message-ID: <1450303398-25900-15-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAx-0001RV-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967100AbbLPWD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967089AbbLPWDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19D77325E8;
	Wed, 16 Dec 2015 17:03:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=lg1v
	m/6m1Zv+SQWn9rD2u0LdhBk=; b=lfjNNFi5EL6F5xRF/CqpXLl7lXNB7JbK5ovd
	8MJknrBnHXACroNWJ+YN7zvIoJwPlgxlfrh1dbn2vaVPsWQiCucWPHr9Q/lhdagr
	KuSHME6RYIPRcX+LZK6CzNlrjOTBhBq9IZgegGZy7hlJ76XeYb33yqZ9ZRJjAy8x
	rewbXCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hXER8c
	UDl9oxBUrkTvOvqgdzPVNeRnLbXbRKI/HkK+PaY2YKN7qzu+Vm2Zg55ZkDFyQbCf
	tyIddCObjb/JKzSQPnOUx+SszhF6skohEPQ1oZhCoeY3DfLK8sgxJqBJYO5cr5Cw
	yUKcrBx9Ux7XphUrVQHBvYqo0+TmNeWBVRWvM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 101B2325E7;
	Wed, 16 Dec 2015 17:03:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B3AE325E4;
	Wed, 16 Dec 2015 17:03:42 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DE955768-A440-11E5-BF4B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282609>

Multiple lines read here are concatenated on a single line to form a
multi-column output line.  We do not want to have a CR at the end,
even if the input file consists of CRLF terminated lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/column.c b/builtin/column.c
index 449413c..3205aa9 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -51,7 +51,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 			die(_("--command must be the first argument"));
 	}
 	finalize_colopts(&colopts, -1);
-	while (!strbuf_getline(&sb, stdin, '\n'))
+	while (!strbuf_getline_crlf(&sb, stdin))
 		string_list_append(&list, sb.buf);
 
 	print_columns(&list, colopts, &copts);
-- 
2.7.0-rc1-83-ga8b6b9e
