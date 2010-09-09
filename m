From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] diff.c: call regfree to free memory allocated by regcomp when necessary
Date: Thu,  9 Sep 2010 14:02:45 -0500
Message-ID: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 21:03:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmPG-0008OX-Bv
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553Ab0IITDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:03:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54201 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0IITDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:03:05 -0400
Received: by mail.nrlssc.navy.mil id o89J30ZG001964; Thu, 9 Sep 2010 14:03:00 -0500
X-OriginalArrivalTime: 09 Sep 2010 19:02:59.0856 (UTC) FILETIME=[9EE4D100:01CB5051]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155882>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diff.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 144f2aa..9a5c77c 100644
--- a/diff.c
+++ b/diff.c
@@ -919,7 +919,10 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 		free (ecbdata->diff_words->minus.orig);
 		free (ecbdata->diff_words->plus.text.ptr);
 		free (ecbdata->diff_words->plus.orig);
-		free(ecbdata->diff_words->word_regex);
+		if (ecbdata->diff_words->word_regex) {
+			regfree(ecbdata->diff_words->word_regex);
+			free(ecbdata->diff_words->word_regex);
+		}
 		free(ecbdata->diff_words);
 		ecbdata->diff_words = NULL;
 	}
-- 
1.7.2.1
