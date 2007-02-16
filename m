From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] builtin-update-index.c (add_file_to_cache): Don't leak a cache entry.
Date: Fri, 16 Feb 2007 10:01:53 +0100
Message-ID: <87mz3e327y.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 10:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHzNB-0005cw-SB
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 10:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966259AbXBPJ1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 04:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966262AbXBPJ1F
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 04:27:05 -0500
Received: from mx.meyering.net ([82.230.74.64]:59889 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966259AbXBPJ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 04:27:04 -0500
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Feb 2007 04:27:04 EST
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 13F5028DDC; Fri, 16 Feb 2007 10:01:53 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39908>


Signed-off-by: Jim Meyering <jim@meyering.net>
---
 builtin-update-index.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1ac613a..5b2278e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -121,8 +121,10 @@ static int add_file_to_cache(const char *path)
 			ce->ce_mode = create_ce_mode(S_IFREG | 0666);
 	}

-	if (index_path(ce->sha1, path, &st, !info_only))
+	if (index_path(ce->sha1, path, &st, !info_only)) {
+		free(ce);
 		return -1;
+	}
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
--
1.5.0.33.gaf997-dirty
