From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH 4/4] Fix ie_match_stat for non-checked-out submodule
Date: Fri,  2 May 2008 21:35:36 +0800
Message-ID: <1209735336-4690-5-git-send-email-pkufranky@gmail.com>
References: <46dff0320804300856w941d948rbcc1cee06f1b41a9@mail.gmail.com>
 <1209735336-4690-1-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-2-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-3-git-send-email-pkufranky@gmail.com>
 <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com, Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 15:37:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrvRb-0003lU-AU
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935135AbYEBNfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933914AbYEBNfl
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:35:41 -0400
Received: from mail.qikoo.org ([60.28.205.235]:57896 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S935126AbYEBNfj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:35:39 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id C689D470B1; Fri,  2 May 2008 21:35:36 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.116.ge4b9c.dirty
In-Reply-To: <1209735336-4690-4-git-send-email-pkufranky@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80994>

For submodules non checked out, ie_match_stat should always return 0.
So in this case avoid calling is_racy_timestamp.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a92b25b..8c9c8e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -294,7 +294,7 @@ int ie_match_stat(const struct index_state *istate,
 	 * whose mtime are the same as the index file timestamp more
 	 * carefully than others.
 	 */
-	if (!changed && is_racy_timestamp(istate, ce)) {
+	if (!changed && !S_ISGITLINK(ce->ce_mode) && is_racy_timestamp(istate, ce)) {
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
-- 
1.5.5.1.116.ge4b9c.dirty
