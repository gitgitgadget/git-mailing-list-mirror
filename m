From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/6] remote-hg: trivial reorganization
Date: Fri, 10 May 2013 15:59:26 -0500
Message-ID: <1368219566-1399-7-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauRO-00011b-A0
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3EJVBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:01:12 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:56846 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab3EJVBK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:01:10 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so5494077oag.30
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E9+MJivRHjmGPlNZfkiVJI0NFPigExoe/4YXx84dkuw=;
        b=qzSpRYUpYr3SLfGPtjNR/hZm4GMyP3zTyjibqPwEgJvHBvw+w/REiwngL/uSWm6Nkg
         cogYLKeYfgVKrh86MizEmGJmPr/GGdXjz9PlFJEbT+pRIdrVqHs2GvRxVznTRwJ8ient
         5zQc1IC214W9JJw8lEcl+Emfzm/8KD7iQy3/eETFiXrLnIxxWYbxAOpNS6AozUcVJ2Bd
         6lo6cUd3AqaumGrKdvUSdP2mcoOeR77uIV2KUcaEIA1Q2qafBBJXN4aGmVltz/b0gcJh
         1nJke2zRytl8VjCgvyX5Eo1ADoAGHdrnDaLklP7oREdHqQAbBRn2g/ZdwlHuwhhNqLk0
         9VJQ==
X-Received: by 10.60.136.234 with SMTP id qd10mr8050525oeb.15.1368219670015;
        Fri, 10 May 2013 14:01:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id bh8sm4550443obb.11.2013.05.10.14.01.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:01:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223913>

We only need to get the remote dict once.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 50ead38..40da4b0 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -854,6 +854,7 @@ def do_export(parser):
 
     if peer:
         parser.repo.push(peer, force=force_push, newbranch=True)
+        remote_bmarks = peer.listkeys('bookmarks')
 
     # handle bookmarks
     for bmark, node in p_bmarks:
@@ -880,8 +881,7 @@ def do_export(parser):
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
