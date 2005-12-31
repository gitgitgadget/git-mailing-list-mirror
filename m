From: Alecs King <alecsk@gmail.com>
Subject: [PATCH] gitk - show newly created files
Date: Sat, 31 Dec 2005 16:14:03 +0800
Message-ID: <20051231081403.GA4547@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 31 09:07:42 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Esbm9-000846-MT
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 09:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbVLaIHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Dec 2005 03:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVLaIHe
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Dec 2005 03:07:34 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:22244 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751321AbVLaIHd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Dec 2005 03:07:33 -0500
Received: by zproxy.gmail.com with SMTP id 13so2196391nzn
        for <git@vger.kernel.org>; Sat, 31 Dec 2005 00:07:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=HlQO7bQNjlGmYYN4E2eSFN3+yKB+fnJdpscrlEvbsC9H8YHGGJsNmz2rYqtOT/vUzcWluE1cGU5TKFD60C1dbODqCZc7bkCKp4dUJRRek6vDJEbHHXsLsgiG9h6EPxRxrDea6GcG1eCykbRC+V/ZN9+0AD8PndWrdfNLvqXH5ok=
Received: by 10.36.148.14 with SMTP id v14mr8693466nzd;
        Sat, 31 Dec 2005 00:07:32 -0800 (PST)
Received: from localhost ( [221.218.134.251])
        by mx.gmail.com with ESMTP id 36sm3231126nzk.2005.12.31.00.07.30;
        Sat, 31 Dec 2005 00:07:32 -0800 (PST)
To: git <git@vger.kernel.org>
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14122>

When specifying a filename as an argument to gitk, ie.

$ gitk apply.c

gitk does not show the diff when the file newly created.  

That 'newly created' commit is the last one gitk gets from
'git-rev-list' so gitk thinks it has no parent while it normally does
(except that the commit itself is the root commit).

This patch is to (try to) fix this problem.

P.S, is it good if gitk also has a '--root' option like git-whatchanged?


Signed-off-by: Alecs King <alecsk@gmail.com>


diff --git a/gitk b/gitk
index f12b3ce..688ee12 100755
--- a/gitk
+++ b/gitk
@@ -2288,10 +2288,10 @@ proc selectline {l isnew} {
 
     $cflist delete 0 end
     $cflist insert end "Comments"
-    if {$nparents($id) == 1} {
-	startdiff $id
-    } elseif {$nparents($id) > 1} {
+    if {$nparents($id) > 1} {
 	mergediff $id
+    } else {
+        startdiff $id
     }
 }
 

-- 
Alecs King
