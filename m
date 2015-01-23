From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: correct --prepare-p4-only instructions
Date: Fri, 23 Jan 2015 09:15:12 +0000
Message-ID: <1422004512-10049-2-git-send-email-luke@diamand.org>
References: <1422004512-10049-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 10:16:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEaLq-0000kF-5M
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 10:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbbAWJQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 04:16:20 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34769 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbAWJQP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 04:16:15 -0500
Received: by mail-wg0-f52.google.com with SMTP id y19so6274992wgg.11
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 01:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZ8oLavUTSZ9avK59T70DUM+05Q/EE/VqVPkFyFJFGE=;
        b=QLwoTmYK8n7kHvNQUoz1JcWGmOQewyB+vwocsTDdV1ARWezr3UofutpMEjRtYlGktP
         O90aj5WOqdTXlkf/jZZN7zko10fo5AuADnzVAJeGyfHsff+wMjmpM9if5Ukgt5O20x/W
         ttciFGOeiK0Rg0hVXiOVoHY9xAZpnGqtloIaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZ8oLavUTSZ9avK59T70DUM+05Q/EE/VqVPkFyFJFGE=;
        b=Zvdny3ca7ayAj2asL1fFhXhxtpwEi3Ev7YFba9PMUIEvQag+kcWoyj+BP9TgKd6HfA
         NIxF+rvNWVfeKh0wd0c82jV+8HIMlU5j0qngYf2pxQm9zBYozwmINnjoxt3I041YoDet
         O9GLhNnP3B5R6AoLNNlMjcl/2xsh9WzeJvoQFF914qyTLySEwuHWbCHHLm98iSQhySRx
         0BGtk8kpax/YogdunbvKPdxCmOLfdb/gTBDimlJdkEwZO8DtAXV7bL5tzs9QFP+EkdQw
         YxdBGvo1rEl5xtL8jAFA45wPflJg2E3h4QzSdxF7oXc+sOFpWeJVR6G8bF/xIonNijGp
         +GRQ==
X-Gm-Message-State: ALoCoQnWhgMFMHNYo16W/ih2O01XJAFmOq8XWrki+ur8scDYzTz5/+xv4bkCE8NieEemrIbwoINC
X-Received: by 10.180.8.169 with SMTP id s9mr1736581wia.72.1422004574291;
        Fri, 23 Jan 2015 01:16:14 -0800 (PST)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id cf12sm1372311wjb.10.2015.01.23.01.16.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2015 01:16:13 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.30.g76afe74
In-Reply-To: <1422004512-10049-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262904>

If you use git-p4 with the "--prepare-p4-only" option, then
it prints the p4 command line to use. However, the command
line was incorrect: the changelist specification must be
supplied on standard input, not as an argument to p4.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index ff132b2..90447de 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1442,7 +1442,7 @@ class P4Submit(Command, P4UserMap):
             print "  " + self.clientPath
             print
             print "To submit, use \"p4 submit\" to write a new description,"
-            print "or \"p4 submit -i %s\" to use the one prepared by" \
+            print "or \"p4 submit -i <%s\" to use the one prepared by" \
                   " \"git p4\"." % fileName
             print "You can delete the file \"%s\" when finished." % fileName
 
-- 
2.1.3.1037.g95a6691.dirty
