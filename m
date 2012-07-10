From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 02/19] apply: a bit more comments on PATH_TO_BE_DELETED
Date: Tue, 10 Jul 2012 00:03:55 -0700
Message-ID: <1341903852-4815-3-git-send-email-gitster@pobox.com>
References: <1341903852-4815-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 09:04:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoUUn-00085p-CX
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 09:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab2GJHEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 03:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab2GJHEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 03:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0865F7DCA
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=85xr
	KPeg6xZH3BEr2bGleP53TXg=; b=QI8GskEJRx+WQZGiTTI+VwscTPiSa7qTrhZ0
	a+eenMYPjQAex+hcy3bMn64AU1QC+qDmFDBznF8fpTxrQEA08oAh5L1GVfUh5zb1
	y7M6cVnnSEljr1mXi1hb11qvxtEXXdfiB1FF0Uje4B70MSBHbn1z33nixp8MI1aZ
	4/72miM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZgG7t4
	WTOepP2WtZd6+ltuGsIqRx5DJYZj7asJWp9LZAqKXwCevIJYjUll3PYKG/jqAsU6
	y6VDb/f/Y6ehNeb9Zqmlma1jjaQZAEzF4+cYVNO9R994as76gXLJnQO4z93SabVE
	50qoOLWeRP0cKegRcpxagIOCpLCwBquqAYbrI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BED7DC9
	for <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77E6A7DC7 for
 <git@vger.kernel.org>; Tue, 10 Jul 2012 03:04:21 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.294.g68a9409
In-Reply-To: <1341903852-4815-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 79611BF4-CA5D-11E1-BEE2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201240>

The code is littered with to_be_deleted() whose purpose is not so clear.
Describe where it matters.  Also remove an extra space before "#define"
that snuck in by mistake at 7fac0ee (builtin-apply: keep information about
files to be deleted, 2009-04-11).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 44f6de9..35460c9 100644
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
1.7.11.1.294.g68a9409
