From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 2/6] Output the graph columns at the end of the commit message
Date: Wed, 26 May 2010 15:08:03 +0800
Message-ID: <1274857687-10514-2-git-send-email-struggleyb.nku@gmail.com>
References: <1274857687-10514-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 09:08:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHAjR-0002il-BL
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 09:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933977Ab0EZHIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 03:08:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55773 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZHIi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 03:08:38 -0400
Received: by pwi7 with SMTP id 7so33177pwi.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Fqa5IGYaa+3sthYb0YwZf86Nbo25e9yt9oMM/yPPTp4=;
        b=Bx983yamOGJiiclRwTaKONXbnjuflC5R/hagZ7NajJPneCeLjXBDBOWvjK2KQhItVM
         rSwoBIX9Qem0WxRDzVMNRllQnZ+45ZuEpGsGRObP7kSFjAgN9p+bmhWKRaX3CwIeY4Pa
         UH07nyrVmH44ul26QycMOzQrZAz0zEdySTHXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WixOduGLr+1fydSp4LZ1DHSR+D3hzFSLS/ckyK5THzMH4o4kPgukPjNge9AxV2DyfO
         b+PGqqtgBmWGfomynCfCJ8zmepYBo1i1Q7cjS/nL+xXcyxo0PnvxDpMBfzQFiu1mGEyq
         zkhXtPeqOplyeO3EXdpW6dedoNjQN9gqFXw5U=
Received: by 10.115.64.32 with SMTP id r32mr7263807wak.15.1274857717356;
        Wed, 26 May 2010 00:08:37 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id n29sm54704526wae.4.2010.05.26.00.08.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 00:08:36 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274857687-10514-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147774>

There is an empty line between the commit message and the
diff output. Add the graph columns as prefix of this line.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 log-tree.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d3ae969..2e2be7c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -469,6 +469,12 @@ int log_tree_diff_flush(struct rev_info *opt)
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
 				printf("---");
+			if (opt->diffopt.output_prefix) {
+				struct strbuf *msg = NULL;
+				msg = opt->diffopt.output_prefix(&opt->diffopt,
+					opt->diffopt.output_prefix_data);
+				fwrite(msg->buf, msg->len, 1, stdout);
+			}
 			putchar('\n');
 		}
 	}
-- 
1.6.0.4
