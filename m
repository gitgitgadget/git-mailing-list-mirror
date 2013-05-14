From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/47] remote-hg: trivial reorganization
Date: Mon, 13 May 2013 23:36:33 -0500
Message-ID: <1368506230-19614-11-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71G-00040Q-Gc
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab3ENEjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:14 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:42269 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3ENEjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:12 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so101517oah.21
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pNYgOlPnp2j+E4K5VuD6ubBmvyokXfQhpC0oGqJOOeM=;
        b=GI1QkDaduJE+gvPXrO0xTZc5m9wA2S7o/Kc41xquSPeN2RHURkjhwuHszqm0kan+ZQ
         BCxGbg+IPYBvovO5exjAfOnCW5oCMW+lpu+LYYqdWxpgWgfnyrZlZ6lnP9tQLxZZbqmH
         VUsdJ/K+x9bSxwcjIR/T3typauXrRq6mlkWUUyv0z3Kzs3Z/j/ZYff14tS2J2JBlKzHw
         ch3cdwdeoBw0Fp9PertO1JE0yGlae1cEZj2QS5ahCcPO/zB68ESAX8oqiRUpGWYALtT5
         NMdHR8Isawzwvl+lq1Ey5eMshmp5KMUo/UBg9rYVV5UrPcT7zOrraxgX3FM9LY7IKOyz
         BZyQ==
X-Received: by 10.60.79.68 with SMTP id h4mr11319562oex.39.1368506351599;
        Mon, 13 May 2013 21:39:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm20047251obc.2.2013.05.13.21.39.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224245>

We only need to get the remote dict once.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index dc276af..96bed8d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -860,6 +860,7 @@ def do_export(parser):
 
     if peer:
         parser.repo.push(peer, force=force_push, newbranch=True)
+        remote_bmarks = peer.listkeys('bookmarks')
 
     # handle bookmarks
     for bmark, node in p_bmarks:
@@ -886,8 +887,7 @@ def do_export(parser):
             continue
 
         if peer:
-            rb = peer.listkeys('bookmarks')
-            old = rb.get(bmark, '')
+            old = remote_bmarks.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
                 continue
-- 
1.8.3.rc1.579.g184e698
