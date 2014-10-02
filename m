From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/24] test: put tests for handling of bad ref names in one
 place
Date: Wed, 1 Oct 2014 19:17:39 -0700
Message-ID: <20141002021739.GK1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:17:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVxi-0005H2-TX
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaJBCRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:17:43 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42719 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:17:42 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so1220084pdb.31
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1yyxKYJRqHHecqetLecIJMcsO6ZeTPSbIN7ZIeLP6IU=;
        b=0MNOLX9LcK9tMAFSaI0+WHlPZgT8iEwYGkzlp8sLCB3nvrLywITy3T1Co90A7aG/lS
         sHi8Pitp7NkC9lXcZBxGcqdwnOBBgtB/abJdatEX3PuScS1w6+Rb1nmErYLYT0Hu+a8f
         fS3fvdRYR0T/kJUo1Fi9HPGSoZwup1IVU38MAoUuhxla82rqiPljj3Ir+X61r4lAHoEB
         ybs3GW6qVncfNggAq6rQrAPEiO37VYfA3rl58ppFU2a/Kao4vcoPGZXrN2ehOAX2agMa
         3DeU4278RQ+2hjizEx30wZGOBOLpuCnb8okrn/27m2uIg+1Dy+XOc5OKIW0wHZovCeMa
         HuUw==
X-Received: by 10.66.159.8 with SMTP id wy8mr83605057pab.17.1412216262476;
        Wed, 01 Oct 2014 19:17:42 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id j5sm2178352pdp.9.2014.10.01.19.17.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257789>

From: Ronnie Sahlberg <sahlberg@google.com>

There's no straightforward way to grep for all tests dealing with
invalid refs.  Put them in a single test script so it is easy to see
what functionality has not been exercised with bad ref names yet.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New.

 t/t1400-update-ref.sh   | 44 --------------------------
 t/t1430-bad-ref-name.sh | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9300-fast-import.sh  | 30 ------------------
 3 files changed, 84 insertions(+), 74 deletions(-)
 create mode 100755 t/t1430-bad-ref-name.sh

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7c8c41a..7b4707b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -136,14 +136,6 @@ test_expect_success 'update-ref --no-deref -d can delete reference to bad ref' '
 	test_path_is_missing .git/refs/heads/ref-to-bad
 '
 
-test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
-	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/badname" &&
-	test_path_is_file .git/refs/heads/badname &&
-	git update-ref --no-deref -d refs/heads/badname &&
-	test_path_is_missing .git/refs/heads/badname
-'
-
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
@@ -408,12 +400,6 @@ test_expect_success 'stdin fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin fails create with bad ref name' '
-	echo "create ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -432,12 +418,6 @@ test_expect_success 'stdin fails update with no ref' '
 	grep "fatal: update: missing <ref>" err
 '
 
-test_expect_success 'stdin fails update with bad ref name' '
-	echo "update ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -456,12 +436,6 @@ test_expect_success 'stdin fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin fails delete with bad ref name' '
-	echo "delete ~a $m" >stdin &&
-	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
@@ -734,12 +708,6 @@ test_expect_success 'stdin -z fails create with no ref' '
 	grep "fatal: create: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails create with bad ref name' '
-	printf $F "create ~a " "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a " err
-'
-
 test_expect_success 'stdin -z fails create with no new value' '
 	printf $F "create $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
@@ -764,12 +732,6 @@ test_expect_success 'stdin -z fails update with too few args' '
 	grep "fatal: update $a: unexpected end of input when reading <oldvalue>" err
 '
 
-test_expect_success 'stdin -z fails update with bad ref name' '
-	printf $F "update ~a" "$m" "" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z emits warning with empty new value' '
 	git update-ref $a $m &&
 	printf $F "update $a" "" "" >stdin &&
@@ -802,12 +764,6 @@ test_expect_success 'stdin -z fails delete with no ref' '
 	grep "fatal: delete: missing <ref>" err
 '
 
-test_expect_success 'stdin -z fails delete with bad ref name' '
-	printf $F "delete ~a" "$m" >stdin &&
-	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid ref format: ~a" err
-'
-
 test_expect_success 'stdin -z fails delete with no old value' '
 	printf $F "delete $a" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
new file mode 100755
index 0000000..c7b19b0
--- /dev/null
+++ b/t/t1430-bad-ref-name.sh
@@ -0,0 +1,84 @@
+#!/bin/sh
+
+test_description='Test handling of ref names that check-ref-format rejects'
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit one
+'
+
+test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit .badbranchname
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"' '
+	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&
+	cat >input <<-INPUT_END &&
+		commit bad[branch]name
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		corrupt
+		COMMIT
+
+		from refs/heads/master
+
+	INPUT_END
+	test_must_fail git fast-import <input
+'
+
+test_expect_success 'update-ref --no-deref -d can delete reference to broken name' '
+	git symbolic-ref refs/heads/badname refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/badname" &&
+	test_path_is_file .git/refs/heads/badname &&
+	git update-ref --no-deref -d refs/heads/badname &&
+	test_path_is_missing .git/refs/heads/badname
+'
+
+test_expect_success 'update-ref --stdin fails create with bad ref name' '
+	echo "create ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails update with bad ref name' '
+	echo "update ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin fails delete with bad ref name' '
+	echo "delete ~a refs/heads/master" >stdin &&
+	test_must_fail git update-ref --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails create with bad ref name' '
+	printf "%s\0" "create ~a " refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a " err
+'
+
+test_expect_success 'update-ref --stdin -z fails update with bad ref name' '
+	printf "%s\0" "update ~a" refs/heads/master "" >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
+	printf "%s\0" "delete ~a" refs/heads/master >stdin &&
+	test_must_fail git update-ref -z --stdin <stdin 2>err &&
+	grep "fatal: invalid ref format: ~a" err
+'
+
+test_done
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5fc9ef2..3d156f9 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -347,36 +347,6 @@ test_expect_success 'B: fail on invalid blob sha1' '
 rm -f .git/objects/pack_* .git/objects/index_*
 
 cat >input <<INPUT_END
-commit .badbranchname
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
-commit bad[branch]name
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-corrupt
-COMMIT
-
-from refs/heads/master
-
-INPUT_END
-test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git fast-import <input
-'
-rm -f .git/objects/pack_* .git/objects/index_*
-
-cat >input <<INPUT_END
 commit TEMP_TAG
 committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 data <<COMMIT
-- 
2.1.0.rc2.206.gedb03e5
