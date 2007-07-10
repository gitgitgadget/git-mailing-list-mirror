From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH 2/2] t0030: Add tests with consecutive text lines and others
 with spaces added.
Date: Tue, 10 Jul 2007 23:59:43 +0200
Message-ID: <4694014F.7040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 23:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8NkO-0000Ja-2L
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 23:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759852AbXGJV7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758380AbXGJV7t
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 17:59:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:16028 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbXGJV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 17:59:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1433797ugf
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 14:59:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=l1oVAEMZuyJz4IKDa0NliKWUCb2rCP3+ZoBO36cw6wIVMTyWw5nIvaq4gp0LP+l5gqSC4/OkmLk/w7yKIL2H9MEj7Qp7hVfireFX2U1SXTBk41wly+6NsnWHZTzlus16qT9Cev6Cl2TOmf7/pzAUzpXxNt7N/IH46hoHw+QOx3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=EspexKG7tEhYxYFwC+Tq/xzr7P3I0hLIckMOXrWlNj7NKr6m5VGGxVAH+1NuKBqP+odvyFKI8sy3WCSuzqV4DkOQBqFBijBF3hue0rGxhIOBqj7yerP/WPECXLfeFqDrRJZB3/h5+Dyc6k+dbgaA7wu5Aj5iCPDt+cZWQ5b6v6A=
Received: by 10.66.224.3 with SMTP id w3mr6205866ugg.1184104787343;
        Tue, 10 Jul 2007 14:59:47 -0700 (PDT)
Received: from ?192.168.0.194? ( [212.145.102.186])
        by mx.google.com with ESMTPS id p32sm2012294ugc.2007.07.10.14.59.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jul 2007 14:59:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52114>

Previous tests only had paragraphs of one line. This commit adds some
tests to check when many consecutive text lines are given.

Also, it adds tests for checking that many lines between paragraphs are
correctly reduced to one when there are tabs and spaces in those lines.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   These were used in the development of the new in-place version
   of the stripspace function, which acts on a buffer instead
   on file descriptors. The first version I wrote passed the
   previous tests but it was completely broken in these cases.

 t/t0030-stripspace.sh |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 4a2980c..b1c9003 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -81,6 +81,30 @@ test_expect_success \

     printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
     printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt\n" > expect &&
+    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt$ttt\n" > expect &&
+    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
     git diff expect actual
 '

@@ -341,4 +365,31 @@ test_expect_success \
     git diff expect actual
 '

+test_expect_success \
+    'consecutive text lines should be unchanged' '
+    printf "$ttt$ttt\n$ttt\n" >expect &&
+    printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
+    printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
+    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
+    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
+    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+    git diff expect actual &&
+
+    printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
+    printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
+    git diff expect actual
+'
+
 test_done
-- 
1.5.0
