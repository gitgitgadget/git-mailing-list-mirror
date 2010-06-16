From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v3 2/2] add --recode-patch option to git-am
Date: Wed, 16 Jun 2010 13:09:43 +0800
Message-ID: <1276664983-5693-2-git-send-email-r0bertz@gentoo.org>
References: <1276664983-5693-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 07:10:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOkta-00013X-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 07:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab0FPFK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 01:10:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49195 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab0FPFK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 01:10:27 -0400
Received: by pxi8 with SMTP id 8so3710900pxi.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 22:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=L5+vx72oRE7fjBy+Ajeeo6nBTzUtALtZfBko4jsOvL4=;
        b=v6hZW/GsA/28bMrHDlsL6wIrWqxBMVcRyDfJHl5n1nHkpHj/oZn9smY3pybpPsy2nk
         IgHn7xMLDcY7VNgEjVs3VgqLwlmwWbC9qwlo6DEoZVldR7ZJCnYWJkD8xJN+jkFbo7fH
         uE9H91JMkGDYg/MAM4B/DZjY9iycNPpiyB8RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=huKEGz3DMCAxmCNW/EQKVHXSfpDd5zIbbB/G/byL8tJD2+iZsxrt/hQES3fMrVaL/u
         JB8Aeh8wiEtGe2x5xUcpmP/3jW6ImESKkeTQG/ft2vBb++Jbpt0+FbpGAhY5/hhV0qCN
         vzQxO7mn7/n/zqn7y/UBkzMtIIHasq3dOKhO0=
Received: by 10.141.90.11 with SMTP id s11mr6621354rvl.152.1276665026871;
        Tue, 15 Jun 2010 22:10:26 -0700 (PDT)
Received: from localhost ([119.122.48.97])
        by mx.google.com with ESMTPS id b2sm4782566rvn.7.2010.06.15.22.10.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 22:10:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276664983-5693-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149247>

The reason has been explained in the "add --recode-patch to git-mailinfo" patch

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 Documentation/git-am.txt |    4 ++++
 git-am.sh                |   13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9e62f87..38c1442 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -73,6 +73,10 @@ default.   You can use `--no-utf8` to override this.
 	Pass `-n` flag to 'git mailinfo' (see
 	linkgit:git-mailinfo[1]).
 
+--recode-patch::
+	Pass `--recode-patch` flag to 'git mailinfo' (see
+	linkgit:git-mailinfo[1]).
+
 -3::
 --3way::
 	When the patch does not apply cleanly, fall back on
diff --git a/git-am.sh b/git-am.sh
index 87ffae2..49cf788 100755
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
 
-- 
1.7.1
