From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/17] update-index: read list of paths with strbuf_getline_crlf() under --stdin
Date: Wed, 16 Dec 2015 14:03:05 -0800
Message-ID: <1450303398-25900-5-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAj-00014Y-Az
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966702AbbLPWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966030AbbLPWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65366325BD;
	Wed, 16 Dec 2015 17:03:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cT8E
	CaqGFYr+TmYnykkCt6gIrns=; b=Ftbwc807dS1SEUcHMBIc/9lKrXAXhi3kkI7x
	OMjaEOZekpaqKWc4lXzKPTT9j5oLWAIjnGJnvI110Oy4GsLDXDc/KADWkw15zRl5
	yX6CAkJwFsl91GX/RTHY9YPAZO+mL8/7oQruBq5L14IoGtEyOUnuTDxONOYm0B/b
	AnDG1E0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ih4klq
	wDYBDPUkd3tU3r/lj1LpBk7h8PCzt2uheLOggwZBXGJONAJZTXO+r+/xnbYQkJxn
	+2dEuyQcxOXsA8pktjJwmO/RwVDnLodgqWqlYIFZ2a/vtuMebbF4fk5rjLG9QvZM
	7F2klrtKYsv5RjxtpNCpmPb2620EyNwc3RwHA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DE14325BB;
	Wed, 16 Dec 2015 17:03:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0261325BA;
	Wed, 16 Dec 2015 17:03:25 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D4BC96D4-A440-11E5-B1C9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282601>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a7a9a7e..3a6c5b2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1075,7 +1075,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
 		setup_work_tree();
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+
+		while ((line_termination
+			? strbuf_getline_crlf(&buf, stdin)
+			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
-- 
2.7.0-rc1-83-ga8b6b9e
