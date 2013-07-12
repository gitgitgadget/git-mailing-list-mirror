From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] check-attr: the name of the character is NUL, not NULL
Date: Thu, 11 Jul 2013 23:18:45 -0700
Message-ID: <1373609927-3244-3-git-send-email-gitster@pobox.com>
References: <1373609927-3244-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:19:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWh5-0006n6-Cy
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab3GLGSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:18:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLGSx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:18:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DBD2B4F0
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=FzQJ
	Vb+FwDn255A3fKRP3Ed1pYU=; b=Q96kwUrEhJcbUvo3dguw1CI69vKx5bqm2pAb
	nl4NETy0s4A0vidDEB71TsB9vrG0B6+PPryG0YLAXRplydXdtDzVQ3SXkS/JX81V
	kTfDZG9fIidWVR4N55qSlJ7Ui5Sd4r3I2arGa5iPl0TOO/Jt+yfMV8ZvcllycfbX
	XoH8szc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AUuQ/w
	gNUjKo+kYMEVwCIQIu6+qTfVZOx2KN4v/cNeAhFeZ3NuF2bcIgYtNdJTmG5QpGcU
	6zk8/m79J8KSc/vLBoUIdBV37eW/lp6TTMez0LVqXCiCF4LivokBVWtbhb0qJjkx
	Pg+HNHJh6xOR6J8SaaCox253YYtEv8vLZqq4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCA782B4EF
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C6642B4E8
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:52 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373609927-3244-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC2FB824-EABA-11E2-89EB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230168>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-attr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 075d01d..7cc9b5d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -13,14 +13,14 @@ N_("git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-paths>"),
 NULL
 };
 
-static int null_term_line;
+static int nul_term_line;
 
 static const struct option check_attr_options[] = {
 	OPT_BOOLEAN('a', "all", &all_attrs, N_("report all attributes set on file")),
 	OPT_BOOLEAN(0,  "cached", &cached_attrs, N_("use .gitattributes only from the index")),
 	OPT_BOOLEAN(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
-	OPT_BOOLEAN('z', NULL, &null_term_line,
-		N_("input paths are terminated by a null character")),
+	OPT_BOOLEAN('z', NULL, &nul_term_line,
+		    N_("input paths are terminated by a NUL character")),
 	OPT_END()
 };
 
@@ -65,7 +65,7 @@ static void check_attr_stdin_paths(const char *prefix, int cnt,
 	struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
-	int line_termination = null_term_line ? 0 : '\n';
+	int line_termination = nul_term_line ? 0 : '\n';
 
 	strbuf_init(&buf, 0);
 	strbuf_init(&nbuf, 0);
-- 
1.8.3.2-911-g2c4daa5
