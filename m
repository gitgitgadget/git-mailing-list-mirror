From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 15:55:15 -0500
Message-ID: <1234990515-1636-1-git-send-email-jaysoffian@gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 21:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtTJ-0007G1-Kr
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 21:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbZBRUzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753604AbZBRUzV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 15:55:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:28804 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbZBRUzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 15:55:20 -0500
Received: by yw-out-2324.google.com with SMTP id 5so41232ywh.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9efhRFNfyeWj4TjpbDWwcpJAdpGKDYBdzvCjEAJinZg=;
        b=xIHJFwTh3KrJBW1xCi57uWvJXyHn2gqeYggbjLTcyuDmNoIEkpY1KrVsfoqMQIDcjK
         GwF65mTQQaNG2ku5STfA1wfyWjtIKE3N0ujMY9mJbsL9aiwaWT6W/FkkvAfB/hAFMCiY
         Fxaoq0JGJ+sIyX/Bhihn+OOadagNQ+H8ve92Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=i2O4o97hTgIQ+3fMZaVvi160ka+P3KN8uLwuvB3UwsCFiDU3wvWaQf8wpknQBWJVNa
         5qPc0uyhh7wqQYdNT9AfF09Smk01irIsxeggcCQnI5dnLF2IZlD9dqQk46jGB+YyIJvs
         n3uYlptu7Fr88fkLFx7W58y9KSRcD1pGB00O8=
Received: by 10.65.158.9 with SMTP id k9mr4785553qbo.34.1234990518492;
        Wed, 18 Feb 2009 12:55:18 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id k30sm390040qba.31.2009.02.18.12.55.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 12:55:17 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110574>

Some shells do not like "export var=val", and the right way to write
these is to do an usual assignment and then export just variable names.

Also corrects a typo in the tests added by 94859732 and noticed by
Brandon Casey (gmane 110412):

    test_expect_success 'refusing to edit in refs/heads/' '
            (MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
             export MSG= GIT_NOTES_REF=refs/heads/bogus &&
             test_must_fail git notes edit)
    '

    test_expect_success 'refusing to edit in refs/remotes/' '
            (MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
             export MSG= GIT_NOTES_REF=refs/heads/bogus &&
             test_must_fail git notes edit)
    '

    Notice the 'export' lines. Comparing it to Thomas's v2 5/5 patch, it
    looks like the first line which sets the variables is correct and
    the export line should just be 'export MSG GIT_NOTES_REF' in both
    tests.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
This time with a better (I hope...) commit message to clarify
that we are fixing a typo and not introducing one.

 t/t3301-notes.sh                 |    4 ++--
 t/t3302-notes-index-expensive.sh |    4 ++--
 t/t9301-fast-export.sh           |    4 ++--
 t/test-lib.sh                    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2321316..18c4eb6 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -39,13 +39,13 @@ test_expect_success 'need valid notes ref' '
 
 test_expect_success 'refusing to edit in refs/heads/' '
 	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
-	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
+	export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes edit)
 '
 
 test_expect_success 'refusing to edit in refs/remotes/' '
 	(MSG=1 GIT_NOTES_REF=refs/remotes/bogus &&
-	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
+	 export MSG GIT_NOTES_REF &&
 	 test_must_fail git notes edit)
 '
 
diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index 00d27bf..0ef3e95 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -29,7 +29,7 @@ create_repo () {
 	done &&
 	git update-ref refs/heads/master $commit &&
 	{
-		export GIT_INDEX_FILE=.git/temp;
+		GIT_INDEX_FILE=.git/temp; export GIT_INDEX_FILE;
 		git rev-list HEAD | cat -n | sed "s/^[ 	][ 	]*/ /g" |
 		while read nr sha1; do
 			blob=$(echo note $nr | git hash-object -w --stdin) &&
@@ -63,7 +63,7 @@ cat > time_notes << \EOF
 	while [ $i -lt $2 ]; do
 		case $1 in
 		no-notes)
-			export GIT_NOTES_REF=non-existing
+			GIT_NOTES_REF=non-existing; export GIT_NOTES_REF
 		;;
 		notes)
 			unset GIT_NOTES_REF
diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 9985721..86c3760 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -185,8 +185,8 @@ test_expect_success 'submodule fast-export | fast-import' '
 
 '
 
-export GIT_AUTHOR_NAME='A U Thor'
-export GIT_COMMITTER_NAME='C O Mitter'
+GIT_AUTHOR_NAME='A U Thor'; export GIT_AUTHOR_NAME
+GIT_COMMITTER_NAME='C O Mitter'; export GIT_COMMITTER_NAME
 
 test_expect_success 'setup copies' '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2021446..7a847ec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -98,7 +98,7 @@ do
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t; shift ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		export GIT_TEST_LONG=t; shift ;;
+		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
 	-h|--h|--he|--hel|--help)
 		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-- 
1.6.2.rc1.218.g1b4fab
