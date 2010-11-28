From: "ZHANG, Le" <r0bertz@gentoo.org>
Subject: [PATCH v4 4/4] git am: added a --recode-patch parameter
Date: Mon, 29 Nov 2010 03:10:17 +0800
Message-ID: <1290971417-4474-5-git-send-email-r0bertz@gentoo.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Cc: "ZHANG, Le" <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:11:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMmeY-0001GJ-2g
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0K1TLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:11:10 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50803 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0K1TLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 14:11:09 -0500
Received: by pwj3 with SMTP id 3so638121pwj.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=+cFrAh4f2wTTr4GSyO1bs6P5MZJMHT6HC4y+8sMM9gM=;
        b=XcILLNejjC+8062U9DOEY2ZQpM4o2Slghe1AeoeUev1skDVAYJ3SmZ0AyGO1fvdYKx
         YTEvdnKod3t/7swVx3NCTHlBcyJGFZrn3NpNOaq3qXLqG+/BpQbeCicm7rQc8pJxMFNk
         cfaq59OlKEGdAkMSngGlwL58yNSYR4ogVEh9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=vokt0fHEb828muNY+gWcw56cvwcqLG7QiV1QSzaeVyNfItchrDuBrHcOHKWxVjs6+7
         oNMCX//0r8NBKbP/FMkAn7ozq9wsizpxZTvThdotxPM98fuxNOewivv713H+4bd/VQbc
         Zfbgdauvp/f7owTa+TP9RuiOFGpDQC/0vsYWo=
Received: by 10.143.159.18 with SMTP id l18mr4497077wfo.98.1290971468888;
        Sun, 28 Nov 2010 11:11:08 -0800 (PST)
Received: from localhost ([183.37.0.219])
        by mx.google.com with ESMTPS id e14sm6319976wfg.20.2010.11.28.11.11.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 11:11:07 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.344.gb3680.dirty
In-Reply-To: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162349>

When this parameter is specified, git am will pass this parameter to git mailinfo.

Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
---
 Documentation/git-am.txt |    4 ++++
 git-am.sh                |   13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 51297d0..24ba5ec 100644
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
index df09b42..8010119 100755
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
@@ -295,7 +296,7 @@ split_patches () {
 prec=4
 dotest="$GIT_DIR/rebase-apply"
 sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
-resolvemsg= resume= scissors= no_inbody_headers=
+resolvemsg= resume= scissors= no_inbody_headers= recode_patch=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
@@ -321,6 +322,8 @@ do
 		utf8=t ;; # this is now default
 	--no-utf8)
 		utf8= ;;
+	--recode-patch)
+		recode_patch=t ;;
 	-k|--keep)
 		keep=t ;;
 	-c|--scissors)
@@ -464,6 +467,7 @@ else
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
+	echo "$recode_patch" >"$dotest/recode_patch"
 	echo "$keep" >"$dotest/keep"
 	echo "$keepcr" >"$dotest/keepcr"
 	echo "$scissors" >"$dotest/scissors"
@@ -505,6 +509,10 @@ then
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
@@ -581,7 +589,8 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
+		git mailinfo $keep $no_inbody_headers $scissors $utf8 \
+			$recodepatch "$dotest/msg" "$dotest/patch" \
 			<"$dotest/$msgnum" >"$dotest/info" ||
 			stop_here $this
 
-- 
1.7.3.2.344.gb3680.dirty
