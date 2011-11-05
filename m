From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/10] tests: distinguish merges of tags and commits
Date: Fri,  4 Nov 2011 23:01:35 -0700
Message-ID: <1320472900-6601-6-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 05 07:02:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMZKm-0005jr-Pj
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 07:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab1KEGBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 02:01:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1KEGBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 02:01:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B713C22
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qoxZ
	PuEjEC11BOaiPgL0KGeYtm8=; b=qHGHcYhsiZKRl+rrYlCbGZCtBVl5VYhQNppy
	/LB6rjbvIFQEHuI2Cpi4YFEhWWm18GJ6rUXiQ/Q9OQeP/ZiJ9HvoU31Ymt15r1b+
	ROD5NnXbhlHt8o+qcjrWTZQglCK3dW3Z5Db4zRQ042d62UGOO85F32CeQagekGft
	cgCOg08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=KT+Oeb
	g7TPgXCTUxohw9BUjQQ+QP47D0KssUGOp5fPYuQ1jMsvQLV1MA2EagoUJcIh2nAY
	YK+KoIpK52I0LEHDRUXLJnPBa6hbOhgIR1p3WnF8HNRHqsU9rFkNr86QP7KtQOiY
	v0wpnZOv+iQTMbhcJaZn9yugh75r/juuTVTJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E36ED3C21
	for <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5688B3C20 for
 <git@vger.kernel.org>; Sat,  5 Nov 2011 02:01:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.8.rc0.108.g71b5ec
In-Reply-To: <1320472900-6601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A8464EF6-0773-11E1-A679-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184827>

Recent merge can distinguish merging of local tags from commits,
so the tests need to be adjusted to the updated behaviour.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Strictly speaking, these should probably be part of the earlier two
   patches, but I am not motivated enough to do that to clutter them.

 t/t4202-log.sh                  |    4 ++--
 t/t7600-merge.sh                |    6 +++---
 t/t7604-merge-custom-message.sh |    2 +-
 t/t7608-merge-messages.sh       |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 983e34b..222f755 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -346,11 +346,11 @@ test_expect_success 'set up more tangled history' '
 '
 
 cat > expect <<\EOF
-*   Merge commit 'reach'
+*   Merge tag 'reach'
 |\
 | \
 |  \
-*-. \   Merge commit 'octopus-a'; commit 'octopus-b'
+*-. \   Merge tags 'octopus-a' and 'octopus-b'
 |\ \ \
 * | | | seventh
 | | * | octopus-b
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 3008e4e..b91d022 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -38,8 +38,8 @@ printf '%s\n' '1 X' 2 3 4 '5 X' 6 7 8 '9 X' >result.1-5-9
 >empty
 
 create_merge_msgs () {
-	echo "Merge commit 'c2'" >msg.1-5 &&
-	echo "Merge commit 'c2'; commit 'c3'" >msg.1-5-9 &&
+	echo "Merge tag 'c2'" >msg.1-5 &&
+	echo "Merge tags 'c2' and 'c3'" >msg.1-5-9 &&
 	{
 		echo "Squashed commit of the following:" &&
 		echo &&
@@ -57,7 +57,7 @@ create_merge_msgs () {
 	} >squash.1-5-9 &&
 	echo >msg.nolog &&
 	{
-		echo "* commit 'c3':" &&
+		echo "* tag 'c3':" &&
 		echo "  commit 3" &&
 		echo
 	} >msg.log
diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 9114785..89619cf 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -11,7 +11,7 @@ create_merge_msgs() {
 
 	cp exp.subject exp.log &&
 	echo >>exp.log "" &&
-	echo >>exp.log "* commit 'c2':" &&
+	echo >>exp.log "* tag 'c2':" &&
 	echo >>exp.log "  c2"
 }
 
diff --git a/t/t7608-merge-messages.sh b/t/t7608-merge-messages.sh
index 9225fa6..8e7e0a5 100755
--- a/t/t7608-merge-messages.sh
+++ b/t/t7608-merge-messages.sh
@@ -35,7 +35,7 @@ test_expect_success 'merge tag' '
 	git checkout master &&
 	test_commit master-3 &&
 	git merge tag-1 &&
-	check_oneline "Merge commit Qtag-1Q"
+	check_oneline "Merge tag Qtag-1Q"
 '
 
 test_expect_success 'ambiguous tag' '
@@ -44,7 +44,7 @@ test_expect_success 'ambiguous tag' '
 	git checkout master &&
 	test_commit master-4 &&
 	git merge ambiguous &&
-	check_oneline "Merge commit QambiguousQ"
+	check_oneline "Merge tag QambiguousQ"
 '
 
 test_expect_success 'remote-tracking branch' '
-- 
1.7.8.rc0.108.g71b5ec
