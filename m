From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] remote-hg: try the 'tip' if no checkout present
Date: Mon, 12 Nov 2012 18:41:07 +0100
Message-ID: <1352742068-15346-4-git-send-email-felipe.contreras@gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy16-0004TU-86
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab2KLRlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:41:35 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36570 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab2KLRle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:41:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so197208bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pUaeltLYgeyhIFSk3cbd4CMQTLYri4ndM1/Ea3ooxXc=;
        b=Msd0prr0PvdOnzswDCibt91oMKrrXxrm1xkZ8PcvD4FwaoeYiHHPRl7w6BJ2QBKuA8
         kDaPyq4NInS3fL66uUcU4JXqgMv7RYGdfmnuikNt7CuAfXfmpeh00czgXr3OgpSzISO5
         vGLIQ77UTFb+FGUfEpTXRO0yHSz9Vxr5zkJ7MPOv+z/i+C+PU/Ox+DUR+cCQZT+xWPUh
         XksJv+v8byaE2FZ4J8MnqTfpWwQA1MxJ8uxNuQSM9fp3wN6/DOx51M2Mu+3vtyasVLZ9
         hGuz1ptesObI+8MFYBBdVzKeU2a6nBfHhEu+8DXASH4KPH1falhVXfnVvR7zMO1mnRB/
         AH7w==
Received: by 10.204.149.2 with SMTP id r2mr7564430bkv.0.1352742094276;
        Mon, 12 Nov 2012 09:41:34 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id z22sm3862007bkw.2.2012.11.12.09.41.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 09:41:33 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209494>

There's no concept of HEAD in mercurial, but let's try our best to do
something sensible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c6d0367..3cdc1e2 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -440,6 +440,8 @@ def list_head(repo, cur):
         head = cur
         node = repo['.']
         if not node:
+            node = repo['tip']
+        if not node:
             return
         if head == 'default':
             head = 'master'
-- 
1.8.0
