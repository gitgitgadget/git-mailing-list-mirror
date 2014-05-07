From: Tolga Ceylan <tolga.ceylan@gmail.com>
Subject: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Tue, 6 May 2014 22:48:54 -0700
Message-ID: <20140507054854.GA3571@olive>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cdleonard@gmail.com, pw@padd.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 07:49:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhujC-0006xb-LW
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 07:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbaEGFtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 01:49:11 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49490 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaEGFtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 01:49:10 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so667925pab.11
        for <git@vger.kernel.org>; Tue, 06 May 2014 22:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=bwStlgNmDSCGpjBwuA6uKqySJemxsLE0cGYYr8VQN1U=;
        b=rOiXSuUBD2qDAOCFU49P6pYCEkv1YdqAbv1v+gGJ2t/0BGycaaWQpP0OyoRhkXzhmt
         CmxwRHrg7r1Y7NSEgNmeghlzlnGEubrHoJnqSBseMsjIHEZ9JsGD02REVpSGrKRLW+Eb
         QwFGc1a/8ETWiVjvPqpM0oq6tv44mHmo1E57qpf0aXy68Lp6n6Iv0QOI/INvjxqFHpry
         fZLJNS25Rln4+9mjKcIc5hs0YwMlTJzE2vw2UvAXa+UProerHyiGjKoxwwXDbFUjLPbh
         kYcjN56ySohC8w6rUJqzvjOtZoRm6/sHqXNL250GH5y+YrthgXcq/2kApfWcogAuPV7G
         j0vQ==
X-Received: by 10.66.150.228 with SMTP id ul4mr14916162pab.16.1399441749050;
        Tue, 06 May 2014 22:49:09 -0700 (PDT)
Received: from olive (c-98-210-144-148.hsd1.ca.comcast.net. [98.210.144.148])
        by mx.google.com with ESMTPSA id cj1sm2695128pac.40.2014.05.06.22.49.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 May 2014 22:49:08 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248283>

When applying binary patches a full index is required. format-patch
already handles this, but diff-tree needs '--full-index' argument
to always output full index. When git-p4 runs git-apply to test
the patch, git-apply rejects the patch due to abbreviated blob
object names. This is the error message git-apply emits in this
case:

error: cannot apply binary patch to '<filename>' without full index line
error: <filename>: patch does not apply

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
Acked-by: Pete Wyckoff <pw@padd.com>
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
