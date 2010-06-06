From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 2/2] [RFC] add --recode-patch to git-am
Date: Sun,  6 Jun 2010 19:59:43 +0800
Message-ID: <1275825583-23913-2-git-send-email-r0bertz@gentoo.org>
References: <1275825583-23913-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 06 14:01:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLEXS-0005EP-KD
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 14:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805Ab0FFMBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 08:01:08 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47569 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796Ab0FFMBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 08:01:06 -0400
Received: by pvg16 with SMTP id 16so1102978pvg.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5YUH2m4MOR6Ae++kTDgKXc6LKrFbDXskyJt+h0D7aYM=;
        b=heNUGBmeP4CDEmqc6GaviNSYJF14NU7La6VGCzFSNnGWG7hZ4RrkgBe4wNq7I8VBV1
         a3bJKbpBTNz9860CBaO0yx+8tVnu57t+xL4hQmqaXo7/9RyEGuVJkHZ79fTIxvWNwzEe
         qv+H51zb0/4zrkXG1JI4GlgC4DZIf/ud3E/Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=LoD+Eqs6XkhG774vm/pJz6A1OUfN3141UAVs8EP6DwbEZsAsYUH3VxenJ9NQuCTjxb
         LWnJQZLUC2h270i/zfzq7TXBCAxRIVWdALkAJUZTjXk2k4C4W6uRHb+2lbDBLEB2eBHe
         rLKn/nnXwl8uEwOairehjGGgADwQD8BtY8m60=
Received: by 10.143.26.19 with SMTP id d19mr9748268wfj.160.1275825665999;
        Sun, 06 Jun 2010 05:01:05 -0700 (PDT)
Received: from localhost ([119.122.45.205])
        by mx.google.com with ESMTPS id b6sm28272127wam.21.2010.06.06.05.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jun 2010 05:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275825583-23913-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148519>

The reason has been explained in the "add --recode-patch to git-mailinfo" patch

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 git-am.sh     |   13 +++++++++++--
 man1/git-am.1 |   12 +++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 1056075..62e7870 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -14,6 +14,7 @@ b,binary*       (historical option -- no-op)
 q,quiet         be quiet
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
+recode-patch    pass --recode-patch flag to git-mailinfo
 k,keep          pass -k flag to git-mailinfo
 keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
 no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
@@ -294,7 +295,7 @@ split_patches () {
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
-resolvemsg= resume= scissors= no_inbody_headers=
+resolvemsg= resume= scissors= no_inbody_headers= recode_patch=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
@@ -320,6 +321,8 @@ do
 		utf8=t ;; # this is now default
 	--no-utf8)
 		utf8= ;;
+	--recode-patch)
+		recode_patch=t ;;
 	-k|--keep)
 		keep=t ;;
 	-c|--scissors)
@@ -463,6 +466,7 @@ else
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
+	echo "$recode_patch" >"$dotest/recode_patch"
 	echo "$keep" >"$dotest/keep"
 	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
@@ -504,6 +508,10 @@ then
 else
 	utf8=-n
 fi
+if test "$(cat "$dotest/recode_patch")" = t
+then
+	recodepatch=--recode-patch
+fi
 if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
@@ -580,7 +588,8 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
+		git mailinfo $keep $no_inbody_headers $scissors $utf8 \
+		$recodepatch "$dotest/msg" "$dotest/patch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
 
diff --git a/man1/git-am.1 b/man1/git-am.1
index c6a0d27..b5bc0e8 100644
--- a/man1/git-am.1
+++ b/man1/git-am.1
@@ -24,7 +24,7 @@ git-am \- Apply a series of patches from a mailbox
 .sp
 .nf
 \fIgit am\fR [\-\-signoff] [\-\-keep] [\-\-keep\-cr | \-\-no\-keep\-cr] [\-\-utf8 | \-\-no\-utf8]
-         [\-\-3way] [\-\-interactive] [\-\-committer\-date\-is\-author\-date]
+         [\-\-recode\-patch] [\-\-3way] [\-\-interactive] [\-\-committer\-date\-is\-author\-date]
          [\-\-ignore\-date] [\-\-ignore\-space\-change | \-\-ignore\-whitespace]
          [\-\-whitespace=<option>] [\-C<n>] [\-p<n>] [\-\-directory=<dir>]
          [\-\-reject] [\-q | \-\-quiet] [\-\-scissors | \-\-no\-scissors]
@@ -116,6 +116,16 @@ flag to
 \fBgit-mailinfo\fR(1))\&.
 .RE
 .PP
+\-\-recode\-patch
+.RS 4
+Pass
+\-\-recode\-patch
+flag to
+\fIgit mailinfo\fR
+(see
+\fBgit-mailinfo\fR(1))\&.
+.RE
+.PP
 \-3, \-\-3way
 .RS 4
 When the patch does not apply cleanly, fall back on 3\-way merge if the patch records the identity of blobs it is supposed to apply to and we have those blobs available locally\&.
-- 
1.7.1
