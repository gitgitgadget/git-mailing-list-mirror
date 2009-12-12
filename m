From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] commit/status: "git add <path>" is not necessarily how
 to resolve
Date: Sat, 12 Dec 2009 01:02:02 -0800
Message-ID: <1260608523-15579-3-git-send-email-gitster@pobox.com>
References: <1260608523-15579-1-git-send-email-gitster@pobox.com>
 <1260608523-15579-2-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 12 10:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNsU-0001Ra-Pu
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 10:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbZLLJCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 04:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbZLLJCk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 04:02:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010AbZLLJCS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 04:02:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE0C878B1
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SBXR
	UIi6ukOurUCn4NISifNioME=; b=C2DV+eJwOiqhfpnkD4chNk/Bcn0i7SGOFoJ7
	8Pe1vWMLphtCqfkY3PGkPi6rgF3fgVNCPRCzSqTPbckT7LvI4IYG+XvCTx4AP41M
	IY/E7tdAJnIruMycw26uTEZg21gbIafWXNbp/gUUrpuV2wbaMJHzc8C5vA1ioLRM
	k2f7dyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=CVhvnw
	OThMw4CJWdMYeB//fDunUYv+yrGxvo0apVqaJTUJqgrGGxJxcdBo8SvwG6q1CJRy
	Nq8/6L+tVMUUrzS6llpUgXKx1cKsIPDISJL4rDU/CVx4wNk8j9IXrUHXVhxfROpX
	KNKsKmqgzkglMw2tw7zur9hYRVMQRAfJJph8s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E59E3878B0
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C6BC878AF for
 <git@vger.kernel.org>; Sat, 12 Dec 2009 04:02:16 -0500 (EST)
X-Mailer: git-send-email 1.6.6.rc2.5.g49666
In-Reply-To: <1260608523-15579-2-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0C872974-E6FD-11DE-8AD8-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135129>

When the desired resolution is to remove the path, "git rm <path>" is the
command the user needs to use.  Just like in "Changed but not updated"
section, suggest to use "git add/rm" as appropriate.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7060-wtstatus.sh |    2 +-
 wt-status.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 7b5db80..6c1af26 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -32,7 +32,7 @@ cat >expect <<EOF
 # On branch side
 # Unmerged paths:
 #   (use "git reset HEAD <file>..." to unstage)
-#   (use "git add <file>..." to mark resolution)
+#   (use "git add/rm <file>..." as appropriately to mark resolution)
 #
 #	deleted by us:      foo
 #
diff --git a/wt-status.c b/wt-status.c
index 3fdcf97..5271b6a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -52,7 +52,7 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
 		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to mark resolution)");
+	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appropriately to mark resolution)");
 	color_fprintf_ln(s->fp, c, "#");
 }
 
-- 
1.6.6.rc2.5.g49666
