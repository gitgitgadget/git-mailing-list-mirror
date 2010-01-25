From: Greg Price <price@MIT.EDU>
Subject: [PATCH 6/6] rebase --rewrite-refs: tests
Date: Sun, 24 Jan 2010 21:28:48 -0500
Message-ID: <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com>
References: <cover.1309133817.git.greg@quora.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 02:42:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QazuQ-0006H7-KY
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 02:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756060Ab1F0AkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 20:40:08 -0400
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:42836 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756055Ab1F0AkE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2011 20:40:04 -0400
X-AuditID: 1209190c-b7c65ae00000117c-0d-4e07d03a0c1b
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 15.18.04476.A30D70E4; Sun, 26 Jun 2011 20:35:06 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p5R0Z1gR001631;
	Sun, 26 Jun 2011 20:35:01 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5R0Z0pF019058;
	Sun, 26 Jun 2011 20:35:00 -0400 (EDT)
In-Reply-To: <cover.1309133817.git.greg@quora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixG6nomt1gd3PYMNlRYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugSvj+fvTTAXnBCtWrrrB0sDYyNfFyMEhIWAi8WSu
	SBcjJ5ApJnHh3nq2LkYuDiGBfYwS3VuOMoEkhAQ2MEq0tJtDJL4wShyf+J0NIqEucbPtECOE
	rSOx79AhdgjbSuLy+mNQcUOJJ0fvgMV5BUIkrny6xgiymFPASOJlowJMyf0LTWAj2QQUJH7M
	X8cMYosIqElMbDvEAmIzC4hLrJt7HmwMi4CqxL32XrDbhIF6L55awzaBUXABI8MqRtmU3Crd
	3MTMnOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MoIDjlOTZwfjmoNIhRgEORiUe3gcJ7H5CrIll
	xZW5hxglOZiURHlFzwOF+JLyUyozEosz4otKc1KLDzFKcDArifC+CwPK8aYkVlalFuXDpKQ5
	WJTEecu9//sKCaQnlqRmp6YWpBbBZGU4OJQkeINAhgoWpaanVqRl5pQgpJk4OEGG8wANDwWp
	4S0uSMwtzkyHyJ9iVJQS510NkhAASWSU5sH1whLCK0ZxoFeEeQ+DVPEAkwlc9yugwUxAg/su
	s4EMLklESEk1MM6Ln63C1XPWo4klXaX/xVFZS6f5T1pr0hpj0q9c27T8ueLfmiQjQ1X2W4Ke
	4UfU94fc7QnZ4WJwsuGbQ63EFVPjSwf6axYeFY09lbhv9RdZEbHtvIsmGR7+Yifplqr7iYX5
	Ytbtf2IP9u5q4TtXZv/W6Ph99ibvo6ZdyTzBz7YyMCp/143eq8RSnJFoqMVcVJwI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176341>

Signed-off-by: Greg Price <price@mit.edu>
---
 t/t3420-rebase-ref.sh |   75 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 t/t3420-rebase-ref.sh

diff --git a/t/t3420-rebase-ref.sh b/t/t3420-rebase-ref.sh
new file mode 100644
index 0000000..601a434
--- /dev/null
+++ b/t/t3420-rebase-ref.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description='git rebase --rewrite-refs'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-rebase.sh"
+set_fake_editor
+
+#      part1  part2 topic
+#	 |	|     |
+#	 v	v     v
+#  A-----C------D-----E
+#   \
+#    B <--master
+
+test_expect_success setup '
+	test_commit A &&
+	git branch topic &&
+	test_commit B &&
+	git checkout topic &&
+	test_commit C &&
+	git branch part1 &&
+	test_commit D
+	git branch part2 &&
+	test_commit E
+'
+
+test_expect_success 'rebase --rewrite-heads' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard E &&
+
+	git rebase --rewrite-heads master &&
+	git rev-parse part1 >actual &&
+	git rev-parse HEAD~2 >expected &&
+	test_cmp expected actual &&
+	git rev-parse part2 >actual &&
+	git rev-parse HEAD~1 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rebase --rewrite-refs' '
+	git reset --hard &&
+	git update-ref refs/heads/part1 C &&
+	git update-ref refs/heads/part2 D &&
+	git checkout topic &&
+	git reset --hard E &&
+
+	git rebase --rewrite-refs=refs/heads/part2 master &&
+	git rev-parse part1 >actual &&
+	git rev-parse C >expected &&
+	test_cmp expected actual &&
+	git rev-parse part2 >actual &&
+	git rev-parse HEAD~1 >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'ref in TODO followed by rebase --abort' '
+	git reset --hard &&
+	git update-ref refs/heads/part1 C &&
+	git update-ref refs/heads/part2 D &&
+	git checkout topic &&
+	git reset --hard E &&
+
+	FAKE_LINES="1 2 edit 3 4 5" git rebase -i --rewrite-heads master &&
+	git rev-parse part1 >actual &&
+	git rev-parse HEAD^ >expected &&
+	test_cmp expected actual &&
+	git rebase --abort &&
+	git rev-parse part1 >actual &&
+	git rev-parse C >expected &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.5.4
