From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 21/28] The log.decorate setting should not influence import-commit.
Date: Fri, 21 Mar 2014 08:31:59 +0100
Message-ID: <1395387126-13681-22-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQty0-00035m-QK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbaCUHeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:34:09 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:64877 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbaCUHdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:32 -0400
Received: by mail-la0-f45.google.com with SMTP id hr17so1399806lab.32
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mQoRXqb+4kMCyX+INrPeOydI9uNUn4fuFRIw4Hsx8EA=;
        b=AihBhP5jJVYYHN4LOToo8OX1y1RgIOMEbJoVgeRkl+FYLNUraUDQByd7g6ACMIE7LR
         dRJbQi9YvSI4LASH77aigg4IlmCqs77X+R9FoC2YB00Gd1Ux0lDAUfP5FeAaT8MQJP+Z
         JMsvp+ZO90ks84Indsne/UUVkn3Fp0t3sFI0HL75gXO1V4bBtkSinRdfxM9zj3sTFaz4
         a1V3qR2hmMmWNx8i+CnF1wkP3QBL/MTBm7J8uGnB6LgHCTtnaQTCVgZiOiPNz9V3+UuI
         nbXZlSb5H/yJeCA8FhkjPDzTBTDhp3D7Bt5X5O2XF28k1bzl5rTi7eoEDmqYICQzZV5A
         PadQ==
X-Gm-Message-State: ALoCoQn0k3wf19hEVG7FZb/jmnU9iy5hSYR1LyN1lzmE4D2kbr2c6q5Wbprh81fJ8KhJH5eDSVjt
X-Received: by 10.112.171.67 with SMTP id as3mr31093845lbc.10.1395387211665;
        Fri, 21 Mar 2014 00:33:31 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244657>

Use --no-decorate in the call to git log that tries to read the commit
message to produce patch names.  Otherwise, if the user has set
log.decorate to short or full, the patch name will be less useful.

Modify the t-034.sh test case to demonstrate that this is needed.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-import-commit  | 2 +-
 regression/t-034.out | 2 ++
 regression/t-034.sh  | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/guilt-import-commit b/guilt-import-commit
index 6eb2f4e..703f034 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -26,7 +26,7 @@ disp "About to begin conversion..." >&2
 disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
 
 for rev in `git rev-list $rhash`; do
-	s=`git log --pretty=oneline -1 $rev | cut -c 42-`
+	s=`git log --no-decorate --pretty=oneline -1 $rev | cut -c 42-`
 
 	# Try to convert the first line of the commit message to a
 	# valid patch name.
diff --git a/regression/t-034.out b/regression/t-034.out
index bda4399..5d81bd4 100644
--- a/regression/t-034.out
+++ b/regression/t-034.out
@@ -232,6 +232,7 @@ Date:   Mon Jan 1 00:00:00 2007 +0000
     
     Signed-off-by: Commiter Name <commiter@email>
 % guilt init
+% git config log.decorate short
 % guilt import-commit base..HEAD
 About to begin conversion...
 Current head: 2a8b1889aa5066193bac978e6bf5073ffcfa6541
@@ -259,6 +260,7 @@ Converting 45e81b51 as the_sequence_.lock-_is_forbidden
 Converting eebb76e9 as the_sequence_-._is_forbidden
 Done.
 Current head: d4850419ccc1146c7169f500725ce504b9774ed0
+% git config log.decorate no
 % guilt push -a
 Applying patch..the_sequence_-._is_forbidden.patch
 Patch applied.
diff --git a/regression/t-034.sh b/regression/t-034.sh
index 1055ddb..8179bc7 100755
--- a/regression/t-034.sh
+++ b/regression/t-034.sh
@@ -57,7 +57,9 @@ cmd git log
 
 # Import all the commits to guilt.
 cmd guilt init
+cmd git config log.decorate short
 cmd guilt import-commit base..HEAD
+cmd git config log.decorate no
 
 for patch in .git/patches/master/*.patch
 do
-- 
1.8.3.1
