From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/4] t3302,t3419: use the TIME_COMMAND prereq
Date: Tue, 16 Oct 2012 13:39:47 +0200
Message-ID: <71d3a0f9ab2bfd73fb2abfb4a0bc9fa7be6cd70b.1350387132.git.git@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 13:40:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5VO-00049d-Fo
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab2JPLkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:40:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46207 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754542Ab2JPLjz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 07:39:55 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4A9AA20A1E;
	Tue, 16 Oct 2012 07:39:55 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 16 Oct 2012 07:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=UN
	F0frvfDJO86NlQz4HEiIBkLUI=; b=ZwO5w6/s+wokSGBzYYAOma3XdxVW2x5C9S
	9Rdfg61NW3C2Bdf+TlPcrV/0cvlZJazzA/Cl607gPwkJnYgTZlPA2TkZvqPKEM7S
	I7HDtiZcYeoh+CNe4Qke1i2lipQ56ENuIw9CTQUMkMqvp7buGc7scxXEisN5wOPb
	WVk0E/isQ=
X-Sasl-enc: 71GQgWRZojm57ZP53OVKNmULW43922+fqm+/ab3YUFCd 1350387594
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E13884827C7;
	Tue, 16 Oct 2012 07:39:54 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <k5gq60$q8c$1@ger.gmane.org>
In-Reply-To: <cover.1350387132.git.git@drmicha.warpmail.net>
References: <cover.1350387132.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207819>

Use the TIME_COMMAND prereq in both tests so that time from several
paths can be used.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3302-notes-index-expensive.sh | 5 ++---
 t/t3419-rebase-patch-id.sh       | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-expensive.sh
index e35d781..3d9f37e 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -9,7 +9,6 @@ test_description='Test commit notes index (expensive!)'
 
 test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
-test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 create_repo () {
 	number_of_commits=$1
@@ -96,7 +95,7 @@ time_notes () {
 	for mode in no-notes notes
 	do
 		echo $mode
-		/usr/bin/time "$SHELL_PATH" ../time_notes $mode $1
+		"$TIME_COMMAND_PATH" "$SHELL_PATH" ../time_notes $mode $1
 	done
 }
 
@@ -113,7 +112,7 @@ do_tests () {
 
 	test_expect_success $pr 'notes work' "test_notes $count"
 
-	test_expect_success USR_BIN_TIME,$pr 'notes timing with /usr/bin/time' "time_notes 100"
+	test_expect_success TIME_COMMAND,$pr 'notes timing with a time command' "time_notes 100"
 
 	test_expect_success $pr 'teardown / cd ..' 'cd ..'
 }
diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 52af547..c7d90a6 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -6,7 +6,6 @@ test_description='git rebase - test patch id computation'
 
 test_set_prereq NOT_EXPENSIVE
 test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
-test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
 
 count()
 {
@@ -35,7 +34,7 @@ scramble()
 run()
 {
 	echo \$ "$@"
-	/usr/bin/time "$@" >/dev/null
+	"$TIME_COMMAND_PATH" "$@" >/dev/null
 }
 
 test_expect_success 'setup' '
@@ -69,7 +68,7 @@ do_tests()
 		git cherry-pick master >/dev/null 2>&1
 	"
 
-	test_have_prereq USR_BIN_TIME && test_debug "
+	test_have_prereq TIME_COMMAND && test_debug "
 		run git diff master^\!
 	"
 
@@ -77,7 +76,7 @@ do_tests()
 		echo 'file binary' >.gitattributes
 	"
 
-	test_have_prereq USR_BIN_TIME && test_debug "
+	test_have_prereq TIME_COMMAND && test_debug "
 		run git format-patch --stdout master &&
 		run git format-patch --stdout --ignore-if-in-upstream master
 	"
-- 
1.8.0.rc2.304.g9f3ac5c
