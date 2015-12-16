From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/17] test-sha1-array: read command stream with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:18 -0800
Message-ID: <1450303398-25900-18-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:03:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAs-0001KG-JF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967098AbbLPWDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966090AbbLPWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26135325F8;
	Wed, 16 Dec 2015 17:03:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=P/RQ
	y0yjvUgLfoAuMYtuAdIEsp0=; b=hUmB3Ow11CNo0FZzr6/SErx8ejVsTXptENdV
	EyBUPTJof2lw9w4sthbkfoVIkRvBonp9HfpNvxkE1OSzXIwo7Uhp6pfMrorywYYE
	xcXkJ/g7EiwO0/WO4ClbqgA2ilLgXaxImXD6gTQE4JX4uyn4AnblzlMUzHpgK/wA
	ZgCupJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=P+vvBk
	OKFs5cO/SBurYdsroxOsFcSfESyPKs9+I5dnw362Qg8EiBPwoWgeutosZPNO4tB3
	vuwkCekhkMQ0sgo9JRGdA014psGZnQKJA6phLWHx7IdAKZVGHzujSIfE6q94OE/l
	t3l/2vNhTfqePXL1zEAbdSIG5DlCKjm/8kq64=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1E65E325F7;
	Wed, 16 Dec 2015 17:03:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D9B9325F6;
	Wed, 16 Dec 2015 17:03:47 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1AFABCE-A440-11E5-900F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282606>

The input to this command comes from a pipeline in t0064, whose
upstream has bunch of "echo"s.  It is not unreasonable to expect
that it may be fed CRLF lines on DOSsy systems.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-sha1-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-sha1-array.c b/test-sha1-array.c
index ddc491e..87b04de 100644
--- a/test-sha1-array.c
+++ b/test-sha1-array.c
@@ -11,7 +11,7 @@ int main(int argc, char **argv)
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, stdin, '\n') != EOF) {
+	while (strbuf_getline_crlf(&line, stdin) != EOF) {
 		const char *arg;
 		unsigned char sha1[20];
 
-- 
2.7.0-rc1-83-ga8b6b9e
