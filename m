From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 09/19] Adding a "list" command
Date: Sat, 9 Mar 2013 19:26:37 +0000
Message-ID: <CALeLG_nWWbQnmMcKoqtpdLa+7VaxMgjmAr4Y7pPZ98SNO+_05g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPQ8-00022C-91
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab3CIT0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:26:38 -0500
Received: from mail-oa0-f45.google.com ([209.85.219.45]:64259 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CIT0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:26:37 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3316811oag.32
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=8jjDWf2VtzqUg0xV0D3DICpypI1kTuhOaxKYXiKwAZU=;
        b=hvY7vz/fdyHMsGkBwmMm/abhtrBmMf7xzWn6vO1UU4e7fksoJX7I/X5WgfITCVWclb
         DV5cy+Tx3UpKhbayG/O+Jq1tJZ1vxdXlaTiaidm0nUeOim3E5UVVCLNGlwd/hoBKRBez
         EtSeYIRGSt6juFi15pgaeDF8zix1t6jCUE7WzxQeNHSoYue3JgLIpvXP4GeRF73ZsldQ
         TruXCH4s7EiCeqplFUqsG5mIz5/Zo2UsTPCShHhdraOOh0+5qMJGIp2UBQf6kQDuZSx0
         eVj0knS+y8C1XYUrbPyTWDQwL0MRf2Q2DqI0IzmHYthL96JXXDkVn6SYAA/cFikUMVO2
         bdig==
X-Received: by 10.182.3.196 with SMTP id e4mr5150553obe.36.1362857197292; Sat,
 09 Mar 2013 11:26:37 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:26:37 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQnWGNt/ESFPE4q3to+3KsoiwFgj/bPNlL1icqbKOC0m2rSqIn2ltD5GsLqcOCq6is/6papa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217746>

>From ca1c855c032d88159ed878f68ef2e18640bbd49c Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:33:12 +0000
Subject: [PATCH 09/19] Adding a "list" command

Conflicts:
	git-subtree.sh

Original-Author: mhoffman <matt.hoffman@quantumretail.com>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 4c3f3c0..7d08064 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -107,10 +107,10 @@ shift
 case "$command" in
 	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
 	*) die "Unknown command '$command'" ;;
-    split|push|diff) default="--default HEAD" ;;
+    split|push|diff|list) default="--default HEAD" ;;
 esac

-if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" ]; then
+if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" -a "$command" != "list" ]; then
 	die "You must provide the --prefix option."
 fi

@@ -824,6 +824,21 @@ cmd_from-submodule()
 	rm -rf $tmp_repo
 }

+subtree_list()
+{
+    git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
+    while read path; do
+        repository=$(git config -f .gittrees subtree.$path.url)
+        refspec=$(git config -f .gittrees subtree.$path.branch)
+        echo "    $path        (merged from $repository branch $refspec) "
+    done
+}
+
+cmd_list()
+{
+  subtree_list
+}
+
 cmd_pull-all()
 {
     git config -f .gittrees -l | grep subtree | grep path | grep -o
'=.*' | grep -o '[^=].*' |
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
