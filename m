From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 07/13] remote-hg: redirect buggy mercurial output
Date: Tue,  2 Apr 2013 13:02:56 -0600
Message-ID: <1364929382-1399-8-git-send-email-felipe.contreras@gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:05:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6Vu-0007A7-6F
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab3DBTEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:04:25 -0400
Received: from mail-gg0-f178.google.com ([209.85.161.178]:49433 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762098Ab3DBTEW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:04:22 -0400
Received: by mail-gg0-f178.google.com with SMTP id e5so113921ggh.9
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3/RA9ZXseMJHr6CU7Rhydmsor0DJ/8eJGzCGPwBqnHE=;
        b=u+qsdUtzkZ8utQyIisK7mqQDVodNvwr2J2Dj2crnONwQ8LYk1eRTAhV6sex2stJpfS
         Eu9L0YuxvvMhSinpvWIDFarsxvIfDdOv4gaBK9DoqXd92cmHbPKHsZsslabZWbKQmtRu
         3RqIN65bNpQOGQaivjrveRhMaN3y/tf0phL9t18YdWnPiksaRMEEtAQW5kbncB53tYLS
         IhBM9E1PsXCjgSEyDbqFFu8UOIDhRqMKqXN5XYwg8SsVCzPTAzUW8vpmqABKMpvnNB3o
         OZjRsG5RJlqbVjfXaPnyeDWkVrSVsNY6dAxhWBsKkuVg6mu/aXEgJJ87HQhB0G08VwPT
         Jqww==
X-Received: by 10.236.152.102 with SMTP id c66mr16368318yhk.72.1364929461547;
        Tue, 02 Apr 2013 12:04:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id b78sm4926584yhi.2.2013.04.02.12.04.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 12:04:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219840>

We can't use stdout for that in remote helpers.

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
