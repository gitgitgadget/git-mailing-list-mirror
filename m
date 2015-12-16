From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/17] update-index: read --index-info with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:04 -0800
Message-ID: <1450303398-25900-4-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAa-0000pX-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966718AbbLPWDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965979AbbLPWDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B95C3325B9;
	Wed, 16 Dec 2015 17:03:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=5nF9
	epVhL3DwDRDPNUZjPidtjz0=; b=sQbv8Zff5HWahfKigt4Az2qHxifWZyumHz58
	a38pXT8p4uGJIXoKuRBlH8jw/PhN+m5f0NcvhpMbpm8Mspfy6tinYSB9IfPhmak2
	vA2x1to5K365ETAVfAWzrOkgOBtKYk4ii97/eSdF/K+1MxSV89hHWjLYYAfL/Kaa
	Q99BrMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=H9WgHm
	Q3cA0Pqk0j8VpMt1UMCXXcYwsjvBXUPtqRKY5E8sExmJDjgpy5bMVvNU7HbbwGm6
	NW5sLQSG5AtNFruz4A4gDBtsKY+fzzQRCgDLpw83Mz+WwuKF/82ozdE0qrJyy5KF
	m5mkAUMQ98ZgMYG5wRKbsM3H9vf/d2XPTFjB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2091325B8;
	Wed, 16 Dec 2015 17:03:24 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3579B325B7;
	Wed, 16 Dec 2015 17:03:24 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D3C35808-A440-11E5-B111-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282599>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a7a9a7e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -473,7 +473,9 @@ static void read_index_info(int line_termination)
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
 
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+	while ((line_termination
+		? strbuf_getline_crlf(&buf, stdin)
+		: strbuf_getline(&buf, stdin, '\0')) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
 		unsigned char sha1[20];
-- 
2.7.0-rc1-83-ga8b6b9e
