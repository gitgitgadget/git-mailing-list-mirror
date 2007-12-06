From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Revert "git-am: catch missing author date early."
Date: Wed, 05 Dec 2007 17:20:57 -0800
Message-ID: <7vodd4ipom.fsf@gitster.siamese.dyndns.org>
References: <20071205202932.GG29561@kernel.dk>
	<7vir3conab.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Axboe <jens.axboe@oracle.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 02:21:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J05Qe-0001ZH-7C
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 02:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXLFBVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 20:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbXLFBVG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 20:21:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57515 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbXLFBVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 20:21:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2DE3E2F0;
	Wed,  5 Dec 2007 20:21:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BA969D637;
	Wed,  5 Dec 2007 20:21:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67217>

This reverts commit 6e9e0327b7d7f384d8a223b4bc40330ef3e7fb61.  People
can prepare a text file with Subject: and From: headers and feed it to
"am" (pretending the file is a piece of e-mail), and have actually been
doing so.  Strict checking for Date: breaks this established workflow,
which wants to record the time of the commit as the author time.

Thanks go to Jens Axboe for injection of sanity.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2e40708..76c1c84 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -307,9 +307,9 @@ do
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
 
-	if test -z "$GIT_AUTHOR_EMAIL" || test -z "$GIT_AUTHOR_DATE"
+	if test -z "$GIT_AUTHOR_EMAIL"
 	then
-		echo "Patch does not have valid authorship information."
+		echo "Patch does not have a valid e-mail address."
 		stop_here $this
 	fi
 
-- 
1.5.3.7-2132-gbd1cf
