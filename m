From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/4] xdiff-interface.c: always trim trailing space from xfuncname matches
Date: Thu,  9 Sep 2010 14:02:46 -0500
Message-ID: <rRj7JpFIk_D_n7-wGkkucCda_kClmekHTPEHOGwmU5nYdmNhqqgzF59v609YFx69vv526WtEpyU@cipher.nrlssc.navy.mil>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 09 21:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmOv-0008CF-FG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab0IITDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:03:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54203 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0IITDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:03:05 -0400
Received: by mail.nrlssc.navy.mil id o89J32mG001971; Thu, 9 Sep 2010 14:03:02 -0500
In-Reply-To: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 09 Sep 2010 19:03:02.0199 (UTC) FILETIME=[A04A5470:01CB5051]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155880>

From: Brandon Casey <drafnel@gmail.com>

Generally, trailing space is removed from the string matched by the
xfuncname patterns.  The exception is when the matched string exceeds the
length of the fixed-size buffer that it will be copied in to.  But, a
string that exceeds the buffer can still contain trailing space in the
portion of the string that will be copied into the buffer.  So, simplify
this code slightly, and just perform the trailing space removal always.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 xdiff-interface.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index cd2285d..e1e054e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -286,9 +286,8 @@ static long ff_regexp(const char *line, long len,
 	result = pmatch[i].rm_eo - pmatch[i].rm_so;
 	if (result > buffer_size)
 		result = buffer_size;
-	else
-		while (result > 0 && (isspace(line[result - 1])))
-			result--;
+	while (result > 0 && (isspace(line[result - 1])))
+		result--;
 	memcpy(buffer, line, result);
  fail:
 	free(line_buffer);
-- 
1.7.2.1
