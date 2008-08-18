From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] dir.c: avoid c99 array initialization
Date: Mon, 18 Aug 2008 18:57:33 -0500
Message-ID: <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEcU-0007eE-Gg
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215AbYHRX5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbYHRX5g
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:57:36 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:42429 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179AbYHRX5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:57:34 -0400
Received: by mail.nrlssc.navy.mil id m7INvYkO029407; Mon, 18 Aug 2008 18:57:34 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:57:33.0837 (UTC) FILETIME=[2EC44BD0:01C9018E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92782>

The following syntax:

        char foo[] = {
                [0] = 1,
                [7] = 2,
                [15] = 3
        };

is a c99 construct which some compilers do not support even though they
support other c99 constructs. Use an alternative.
---
 dir.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 29d1d5b..14d2eea 100644
--- a/dir.c
+++ b/dir.c
@@ -680,13 +680,14 @@ static int cmp_name(const void *p1, const void *p2)
  */
 static int simple_length(const char *match)
 {
-	const char special[256] = {
-		[0] = 1, ['?'] = 1,
-		['\\'] = 1, ['*'] = 1,
-		['['] = 1
-	};
+	char special[256] = { 1, };
 	int len = -1;
 
+	special['?'] = 1;
+	special['\\'] = 1;
+	special['*'] = 1;
+	special['['] = 1;
+
 	for (;;) {
 		unsigned char c = *match++;
 		len++;
-- 
1.6.0.11.gecc7e
