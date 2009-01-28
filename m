From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3 2/2] git-am: minor cleanups
Date: Wed, 28 Jan 2009 10:03:10 -0500
Message-ID: <1233154990-19745-2-git-send-email-jaysoffian@gmail.com>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com,
	sverre@rabbelier.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 16:04:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSByC-0004CO-2H
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 16:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZA1PDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbZA1PDU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 10:03:20 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:34589 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZA1PDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 10:03:19 -0500
Received: by qyk4 with SMTP id 4so7961762qyk.13
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=i1HYihQWyCvur5WxE1bNJUb1NWHYewQAyjo4K2n6PAw=;
        b=rnw83I5V+yeUK7poSJYQc3dX0+wlXSR9y1oW4rKBuk24aOVxcfpBoyczSZfkJhk7C4
         VP9ltvGDO9KLFJ0bdsi/6X9hiK8G3+daW0St2u5Mq+JTDYQKVsDWNsdqK0dYlVCGQcxK
         FkVO1anF+mMzw+dQocEkwzd9Lm8F4TBXsodhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZBDxGHXKpEO3syis5pupayx53mrAQ23q1DMZo3N9XPcBhnHsYN/fs/H+PyJz7L9/YH
         B4mxRoSHZRsLGWHIQ61js5mkcXF1LJVfi4zpY7s6Hlge5+ekh5xJXvBfU6KGodCo/XLi
         f6N4YiDl2wMZlCW/zH3JjNCPyGZyd+GpNcjQw=
Received: by 10.214.150.13 with SMTP id x13mr2154898qad.60.1233154997215;
        Wed, 28 Jan 2009 07:03:17 -0800 (PST)
Received: from localhost (cpe-075-189-159-045.nc.res.rr.com [75.189.159.45])
        by mx.google.com with ESMTPS id 6sm2218486ywi.36.2009.01.28.07.03.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jan 2009 07:03:16 -0800 (PST)
X-Mailer: git-send-email 1.6.1.224.gb56c
In-Reply-To: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107539>

Update usage statement to remove a no-longer supported option, and to hide two
options (one a no-op, one internal) unless --help-all is used.

Use "test -t 0" instead of "tty -s" to detect when stdin is a terminal. (test
-t 0 is used elsewhere in git-am and in other git shell scripts, tty -s is
not, and appears to be deprecated by POSIX)

Use "test ..." instead of "[ ... ]" and "die <msg>" instead of "echo <msg>
>&2; exit 1" to be consistent with rest of script.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Change from v2: mention who deprecated "tty -s" in commit message.

 git-am.sh |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 92a64b2..670fc02 100755
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
@@ -281,10 +280,7 @@ fi
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
