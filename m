From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] check-ignore -z: a single -z should apply to both input and output
Date: Thu, 11 Jul 2013 23:18:46 -0700
Message-ID: <1373609927-3244-4-git-send-email-gitster@pobox.com>
References: <1373609927-3244-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 08:19:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWh5-0006n6-UE
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab3GLGS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:18:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab3GLGSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:18:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9334B2B4FB
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=3ib7
	H9XQ5jnSkGX5+Do3YMBzH4Y=; b=pcZDpzLu7vqwrfUloFkDZ527Uu0sCm1t+CAp
	sVKTaYQwSYY/2yo8x+uTNL7+rj1Exf1lHi+1gBqnmfPGCZ+kuGtH55qFwB6AdoEH
	DJyIFu/AakizEA0ptjNEWhe/EQzHj60DwoMr2YNWDeGVGW1eD86UpOr0qZEgtvd7
	8f0PL2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IePRZl
	QUAORuqAekfQSNsqGOdjmh1UINOMLF1xGeYQShaqcQ1ZAZ4o7kPAZCNJ5o/VEEta
	56qixHzrtFDpwqO0S2NUBFkyV4DHI9emRK1qXasbfXQjel3vp/sZdSYsrJ2I+rwN
	b6EHYnWoT9SHhi8C1g93UQVwq9xq21n4yJ2E0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A63E2B4FA
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03C4F2B4F7
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 06:18:53 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373609927-3244-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: ED47763E-EABA-11E2-98F8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230169>

Unless a command has separate --nul-terminated-{input,output}
options, the --nul-terminated-records (-z) option should apply
to both input and output for consistency.  The caller knows that its
input paths may need to be protected for LF, and the program shows
these problematic paths to its output.

The code already did the right thing.  Only the help text needs
fixing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ignore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index be22bce..03e509e 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -21,7 +21,7 @@ static const struct option check_ignore_options[] = {
 	OPT_BOOLEAN(0, "stdin", &stdin_paths,
 		    N_("read file names from stdin")),
 	OPT_BOOLEAN('z', NULL, &nul_term_line,
-		    N_("input paths are terminated by a NUL character")),
+		    N_("terminate input and output records by a NUL character")),
 	OPT_END()
 };
 
-- 
1.8.3.2-911-g2c4daa5
