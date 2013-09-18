From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/7] upload-pack: send non-HEAD symbolic refs
Date: Tue, 17 Sep 2013 22:14:20 -0700
Message-ID: <1379481263-29903-5-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6K-0006Dp-C3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3IRFOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751609Ab3IRFOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DD093C946;
	Wed, 18 Sep 2013 05:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=APX6
	iKJEruPzRnCmRZuW6ZUXBhU=; b=qPpUcV6FRwkCI3Kq/BBLLxDlysgw6Pmo8WvV
	KTL5SDP0eUlK/1OzLUF2ms5C4LSVdHj2OHaxXxJ8MryO8miJ+rzsn8HLeJEknvpV
	FIXl+NlHt/X8AkIByTQLN2JAh5nI8U4GP/j+iInsrk8U16T02O+18kaCPPipA5V7
	59CrIpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MjBvF9SFRnqGPOZnYG1nRnzUGIUwtfWh/qcUHg0CSFe+Bgn7aamxUDgdMrZpJ/lx
	xavsqORwZp3ap/oT00CWEJtMbjQlkQ5C9/evstVBLWDa5h4gG9kyy96EFTBxOKtF
	lT+HanyGkkmUb0ZBtqpA2rnAIBTlsjAA+UO10gXb2ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60D083C945;
	Wed, 18 Sep 2013 05:14:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBF033C944;
	Wed, 18 Sep 2013 05:14:33 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3485ECF6-2021-11E3-ADB5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234953>

With the same mechanism as used to tell where "HEAD" points at to
the other end, we can tell the target of other symbolic refs as
well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/upload-pack.c b/upload-pack.c
index 979fc8e..2826909 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -798,6 +798,7 @@ static void upload_pack(void)
 	struct string_list symref = STRING_LIST_INIT_DUP;
 
 	head_ref_namespaced(find_symref, &symref);
+	for_each_namespaced_ref(find_symref, &symref);
 
 	if (advertise_refs || !stateless_rpc) {
 		reset_timeout();
-- 
1.8.4-585-g8d1dcaf
