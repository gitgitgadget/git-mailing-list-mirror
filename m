From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Allow installing in the traditional way
Date: Mon, 28 Jul 2008 00:09:51 -0700
Message-ID: <7vod4itrgg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMsl-0002gV-9c
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbYG1HJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 03:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYG1HJ5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:09:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbYG1HJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:09:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A32463F739;
	Mon, 28 Jul 2008 03:09:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7F7A03F738; Mon, 28 Jul 2008 03:09:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F10E774-5C74-11DD-B71C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90425>

In an earlier commit c70a8d9 (Makefile: Do not install a copy of 'git' in
$(gitexecdir), 2008-07-21), we tried to avoid installing two git, one in
/usr/bin/git and the other in /usr/libexec/git-core/git.  It mistakenly
removed the only copy of git when gitexecdir and bindir are set to the
same directory, i.e. the traditional layout.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 7e30b30..52c67c1 100644
--- a/Makefile
+++ b/Makefile
@@ -1362,7 +1362,10 @@ endif
 		cp "$$bindir/git$X" "$$execdir/git$X"; \
 	fi && \
 	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
-	$(RM) "$$execdir/git$X" && \
+	if test "z$$bindir" != "z$$execdir"; \
+	then \
+		$(RM) "$$execdir/git$X"; \
+	fi && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
-- 
1.6.0.rc1
