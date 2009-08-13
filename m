From: Luke Dashjr <luke-jr+git@utopios.org>
Subject: [PATCH 5/5] Convert add_file_to_index's lstat failure from a die to an error
Date: Wed, 12 Aug 2009 22:20:24 -0500
Message-ID: <1250133624-2272-5-git-send-email-luke-jr+git@utopios.org>
References: <200908121726.52121.luke-jr@utopios.org>
 <1250133624-2272-1-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-2-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-3-git-send-email-luke-jr+git@utopios.org>
 <1250133624-2272-4-git-send-email-luke-jr+git@utopios.org>
Cc: Luke Dashjr <luke-jr+git@utopios.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 05:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbQsM-0007QD-Jv
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbZHMDUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 23:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbZHMDUp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:20:45 -0400
Received: from unused ([66.216.20.21]:60401 "EHLO zinan.dashjr.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752551AbZHMDUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:20:43 -0400
Received: from tsuruki (ip70-187-26-118.om.om.cox.net [70.187.26.118])
	by zinan.dashjr.org (Postfix) with SMTP id D489CB9DB7D;
	Thu, 13 Aug 2009 03:20:43 +0000 (UTC)
Received: by tsuruki (sSMTP sendmail emulation); Wed, 12 Aug 2009 22:20:43 -0500
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1250133624-2272-4-git-send-email-luke-jr+git@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125771>

In order to make --ignore-errors able to ignore a lstat failure in
add_file_to_index, it needs to raise an error, NOT a fatal die.

Signed-off-by: Luke Dashjr <luke-jr+git@utopios.org>
---
 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4e3e272..074e6b8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -638,7 +638,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int flags)
 {
 	struct stat st;
 	if (lstat(path, &st))
-		die_errno("unable to stat '%s'", path);
+		return error_errno("unable to stat '%s'", path);
 	return add_to_index(istate, path, &st, flags);
 }
 
-- 
1.6.3.3
