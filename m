From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [TENTATIVE PATCH] Complain loudly, dying, when a ref is invalid
Date: Thu, 27 Oct 2005 19:40:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271936520.7518@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 27 19:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVBkL-0006It-5B
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 19:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVJ0RkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 13:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJ0RkQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 13:40:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:12434 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751320AbVJ0RkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 13:40:14 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1B33713F273
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 19:40:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 031369EFC2
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 19:40:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id E5A6C9EF9B
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 19:40:13 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id BB7FF13F273
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 19:40:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10718>

for_each_ref() used to ignore refs which point nowhere. Making git-fsck-objects
be happy about them.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Of course, it may be by design. But then, it does not feel 
	right to me. If this is intended behaviour, please don't let me 
	die dumb.

 refs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

applies-to: d29f6558d14b1da55642659c9874d4f52dac18bf
047627834b0ecb7ec0e0a98066b4b28688c374bc
diff --git a/refs.c b/refs.c
index a52b038..d74ede9 100644
--- a/refs.c
+++ b/refs.c
@@ -194,9 +194,9 @@ static int do_for_each_ref(const char *b
 				continue;
 			}
 			if (read_ref(git_path("%s", path), sha1) < 0)
-				continue;
+				die("%s points nowhere!", path);
 			if (!has_sha1_file(sha1))
-				continue;
+				die("%s does not point to a valid commit object!", path);
 			retval = fn(path, sha1);
 			if (retval)
 				break;
---
0.99.8.GIT
