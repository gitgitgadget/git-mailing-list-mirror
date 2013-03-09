From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 18/19] Added --force option to push
Date: Sat, 9 Mar 2013 19:30:37 +0000
Message-ID: <CALeLG_=Pr5_OWCc+EJ7g33O-neka7HAgwa58w-TAm3WQwJjrTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:31:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPU0-0005UP-FF
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3CITai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:30:38 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51059 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CITai (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:30:38 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so2222067obc.19
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=0tXqiMc35kDsn6xmPIB2HGpdfDHziEn0Dq1skcXNsP8=;
        b=LvJYwkvJBLnc/NvuZzvKMLrk8aJfYnWzNz3Rw3tQxiWIeDUO5S3FKfI4nfI+Yu1Aqs
         X1gRmu2IpPrCpixG3ZWz4fdnF9ers+EFlbE54/S4/viGh4YZF4LYJJdcrJs5c2Uv5Swo
         W+xOkGi+I05JkV5QKXBabOucEoU/LWfK7zwyGLmCmTgzvYl0i4+FJzM+P491BrUQYzSv
         PRxVRgehy4onkcm3kSRTp7EzrB0Y9u/xLHVpxM+RzGn4DDE8bbbKeI7tW6DRIfaCSJQo
         O4Pl/Z983GhoWGFVhgbZ8YocelxJXzqWj1Cv3Ms2tmsFOXvNLMD68M89zkV+08PgG953
         j2uQ==
X-Received: by 10.60.22.34 with SMTP id a2mr5047210oef.97.1362857437561; Sat,
 09 Mar 2013 11:30:37 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:30:37 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnqxvt6/Cbx452NVAgrGIMWwA9khMF15hJtNnKpcg2b3xWjD0QTq476NwKXgpijiZaBjSXz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217756>

>From ae7c05bdc6d02fa89deabb59cec6150308f227f7 Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:35:42 +0000
Subject: [PATCH 18/19] Added --force option to push

Conflicts:
	contrib/subtree/git-subtree.sh

Original-Author: James Roper <jroper@vz.net>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh  | 9 ++++++++-
 contrib/subtree/git-subtree.txt | 5 +++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 4605203..3582a55 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -32,6 +32,8 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
+ options for 'push'
+f,force       use force push
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
 "
@@ -90,6 +92,7 @@ while [ $# -gt 0 ]; do
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
+        -f|--force) force=1 ;;
 		--no-prefix) prefix= ;;
 		--onto) onto="$1"; shift ;;
 		--no-onto) onto= ;;
@@ -790,10 +793,14 @@ cmd_push()
 	      repository=$(git config -f .gittrees subtree.$prefix.url)
         refspec=$(git config -f .gittrees subtree.$prefix.branch)
       fi
+        push_opts=
+        if [ "$force" == "1" ]; then
+            push_opts="$push_opts --force"
+        fi
 	    echo "git push using: " $repository $refspec
 	    rev=$(git subtree split --prefix=$prefix)
 	    if [ -n "$rev" ]; then
-	        git push $repository $rev:refs/heads/$refspec
+	        git push $push_opts $repository $rev:refs/heads/$refspec
 	    else
 	        die "Couldn't push, 'git subtree split' failed."
 	    fi
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 385bde8..9e9eb9e 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -278,6 +278,11 @@ OPTIONS FOR split
 	'--rejoin' when you split, because you don't want the
 	subproject's history to be part of your project anyway.

+OPTIONS FOR push
+----------------
+-f::
+--force::
+    Uses 'git push --force'.

 EXAMPLE 1. Add command
 ----------------------
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
