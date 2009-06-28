From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH] git mailinfo strips important context from patch subjects
Date: Sun, 28 Jun 2009 22:07:44 +0200
Message-ID: <1246219664-11000-1-git-send-email-bonzini@gnu.org>
References: <20090628193858.GA29467@codelibre.net>
Cc: Roger Leigh <rleigh@codelibre.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 22:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ML0fQ-0000zt-OV
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 22:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbZF1UHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 16:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbZF1UHv
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 16:07:51 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:43436 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZF1UHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 16:07:50 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1ML0fI-0003wM-6F; Sun, 28 Jun 2009 16:07:52 -0400
X-Mailer: git-send-email 1.6.0.3
In-Reply-To: <20090628193858.GA29467@codelibre.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122421>

> Would it be possible to change the git-mailinfo logic to use a less
> greedy pattern match?

Like this?  (I also simplified the first part of the if condition since I
was at it).  Anyone, feel free to resubmit it as a proper patch.

Almost-Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-mailinfo.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 92637ac..d340ae6 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -237,7 +237,8 @@ static void cleanup_subject(struct strbuf *subject)
 		case '[':
 			if ((pos = strchr(subject->buf, ']'))) {
 				remove = pos - subject->buf;
-				if (remove <= (subject->len - remove) * 2) {
+				if (remove <= subject->len * 2 / 3
+				    && memmem(subject->buf, remove, 'PATCH', 5)) {
 					strbuf_remove(subject, 0, remove + 1);
 					continue;
 				}
-- 
1.6.0.3
