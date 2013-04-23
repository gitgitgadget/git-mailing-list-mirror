From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/7] rebase -i: don't error out if $state_dir already exists
Date: Tue, 23 Apr 2013 19:31:59 +0530
Message-ID: <1366725724-1016-3-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdmK-0001SN-96
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab3DWOAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:43 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:58718 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393Ab3DWOAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:41 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so453222pdi.35
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yLjR7etTwfe17OEDP8gYlSDPLueuSQDxuGxpGIogQNY=;
        b=BcE28OWp8RyDg8j7NUMPRfh8Re9XbqsMIxj5iXegfzDI4zPH99zNagUX1DKSddiRRo
         ZvPP5Vr+dxdKYkLh+0gq8K9QrPyGcirBvR1WxXgzhzYLNbzzMWhgx7ob9MRtpiDBfx++
         5IbkITkiKU6EM4Q7fzYSbfEzDMrKTYBTSJtzvmWSDb+TnChe8GepTScVpMyNTRI5vtjM
         jbEZYst7xfHR8St1S5xy5lN1k3/5pdBVlCmXePgGM8b+0Zc9ILwbi/gUWesB9/ejB1cA
         qw28FVKxoV0+bn4IUQkyQDmdSUpuI89vPa4NaTV9afUvr+qUUNjj4Hhn2HbmiwFBEprW
         HclA==
X-Received: by 10.68.88.129 with SMTP id bg1mr40828562pbb.10.1366725640660;
        Tue, 23 Apr 2013 07:00:40 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222162>

Practically speaking, the only reason why a `mkdir $state_dir` would
fail is because $state_dir already exists.  There is no problem in
this case, and we can proceed as usual.  So, change the `mkdir` call
to `mkdir -p`, and strip the `|| die`.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-rebase--interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 048a140..cc3a9a7 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -837,7 +837,7 @@ then
 fi
 
 orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
-mkdir "$state_dir" || die "Could not create temporary $state_dir"
+mkdir -p "$state_dir"
 
 : > "$state_dir"/interactive || die "Could not mark as interactive"
 write_basic_state
-- 
1.8.2.1.578.ga933817
