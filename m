From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] grep: simplify assignment of ->fixed
Date: Wed, 03 Feb 2010 19:16:30 +0100
Message-ID: <4B69BD7E.1040204@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 19:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncjve-00055A-9q
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab0BCS0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 13:26:13 -0500
Received: from india601.server4you.de ([85.25.151.105]:44180 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0BCS0M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 13:26:12 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2010 13:26:12 EST
Received: from [10.0.1.100] (p57B7CCAF.dip.t-dialin.net [87.183.204.175])
	by india601.server4you.de (Postfix) with ESMTPSA id 2AA7B2F80B6;
	Wed,  3 Feb 2010 19:16:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138855>

After 885d211e, the value of the ->fixed pattern option only depends on
the grep option of the same name.  Regex flags don't matter any more,
because fixed mode and regex mode are strictly separated.  Thus we can
simply copy the value from struct grep_opt to struct grep_pat, as we do
already for ->word_regexp and ->ignore_case.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 60cce46..a0864f1 100644
--- a/grep.c
+++ b/grep.c
@@ -57,11 +57,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
+	p->fixed = opt->fixed;
 
-	if (opt->fixed)
-		p->fixed = 1;
-	if (opt->regflags & REG_ICASE)
-		p->fixed = 0;
 	if (p->fixed)
 		return;
 
-- 
1.7.0.rc1
