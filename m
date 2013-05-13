From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 10/10] remote-hg: trivial reorganization
Date: Mon, 13 May 2013 18:12:00 -0500
Message-ID: <1368486720-2716-11-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:15:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1xg-0007j6-IS
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518Ab3EMXPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:15:13 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:47957 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab3EMXPM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:15:12 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so1628232obb.18
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=pNYgOlPnp2j+E4K5VuD6ubBmvyokXfQhpC0oGqJOOeM=;
        b=Xn46oiaSEa10XNPta24IY/0aYV1HIqzdQtdcuxeXLphlmMUObAzuF+WVanwFvMG43N
         6FP/FBmAjcun0KI6ywoA9PUgK8hOa7M/gPOr+gJxhAAbvXaSMF+8iPt+O/KPFN/QizeD
         Nzo6qKn2seOJd+8vviTYhQ2R2vlEKXci112y4rcc3Gr5DnP9d4KC9XrtQUVP8PrSy1uP
         wrrSpXkvrJUysWQ7P+QROaV9ZDHq+1QjZpxbQA0NBmxZgBhq7yzGahB7QZ9wdLuwSTvS
         8WJRnzQ0v/DpXdp3mvxsc7+HE04ib9ObK0DGVzF/B02LHvXKpUeQDZkB/zLFu/IGCH87
         rXHw==
X-Received: by 10.60.141.2 with SMTP id rk2mr3919395oeb.69.1368486911832;
        Mon, 13 May 2013 16:15:11 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id p9sm19222120oeq.7.2013.05.13.16.15.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:15:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224228>

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
