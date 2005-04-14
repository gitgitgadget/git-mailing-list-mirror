From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] git: cleanup in ls-tree.c
Date: Thu, 14 Apr 2005 13:43:44 +0200
Message-ID: <20050414114344.GA13879@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414113527.GA13790@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 13:41:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM2i2-0002Cx-3R
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 13:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDNLnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 07:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDNLnx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 07:43:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3557 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261480AbVDNLnv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 07:43:51 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 8CF7D31DBFE;
	Thu, 14 Apr 2005 13:43:12 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 7DD4B1FC2; Thu, 14 Apr 2005 13:43:47 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414113527.GA13790@elte.hu>
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


cleanup: this patch adds a free() to ls-tree.c.

(Technically it's not a memory leak yet because the buffer is allocated 
once by the function and then the utility exits - but it's a tad cleaner 
to not leave such assumptions in the code, so that if someone reuses the 
function (or extends the utility to include a loop) the uncleanliness 
doesnt develop into a real memory leak.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- ls-tree.c.orig
+++ ls-tree.c
@@ -33,6 +33,8 @@ static int list(unsigned char *sha1)
 		type = S_ISDIR(mode) ? "tree" : "blob";
 		printf("%03o\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), path);
 	}
+	free(buffer);
+
 	return 0;
 }
 
