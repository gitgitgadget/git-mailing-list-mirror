From: Tolga Ceylan <tolga.ceylan@gmail.com>
Subject: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Thu, 24 Apr 2014 21:46:18 -0700
Message-ID: <20140425044618.GA7058@olive>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cdleonard@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 06:47:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdY33-00088J-9y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 06:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbaDYErL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 00:47:11 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63626 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbaDYErK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 00:47:10 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so2703322pab.40
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 21:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=9hr+gOO43EC27JYhSuy4u8ltCeo0MGRuIKYJlFwSyUM=;
        b=m96DlVVfT4uryfC/9u9Sc1jIjDbVb1catvjumipxABPUdtFlXFi9Q83wk4K4dbH1Os
         aDRjHzY15yTGtFzfxd827MBUGaP9cVTLw+Rs2jW9Zt0uqg0H8Ywfng/syOEIqHFqxhKA
         yKLbo35viLGQPthMYt8m14gqLqT+RfzJ0JxspcRq1IcSpG8UCoYzpqw74xsypQvtm8ZG
         GpiOqrLN2oxJmIfury74XloSb6xEzUvYpS/ACYI0cyxCpg06OMnLJP5DE+AC16rlsjMA
         cfC2UeKccjdalqZ2zNl5i3bDsaqy0QqK+2jYdnbpeZ6v2Nl5MyHHTqtgeVaOuw22ylkc
         wpuw==
X-Received: by 10.68.141.102 with SMTP id rn6mr4916365pbb.43.1398401229460;
        Thu, 24 Apr 2014 21:47:09 -0700 (PDT)
Received: from olive (c-98-210-144-148.hsd1.ca.comcast.net. [98.210.144.148])
        by mx.google.com with ESMTPSA id op3sm12783955pbc.40.2014.04.24.21.47.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 21:47:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247030>

When applying binary patches a full index is required. format-patch
already handles this, but diff-tree needs '--full-index' argument
to always output full index.

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 git-p4.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index cdfa2df..4ee6739 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1311,7 +1311,7 @@ class P4Submit(Command, P4UserMap):
             else:
                 die("unknown modifier %s for %s" % (modifier, path))
 
-        diffcmd = "git diff-tree -p \"%s\"" % (id)
+        diffcmd = "git diff-tree --full-index -p \"%s\"" % (id)
         patchcmd = diffcmd + " | git apply "
         tryPatchCmd = patchcmd + "--check -"
         applyPatchCmd = patchcmd + "--check --apply -"
-- 
1.7.9.5
