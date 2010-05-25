From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH 2/6 rebase-version] Output the graph columns at the end of the commit message.
Date: Tue, 25 May 2010 17:02:30 +0800
Message-ID: <1274778154-29976-3-git-send-email-struggleyb.nku@gmail.com>
References: <1274778154-29976-1-git-send-email-struggleyb.nku@gmail.com>
 <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 11:03:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGq2c-0006UN-Fw
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 11:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183Ab0EYJCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 05:02:55 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46547 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0EYJCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 05:02:53 -0400
Received: by pvg3 with SMTP id 3so456090pvg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Fqa5IGYaa+3sthYb0YwZf86Nbo25e9yt9oMM/yPPTp4=;
        b=kjcMvE/k3yh6D7I3k/+Yb7dktZNj4tLQ5ZBdudkkSlxKpbxam1vjNAdN6PHZJQMWaw
         cKOJ3UWDnidlWyQbOBqM9qmxRxA6FBN9du5aJ+jsq8wQxS9LvuPZNbEqj6C7/oVWdGG8
         t+CiwybycjrOGL31YqnQwanL30StreE13g5/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AogGk3YHxfeStcnioVUxBegrpjNkf5qb0EtRNi3I25uyFnZaq0l3BP3kX7hwU9y7Wn
         xbClm/VKl8+P4BFkVcPgEPTgmZoWiQ9qgMCdzvV3LspR0VPtyxEHiI8AUzoQbJt5UFfp
         Sptq4whi6AD5BaZ5wPHjKA6kP/iX4J5A5y7S8=
Received: by 10.142.55.19 with SMTP id d19mr4795355wfa.163.1274778172851;
        Tue, 25 May 2010 02:02:52 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.99])
        by mx.google.com with ESMTPS id d16sm46058650wam.0.2010.05.25.02.02.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 02:02:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1274778154-29976-2-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147690>

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
