From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 2/3] fix handling of multiple untracked files for git mv -k
Date: Wed, 14 Jan 2009 18:03:22 +0100
Message-ID: <1231952603-32527-3-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
 <1231952603-32527-1-git-send-email-git@drmicha.warpmail.net>
 <1231952603-32527-2-git-send-email-git@drmicha.warpmail.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 18:06:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9Bf-0006nq-Ft
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764017AbZANREA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763952AbZANREA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:04:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41317 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763173AbZANRD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 12:03:59 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4E7C9210F4E;
	Wed, 14 Jan 2009 12:03:58 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 12:03:58 -0500
X-Sasl-enc: t+utdNUkeB3401wNiW1oYJ1ZQyQR3OcdJS/QimGEzVkh 1231952637
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B3CD02B7CA;
	Wed, 14 Jan 2009 12:03:57 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <1231952603-32527-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105662>

The "-k" option to "git mv" should allow specifying multiple untracked
files. Currently, multiple untracked files raise an assertion if they
appear consecutively as arguments. Fix this by decrementing the loop
index after removing one entry from the array of arguments.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-mv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 4f65b5a..bce9959 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -192,6 +192,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 					memmove(destination + i,
 						destination + i + 1,
 						(argc - i) * sizeof(char *));
+					i--;
 				}
 			} else
 				die ("%s, source=%s, destination=%s",
-- 
1.6.0.6
