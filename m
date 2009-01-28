From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2 2/2] git-am: minor cleanups
Date: Tue, 27 Jan 2009 22:27:42 -0500
Message-ID: <1233113262-17491-2-git-send-email-jaysoffian@gmail.com>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 04:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS179-0008R2-J0
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbZA1D1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 22:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZA1D1u
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:27:50 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:40459 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbZA1D1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 22:27:49 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3282672qwe.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 19:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iU8w0gMqYd23txeicI7jayW3U7elEUGhadqF5Ixf6d8=;
        b=MpHixRJVrUCtbFj/WxmPC1NofkcrCeSvqA/oKfJTaPeANT6gNbS+YqMrzYof1OV2C+
         VSz40F3XLAWiV+FbmEEromeR5TIDZ196ObcX322q4u4Ev3eAxSwT0LR5kI0l4SkmdkkV
         L7krfWE1y8rddzCO89nuZyxI0W8jJ0ilItFfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KX1wzHczfU6r/YTrCxq2gGddBG+8wCkf7+cm4PSTOR9ohO3C5XvuG74rpp3qUXJyBQ
         r8qAVQkI9CT3KvbCzkv7Z78+RMr+x3gUfvLc74PNsIeT/1Er/OLq8bw6b5KtF6S3l5Fh
         klWCAot/+EQpA8lrL3zxufTXBvREGQAzpaxx0=
Received: by 10.215.100.8 with SMTP id c8mr2965513qam.125.1233113267916;
        Tue, 27 Jan 2009 19:27:47 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 6sm1260637ywn.37.2009.01.27.19.27.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 19:27:47 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
In-Reply-To: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107460>

Update usage statement to remove a no-longer supported option, and to hide two
options (one a no-op, one internal) unless --help-all is used.

Use "test -t 0" instead of deprecated "tty -s" to detect when stdin is a
terminal. (test -t 0 is used elsewhere in git-am and in other git shell
scripts, tty -s is not.)

Use "test ..." instead of "[ ... ]" and "die <msg>" instead of "echo <msg>
>&2; exit 1" to be consistent with rest of script.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Added SoB, otherwise no change from v1.

 git-am.sh |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 65285a0..9653a98 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -8,9 +8,8 @@ OPTIONS_SPEC="\
 git am [options] [<mbox>|<Maildir>...]
 git am [options] (--resolved | --skip | --abort)
 --
-d,dotest=       (removed -- do not use)
 i,interactive   run interactively
-b,binary        (historical option -- no-op)
+b,binary*       (historical option -- no-op)
 3,3way          allow fall back on 3way merging if needed
 s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
@@ -24,7 +23,7 @@ resolvemsg=     override error message when patch failure occurs
 r,resolved      to be used after a patch failure
 skip            skip the current patch
 abort           restore the original branch and abort the patching operation.
-rebasing        (internal use for git-rebase)"
+rebasing*       (internal use for git-rebase)"
 
 . git-sh-setup
 prefix=$(git rev-parse --show-prefix)
@@ -204,7 +203,7 @@ then
 		# unreliable -- stdin could be /dev/null for example
 		# and the caller did not intend to feed us a patch but
 		# wanted to continue unattended.
-		tty -s
+		test -t 0
 		;;
 	*)
 		false
@@ -283,10 +282,7 @@ fi
 case "$resolved" in
 '')
 	files=$(git diff-index --cached --name-only HEAD --) || exit
-	if [ "$files" ]; then
-	   echo "Dirty index: cannot apply patches (dirty: $files)" >&2
-	   exit 1
-	fi
+	test "$files" && die "Dirty index: cannot apply patches (dirty: $files)"
 esac
 
 if test "$(cat "$dotest/utf8")" = t
-- 
1.6.1.224.gb56c
