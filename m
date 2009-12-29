From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] builtin-merge.c: use standard active_cache macros
Date: Tue, 29 Dec 2009 13:42:30 -0800
Message-ID: <1262122958-9378-2-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqS-0003SS-DH
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbZL2Vmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbZL2Vmp
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:42:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbZL2Vmn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C6716ABFB4
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=y62w
	GfrGFP3XA+9ueLgL4VX+wUA=; b=fa4+nT/h14qt9qH62S2LQ3IH4yLZSb93vzfk
	QsWn/mYAhSF6zq1Dya5qvvkQJSsLWkU5i0aO4a/+SRsLZ6CMfQ6SXICUURz+8wB8
	fIf0vmIEL5fUzfDB6vm1S1U0PIhF8A9HYjQwok+ctD5CosmrunZyD522TZqHZN/2
	hrAIKIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CQcgym
	Bic3KRBNhAwHiXF1aLvnROToDIHuPKTeGNVFcZpWE2wKLWBCxMCfVr43HzUn2X+k
	rjkoLSbGipI3+zHbQNbCbDY/PWxROvRI0/AXcZE7EhbxfUfHskUyRiBUefjeV8U0
	JTuE7AIHpbO8OMW3cakjX1K5VMAm+UKuvGdig=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C08E6ABFB3
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E5D2ABFB2 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:41 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1802F6E2-F4C3-11DE-86C2-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135831>

Instead of using the low-level index_state interface, use the bog standard
active_cache and active_nr macros to access the cache entries when using the
default one.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index f1c84d7..6cb804b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -618,11 +618,10 @@ static void count_diff_files(struct diff_queue_struct *q,
 
 static int count_unmerged_entries(void)
 {
-	const struct index_state *state = &the_index;
 	int i, ret = 0;
 
-	for (i = 0; i < state->cache_nr; i++)
-		if (ce_stage(state->cache[i]))
+	for (i = 0; i < active_nr; i++)
+		if (ce_stage(active_cache[i]))
 			ret++;
 
 	return ret;
-- 
1.6.6
