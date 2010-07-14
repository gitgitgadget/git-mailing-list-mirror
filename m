From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] MERGE_RR is in .git, not .git/rr-cache
Date: Wed, 14 Jul 2010 13:18:11 -0400
Message-ID: <1279127891-247-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 14 19:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ5bU-0003L4-34
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 19:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab0GNRSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 13:18:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36348 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab0GNRSe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 13:18:34 -0400
Received: by gxk23 with SMTP id 23so3973726gxk.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=dY8a+H6ZA212mSnNL/IVaStSCLWAgdUY8tSV1725u3Q=;
        b=NiX7aqhvHTC/k6h/92TQDwuUiEE2ymW5fBIvVYSBncVpMQjSThGKU7g5+vBjfVRB+A
         3oGfGA4vveAA+NJ2Yzl99MVK6vGtPIC3rKnoSI01N4FsB/A27pzrbzAKBgfHOb2FserG
         zT4w8UGyxEyh7WvDLWYOJtU9b2g/HIj8pySjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ddzZGRS93AVPqozwlUe95dG+Du/NQOrwXsWCr3j1ExLHfigEWhEDdOSs4exG25fSpk
         O8/Z2qq/XijeyZ8Zvf03HEbyNSBZEMvMRaoWpi2HcAT+RqqkLsLZfSa/lE7PPtjYiBi+
         /yB7phpBR1OJRovQp0hn8K68PDpvNJvDDQUes=
Received: by 10.101.106.10 with SMTP id i10mr18944116anm.99.1279127908495;
        Wed, 14 Jul 2010 10:18:28 -0700 (PDT)
Received: from localhost ([65.190.41.119])
        by mx.google.com with ESMTPS id p9sm528952anf.6.2010.07.14.10.18.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 10:18:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151016>

0af0ac7 (Move MERGE_RR from .git/rr-cache/ into .git/) moved the
location of MERGE_RR but I found a few references to the old
location.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I thought I'd mailed this out, but apparently not, hence the month old commit date.

 builtin/rerere.c    |    2 +-
 t/t4151-am-abort.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..39ad601 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -135,7 +135,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			if (!has_rerere_resolution(name))
 				unlink_rr_item(name);
 		}
-		unlink_or_warn(git_path("rr-cache/MERGE_RR"));
+		unlink_or_warn(git_path("MERGE_RR"));
 	} else if (!strcmp(argv[1], "gc"))
 		garbage_collect(&merge_rr);
 	else if (!strcmp(argv[1], "status"))
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 2b912d7..b55c411 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -47,7 +47,7 @@ do
 		test_must_fail git am$with3 --skip >output &&
 		test "$(grep "^Applying" output)" = "Applying: 6" &&
 		test_cmp file-2-expect file-2 &&
-		test ! -f .git/rr-cache/MERGE_RR
+		test ! -f .git/MERGE_RR
 	'
 
 	test_expect_success "am --abort goes back after failed am$with3" '
@@ -57,7 +57,7 @@ do
 		test_cmp expect actual &&
 		test_cmp file-2-expect file-2 &&
 		git diff-index --exit-code --cached HEAD &&
-		test ! -f .git/rr-cache/MERGE_RR
+		test ! -f .git/MERGE_RR
 	'
 
 done
-- 
1.7.1
