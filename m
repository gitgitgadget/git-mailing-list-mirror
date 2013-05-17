From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] diffcore-pickaxe: make error messages more consistent
Date: Fri, 17 May 2013 17:53:22 +0530
Message-ID: <1368793403-4642-2-git-send-email-artagnon@gmail.com>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
Cc: Phil Hord <phil.hord@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 17 14:21:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdJfa-000113-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 14:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838Ab3EQMVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 08:21:50 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:39167 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab3EQMVt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 08:21:49 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so10075dak.33
        for <git@vger.kernel.org>; Fri, 17 May 2013 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=P2/oYEAx2iofU7OClabHhuN9BuqGMDeWTxif9BTj9ek=;
        b=H0WbknWhlagG6Z188QdGomisgSW58y2kDmUO2OFIyk9J89U4oS+XR0HUq4tIJMOwxW
         P3DwSZDWXJ/LuAoJrBlu3tHiYBGIQT0tj02B97+pfBq6b0htrg2Ty+EAZUk9xfRpHu/C
         3+icVT0jFSr41sUaKfitMtIY4jqV+8a1t/brLZgIzNFcx+Sin/7SXRahIsj4Rv82p7xH
         jS8ri9ezUvOahWVSW8IzSMjWLGCG79r2MvPcjfVsKosr++6bt5i6wzRWzN58aSEcQ3r8
         P/+4Dr7G45p9ODyl6ZsNp5H5XKerrQEgT53ysOv6knXjnyCfw2TBieSGJsd3I7ETQ6OV
         f07w==
X-Received: by 10.66.151.46 with SMTP id un14mr49498402pab.14.1368793308175;
        Fri, 17 May 2013 05:21:48 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id rn7sm11064643pbc.12.2013.05.17.05.21.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 May 2013 05:21:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2.432.g070c57d
In-Reply-To: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224685>

Currently, diffcore-pickaxe reports two distinct errors for the same
user error:

    $ git log --pickaxe-regex -S'\1'
    fatal: invalid pickaxe regex: Invalid back reference

    $ git log -G'\1' # --pickaxe-regex is implied
    fatal: invalid log-grep regex: Invalid back reference

Since the error has nothing to do with "log-grep", change the -G error
message to match the -S error message.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 diffcore-pickaxe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 63722f8..d69a7a2 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -122,7 +122,7 @@ static void diffcore_pickaxe_grep(struct diff_options *o)
 		char errbuf[1024];
 		regerror(err, &regex, errbuf, 1024);
 		regfree(&regex);
-		die("invalid log-grep regex: %s", errbuf);
+		die("invalid pickaxe regex: %s", errbuf);
 	}
 
 	pickaxe(&diff_queued_diff, o, &regex, NULL, diff_grep);
-- 
1.8.1.2.432.g070c57d
