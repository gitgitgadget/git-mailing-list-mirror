From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 02/19] apply: a bit more comments on PATH_TO_BE_DELETED
Date: Wed, 13 Jun 2012 12:32:43 -0700
Message-ID: <1339615980-19727-3-git-send-email-gitster@pobox.com>
References: <1339615980-19727-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 21:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetJZ-0007CQ-4d
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab2FMTdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 15:33:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab2FMTdG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 15:33:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F06686F1
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Z4oP
	e6kkKIgkv5OVsx+nOy5uHnw=; b=MHHl+ncYFebps2Q2zFka7JYzNSzeoYeH93xS
	1oHMksjFwNu+OUJw/N6rJAf7IpRZ+lmQz1XhTg9fCncVtOscP7YDEQR8Zkasb51k
	Iz33M+hZcgqk7pi9Wsx9dGTxSoT+CjfZhfFeklgkwXBxsXOMkskOdE22sYxGkBF9
	XuUt/KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=oUsRAk
	KNqWLLklmz6j2GvbJ31Tj53nRFfQkidgkyFOu1hjSCGoSiMDcB6kOpG85LEHFCPk
	mWMsPveYo7uy7todpsESvVeuH7PIR6Ss1IPgLg5NsWfioQ9nGCrd/sijVfoBHFYf
	X9HVFsZe13iURmibwAQfj40vJpMAM5tEXQKJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16F1186F0
	for <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FAC986ED for
 <git@vger.kernel.org>; Wed, 13 Jun 2012 15:33:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.rc3.30.g3bdace2
In-Reply-To: <1339615980-19727-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 991D2B1A-B58E-11E1-9430-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199919>

The code is littered with to_be_deleted() whose purpose is not so clear.
Describe where it matters.  Also remove an extra space before "#define"
that snuck in by mistake at 7fac0ee (builtin-apply: keep information about
files to be deleted, 2009-04-11).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index be4e3f3..8488c8e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2970,9 +2970,15 @@ static struct patch *in_fn_table(const char *name)
  * item->util in the filename table records the status of the path.
  * Usually it points at a patch (whose result records the contents
  * of it after applying it), but it could be PATH_WAS_DELETED for a
- * path that a previously applied patch has already removed.
+ * path that a previously applied patch has already removed, or
+ * PATH_TO_BE_DELETED for a path that a later patch would remove.
+ *
+ * The latter is needed to deal with a case where two paths A and B
+ * are swapped by first renaming A to B and then renaming B to A;
+ * moving A to B should not be prevented due to presense of B as we
+ * will remove it in a later patch.
  */
- #define PATH_TO_BE_DELETED ((struct patch *) -2)
+#define PATH_TO_BE_DELETED ((struct patch *) -2)
 #define PATH_WAS_DELETED ((struct patch *) -1)
 
 static int to_be_deleted(struct patch *patch)
-- 
1.7.11.rc3.30.g3bdace2
