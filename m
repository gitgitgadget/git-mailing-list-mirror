From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/8] git-remote-hg: use internal clone's hgrc
Date: Tue, 29 Apr 2014 04:04:33 -0500
Message-ID: <1398762275-346-7-git-send-email-felipe.contreras@gmail.com>
References: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Cc: Daniel Liew <delcypher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 11:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf48o-0000Mn-1Z
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933267AbaD2JPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:15:35 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45561 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248AbaD2JPb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:15:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so8587877obc.38
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eeTOnX3yZjY5w8/ck63h6BBh4qAh7A8QZMGngcbNNdY=;
        b=I+hIvovDRq2awxP6omeT2lGveX6LkLVJTMxUf/HId9/5IL4rLr4/IR4OZ2iotLNX7q
         /qpIOytyfqFHMgPgRkhJyI7oA9qk9ho3biOdB86k14MAt9UyAEYpTs7YC03WhQ7G90nh
         GtnDlWDgdB8LOdgEDJmpfd/RZXK95sJmZp1mer6jJ9B2YMqjlvQg7tBxYS11DQK3ZiTB
         ZppD/wI5HWjT1PBp7bbdDIXb/CyI9ePIfMzNcxYyGI0RFoxhzQP4JZFXyc8dZgjKCkRS
         HCTpV2+4n+u5Myq8d80vdZJ3V6CqFvO5IlsiiZQM0Yc2F1b145ImVD/bOcqlYuijbdaw
         xebw==
X-Received: by 10.60.96.165 with SMTP id dt5mr473108oeb.72.1398762930922;
        Tue, 29 Apr 2014 02:15:30 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm42791493obc.13.2014.04.29.02.15.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 02:15:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.3.gade8541
In-Reply-To: <1398762275-346-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247553>

From: Daniel Liew <delcypher@gmail.com>

Use the hgrc configuration file in the internal mercurial repository in
addition to the other system wide hgrc files. This is done by using the
'ui' object from the 'repository' object which will have loaded the
repository hgrc file if it exists.

Signed-off-by: Dan Liew <delcypher@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-hg.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-remote-hg.py b/git-remote-hg.py
index 1972f7f..cd3d79e 100755
--- a/git-remote-hg.py
+++ b/git-remote-hg.py
@@ -422,7 +422,7 @@ def get_repo(url, alias):
 
         repo = hg.repository(myui, local_path)
         try:
-            peer = hg.peer(myui, {}, url)
+            peer = hg.peer(repo.ui, {}, url)
         except:
             die('Repository error')
         repo.pull(peer, heads=None, force=True)
-- 
1.9.2+fc1.3.gade8541
