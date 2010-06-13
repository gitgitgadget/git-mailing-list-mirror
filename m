From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v2 2/2] add --recode-patch option to git-am
Date: Mon, 14 Jun 2010 02:50:40 +0800
Message-ID: <1276455040-14726-2-git-send-email-r0bertz@gentoo.org>
References: <1276455040-14726-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 20:51:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONsHM-0007fp-TO
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 20:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab0FMSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 14:51:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:62553 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645Ab0FMSvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 14:51:18 -0400
Received: by pxi8 with SMTP id 8so2240308pxi.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=c+JH3uQblbH3QozJMzSsQK0mdZGueiYJ68OSFt8gAxM=;
        b=nKQKvvN1v8yX4N7RX/ExTCBlPsEjiQcUJxhr+SBoGcSL/UzYluwygD9Fp4dNSiVN3g
         3dwz+BxMLhFRE0HhePhGP64pZ3cU8PUT83TOT+uKD9JZ3hp4f0j1sSP9+Q8gk4TfN0yl
         5lDpvMiN1OrHoN1u91hZuRUEczazv6I3g8N3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=O+6ixFlp2S70AmvlCbcGIkBhwBH3qI6BNTFYi5FJUcgdoWUX/HvhyugllALNeBVbvh
         jmsYkGmlsFtr6UPYACp792I8xEfASyfEFkoILbyh/lTv7kIISVSm/CLGbDgE81zO8/ak
         LfmzKGkCIswHARUwaL4g+sIfdwlWWZfXwM1oY=
Received: by 10.142.207.11 with SMTP id e11mr3419604wfg.93.1276455077801;
        Sun, 13 Jun 2010 11:51:17 -0700 (PDT)
Received: from localhost ([121.34.28.151])
        by mx.google.com with ESMTPS id c1sm44616805wam.7.2010.06.13.11.51.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 11:51:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1276455040-14726-1-git-send-email-r0bertz@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149059>

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
 
-- 
1.7.1
