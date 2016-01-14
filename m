From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 18/21] column: read lines with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:33 -0800
Message-ID: <1452815916-6447-19-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnd-0003fe-Aj
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbcANX7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932128AbcANX7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CEBB3CDA5;
	Thu, 14 Jan 2016 18:59:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=38Ti
	jnvkS0yv+NkQro9kBxpRJHs=; b=qhVdlHlKU6x7oNC3DVPwdHT+vZBuTJghT7It
	Bhrqe5dsZy08kW/XH4RGBW1mw/BPvSHYQ3ttp2bLXMUIHqW6sjtWuynM8UYOJ6bO
	yk9PzdqyTheXL8xmUIp1Ei6/JNiSCrvAwrNZHdZRCT2/UZN7/2PgxsqG87ULSfhn
	IwDeFqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	c47OovXDytrMVUtjSbK/AJ4c4LNhFSeMVNkqht50oEE+9YsOlXXvch/mXpiggvGc
	FGA5FTt/DerbdML0miTAavezxAdXr6Q91KW10mNUY/eFLE7urwdXbPRx+h0aWO/j
	Zsu2JTB9EC1QUnbBGJmAK7uWS9qCCCZSX5BDrSUYaDg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 440E63CDA4;
	Thu, 14 Jan 2016 18:59:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AAC5C3CDA1;
	Thu, 14 Jan 2016 18:59:07 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CC60DEA0-BB1A-11E5-A5DF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284118>

Multiple lines read here are concatenated on a single line to form a
multi-column output line.  We do not want to have a CR at the end,
even if the input file consists of CRLF terminated lines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/column.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/column.c b/builtin/column.c
index 40eab08..33314b4 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -51,7 +51,7 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 			die(_("--command must be the first argument"));
 	}
 	finalize_colopts(&colopts, -1);
-	while (!strbuf_getline_lf(&sb, stdin))
+	while (!strbuf_getline(&sb, stdin))
 		string_list_append(&list, sb.buf);
 
 	print_columns(&list, colopts, &copts);
-- 
2.7.0-250-ge1b5ba3
