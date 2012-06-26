From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 4/5] am: don't call mailinfo if $rebasing
Date: Tue, 26 Jun 2012 07:51:57 -0700
Message-ID: <1340722318-24392-5-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:52:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX8H-0005yY-AM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951Ab2FZOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:42 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:34937 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab2FZOwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:39 -0400
Received: by yenl3 with SMTP id l3so575763yen.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=kQLIDzQCQB3HRCd/qhRLXDJ1oHWLvTgR6TZS/laboAY=;
        b=c+QSNql9vaQW+yn3+6Accswb4BeA9Vb5Spc+jrAWHqMQhIEhKK0TMFN0KILfkOmqDR
         F/IXhQmJ0LQwt35r/T6Iu4cIoWZh6eKNEdfT22cgqwDmte9/zSprVqoAKLFOv+CA+r+z
         iAsQAqzQv74mRuGzZtF/l/eyvCvEJlK8RJwkj9DIJqJms0yV7BWUGFr4kvH3SH1/i6un
         YMC/U12zbl2QCgma2T1AAuKS3Uh2GTsJkMd/S1d3BBMaHW/RpKkWpfN0wRFPq8K7JGcz
         yZKh8Eg7P79MZgqmdLWMZL4FwyJZBUrMZELuJdvHNyZ6RkC6BQGQX4v2FSsYQ3M+V4zv
         aVIA==
Received: by 10.236.73.131 with SMTP id v3mr23475799yhd.6.1340722359247;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by 10.236.73.131 with SMTP id v3mr23475791yhd.6.1340722359209;
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r48si23456241yhm.3.2012.06.26.07.52.39
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 072DD100047;
	Tue, 26 Jun 2012 07:52:39 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id AA830C1A3D; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
In-Reply-To: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQk/2fwWerw32QnjcqVWr2JuoIxehQ2sdrmaaCXAXRYSgto5Wfvkl8RkBf44lb0deyKNhGioDaF1rwe+FOvtNdPTMMRMeEvbMo0SkYQ9KfXJfCP+9vCgdnHBhFl/6LPUMgY72J7wzsQC88TtbbH2rOj2vxOpWefZE5y6XEO2AU4qvL17d2vNehjRgOv/p0wKZ8kSjwXC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200646>

Since 5e835ca (rebase: do not munge commit log message, 2008-04-16),
'git am --rebasing' no longer gets the commit log message from the
patch, but reads it from the commit identified by the "From " header
line. From 43c2325 (am: use get_author_ident_from_commit instead of
mailinfo when rebasing, 2010-06-16), it also gets the author name,
email and date from the commit. Now that the final part of the patch
-- the patch body itself -- is also read from the commit, there is no
longer a need to call 'git mailinfo' to extract any of these parts
while --rebasing.

Sugested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-am.sh |   47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ec8fde1..b6a5300 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -260,7 +260,7 @@ check_patch_format () {
 split_patches () {
 	case "$patch_format" in
 	mbox)
-		if test -n "$rebasing" || test t = "$keepcr"
+		if test t = "$keepcr"
 		then
 		    keep_cr=--keep-cr
 		else
@@ -413,7 +413,7 @@ do
 	--abort)
 		abort=t ;;
 	--rebasing)
-		rebasing=t threeway=t keep=t scissors=f no_inbody_headers=t ;;
+		rebasing=t threeway=t ;;
 	-d|--dotest)
 		die "$(gettext "-d option is no longer supported.  Do not use.")"
 		;;
@@ -658,33 +658,34 @@ do
 	# by the user, or the user can tell us to do so by --resolved flag.
 	case "$resume" in
 	'')
-		git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
-			<"$dotest/$msgnum" >"$dotest/info" ||
-			stop_here $this
-
-		# skip pine's internal folder data
-		sane_grep '^Author: Mail System Internal Data$' \
-			<"$dotest"/info >/dev/null &&
-			go_next && continue
-
-		test -s "$dotest/patch" || {
-			eval_gettextln "Patch is empty.  Was it split wrong?
-If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
-To restore the original branch and stop patching run \"\$cmdline --abort\"."
-			stop_here $this
-		}
-		rm -f "$dotest/original-commit" "$dotest/author-script"
-		if test -f "$dotest/rebasing" &&
+		if test -f "$dotest/rebasing"
+		then
 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
 				-e q "$dotest/$msgnum") &&
-			test "$(git cat-file -t "$commit")" = commit
-		then
+			test "$(git cat-file -t "$commit")" = commit ||
+				stop_here $this
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
-			echo "$commit" > "$dotest/original-commit"
-			get_author_ident_from_commit "$commit" > "$dotest/author-script"
+			echo "$commit" >"$dotest/original-commit"
+			get_author_ident_from_commit "$commit" >"$dotest/author-script"
 			git diff-tree --root --binary "$commit" >"$dotest/patch"
 		else
+			git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
+				<"$dotest/$msgnum" >"$dotest/info" ||
+				stop_here $this
+
+			# skip pine's internal folder data
+			sane_grep '^Author: Mail System Internal Data$' \
+				<"$dotest"/info >/dev/null &&
+				go_next && continue
+
+			test -s "$dotest/patch" || {
+				eval_gettextln "Patch is empty.  Was it split wrong?
+If you would prefer to skip this patch, instead run \"\$cmdline --skip\".
+To restore the original branch and stop patching run \"\$cmdline --abort\"."
+				stop_here $this
+			}
+			rm -f "$dotest/original-commit" "$dotest/author-script"
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
 				echo
-- 
1.7.9.3.327.g2980b
