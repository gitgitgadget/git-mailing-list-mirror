From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 21/29] The log.decorate setting should not influence import-commit.
Date: Tue, 13 May 2014 22:30:57 +0200
Message-ID: <1400013065-27919-22-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJSH-0007x1-6q
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbaEMUhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:37:21 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:42456 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbaEMUhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:37:15 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so721145lab.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pY/GiRUtAyG5IhBgZwxwRFDwb30vzNqKSeToRPvHhoQ=;
        b=JCOwXPTfk0qu/y0iGfvnXky6WYoyeV4yKw6NWTz4uVXjDZiK7iQBOh1W36A2QHsNR4
         GKbS5eDxHrZQpA8jjbPHBE7MSgv20mm84ckYf5nMjXp5HZcLYLXnoqHFGdLESgD6Kxh5
         YB1dq2CSd/E5Oz8gQicWNP/fXK1Ar+Yyp+DCQuqXDJwu17vtXwX9O64PN/fcFeKTcngC
         sPAdyTEpp2veM4yjpPCBK5scMm9jQL+ouV7DapxDrMZTPkrgjCEGye/TGiYU8YV/RrSv
         DeykHma7i7Z/vWtMr7LAesTx75wwTjI8npy/eLMq3LbpjuzlRUxqlpsRPhBapTzzW9no
         4r0Q==
X-Gm-Message-State: ALoCoQllNusQ//oVscizw5G+v5h4uM43tw8QuWv9shlQ5j28upsGA+6lpjdz44j6zJm4Ce4WD2Bu
X-Received: by 10.112.13.137 with SMTP id h9mr2521579lbc.33.1400013434845;
        Tue, 13 May 2014 13:37:14 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.37.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:37:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248838>

Use --no-decorate in the call to git log that tries to read the commit
message to produce patch names.  Otherwise, if the user has set
log.decorate to short or full, the patch name will be less useful.

Modify the t-034.sh test case to demonstrate that this is needed.

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt-import-commit  | 2 +-
 regression/t-034.out | 2 ++
 regression/t-034.sh  | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/guilt-import-commit b/guilt-import-commit
index 45f2404..1da7c8e 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -26,7 +26,7 @@ disp "About to begin conversion..." >&2
 disp "Current head: `git rev-parse \`git_branch\``" >&2
 
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
index f41f958..648d009 100755
--- a/regression/t-034.sh
+++ b/regression/t-034.sh
@@ -57,7 +57,9 @@ cmd git log
 
 # Import all the commits to guilt.
 cmd guilt init
+cmd git config log.decorate short
 cmd guilt import-commit base..HEAD
+cmd git config log.decorate no
 
 for patch in .git/patches/master/*.patch; do
 	touch -a -m -t "$TOUCH_DATE" "$patch"
-- 
1.8.3.1
