From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/17] test-sha1-array: read command stream with strbuf_gets()
Date: Wed, 28 Oct 2015 15:26:01 -0700
Message-ID: <1446071161-15610-18-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
 <1446071161-15610-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZIK-0000sm-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbJ1WeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:34:05 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754487AbbJ1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 694C326A60;
	Wed, 28 Oct 2015 18:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=g2r3
	APG6MMv7eACHkcuJYTCdtdM=; b=keHxLWQC4fuRimd6kqJ7MobsnlOPN10SqgLQ
	6ouwTHsAlmAC8p8mNgidzl3KZ5khKMo6P8vnYcsA5CEDLKj1h36HEGdSp4MFi3c8
	zoV11iMRo7iNX5CWJ13Uz3rNBhJhsLqz6O9ALqgaBizXW6HyNhRiFoozyWWr4xGN
	qs/wp1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RoXxPA
	3H9Q6k37D4U7H7fQgQrn2mlu4klXI8B6u7jCizacUVs3F1OrLBfW0G/TTrzYAwG5
	o9brT6tsl7/l/Oa3XfUgtVNtJGVEpbPyc+Qd+z/PyoWmRwkVdP2n8vO+uYYK7uhh
	P6bJxfOCwtWVsJDCUDXoyozrlF+01l/1kT0tM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61B8626A5E;
	Wed, 28 Oct 2015 18:26:28 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E12B226A5C;
	Wed, 28 Oct 2015 18:26:27 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <1446071161-15610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EE45CB4C-7DC2-11E5-808D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280413>

The input to this command comes from a pipeline in t0064, whose
upstream has bunch of "echo"s.  It is not unreasonable to expect
that it may be fed CRLF lines on DOSsy systems.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-sha1-array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test-sha1-array.c b/test-sha1-array.c
index ddc491e..46ff240 100644
--- a/test-sha1-array.c
+++ b/test-sha1-array.c
@@ -11,7 +11,7 @@ int main(int argc, char **argv)
 	struct sha1_array array = SHA1_ARRAY_INIT;
 	struct strbuf line = STRBUF_INIT;
 
-	while (strbuf_getline(&line, stdin, '\n') != EOF) {
+	while (strbuf_gets(&line, stdin) != EOF) {
 		const char *arg;
 		unsigned char sha1[20];
 
-- 
2.6.2-423-g5314b62
