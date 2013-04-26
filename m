From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/20] remote-bzr: always try to update the worktree
Date: Thu, 25 Apr 2013 20:07:52 -0500
Message-ID: <1366938488-25425-5-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXAW-0003Zu-DK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643Ab3DZBJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:09:37 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55380 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab3DZBJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:09:35 -0400
Received: by mail-oa0-f46.google.com with SMTP id k3so3474696oag.19
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zH6JuNCFzfNgewXjV/0PC+PKFnaA2J64Nx9too6xLPY=;
        b=Ev062YpsvlH9+RPHKtCCu3JI97eAL6QrS5TCxgWyRwN9ejYNhwqL1Qfus2pyho4Gc3
         8+dwofG/BIR/Bsjhc2mIURW8mxHMbpJ+e4ooUdD9UgHVlYufg7eZDbMTsGnsICYwVeKE
         /+h1FihlxgveT6ghjre1um8p2qNrlFaLbMln5zQZyH8E9rFUrBPwg/yMk1H4jdWJQYSA
         lWm/AtyUFPCLZLCpKi88e/JAkYK0EWsIJwIFN25G9ZubA3AiWG5TCijnNRibVZ/jDb0K
         DXQwPOcOqPOEkka2akkhQ/cSDSThcRhP9HjItHsNiXft1kA15S7a363mLZHuIJytvZ2G
         26QQ==
X-Received: by 10.182.32.1 with SMTP id e1mr16262153obi.90.1366938574665;
        Thu, 25 Apr 2013 18:09:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm5857944oby.5.2013.04.25.18.09.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:09:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222486>

And fail properly when we can't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index b428244..eb91d28 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -641,9 +641,13 @@ def do_export(parser):
                 except bzrlib.errors.DivergedBranches:
                     print "error %s non-fast forward" % ref
                     continue
-            else:
+
+            try:
                 wt = repo.bzrdir.open_workingtree()
                 wt.update()
+            except bzrlib.errors.NoWorkingTree:
+                pass
+
         print "ok %s" % ref
 
     print
-- 
1.8.2.1.884.g3532a8d
