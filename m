From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] test suite: correct export var=val usage
Date: Tue, 17 Feb 2009 17:53:08 -0500
Message-ID: <1234911188-36941-1-git-send-email-jaysoffian@gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 23:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYpz-0001sP-Pr
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:54:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbZBQWxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZBQWxP
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:53:15 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:17380 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbZBQWxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:53:14 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1197769yxm.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=28ByMWHs8P36i3ZykGn/Q7wba0L+gUkPDRPLRZOc1UI=;
        b=o8d4+k5ItQYu4kTUboOgqDRjiuZnhZ3E2JuXOHU01mHCXJqllU/xIj4tVt/sQvTJ+i
         MYFQan0DcSSboS+8PQNTC6nJwtmElnOIGm8IhIPxZtBbnckbnmV4qaSKrQQ/Ae7ixpL8
         RnlWWncECwUQVwGZ501jNd4rjZFIbop59ZJlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vxKNjbjLyYbTNY9hyoKJztwb8AS5VQAHKMlN5vhrsnTpILZ8Wx4ilMXvIGIXOx5T3N
         1uezGc65xh/OjsSg+xxMs/z7iw5tr5LqsvV3LR15Om/8WNwoQKTIBvptVZf3uQOgWz9X
         R8RREnN7LsKoyOuGrbE8yJLu4+90RDLAwhIsw=
Received: by 10.65.160.5 with SMTP id m5mr4227289qbo.100.1234911191390;
        Tue, 17 Feb 2009 14:53:11 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 9sm13692579qbw.18.2009.02.17.14.53.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 14:53:10 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110462>

Some shells do not like "export var=val", and the right way to write
these is to do an usual assignment and then export just variable names.
---
 t/t3301-notes.sh                 |    6 +++---
 t/t3302-notes-index-expensive.sh |    4 ++--
 t/t9301-fast-export.sh           |    4 ++--
 t/test-lib.sh                    |    2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2321316..7ea98f2 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -38,14 +38,14 @@ test_expect_success 'need valid notes ref' '
 '
 
 test_expect_success 'refusing to edit in refs/heads/' '
-	(MSG=1 GIT_NOTES_REF=refs/heads/bogus &&
-	 export MSG= GIT_NOTES_REF=refs/heads/bogus &&
+	(MSG=1 GIT_NOTES_REF=refs/heads/bogus
+	 && export MSG GIT_NOTES_REF &&
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
