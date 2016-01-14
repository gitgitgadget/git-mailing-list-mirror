From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 19/21] send-pack: read list of refs with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:34 -0800
Message-ID: <1452815916-6447-20-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnT-0003Xm-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbcANX7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932148AbcANX7K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2B0E3CDAB;
	Thu, 14 Jan 2016 18:59:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=JqrK
	MridcQdfc09/EOy1JGJvhlM=; b=BUw9TYjLgT8uM9rRx0xTqlYKZmdrw2fSm1e8
	voZw6Ngl6YcFCuRQTYfbyhG4rqYGgTbWkex0hqMsmrjH1wKKVLk6PhMW+Rvixwux
	+3oUNLH3OYjeb79t2kEnpK5/al1vhoS9U+CumibS4wF6Nq8NMmigQM/mZFHTRsK3
	3ywUMAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	s5OEvJwbdDFNd3nQSnHTUQEb9uEptqOLFMD+DpXt7FRa+sLx15Qnib4NtrK+b/lZ
	m1C2Oa2uL/4P4S0jBXhETn9uAy+2AIktLnhteiJJicRZVAYwKLWl0K2++ipNiJaT
	4CJFX8cl8MC/VE1XJdgMTCAQtK5JrGJg9isumBllwGo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB5803CDAA;
	Thu, 14 Jan 2016 18:59:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5A7C93CDA9;
	Thu, 14 Jan 2016 18:59:09 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CD603224-BB1A-11E5-A23D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284113>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8f9f4f1..5b9dd6a 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				argv_array_push(&all_refspecs, buf);
 		} else {
 			struct strbuf line = STRBUF_INIT;
-			while (strbuf_getline_lf(&line, stdin) != EOF)
+			while (strbuf_getline(&line, stdin) != EOF)
 				argv_array_push(&all_refspecs, line.buf);
 			strbuf_release(&line);
 		}
-- 
2.7.0-250-ge1b5ba3
