From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/6 v3] Output the graph columns at the end of the commit message.
Date: Thu, 20 May 2010 18:52:40 -0700
Message-ID: <1274406764-32278-3-git-send-email-struggleyb.nku@gmail.com>
References: <1274406764-32278-1-git-send-email-struggleyb.nku@gmail.com>
 <1274406764-32278-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 03:53:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFHQH-0004JK-N6
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 03:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386Ab0EUBw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 21:52:56 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64076 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab0EUBwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 21:52:55 -0400
Received: by pvg3 with SMTP id 3so196508pvg.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Fqa5IGYaa+3sthYb0YwZf86Nbo25e9yt9oMM/yPPTp4=;
        b=l7leZ83SF1XxqvqCuTMG55HmO2mG0RTEQIADPMx3NMnWnaB0XyUMt0VW6R9ABEadjx
         rrZQa/J6ehEWCoTvKSGdLBmZBMwpqV2eeV71h0OgVGrLzZ0np7G4ub60Ly2EPVx5xhYn
         I8Z5SvWaVpRw3AF+U7wiNTJrGmZtqy5tnnmXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rMrZ8zYwQ6mv+JeM0zW1IHKS8YtM5/hq/M1864ihgRGdtI9u1VKeJfe2NAOIC7N2An
         IktUrP95TLzGT7BbKohqstK7xSg/tiVP0ejQyk5krA1bpzC+qyElEw0qi149TYJxgKXu
         b/tc3J0ok9BIQc1FjJi8e3TsEiVPy94AWn+3Y=
Received: by 10.141.90.11 with SMTP id s11mr662076rvl.152.1274406774560;
        Thu, 20 May 2010 18:52:54 -0700 (PDT)
Received: from localhost.localdomain ([222.30.37.37])
        by mx.google.com with ESMTPS id o38sm442378rvp.12.2010.05.20.18.52.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 18:52:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274406764-32278-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147423>

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
