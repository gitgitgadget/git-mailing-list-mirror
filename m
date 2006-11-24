X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/5] get_shallow_commits: Avoid memory leak if a commit has been reached already.
Date: Fri, 24 Nov 2006 15:58:50 +0100
Message-ID: <87slg8uc0l.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 14:59:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32222>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GncWf-0008QM-Ld for gcvg-git@gmane.org; Fri, 24 Nov
 2006 15:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934638AbWKXO7e (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 09:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934639AbWKXO7e
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 09:59:34 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:4581 "EHLO
 mail.codeweavers.com") by vger.kernel.org with ESMTP id S934638AbWKXO7d
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 09:59:33 -0500
Received: from adsl-84-226-49-216.adslplus.ch ([84.226.49.216]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GncVw-0005Jp-Fa for
 git@vger.kernel.org; Fri, 24 Nov 2006 08:58:52 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 7A66610A155; Fri,
 24 Nov 2006 15:58:50 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 shallow.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/shallow.c b/shallow.c
index 2db1dc4..3d53d17 100644
--- a/shallow.c
+++ b/shallow.c
@@ -60,7 +60,9 @@ struct commit_list *get_shallow_commits(
 					commit = NULL;
 					continue;
 				}
-				commit->util = xcalloc(1, sizeof(int));
+				if (!commit->util)
+					commit->util = xmalloc(sizeof(int));
+				*(int *)commit->util = 0;
 				cur_depth = 0;
 			} else {
 				commit = (struct commit *)
-- 
1.4.4.1.ga335e

-- 
Alexandre Julliard
