From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] fix handling of multiple untracked files for git mv -k
Date: Wed, 14 Jan 2009 16:42:17 +0100
Message-ID: <1231947737-23803-1-git-send-email-git@drmicha.warpmail.net>
References: <vpqwscy81o8.fsf@bauges.imag.fr>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 16:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7uN-00017X-8b
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438AbZANPma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbZANPma
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:42:30 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47476 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752074AbZANPm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 10:42:29 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 9AAB620F7DD;
	Wed, 14 Jan 2009 10:42:28 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 14 Jan 2009 10:42:28 -0500
X-Sasl-enc: u6MEqTq/WBJ1QBc4izxR700JidvZVWpWNgvaaZyT3yaW 1231947748
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 05B8E30E67;
	Wed, 14 Jan 2009 10:42:27 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <vpqwscy81o8.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105643>

The "-k" option to "git mv" should allow specifying multiple untracked
files. Currently, multiple untracked files raise an assertion if they
appear consecutively as arguments. Fix this by decrementing the loop
index after removing one entry from the array of arguments.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-mv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

Reported by the OP. Do we need a test case for this? It's a really
trivial change. The patch is off master but builtin-mv.c hasn't change
since 81dc2307d0ad87a4da2e753a9d1b5586d6456eed tags/v1.6.0-rc1~1, so I
suggest this patch for maint.

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
