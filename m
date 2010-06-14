From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] MERGE_RR is in .git, not .git/rr-cache
Date: Mon, 14 Jun 2010 18:01:39 -0400
Message-ID: <1276552899-12487-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 00:07:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOHon-0001dO-41
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 00:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab0FNWHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 18:07:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57728 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab0FNWHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 18:07:39 -0400
Received: by gye5 with SMTP id 5so2819097gye.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xrAJnP/yextCJahDGBbqm2JUUTOUVGWVELGZgMIO2nU=;
        b=dH6beHZEy2mSeGh4oB18ew+pI1j8UMm1HqloqWbz2NuDv2C9z2P+j1+UYREb+1IARa
         T3zDHMaE+Jcown/+YULv4u2SIsmx9bcsEAoTLLyF/rCHwcK6zbSKDpfqpdlbs1nJqlmy
         uujWUbpuy065dOXMvUp5ssIjt7DXsIgdb530U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=N3q1bPWi/Y8pnpFqDMp6dKd2goPloosULUjDiGNi48YuJEhOC0dSCX/iQBZTfhgLYB
         3uAPqT3tBDt4Pqxx890INvfwmv39QHNNa24+SVMAE70ZChTvIC5EAeIxQFz9/B9fROnn
         l8pcjfqFWVRmre8PJ57nu+6cTrJVIvItkEAtg=
Received: by 10.150.55.33 with SMTP id d33mr8040556yba.58.1276552911434;
        Mon, 14 Jun 2010 15:01:51 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id j3sm34837898ybe.43.2010.06.14.15.01.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 15:01:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149141>

0af0ac7 (Move MERGE_RR from .git/rr-cache/ into .git/) moved the
location of MERGE_RR but I found a few references to the old
location.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/rerere.c    |    2 +-
 t/t4151-am-abort.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 34f9ace..52507a2 100644
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
