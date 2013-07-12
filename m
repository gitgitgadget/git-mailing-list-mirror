From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] git_mkstemps: correctly test return value of open()
Date: Fri, 12 Jul 2013 10:58:35 +0200
Message-ID: <9af38018d55c95a6807d305bb3a088e48916baac.1373618940.git.trast@inf.ethz.ch>
References: <cover.1373618940.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 12 10:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxZBv-0003YV-HB
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 10:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab3GLI6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 04:58:51 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:9797 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757501Ab3GLI6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 04:58:39 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:34 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 12 Jul
 2013 10:58:36 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <cover.1373618940.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230187>

From: "Dale R. Worley" <worley@alum.mit.edu>

open() returns -1 on failure, and indeed 0 is a possible success value
if the user closed stdin in our process.  Fix the test.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wrapper.c b/wrapper.c
index dd7ecbb..6a015de 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -322,7 +322,7 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 		template[5] = letters[v % num_letters]; v /= num_letters;
 
 		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
-		if (fd > 0)
+		if (fd >= 0)
 			return fd;
 		/*
 		 * Fatal error (EPERM, ENOSPC etc).
-- 
1.8.3.2.998.g1d087bc
