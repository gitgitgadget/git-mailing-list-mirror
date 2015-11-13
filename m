From: Rob Mayoff <mayoff@dqd.com>
Subject: [PATCH v2] contrib/subtree: unwrap tag refs
Date: Fri, 13 Nov 2015 11:25:49 -0600
Message-ID: <1447435549-34410-1-git-send-email-mayoff@dqd.com>
Cc: Rob Mayoff <mayoff@dqd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 18:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxI7P-0007vq-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 18:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933024AbbKMR0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 12:26:31 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33540 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932607AbbKMR0b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 12:26:31 -0500
Received: by obbww6 with SMTP id ww6so78765559obb.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 09:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dqd_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=o6/HlbVln/ska2Dto4YsrIPqAo1wsvkEIiu/adJymvg=;
        b=vcjDaA3vO8Hg16oKV9DSBFpZgcyGd/cppaB1/Z2bi7w0OxsPCDZVhx7j1i3IHmmVMs
         hvQqA1VbsZY6uXw/Nh4HAzo+5kN0vbP+BbqfMS4BZf5MjMLQfR9DRr21GOlu+N2WyyJH
         Y5CrzvGnoc8M7R7z4BknbAB9Vr86e5oDPagY1s881fVIPuEJjQ+ZL0qreYSgLzre8vZy
         HqRIc29u42NdhfQYZs6T377VallVMm3Onn++FfD1n6LnG4Js/9zNgX93CK469cLj3b+e
         q/EPXxpReTe6f2xCePZZYe7tflmIaAsBzOGGqYTuYD3JWoKMWyoIZ5VZpECK0HIQOrQV
         XAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o6/HlbVln/ska2Dto4YsrIPqAo1wsvkEIiu/adJymvg=;
        b=RnYdcL3pQYCgeGKNrAk2/HE3faCDwb2NWFmPAqJu9AVdiPKU1iiILABM/E2ycWBtqc
         yr+QncIRobFFGxMcc6pDrbTt08rvnDs9dFoGNWzWg8NcPHdyRB2UwlDrgsT+RsuIwEOB
         KsipQlRkXRJDy4R3uaQgNpRRako6VcSQ8WL+X98WqfzNjHo/XHA5lHJDwlJyCZe+GEeV
         4LbRV2BEZrxZa1ssf8Cs3AB/LA9SYM6GXpoFTKTe3dB9JCYP3UeJqg67jwa6aABmu+PW
         n3kxFNZeZL3uxtXmKIcqG982eTk+3KklcwGZP13VUjQYC1NQ9CpVqifsB8kr1q/Ufk8c
         PTDw==
X-Gm-Message-State: ALoCoQkN8pcf2IIWWL1meQs/jpDlVhduqUX3Qp78zl5WcK0PzitRGq0lwBaELY7hsGOeT1HtDtb1
X-Received: by 10.60.115.138 with SMTP id jo10mr14349246oeb.85.1447435588964;
        Fri, 13 Nov 2015 09:26:28 -0800 (PST)
Received: from can.dqd.com (65-36-82-75.dyn.grandenetworks.net. [65.36.82.75])
        by smtp.gmail.com with ESMTPSA id x131sm6272721oix.27.2015.11.13.09.26.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 09:26:28 -0800 (PST)
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281258>

If a subtree was added using a tag ref, the tag ref is stored in
the subtree commit message instead of the underlying commit's ref.
To split or push subsequent changes to the subtree, the subtree
command needs to unwrap the tag ref.  This patch makes it do so.

The problem was described in a message to the mailing list from
Junio C Hamano dated 29 Apr 2014, with the subject "Re: git subtree
issue in more recent versions". The archived message can be found
at <http://comments.gmane.org/gmane.comp.version-control.git/247503>.

Signed-off-by: Rob Mayoff <mayoff@dqd.com>
---

changes since v1:

* remove obsolete sub assignments
* wrap lines

 contrib/subtree/git-subtree.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9f06571..5ed0ea5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -245,7 +245,10 @@ find_latest_squash()
 		case "$a" in
 			START) sq="$b" ;;
 			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:) sub="$b" ;;
+			git-subtree-split:)
+				sub="$(git rev-parse "$b^0")" ||
+				    die "could not rev-parse split hash $b from commit $sq"
+				;;
 			END)
 				if [ -n "$sub" ]; then
 					if [ -n "$main" ]; then
@@ -278,7 +281,10 @@ find_existing_splits()
 		case "$a" in
 			START) sq="$b" ;;
 			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:) sub="$b" ;;
+			git-subtree-split:)
+				sub="$(git rev-parse "$b^0")" ||
+				    die "could not rev-parse split hash $b from commit $sq"
+				;;
 			END)
 				debug "  Main is: '$main'"
 				if [ -z "$main" -a -n "$sub" ]; then
-- 
2.4.3
