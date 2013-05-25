From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/48] remote-hg: trivial reorganization
Date: Fri, 24 May 2013 21:29:18 -0500
Message-ID: <1369449004-17981-3-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:31:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Gu-0001GX-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668Ab3EYCbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:31:49 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45233 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab3EYCbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:31:48 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo10so2817115obc.10
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0y52uOHl9M3kT1yMaApLEK3cSC9f6StQhl6uzLaBmmI=;
        b=DEdwiaxponBedpLRB0TIIvjtF+DHhScG5ETH9UGNcmT1Bv2xgLLc+5pDDkt9bsR4H1
         5X07NOW9Y2g0JohT1Iu1Liz+ILeqcliZ+pF5lkc72y/MrJoi7xPp8Qo5W16oZGZBw8yu
         3jeIkSJzkx4UMaiHcFeMiTW6mXvMlexMeyF+pn+9C1U153aHPai2i7gKaHwCim91a0iV
         +0h23Bl8Dfi2w7DdX15DZc40SpNkOSkoOBizhhf3OPZqe2gfB9hmKV51P44tHXpG3SQb
         Z9h0YmBJ/HdFvep+kmVEqYrmSlmvFqQhQxhJyWFgRA5Bw59y9psKHe37+2ez2+o3+u5V
         kMjQ==
X-Received: by 10.60.37.233 with SMTP id b9mr13777711oek.27.1369449107929;
        Fri, 24 May 2013 19:31:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm20040162obc.10.2013.05.24.19.31.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225416>

We only need to get the remote dict once.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 1dd3d70..426c1fc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -857,6 +857,7 @@ def do_export(parser):
 
     if peer:
         parser.repo.push(peer, force=force_push, newbranch=True)
+        remote_bmarks = peer.listkeys('bookmarks')
 
     # handle bookmarks
     for bmark, node in p_bmarks:
@@ -883,8 +884,7 @@ def do_export(parser):
             continue
 
         if peer:
-            rb = peer.listkeys('bookmarks')
-            old = rb.get(bmark, '')
+            old = remote_bmarks.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
                 continue
-- 
1.8.3.rc3.312.g47657de
