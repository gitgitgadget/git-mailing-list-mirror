From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/17] update-index: read list of paths with strbuf_gets() under --stdin
Date: Wed, 28 Oct 2015 15:25:48 -0700
Message-ID: <1446071161-15610-5-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZI6-0000ek-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbbJ1Wdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:49 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932124AbbJ1Wd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5057926A1F;
	Wed, 28 Oct 2015 18:26:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=UwvU
	hjgL6n9A+enl3mOxRoEGEgc=; b=iNVZCK269BhjuZupZ9VL2VYB1vTb47Utrvl1
	r67/UMrriFxlhZn8mOkTD/kfVU2HvclFp2h+m0cDjf+1KA5Lg9HEHq0JnZHYhT/M
	ePSVvdjg+6nnPS1DCwslYLyPPvjcodRQNyKYVvYPmNQfxUmBSISOo97OsytOene6
	fytwbzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Fl0asf
	K0NsI7gP7i+kufG3dftW7SiIXiNsQWaPlbzBS3jtCZXjLPYhoAypCSVIJR4+PvOW
	IUF3oiOLvOIsvQ5qRjtxthxZfzz2z42KhI5TOj0LYpMnrguh9PiiKAxqYaBoR5e8
	MBAw/zqcLXhxnWw1ttNjr1FXPq1DbTSwwj/HY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 481BD26A1D;
	Wed, 28 Oct 2015 18:26:09 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C5A9A26A1B;
	Wed, 28 Oct 2015 18:26:08 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E2E129B8-7DC2-11E5-B4BC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280406>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index dfc65a8..004871b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1075,7 +1075,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
 		setup_work_tree();
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+
+		while ((line_termination
+			? strbuf_gets(&buf, stdin)
+			: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 			char *p;
 			if (line_termination && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
-- 
2.6.2-423-g5314b62
