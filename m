From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH] contrib/subtree: Teach add to store repository & branch in .gittrees
Date: Sun, 24 Mar 2013 20:22:01 +0000
Message-ID: <1364156521-29318-1-git-send-email-pcampbell@kemitix.net>
References: <CALeLG_nEuH6BOydUPTnDb5CrF=+5tipreHCAooxNnYW2eyVHLQ@mail.gmail.com>
Cc: greened@obbligato.org,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 21:22:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJrRH-0003P2-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 21:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab3CXUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 16:22:18 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:49420 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab3CXUWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 16:22:18 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm11so10260513wib.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=kp9o8AqzfuHtuiurwcJ9apWtV40HIcrRwx+pnEEJv+U=;
        b=kVSBeONuH9ybASlgS74M8GQ7XcL8F0cTttf/WxAf5/WtIHsHGKoU6g5j7k/GWB4VxT
         beOVZaWtYJeoo5pdNhGHumf1Bb922zXYQ7cIIfVEAIwbF1+2SiNtrqgGzbC2cZBmLlfT
         E04BAxwQ8bghykmQ8IDs1FoZBL66O7xUUmcbpwAnvsyiYtU7rEIeid63Lfu70GQj2m7v
         oiTdbDth1aqOvtU7cu0WKFqp7knhQOyLOroUPelZmTGbkHLptLr8nHOfiZWt5V1A1a2A
         Wslu7xy3lRiYxlYzHVNSA3CpiPUYk3hOUDOIRXiYV+laNqimFgaPzUvgmdAnPB8rRlnb
         LuaA==
X-Received: by 10.180.189.17 with SMTP id ge17mr21859821wic.17.1364156537076;
        Sun, 24 Mar 2013 13:22:17 -0700 (PDT)
Received: from coyote.home (host-2-102-87-178.as13285.net. [2.102.87.178])
        by mx.google.com with ESMTPS id o5sm17695232wix.3.2013.03.24.13.22.15
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 13:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <CALeLG_nEuH6BOydUPTnDb5CrF=+5tipreHCAooxNnYW2eyVHLQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQl9Oxj+wySj9HbTD2kXuDZZadhNps/K9iaQ1uh26tjPlxc4bDgdbhY05VCIQP56HOMQZY4D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218977>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

The repository and branch of a subtree added with the add command is
stored in the .gittrees file.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---

Rerolled allowing for $IFS whitespace.

 contrib/subtree/git-subtree.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..b6e821e 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -527,6 +527,14 @@ cmd_add_repository()
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
+
+	# now add it to our list of repos
+	git config -f .gittrees --unset subtree."$dir".url
+	git config -f .gittrees --add subtree."$dir".url "$repository"
+	git config -f .gittrees --unset subtree."$dir".path
+	git config -f .gittrees --add subtree."$dir".path "$dir"
+	git config -f .gittrees --unset subtree."$dir".branch
+	git config -f .gittrees --add subtree."$dir".branch "$refspec"
 }
 
 cmd_add_commit()
-- 
1.8.2
