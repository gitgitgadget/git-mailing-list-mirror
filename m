From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/17] mktree: read textual tree representation with strbuf_gets()
Date: Wed, 28 Oct 2015 15:25:49 -0700
Message-ID: <1446071161-15610-6-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIR-0000zi-Jn
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbbJ1WeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:11 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754531AbbJ1Wd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6E3826A24;
	Wed, 28 Oct 2015 18:26:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GefH
	Cx0yVHOwh8n4QFU0FPZS8Og=; b=Suj46g3vEnKub2fb85FHw00ZpS60jMeUgtm6
	qElE2hgmDpM1To/UC8RfzjwxfhB9+zy6PpD1fOPSgMMNl1yLxPOW3GXDuWTPxR6p
	0LOjrAusn1BWca4P3bXb4yL7PqSDMEHDyR9kK6LXn9j5iQQwkWPFvA0DbCf3y9Y6
	DbhJ7fo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=C7LOPL
	CIIE8uANHvwtyV/WHMEobZQlZTCdT5SZV3pbVuyeQp114+9FUFKuAZ1zvKFlOoaY
	EvRZsItlZ1JBjR3syiDh2ArLAfh6ot3s4TovGlZBZHQwiV3InytpFvMI4PJpiY6/
	7F+7hA7upJxYNsAgJM7bdu2EO1ITiT30ISrgU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBD0D26A23;
	Wed, 28 Oct 2015 18:26:10 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4777D26A22;
	Wed, 28 Oct 2015 18:26:10 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E3C3A9FA-7DC2-11E5-AF85-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280414>

The input can come from a DOS editor.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mktree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a964d6b..a55f067 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -157,7 +157,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	while (!got_eof) {
 		while (1) {
-			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
+			if ((line_termination
+			     ? strbuf_gets(&sb, stdin)
+			     : strbuf_getline(&sb, stdin, '\0')) == EOF) {
 				got_eof = 1;
 				break;
 			}
-- 
2.6.2-423-g5314b62
