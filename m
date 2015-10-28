From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 2/2] rebase-i: work around Windows CRLF line endings
Date: Wed, 28 Oct 2015 15:54:48 +0100 (CET)
Message-ID: <ecea378790275a22167f2434ba714a565971e622.1446043983.git.johannes.schindelin@gmx.de>
References: <cover.1445939154.git.johannes.schindelin@gmx.de> <cover.1446043983.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:55:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrS85-0007Cz-9O
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbbJ1OzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 10:55:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:56658 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbbJ1OzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 10:55:01 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0MYOkT-1Zw2Z72uAr-00VB3z;
 Wed, 28 Oct 2015 15:54:48 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1446043983.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:rFKZrqtBVZ+6Do4hzqymbHTcAadMCWqej1Rfq/q4aYIabBw9Zf+
 v2bdNf+OUyAJhjiQvkpAyi18FG5Wly59MDWk9cIu4TE+U9ysYbZJgFSx5EEdjgNAfH0DPG6
 7eBqMVBVZL/zypnEaxM+1JQaGMyTp3HaWkiT16BXum5pYsMnX9N8ic3X0d0uqbVWG4+GQ6Q
 Amjl8Y/sYB9eWFTk03Yjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ES2wkqMrRJk=:8dGOyeBUBowloM06VAkiU4
 MQ8nQY8VFHwF+zbCb0JsTHdFpFNQ7B7p8e8qrDZRH67aeFw2DULJBdfoxwmZ1j5Oav44ALAkU
 gGo3HkNsRPHV0SQJIvnY4YzO7SexZV9FHE/e2grSYEnJcR5gSewyrMi9Nw9g7cvnQ8AmigGSp
 EKTkVwFZn9JHc+kJzm+/izZQAGy6BtdueBTisjk8WdIT3ynpfUA+t6PyRGo6cCnAlGCEMljoa
 NEA1glIcI/iFOSkgWo1WVaHPsPIfn4Y/jQNtZORoP2EqG/6w+o/g9JKGlpSqzmnxL/cMRPvsU
 U3YZVIGVj7io/Pg9VTtm0w0eSqmT+Z+B1jjOY6cLq/2FVKwrjd5ejmR/iG93O2cZ2+WppdqEw
 VswrlTUutNZuOUqv8+DL5fXwjDv7zDE07lh3b5TwJ9HqwPFfHVcuh+v/rnuX389if+rnojpb6
 9j9lvsBCRlIJOUq6CsOtwt4evIPvDqjKcOFOqq1vDe7wAgOgg7DFOl7ItEavZBqaNeqWB1bSY
 UQzvjgnA7QrNI99hyfx4MB4Iw0eLcikhZ6vZRDTqchts7abmkKuU3hC/hA67or+oG+jzeUfLN
 abd+TeoguH0/cQ0fJ7zM7MijZdNQ8FO4EtbcHDyQlE4mRJZCoEcH/A6WhKX+2B2WecHWpAYOi
 doRjb15KhxvDX4EURZqt/dDC3uAlSiqRYTLmzKLHSl74pXrnAFfy8AVNeynx9pGCsSU7it8S/
 sBXWYtEvA7Q29LPoJKT7oSmw0apBmL5LWAhZ3Kn9VwJl3qiO/J2Xa/CV4z5cHOImeFvkAv2u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280369>

From: Junio C Hamano <gitster@pobox.com>

Editors on Windows can and do save text files with CRLF line
endings, which is the convention on the platform.  We are seeing
reports that the "read" command in a port of bash to the environment
however does not strip the CRLF at the end, not adjusting for the
same convention on the platform.

This breaks the recently added sanity checks for the insn sheet fed
to "rebase -i"; instead of an empty line (hence nothing in $command),
the script was getting a lone CR in there.

Special case a lone CR and treat it the same way as an empty line to
work this around.

This patch passes the test with Git for Windows, where the issue was
seen first.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    | 12 ++++++++++++
 t/t3404-rebase-interactive.sh |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d65c06e..34cfe66 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,6 +77,9 @@ amend="$state_dir"/amend
 rewritten_list="$state_dir"/rewritten-list
 rewritten_pending="$state_dir"/rewritten-pending
 
+# Work around Git for Windows' Bash that strips only LFs but no CRs.
+cr=$(printf "\015")
+
 strategy_args=
 if test -n "$do_merge"
 then
@@ -518,6 +521,11 @@ do_next () {
 	"$comment_char"*|''|noop|drop|d)
 		mark_action_done
 		;;
+	"$cr")
+		# Work around Carriage Returns not being stripped (e.g. with
+		# Git for Windows' Bash).
+		mark_action_done
+		;;
 	pick|p)
 		comment_for_reflog pick
 
@@ -896,6 +904,10 @@ check_bad_cmd_and_sha () {
 		"$comment_char"*|''|noop|x|exec)
 			# Doesn't expect a SHA-1
 			;;
+		"$cr")
+			# Work around Carriage Returns not being stripped
+			# (e.g. with Git for Windows' Bash).
+			;;
 		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
 			if ! check_commit_sha "${rest%%[ 	]*}" "$lineno" "$1"
 			then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5dfa16a..98eb49a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1261,7 +1261,7 @@ test_expect_success 'static check of bad SHA-1' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-test_expect_failure 'editor saves as CR/LF' '
+test_expect_success 'editor saves as CR/LF' '
 	git checkout -b with-crlf &&
 	write_script add-crs.sh <<-\EOF &&
 	sed -e "s/\$/Q/" <"$1" | tr Q "\\015" >"$1".new &&
-- 
2.1.4
