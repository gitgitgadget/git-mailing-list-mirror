From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/6 v2] Output the graph columns at the end of the commit message.
Date: Thu, 20 May 2010 03:25:34 -0700
Message-ID: <1274351138-11813-3-git-send-email-struggleyb.nku@gmail.com>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
 <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 12:26:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF2x9-0006qW-9Z
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 12:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab0ETKZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 06:25:52 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:58573 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571Ab0ETKZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 06:25:51 -0400
Received: by pxi18 with SMTP id 18so1244760pxi.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 03:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rbj8KvlWWeiOXyMiluWYl+L2mvH4ie1RL6OBZEVWs6U=;
        b=F3z2pGQtnTtpJYBpnxyQeR2newe62yLGT89FumruAIIB0zk9CNxqQKr0ohCFUlYjDK
         RDhnjq0qUy2xtlXXWnF4Yf8QiiKySG5anyM6felNp7nm7piCP64w7YIh1vgHvRdA6vFd
         eoUljnHqgQNo8q1hwpvdUYRuUYifA1z9504Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a7ULpgI5Ev8BYdjPRm4IzoFYx4BI0DLJFL6NOvYY2eTwJP6/hLu/eWCm5k2YUc3nFC
         WRhym9Gsf6hvGHXogSilqzyWSKnM/5vh931lQeIjEYUetXk7AJaeROs3r961Nrv6z6uu
         vQCZ3RGuyEb239/8RlUKJaSR7zHEWt3wkgZ9Q=
Received: by 10.115.132.31 with SMTP id j31mr8578541wan.114.1274351150737;
        Thu, 20 May 2010 03:25:50 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id n32sm76160636wae.22.2010.05.20.03.25.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 03:25:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274351138-11813-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147375>

There is an empty line between the commit message and the
diff output. Add the graph columns as prefix of this line.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 log-tree.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d3ae969..a17cde3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -469,6 +469,12 @@ int log_tree_diff_flush(struct rev_info *opt)
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
 				printf("---");
+			if (opt->diffopt.output_prefix) {
+				struct strbuf *msg = NULL;
+				msg = opt->diffopt.output_prefix(opt->diffopt.file,
+					opt->diffopt.output_prefix_data);
+				fwrite(msg->buf, msg->len, 1, stdout);
+			}
 			putchar('\n');
 		}
 	}
-- 
1.6.0.4
