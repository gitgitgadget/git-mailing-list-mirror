From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-apply --whitespace=fix: fix off by one thinko
Date: Wed, 27 Feb 2008 11:48:21 -0800
Message-ID: <7vk5kqtc3e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 20:49:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUSH9-0005Lp-L5
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 20:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbYB0Tsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 14:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758460AbYB0Tsc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 14:48:32 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758449AbYB0Tsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 14:48:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B5862507;
	Wed, 27 Feb 2008 14:48:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 927BB2505; Wed, 27 Feb 2008 14:48:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75293>

When a patch adds a whitespace followed by end-of-line, the
trailing whitespace error was detected correctly but was not
fixed, due to misconversion in 42ab241 (builtin-apply.c: do not
feed copy_wsfix() leading '+').

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ws.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ws.c b/ws.c
index 522f646..ba7e834 100644
--- a/ws.c
+++ b/ws.c
@@ -234,7 +234,7 @@ int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *erro
 	 * Strip trailing whitespace
 	 */
 	if ((ws_rule & WS_TRAILING_SPACE) &&
-	    (2 < len && isspace(src[len-2]))) {
+	    (2 <= len && isspace(src[len-2]))) {
 		if (src[len - 1] == '\n') {
 			add_nl_to_tail = 1;
 			len--;
-- 
1.5.4.3.339.gad2d1
