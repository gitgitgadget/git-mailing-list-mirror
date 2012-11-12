From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/4] remote-hg: fix compatibility with older versions of hg
Date: Mon, 12 Nov 2012 18:41:06 +0100
Message-ID: <1352742068-15346-3-git-send-email-felipe.contreras@gmail.com>
References: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 18:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXy15-0004TU-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 18:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab2KLRlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 12:41:32 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36570 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795Ab2KLRlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 12:41:31 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so197208bkw.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 09:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z/fi6qIyeo6cSxo502up6subLQZ93n/Hanoy+GRqzBI=;
        b=tzaG34JUCX8EyvT3Fh6gejfJ/VifRoht0KBc5LmNkRNzR/06eYYGlMBlnaa8pu5ZST
         gwWojlutB6qztg85FfnCcX6B6xHnVCxLQc0M5rY6ojM0wJcPxyekCKVux0Of2lSNUf/0
         Oh5qcnIorWlN94CGF8qib2DcNKTyAUGfOLpnr6Nbf1qa59YcJ4uSIkbTkB9nfoSaFeDP
         LLGpUTAyem9NNrMYPwbE8qT0MyfZjABEYzCR7F5/m5jYENvLk/nQPEttFpxklNxVMdwl
         Ai5LP+9LUyrIo3+dKLSGz79z+roL/rXSyvjA1udBWF4pl1Je0m2g28kHP99ziwxPHf4g
         QpRA==
Received: by 10.204.129.213 with SMTP id p21mr7353451bks.115.1352742090734;
        Mon, 12 Nov 2012 09:41:30 -0800 (PST)
Received: from localhost (ip-109-43-0-114.web.vodafone.de. [109.43.0.114])
        by mx.google.com with ESMTPS id gy18sm3861733bkc.4.2012.11.12.09.41.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 09:41:29 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352742068-15346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209493>

Turns out repo.revs was introduced quite late, and it doesn't do
anything fancy for our refspec; only list all the numbers in that range.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 1d46838..c6d0367 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -294,7 +294,7 @@ def export_ref(repo, name, kind, head):
     if tip and tip == head.rev():
         # nothing to do
         return
-    revs = repo.revs('%u:%u' % (tip, head))
+    revs = xrange(tip, head.rev() + 1)
     count = 0
 
     revs = [rev for rev in revs if not marks.is_marked(rev)]
-- 
1.8.0
