From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/17] mktree: read textual tree representation with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:06 -0800
Message-ID: <1450303398-25900-6-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KB8-0001kk-0D
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966686AbbLPWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966091AbbLPWD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11368325C0;
	Wed, 16 Dec 2015 17:03:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6vGH
	TCvygaObV54IfLI8iW4Lmgc=; b=sxgruOSLPch2t2QI/RAcbawlb4BUpqRduxkD
	yJFuSEMD7i45fmjx+Xt861DubZuDmmQE7qB2zxhqbSDr6qLavWdzgvaU1rKJ8VkE
	hxcLbdvocR0MUN0EUiGXOTpsd74ZIDIvGq6FEqn0acV0l0bQTy8M6teF0Uq6P+Zf
	LzMKN04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PHAhT+
	+EqleabUu+v+pveHI29eBZe5lf6N9T2iCRKlsrA6XbgN1L5ckARkP+M5xZbEixLk
	xJeIkDdTWbf9FU2W0mdv3P4jFQpcjPz056nNRktQS/UPgAWkN0I951wy05vN3cY8
	wHP0wLrcV8L5gobM3Pc6j5r8hLCYkYMpDQ7vI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09443325BF;
	Wed, 16 Dec 2015 17:03:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7C300325BE;
	Wed, 16 Dec 2015 17:03:27 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D5B8E722-A440-11E5-AB95-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282612>

The input can come from a DOS editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a964d6b..c6cafb6 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -157,7 +157,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	while (!got_eof) {
 		while (1) {
-			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
+			if ((line_termination
+			     ? strbuf_getline_crlf(&sb, stdin)
+			     : strbuf_getline(&sb, stdin, '\0')) == EOF) {
 				got_eof = 1;
 				break;
 			}
-- 
2.7.0-rc1-83-ga8b6b9e
