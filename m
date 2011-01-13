From: Jerzy Kozera <jerzy.kozera@gmail.com>
Subject: [PATCH] git-p4: Fixed handling of file names with spaces
Date: Thu, 13 Jan 2011 18:51:55 +0000
Message-ID: <1294944715-5647-1-git-send-email-jerzy.kozera@gmail.com>
References: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com>
Cc: gitster@pobox.com, msclrhd@googlemail.com,
	Jerzy Kozera <jerzy.kozera@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 13 19:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdSIK-0005Lm-Rr
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 19:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab1AMSww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 13:52:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63593 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805Ab1AMSwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 13:52:51 -0500
Received: by wwa36 with SMTP id 36so2123978wwa.1
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 10:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=ZnhwiSKJIcI23rgsODEyOXbEXhDTPxGfXMG1jzsLsOU=;
        b=RJPyEOiPV36GknpGhU6wT7HSVokiOUji5TuUluqeVyzA47bbLBWexMihwS8o4mH7E8
         rQJPSQnIUeyxWvEAhUeeTT0D8/brNW3bJpY2cbLBLGkMzSC9ghsAOnsB2oqMQAS4fKy0
         7fItrPJdMoT0rpFK85+5i7SENbiFzFpj7KBRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tDp3+kVRkKeisHogJYDphvoIVgxyCxski5ZHg6xuEboe0gjkUVAPi4jTRh/KyoIBu6
         kkDCiltIiD+u/jQ5jIwvGaa8yh8orXNyYQsjEFloCdRL1uwTBs5ABQmUwhPBBm2GkVpu
         m4q03AKhxoaJauF8VNw5Ci8MX3QD4wefb5dN8=
Received: by 10.216.173.147 with SMTP id v19mr2382362wel.102.1294944756053;
        Thu, 13 Jan 2011 10:52:36 -0800 (PST)
Received: from localhost.localdomain (188-223-231-164.zone14.bethere.co.uk [188.223.231.164])
        by mx.google.com with ESMTPS id j58sm216155wes.21.2011.01.13.10.52.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Jan 2011 10:52:34 -0800 (PST)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <AANLkTi=Cp=FCuJdthr7JfML6jdNzUiDAUPjrWpTQfWGk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165063>

Hi,

I've noticed the same issue in reopen and rm calls - not saying these three are all occurences of this problem, but I guess fixing them is a good start.

I'm using \" instead of '' quoting for consistency with rest of the file.

Regards,
Jerzy
---
 contrib/fast-import/git-p4 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..2147315 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -139,12 +139,12 @@ def setP4ExecBit(file, mode):
         if p4Type[-1] == "+":
             p4Type = p4Type[0:-1]
 
-    p4_system("reopen -t %s %s" % (p4Type, file))
+    p4_system("reopen -t %s \"%s\"" % (p4Type, file))
 
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
-    result = p4_read_pipe("opened %s" % file)
+    result = p4_read_pipe("opened \"%s\"" % file)
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
@@ -666,7 +666,7 @@ class P4Submit(Command):
                 for f in editedFiles:
                     p4_system("revert \"%s\"" % f);
                 for f in filesToAdd:
-                    system("rm %s" %f)
+                    system("rm \"%s\"" % f)
                 return
             elif response == "a":
                 os.system(applyPatchCmd)
-- 
1.7.1
