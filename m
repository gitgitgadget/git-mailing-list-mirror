From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 37/47] remote-hg: force remote bookmark push selectively
Date: Mon, 13 May 2013 23:37:00 -0500
Message-ID: <1368506230-19614-38-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:40:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc72k-0004oJ-Hr
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab3ENEko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:40:44 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:45818 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184Ab3ENEkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:40:42 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so104751oag.11
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=uyC0XC+Kt61g6BSvlb76dyBkcv+/2M2S68Jdx4qvTlU=;
        b=0WHrq/VVEYXuNMTOYjiWEAQ2J3qgUBQsRvCMBrqW4XpMQcC9HbgGnMVwzp9rvkLCin
         8dObPQaM7PxSWdRxehvTME3oLUKmHZFhu0krmipwglxNCvTSeIXy4IcnWrZRRHajNGfy
         IY2LgFGZ0VEklkFX3dlvS+rTWmUKUo9BSXn/AKyeYicJxZrRWHKxXmqycEc0AzQdKiqG
         +ykArM/NAdmEvhyMDvLoNTrmu5aeQ2RBPYcfh/Q3eyNGid0nK4wuTmK6HhWHM7JrBQCC
         jlv9PNgF5PIdI+6PH2axHPJuj/O6WGC0fOf+RKZcW90Ack73PvTOhKzIuVX+EoZVxJ31
         89kA==
X-Received: by 10.60.58.99 with SMTP id p3mr15223494oeq.23.1368506441548;
        Mon, 13 May 2013 21:40:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9279247obb.11.2013.05.13.21.40.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:40:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224269>

If we update the 'old' node, we might be updating the remote bookmark
even when our 'new' node is not related at all to what the remote has,
effectively forcing an update.

Let's do that only when forced push is configured.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 14fadd1..0780679 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -906,7 +906,8 @@ def do_export(parser):
         # update remote bookmarks
         remote_bmarks = peer.listkeys('bookmarks')
         for ref, bmark, old, new in p_bmarks:
-            old = remote_bmarks.get(bmark, '')
+            if force_push:
+                old = remote_bmarks.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
     else:
-- 
1.8.3.rc1.579.g184e698
