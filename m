From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 07/20] remote-hg: redirect buggy mercurial output
Date: Mon,  8 Apr 2013 12:13:21 -0500
Message-ID: <1365441214-21096-8-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFgX-0006Qa-GP
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934044Ab3DHRPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:11 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:58911 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934566Ab3DHRPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:06 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so3861592obc.15
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jV+6/FrtPk8df5yU4fhXpbQDH1PSDCBtrZoQoMbeHwA=;
        b=O7w+Au0QCSjJYvjeLzaJ57rqyDPIMy98solAu+i9ZRn+sG80LoGdvruC3Or0jzd4yq
         ztwNGOzEpyzl/hosKehFxCZ9iq0Xa7cBmvGK5cQXdG7BXXFnLta4OQtdjek/9LYp8tWd
         hoEozETL3El/qYM2WSjtYBJ6VEb+D4KjEl1t/ZN3GAFSBZHA5ixoYcPSBl2gbTO7Mtml
         gKd8/w4o5HSVvR4t9tkQkWvDUwJfVnRQWiK6MjL3gH3/PjhCtaDj6cfYlb8uTEPUiBZN
         qu/58YdQC00hLt5QUZ1zlXKCKa/1Eh8PWDgi+97STfqeTfF7S7cGe/lKPzcnf9yGPbu8
         lU1g==
X-Received: by 10.60.35.197 with SMTP id k5mr15843824oej.138.1365441306408;
        Mon, 08 Apr 2013 10:15:06 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm26128605oeb.5.2013.04.08.10.15.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:05 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220460>

Mercurial emits messages like "searching for changes", "no changes
found", etc. meant for the use of its own UI layer, which break the pipe
between transport helper and remote helper.

Since there's no way to silence Mercurial, let's redirect to standard
error.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b200e60..874ccd4 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -271,6 +271,7 @@ def get_repo(url, alias):
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
+    myui.fout = sys.stderr
 
     if hg.islocal(url):
         repo = hg.repository(myui, url)
-- 
1.8.2
