From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/6] name-rev --weight: tests and documentation
Date: Wed, 29 Aug 2012 20:50:28 -0700
Message-ID: <1346298629-13730-6-git-send-email-gitster@pobox.com>
References: <1346298629-13730-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 05:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vn3-0007mt-0h
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab2H3DvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639Ab2H3Dum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:50:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D73688B5
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ZXMB
	vCaRqzoku7j9gUHucLcdi9w=; b=VG1fKJHpz7AehbeA3KlgyLholRV5Keq9fWJR
	/6ICoMcCXB/fpRFf3lD9oYMqvLmPVOW2nfZvZkzLYfVIQmgiaKygE8t4vI4o5D2y
	OlKWYI02A8lEHihz8bg4eeOPcrAZ4l/N2DIVuTjM786IKhUCZdpWKL1q/Cr9z3j6
	aUMJDBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=IyEPqa
	3tnp7cTZIH+orJzhBT8oiNvAg1LWORWjMdoPmyn3yYXts62aDLR897BcDZOGipjP
	S2M5p2SNqiCnqO0VHjrBqCooaMHkPSKikEd6Gnho+V/rwVAmzrtuO024VMOiYqxg
	mBsJaEjJRACKKgCK+uluwRUMqIVat24WKUek0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39FA888B4
	for <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F53A88B3 for
 <git@vger.kernel.org>; Wed, 29 Aug 2012 23:50:41 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.286.g9df01f7
In-Reply-To: <1346298629-13730-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DE5D48F0-F255-11E1-9A85-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204512>

We are almost there...

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-name-rev.txt | 14 ++++++++--
 t/t6039-name-rev.sh            | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100755 t/t6039-name-rev.sh

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index ad1d146..f40027a 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -9,13 +9,13 @@ git-name-rev - Find symbolic names for given revs
 SYNOPSIS
 --------
 [verse]
-'git name-rev' [--tags] [--refs=<pattern>]
+'git name-rev' [--tags] [--refs=<pattern>] [--weight]
 	       ( --all | --stdin | <committish>... )
 
 DESCRIPTION
 -----------
-Finds symbolic names suitable for human digestion for revisions given in any
-format parsable by 'git rev-parse'.
+Finds symbolic names suitable for human digestion for revisions
+given in any format parsable by 'git rev-parse'.
 
 
 OPTIONS
@@ -47,6 +47,14 @@ OPTIONS
 --always::
 	Show uniquely abbreviated commit object as fallback.
 
+--weight::
+	Name commits based on the oldest ref that contains it.  This
+	is way more expensive than the default behaviour of the
+	command, in which commits are named based on the ref that
+	is topologically the closest, but gives more intuitive
+	answer to the question: what is the oldest tag that contains
+	this commit?
+
 EXAMPLE
 -------
 
diff --git a/t/t6039-name-rev.sh b/t/t6039-name-rev.sh
new file mode 100755
index 0000000..315ce14
--- /dev/null
+++ b/t/t6039-name-rev.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+
+test_description='name-rev'
+. ./test-lib.sh
+
+# Prepare a history with this shape
+#
+# ---0--1--2--3--4--Y--5---7---Z
+#     \   /               /
+#      \ /               /
+#       X---------------6
+#
+
+test_expect_success setup '
+	test_tick &&
+	git commit --allow-empty -m 0 &&
+	git branch side &&
+	git commit --allow-empty -m 1 &&
+	git checkout side &&
+	git commit --allow-empty -m X &&
+	git branch X &&
+	git commit --allow-empty -m 6 &&
+	git checkout master &&
+	git merge -m 2 X &&
+	git commit --allow-empty -m 3 &&
+	git commit --allow-empty -m 4 &&
+	git commit --allow-empty -m Y &&
+	git tag Y &&
+	git commit --allow-empty -m 5 &&
+	git merge -m 7 side &&
+	git commit --allow-empty -m Z &&
+	git tag Z
+'
+
+test_expect_success 'name-rev (plain)' '
+	# We expect "X tags/Z~1^2~1" but it could
+	# be written as "X tags/Z^^2^"; the only two
+	# important things that matter are that it
+	# is named after Z (not Y), and it correctly
+	# names X.
+	git name-rev --tags X >actual &&
+	read X T <actual &&
+	test "z$X" = zX &&
+	expr "$T" : 'tags/Z[~^]' &&
+	H1=$(git rev-parse --verify "$T") &&
+	H2=$(git rev-parse --verify X) &&
+	test "z$H1" = "z$H2"
+'
+
+test_expect_success 'name-rev --weight' '
+	# Likewise; "X tags/Y~3^2" but we only care
+	# that it is based on Y.
+	git name-rev --weight --tags X >actual &&
+	read X T <actual &&
+	test "z$X" = zX &&
+	expr "$T" : 'tags/Y[~^]' &&
+	H1=$(git rev-parse --verify "$T") &&
+	H2=$(git rev-parse --verify X) &&
+	test "z$H1" = "z$H2"
+'
+
+test_done
-- 
1.7.12.286.g9df01f7
