From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 21/33] The log.decorate setting should not influence import-commit.
Date: Sun, 18 May 2014 23:59:57 +0200
Message-ID: <1400450409-30998-22-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9HX-0003jP-5x
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbaERWKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:10:06 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:44632 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbaERWKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:10:04 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3511881lab.31
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pY/GiRUtAyG5IhBgZwxwRFDwb30vzNqKSeToRPvHhoQ=;
        b=a6exSSfeCQS2Rbm/PjP2NT3Ptdbp5erjW4rGrNSrO1vwds+egVYZ2eHZlqT2l/FWtw
         QEppBUkGh45slUjwHXtaEx9x9pfwHMJEfKZghB8s1b8DviI/oe78JZaWny6C2rYIsq2l
         YNUmVCKWTfjD1sI0DK1fZPmPozZdFT4+izlsuB0HFP/ig/Yi2kSLKsiPKVTcYiXLWhB0
         6mAiK6qBj/L6a+k16Q7diA4JaFaYpVz3edGgb8IRRMjCeYPfbYT65K4Tv4uedQVt6xcW
         ye/0j8VpLMAQdGt91pmcPWRiHHS6oBVb/RYzFXpA6JMsYoZxr89WOSY2gT62jQQ15j/q
         y1dw==
X-Gm-Message-State: ALoCoQnLSwBqmdJdXTs+7dxWUMKR6hS7JR/XgGdSQHV8coqH9GkEEWdmpi2l0F0n3wiFBIxjA0Mz
X-Received: by 10.152.42.145 with SMTP id o17mr23365790lal.33.1400451003343;
        Sun, 18 May 2014 15:10:03 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.10.01
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:10:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249536>

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
