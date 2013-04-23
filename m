From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 19:31:58 +0530
Message-ID: <1366725724-1016-2-git-send-email-artagnon@gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUdm7-0001CS-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab3DWOAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:00:41 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:45356 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab3DWOAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:00:39 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so167644pbb.41
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dvNmYfqNAxTBt2u5X9elyjAMsXhQcIMck3hb9EpSnpc=;
        b=KYMx5z8Az3Yu4bekocr1JJ/kPVXlQ6jX1HAzEFIRJVSTkROqrFSiXsxSCeZCBL8CQp
         y/fuVZs38pSez12vUam1BgHIdvT1ffvy9W7FDDYNMko/U+hZRnRDmlgBaas57EkzesAd
         WOIAk2/6Xfvug/rbsZsrWol65njRvwkBCUtRG5xsuT9+k0ogUn1UZoMHTnDPd0xcFt1f
         q9JEEkUGT8CxAeLLB+NZ7CuBueQhYlek5RYF+hJ0ud6oednIFrT2rgtLkqmabUAkdfXS
         gvMifigyp+4Z89DNa8gF9GN4wfUcM33NPr6iOHKDiqiTiwcxb/RWeITZ+4CVRCHFEFfP
         jbtQ==
X-Received: by 10.68.202.104 with SMTP id kh8mr40969201pbc.74.1366725638448;
        Tue, 23 Apr 2013 07:00:38 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id vk7sm29634120pbc.41.2013.04.23.07.00.36
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 07:00:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.578.ga933817
In-Reply-To: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222159>

When testing if the $dotest directory exists, and if $next is greater
than $last, the script currently executes `cat` on files that might
not exist.  So, suppress the error output from `cat`.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index c092855..88aa438 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -446,8 +446,8 @@ done
 # If the dotest directory exists, but we have finished applying all the
 # patches in them, clear it out.
 if test -d "$dotest" &&
-   last=$(cat "$dotest/last") &&
-   next=$(cat "$dotest/next") &&
+   last=$(cat "$dotest/last" 2>/dev/null) &&
+   next=$(cat "$dotest/next" 2>/dev/null) &&
    test $# != 0 &&
    test "$next" -gt "$last"
 then
-- 
1.8.2.1.578.ga933817
