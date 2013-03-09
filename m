From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 07/19] Added check to ensure that split succeeds before trying
 to push
Date: Sat, 9 Mar 2013 19:25:37 +0000
Message-ID: <CALeLG_mYSzBKv+u=hyHjKi_-ft-3Pyk2aQMyRQ8CbjL2x08rjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPPA-00015B-39
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab3CITZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:25:38 -0500
Received: from mail-oa0-f43.google.com ([209.85.219.43]:61715 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CITZh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:25:37 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so3269778oag.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=Tp/1MPXbYhcM/PTTNFuF/3M+UjtczTa+G9FRHy4HNqM=;
        b=b9VLaouCBE800Cg5WQP8vDL0UyEnU6Bn3VOVy0MH1W9C8g8V6kxhgPp8XlDWHnds+M
         Z0TAyVTST+kC2WnKx04KfLw2/zkgFN00nugXCu/zirNvoJEHwEzUVJ5UeGrH9f/iLQzE
         T8F2JPckiHlosk8MhHxj+p4jWuAF54C7ObOsknc2yERRLRzLsxDUBV+Pp7e8IYxLhsd+
         sX0ytVDPjg9VnJ+5YySpB9vdExQHpuhmDrcVcUI72oKE7xCrIEHgeo3d0Sd1lbS3nId2
         DE14q0u1OquntbrcTPplfsSn8eaMpTWmAdVd0k8YiIn3rrLcL5JKlxJV7eU/KuxyIDMB
         blFg==
X-Received: by 10.182.231.39 with SMTP id td7mr5129796obc.86.1362857137110;
 Sat, 09 Mar 2013 11:25:37 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:25:37 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQn5PkhrthMmboacvmgnkMw2+zMX5lu2AxF+RtOES7gZR5T88azy/niyPTDmbVZVPk9HIUDI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217744>

>From ef4d4081474bd9925b60c2ab856260d9174220b9 Mon Sep 17 00:00:00 2001
From: mhart <michael@adslot.com>
Date: Sun, 16 Oct 2011 00:16:53 +1100
Subject: [PATCH 07/19] Added check to ensure that split succeeds before trying
 to push

---
 contrib/subtree/git-subtree.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8056851..ae9f87f 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -754,7 +754,12 @@ cmd_push()
         refspec=$(git config -f .gittrees subtree.$prefix.branch)
       fi
 	    echo "git push using: " $repository $refspec
-	    git push $repository $(git subtree split
--prefix=$prefix):refs/heads/$refspec
+	    rev=$(git subtree split --prefix=$prefix)
+	    if [ -n "$rev" ]; then
+	        git push $repository $rev:refs/heads/$refspec
+	    else
+	        die "Couldn't push, 'git subtree split' failed."
+	    fi
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
-- 
1.8.2.rc1

-- 
Paul [W] Campbell
