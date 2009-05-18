From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] tests: introduce --trash specifying root directory for trash folders
Date: Mon, 18 May 2009 00:49:16 -0700
Message-ID: <1242632956-7175-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 09:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5xbE-00075D-CC
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 09:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbZERHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 03:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbZERHtT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 03:49:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:30069 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbZERHtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 03:49:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1824836wfd.4
        for <git@vger.kernel.org>; Mon, 18 May 2009 00:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=v+EK24ffNtWmmjFeXBWGRJD9QAUitmkpf0uOCUCUG6A=;
        b=EjXnEuW+ii3JJfjMrFtsI7fe2vMScSJR4utVxqjPxIyFQhzMXmeySf/66Bzmb6tUsY
         BpeMWFl+Fk2jOLueRAtVIKizqvC1JtrJznPVH2c+J8T7d58VnaJZxLiaGuvl5/SS0wz7
         UmHvP53AOzFXBsUMg7CzRCKikhgs9wLIBGeQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vw0hY7mGSmm6EaYEgZwyLu0DLG6l80eOcIYDEKeB+lglDg7lQZNyE/Rj72md0st1y3
         nKgQu/cZDQ7lAtVh5+os3PrlmSFh9XtgsuVN9UxzCs5hN+U+JmdUo1vQDDamaGMexHXw
         kI20edHr2MQKbRyzQ6W/31LfGSQdk9oG3f/ME=
Received: by 10.142.103.11 with SMTP id a11mr1802388wfc.113.1242632960140;
        Mon, 18 May 2009 00:49:20 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 24sm8270546wfc.37.2009.05.18.00.49.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 00:49:19 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 18 May 2009 00:49:16 -0700
X-Mailer: git-send-email 1.6.3.1.30.g55524
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119422>

Normally, a directory named "trash directory.$TEST_NAME" is created for
each test in the t directory (where the test resides). This option
allows you to specify a different location to create the trash
directories.

For example:

    ./some_test.sh --trash /tmp

will create a git repo and run the tests in some_test.sh under
/tmp/trash directory.some_test/

Users may want to run tests on a tmpfs or maybe they have a disk they
would like to run tests on that differs from the location of the source
code. This option allows them to do so without having to do any mounting
mumbo-jumbo.
---

 I tried this out on a tmpfs and it didn't seem to give me too much speedup.
 Maybe something like 1%, but I couldn't test it with the 2GB test where it
 might be useful? I'm just throwing this out there as something people
 might like.


 t/README                                 |    6 ++++++
 t/t3404-rebase-interactive.sh            |    2 +-
 t/t3411-rebase-preserve-around-merges.sh |    2 +-
 t/t4014-format-patch.sh                  |    2 +-
 t/t4020-diff-external.sh                 |    2 +-
 t/test-lib.sh                            |    6 ++++--
 6 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index d8f6c7d..47a8da3 100644
--- a/t/README
+++ b/t/README
@@ -75,6 +75,12 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+--trash::
+	Normally a directory named "trash directory.$TEST_NAME" is
+	created for each test in the t directory (where the test
+	resides). This option allows you to specify a different
+	location to create the trash directories.
+
 Skipping Tests
 --------------
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c32ff66..da337c3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -10,7 +10,7 @@ that the result still makes sense.
 '
 . ./test-lib.sh
 
-. ../lib-rebase.sh
+. $TEST_DIRECTORY/lib-rebase.sh
 
 set_fake_editor
 
diff --git a/t/t3411-rebase-preserve-around-merges.sh b/t/t3411-rebase-preserve-around-merges.sh
index 6533505..2b82c33 100755
--- a/t/t3411-rebase-preserve-around-merges.sh
+++ b/t/t3411-rebase-preserve-around-merges.sh
@@ -10,7 +10,7 @@ a merge to before the merge.
 '
 . ./test-lib.sh
 
-. ../lib-rebase.sh
+. $TEST_DIRECTORY/lib-rebase.sh
 
 set_fake_editor
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 922a894..0fd7be7 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -493,7 +493,7 @@ test_expect_success 'format-patch from a subdirectory (2)' '
 '
 
 test_expect_success 'format-patch from a subdirectory (3)' '
-	here="$TEST_DIRECTORY/$test" &&
+	here="$PWD" &&
 	rm -f 0* &&
 	filename=$(
 		rm -rf sub &&
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0720001..3d27a95 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -157,7 +157,7 @@ test_expect_success 'diff --cached' '
 	git update-index --assume-unchanged file &&
 	echo second >file &&
 	git diff --cached >actual &&
-	test_cmp ../t4020/diff.NUL actual
+	test_cmp $TEST_DIRECTORY/t4020/diff.NUL actual
 '
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..022f826 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -114,6 +114,8 @@ do
 		valgrind=t; verbose=t; shift ;;
 	--tee)
 		shift ;; # was handled already
+	--tr|--tra|--tras|--trash)
+		shift; trash_dir=$1; shift;;
 	*)
 		break ;;
 	esac
@@ -637,8 +639,8 @@ fi
 . ../GIT-BUILD-OPTIONS
 
 # Test repository
-test="trash directory.$(basename "$0" .sh)"
-test ! -z "$debug" || remove_trash="$TEST_DIRECTORY/$test"
+test="${trash_dir:-$TEST_DIRECTORY}/trash directory.$(basename "$0" .sh)"
+test ! -z "$debug" || remove_trash=$test
 rm -fr "$test" || {
 	trap - EXIT
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
1.6.3.1.30.g55524
