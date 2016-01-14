From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 21/21] test-sha1-array: read command stream with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:36 -0800
Message-ID: <1452815916-6447-22-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnZ-0003cM-82
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbcANX7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932164AbcANX7O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 552E63CDB1;
	Thu, 14 Jan 2016 18:59:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=L4aW
	FYrMGDBsph7pwYOwswjwkKw=; b=sf8Tbtob3f08KlwDOUZFNsCnPKuQGPcAtjLa
	MVHav1C+fMgt1ArybsMjfHxpsYKVYcM2MXXFNQNqUW9jzd9eWMcHb2qSqfw4XwA7
	ULMIfbx37uJsymgWdC+D4e+qfiL4hJys4IzN/aI75cD5BmVkaz5/X2jGZiZMhEJl
	hM88H5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	d5vzT7eBbq/HKGqc9yxBcc9HMLlYyGtTizvpnb1FJdSDNyG6BTZO+OG1zbbTpCPg
	08G5ADah49O2MMEjLGVzAL8BF44Yg25CeM/3TUkVCKUfbaU5cRFKNs4wq6MbvAHM
	WyK3vaihFEvHHNTCNtIFsFR2Jwtz9sacy8RbFfjxpgo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C2093CDB0;
	Thu, 14 Jan 2016 18:59:13 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B30ED3CDAF;
	Thu, 14 Jan 2016 18:59:12 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CF610846-BB1A-11E5-A99F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284117>

The input to this command comes from a pipeline in t0064, whose
upstream has bunch of "echo"s.  It is not unreasonable to expect
that it may be fed CRLF lines on DOSsy systems.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-sha1-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-sha1-array.c b/test-sha1-array.c
index 700f3f3..60ea1d5 100644
--- a/test-sha1-array.c
+++ b/test-sha1-array.c
@@ -11,7 +11,7 @@ int main(int argc, char **argv)
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline_lf(&line, stdin) != EOF) {
+	while (strbuf_getline(&line, stdin) != EOF) {
 		const char *arg;
 		unsigned char sha1[20];
 
-- 
2.7.0-250-ge1b5ba3
