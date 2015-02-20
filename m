From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] idea: Be nicer to the user on tracked/untracked merge conflicts
Date: Fri, 20 Feb 2015 11:31:57 +0100
Message-ID: <1424428317-1682-3-git-send-email-Matthieu.Moy@imag.fr>
References: <20150220020022.GC16124@peff.net>
 <1424428317-1682-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 11:32:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOksb-0003Yc-PZ
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbbBTKcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:32:12 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43651 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753665AbbBTKcL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:32:11 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW4Gh024778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:32:04 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KAW5kX031735;
	Fri, 20 Feb 2015 11:32:05 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YOksP-0000Tg-LI; Fri, 20 Feb 2015 11:32:05 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <1424428317-1682-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Feb 2015 11:32:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KAW4Gh024778
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1425033125.13246@QJ+6DmQkVzYkYFvsiLqPPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264153>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 SoC-2015-Ideas.md | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/SoC-2015-Ideas.md b/SoC-2015-Ideas.md
index 4641800..86de476 100644
--- a/SoC-2015-Ideas.md
+++ b/SoC-2015-Ideas.md
@@ -117,3 +117,30 @@ Cf. $gmane/213180 $gmane/212950
 ### Introduce threading to checkout codepath, possibly helping Windows folks.
 
 Cf. $gmane/235874
+
+### Be nicer to the user on tracked/untracked merge conflicts
+
+When merging a commit which has tracked files with the same name as
+local untracked files, Git refuses to proceed. It could be nice to:
+
+ - Accept the situation without conflict when the tracked file has the
+   exact same content as the local untracked file (which would become
+   tracked). No data is lost, nothing can be committed accidentally.
+
+ - Possibly, for fast-forward merges, if a local files belongs to the
+   index but not to the last commit, attempt a merge between the
+   upstream version and the local one (resulting in the same content
+   as if the file had just been committed, but without introducing an
+   extra commit).
+
+Recent versions SVN do something similar: on update, it considers
+added but not committed files like normal tracked files, and attempts
+a merge of the upstream version with the local one (which always
+succeeds when the files have identical content). Attempting a merge
+for non-fast forward cases would probably not make sense: it would mix
+changes coming from the merge with other changes that do not come from
+a commit.
+
+One difficulty with this project is to identify uncontroversial cases
+(where Git should merge without complaining) and all the possible
+corner-cases.
-- 
2.3.0.157.g79e124b
