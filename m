From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: fix memory leak in checkout-cache.c
Date: Thu, 14 Apr 2005 13:26:38 +0200
Message-ID: <20050414112638.GA12593@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 13:24:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2RZ-00088U-73
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDNL0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDNL0u
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:26:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59618 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261480AbVDNL0q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 07:26:46 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id DF903320154;
	Thu, 14 Apr 2005 13:26:06 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 9671B1FC2; Thu, 14 Apr 2005 13:26:41 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


this patch fixes a memory leak in checkout-cache.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- checkout-cache.c.orig
+++ checkout-cache.c
@@ -48,6 +48,7 @@ static void create_directories(const cha
 		buf[len] = 0;
 		mkdir(buf, 0755);
 	}
+	free(buf);
 }
 
 static int create_file(const char *path, unsigned int mode)
