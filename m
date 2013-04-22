From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/16] remote-hg: safer bookmark pushing
Date: Mon, 22 Apr 2013 16:55:10 -0500
Message-ID: <1366667724-567-3-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOk0-0001Cs-IJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab3DVV5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:57:24 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:49615 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab3DVV5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:57:21 -0400
Received: by mail-ob0-f172.google.com with SMTP id v19so5856755obq.3
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZIE40bxAceLO0dvk9Yqsm9j2ead4rTDvIpLLhAcaKqQ=;
        b=GyddRGrY6uBCj+MrYRGEYlE2Rj3XOHsypgTBsrljmB1fX3NtYAePvnM20jOfO/X8BA
         +F2Nlk8u8Qz1AbM2H2+w5K7xLQs9sLbA8YpaqgVHXuIMAf4SsXLBppqrh8QmEmdT2R6v
         JdAWckTVL0OY79gnn0UNlj+ZKAixxt2yxAuVE7DlSXQkpcX/To2ym/JAG1QmMBbffU9g
         K6pJvsZ0eqvxYsvfmoy+rPa3k40botElMw9lJTfW2t1qOu7OMHpirYl0O8JiylZQAxqD
         5I90g1hB2IJiTZy4a+8nlN6hEYuY3FjEFvqo61+O8VnbY38PRdiOvltXB0X8vaSYU5A1
         P9HQ==
X-Received: by 10.60.50.102 with SMTP id b6mr11302710oeo.46.1366667841170;
        Mon, 22 Apr 2013 14:57:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id zc8sm20055540obc.8.2013.04.22.14.57.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:57:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222099>

It is possible that the remote has changed the bookmarks, so let's fetch
them before we make any assumptions, just the way mercurial does.

Probably doesn't make a difference, but better be safe than sorry.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 2cd1996..dcf6c98 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -782,6 +782,8 @@ def do_export(parser):
             continue
 
         if peer:
+            rb = peer.listkeys('bookmarks')
+            old = rb.get(bmark, '')
             if not peer.pushkey('bookmarks', bmark, old, new):
                 print "error %s" % ref
                 continue
-- 
1.8.2.1.790.g4588561
