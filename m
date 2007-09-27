From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/2] double free in builtin-update-index.c
Date: Thu, 27 Sep 2007 12:51:18 +0200
Message-ID: <20070927110456.50993930B@madism.org>
References: <20070927101300.GD10289@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:06:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IarB4-0006P1-RE
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbXI0LE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbXI0LE7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:04:59 -0400
Received: from pan.madism.org ([88.191.52.104]:41677 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbXI0LE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:04:58 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6C3CE2203D;
	Thu, 27 Sep 2007 13:04:57 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 50993930B; Thu, 27 Sep 2007 13:04:56 +0200 (CEST)
In-Reply-To: <20070927101300.GD10289@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59282>

path_name is either ptr that should not be freed, or a pointer to a strbuf
buffer that is deallocated when exiting the loop. Don't do that !

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-update-index.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index c76879e..e1a938d 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -377,8 +377,6 @@ static void read_index_info(int line_termination)
 				die("git-update-index: unable to update %s",
 				    path_name);
 		}
-		if (path_name != ptr)
-			free(path_name);
 		continue;
 
 	bad_line:
-- 
1.5.3.2.1100.g015a-dirty
