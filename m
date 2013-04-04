From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/13] remote-hg: redirect buggy mercurial output
Date: Thu,  4 Apr 2013 09:30:16 -0600
Message-ID: <1365089422-8250-8-git-send-email-felipe.contreras@gmail.com>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 17:32:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNm9J-00048e-8h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762587Ab3DDPbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:31:43 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39985 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762411Ab3DDPbm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:31:42 -0400
Received: by mail-ob0-f177.google.com with SMTP id uz6so2637749obc.22
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jV+6/FrtPk8df5yU4fhXpbQDH1PSDCBtrZoQoMbeHwA=;
        b=lnozXgFl5lxFgA5mAo+h4gHhCyoH1fQ9KbmHcohC+OxVIwkr8DBjPdnYDhNJn57zcb
         C/HjWPHP1hvTCPj0+U3dtguMMUN5lYVg2uTB9RlTvZK7E59BsjnTSQNlcN78nOZ7pED6
         9dbns0qeorUYwm9H/99r2ygRGoo5yzfc2isBEyS6iZpNS/aLtq+x5eF6u9vEC7Vmj1iE
         N2Cw32XHzfQNC4X5yk2IgyBwRUXD9XrKVJS7p+krjzaEhHCvCb2OKBCk8OumIRnN3EpE
         Uen1+btCcX6yP7Sae7ZBD0Kai5efgbR7wqOMVZ+M4EPNEc85ZVUlIRPuOhhuLJ/3x4QH
         U3cw==
X-Received: by 10.60.131.204 with SMTP id oo12mr1262211oeb.78.1365089501888;
        Thu, 04 Apr 2013 08:31:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id h9sm6781072obg.14.2013.04.04.08.31.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 08:31:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220009>

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
