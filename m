From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] format_commit_message(): fix function signature
Date: Fri, 16 Oct 2009 01:28:20 -0700
Message-ID: <1255681702-5215-2-git-send-email-gitster@pobox.com>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 10:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyiFi-0000yJ-9G
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbZJPI3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757182AbZJPI3K
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:29:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948AbZJPI3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:29:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BE745A898
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zCCb
	lEvOIGpPUQb9IQkOj5uBhyo=; b=wKjFmHhUZnT6S2oxU3y4vVkjrS183RoPW1WV
	jkhS2FongzxwaFYhgb4K4f8xGwEFT0f0zkMPKwWC3OoHPZHPlpB/w/6AIGM6oZKV
	/BZHGeHFj+zIKhu6iej8FJv3Zdyk6g7dffQq1kwzQCqjL5KM4K1nhFsMRPdSnXiZ
	3HUiTFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CT0Wix
	ysVJkpPqgfOVVuUUIf59YNaSfGxTbSz9TvXG+ypvVaqFRubr+OTWEGN7xo8mG+Tj
	23CbWH0XoGD9DE8NTXNa/lsG4haeCBp8JsznBRK95vqXUAG9JmKvr9g0kk8kEhKq
	hwHcccOBe/rvKerdqM91O+2G3CySSw41Wo/yM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98ED95A897
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A4F65A896 for
 <git@vger.kernel.org>; Fri, 16 Oct 2009 04:28:26 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.99.g9ed7e
In-Reply-To: <1255681702-5215-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E03BC722-BA2D-11DE-8712-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130464>

The format template string was declared as "const void *" for some unknown
reason, even though it obviously is meant to be passed a string.  Make it
"const char *".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.h |    2 +-
 pretty.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit.h b/commit.h
index f4fc5c5..95f981a 100644
--- a/commit.h
+++ b/commit.h
@@ -70,7 +70,7 @@ extern char *reencode_commit_message(const struct commit *commit,
 				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
-				  const void *format, struct strbuf *sb,
+				  const char *format, struct strbuf *sb,
 				  enum date_mode dmode);
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit*,
                                 struct strbuf *,
diff --git a/pretty.c b/pretty.c
index f5983f8..587101f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -740,7 +740,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 }
 
 void format_commit_message(const struct commit *commit,
-			   const void *format, struct strbuf *sb,
+			   const char *format, struct strbuf *sb,
 			   enum date_mode dmode)
 {
 	struct format_commit_context context;
-- 
1.6.5.99.g9ed7e
