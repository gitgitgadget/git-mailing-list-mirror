From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] CodingGuidelines: on comparison
Date: Wed, 30 Apr 2014 14:45:11 -0700
Message-ID: <1398894312-30763-8-git-send-email-gitster@pobox.com>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 23:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcKF-0005Qi-T9
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759551AbaD3Vpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:45:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759485AbaD3Vpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:45:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FAAD8262A;
	Wed, 30 Apr 2014 17:45:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pLPA
	kvqDWkyME9oOWKEd4TwsUEQ=; b=kYA8SStULz+HWkEs6ytqDSQnILwm9rR5iuRT
	dk4pGfI5pkPvPDk2Oc1lsL3N6bCv71YEad3fTIwfX13UgeNvkRt2UjwgNLzufheN
	/i4hRYhBsvwSs7FzdwrY8FeICSFVHQWyrvfr1RhxNQNPkdjrzuYcCFIJEyKzRMWP
	uLSF+Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vBUgKx
	u7G2wJAWKLe/OCwmzQ7YzH2eTSLXMEq7s4IsWfpEcI6ib5uSxjdtyh9iUWAPqc05
	Tq5ej3UHEoDWt6eB2oslybrMJ7ABTFVQ7aAjuAdMtCwMyv0p9EhCBoHadXUhkRzv
	Eukqd04tOuj/2eVUzr3Awfq3U0pKJD+5xp6X0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E6A82629;
	Wed, 30 Apr 2014 17:45:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD11882619;
	Wed, 30 Apr 2014 17:45:45 -0400 (EDT)
X-Mailer: git-send-email 2.0.0-rc1-355-gd6d6511
In-Reply-To: <1398894312-30763-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C9224AFE-D0B0-11E3-B101-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247791>

See http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=4126

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 21e4272..86fb9f6 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -212,6 +212,32 @@ For C programs:
  - Double negation is often harder to understand than no negation
    at all.
 
+ - There are two schools of thought when it comes to comparison,
+   especially inside a loop. Some people prefer to have less stable
+   value on the left hand side and more stable value on the right hand
+   side, e.g. if you have a loop that counts variable i down to the
+   lower bound,
+
+	while (i > lower_bound) {
+		do something;
+		i--;
+	}
+
+   Other people prefer to have the textual order of values match the
+   actual order of values in their comparison, so that they can
+   mentally draw a number line from left to right and place these
+   values in order, i.e.
+
+	while (lower_bound < i) {
+		do something;
+		i--;
+	}
+
+   Both are valid, and we use both, even though we tend to see the
+   former the more preferable, the more "stable" the more stable side
+   becomes (comparison with a constant, "i > 0", is an extreme
+   example).  Just do not mix styles in the same part of the code.
+
  - Some clever tricks, like using the !! operator with arithmetic
    constructs, can be extremely confusing to others.  Avoid them,
    unless there is a compelling reason to use them.
-- 
2.0.0-rc1-355-gd6d6511
