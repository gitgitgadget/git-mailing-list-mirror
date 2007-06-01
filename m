From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Fri, 01 Jun 2007 10:13:15 +0200
Message-ID: <op.ts8g4dsa9pspc6@localhost>
References: <11802980992216-git-send-email-hjemli@gmail.com> <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net> <8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com> <7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net> <op.ts8d71b89pspc6@localhost> <465FD11C.6B1D5172@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 10:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu2EQ-0004O8-HS
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 10:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXFAILN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 04:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXFAILN
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 04:11:13 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:10342 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbXFAILL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2007 04:11:11 -0400
Received: by ik-out-1112.google.com with SMTP id b32so428109ika
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 01:11:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=Hs8budig0C9hhNasfqS8SStV3/MR19DYwVOWb205SVXBpK3up7WdIPYqs+zOpJHrV5U3q0CN8jUPcAJTjDhONhcKBQy1t0o7rfdQCzxXo4XqHIqvpPMirKXonF5rIm5uUnkQdY7/mXpL7yniFz8QcaqO4ZGL++oAQ0GOJH3DFD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:from:cc:content-type:mime-version:references:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=fP9Vj0xsWHQB/W9ftx8oA71OddLl7My5B280aiVXr9YdttmSorc0sWXEl8MLuqX9LHI+SmF0L8qiKGoXhyvx3AXeGXmRXLiiMWAqzdOiZy9PFeODPfqAykH4FsiNHQ4x+OZ6kmtryOyi5gZVE2q8zOzI6JMBidGR8rc+EWmFrQU=
Received: by 10.82.120.15 with SMTP id s15mr785445buc.1180685468734;
        Fri, 01 Jun 2007 01:11:08 -0700 (PDT)
Received: from localhost ( [195.1.56.189])
        by mx.google.com with ESMTP id z34sm1673289ikz.2007.06.01.01.11.02;
        Fri, 01 Jun 2007 01:11:05 -0700 (PDT)
In-Reply-To: <465FD11C.6B1D5172@eudaptics.com>
User-Agent: Opera Mail/9.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48851>

This test tries to verify basic sanity of git-submodule, i.e. that it is
able to clone and update a submodule repository, that its status output is
sane, and that it barfs when the submodule path is occupied during init.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

On Fri, 01 Jun 2007 09:56:12 +0200, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Lars Hjemli wrote:
>> +test_expect_success 'status should only print one line' '
>> +       lines=$(git-submodule status | wc -l)
>
> && is missing.
>
>> +       test "$lines" = "1"
>
> Please don't put output of wc in quotes because some versions of wc emit
> padding:
>
> 	test $lines = 1
>
> (without the quotes around 1 - like in other test scripts).
>

Thanks, and sorry...


  t/t7400-submodule-basic.sh |  143 ++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 143 insertions(+), 0 deletions(-)
  create mode 100755 t/t7400-submodule-basic.sh

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
new file mode 100755
index 0000000..a985a6e
--- /dev/null
+++ b/t/t7400-submodule-basic.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Lars Hjemli
+#
+
+test_description='Basic porcelain support for submodules
+
+This test tries to verify basic sanity of the init, update and status
+subcommands of git-submodule.
+'
+
+. ./test-lib.sh
+
+#
+# Test setup:
+#  -create a repository in directory lib
+#  -add a couple of files
+#  -add directory lib to 'superproject', this creates a DIRLINK entry
+#  -add a couple of regular files to enable testing of submodule filtering
+#  -mv lib subrepo
+#  -add an entry to .gitmodules for path 'lib'
+#
+test_expect_success 'Prepare submodule testing' '
+	mkdir lib &&
+	cd lib &&
+	git-init &&
+	echo a >a &&
+	git-add a &&
+	git-commit -m "submodule commit 1" &&
+	git-tag -a -m "rev-1" rev-1 &&
+	rev1=$(git-rev-parse HEAD) &&
+	if test -z "$rev1"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	cd .. &&
+	echo a >a &&
+	echo z >z &&
+	git-add a lib z &&
+	git-commit -m "super commit 1" &&
+	mv lib .subrepo &&
+	GIT_CONFIG=.gitmodules git-config module.lib.url ./.subrepo
+'
+
+test_expect_success 'status should only print one line' '
+	lines=$(git-submodule status | wc -l) &&
+	test $lines = 1
+'
+
+test_expect_success 'status should initially be "missing"' '
+	git-submodule status | grep "^-$rev1"
+'
+
+test_expect_success 'init should fail when path is used by a file' '
+	echo "hello" >lib &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test -f lib && test "$(cat lib)" != "hello"
+	then
+		echo "[OOPS] init failed but lib file was molested"
+		false
+	else
+		rm lib
+	fi
+'
+
+test_expect_success 'init should fail when path is used by a nonempty directory' '
+	mkdir lib &&
+	echo "hello" >lib/a &&
+	if git-submodule init
+	then
+		echo "[OOPS] init should have failed"
+		false
+	elif test "$(cat lib/a)" != "hello"
+	then
+		echo "[OOPS] init failed but lib/a was molested"
+		false
+	else
+		rm lib/a
+	fi
+'
+
+test_expect_success 'init should work when path is an empty dir' '
+	rm -rf lib &&
+	mkdir lib &&
+	git-submodule init &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] Failed to obtain submodule head"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] Submodule head is $head but should have been $rev1"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after init' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_expect_success 'status should be "modified" after submodule commit' '
+	cd lib &&
+	echo b >b &&
+	git-add b &&
+	git-commit -m "submodule commit 2" &&
+	rev2=$(git-rev-parse HEAD) &&
+	cd .. &&
+	if test -z "$rev2"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	fi &&
+	git-submodule status | grep "^\+$rev2"
+'
+
+test_expect_success 'the --cached sha1 should be rev1' '
+	git-submodule --cached status | grep "^\+$rev1"
+'
+
+test_expect_success 'update should checkout rev1' '
+	git-submodule update &&
+	head=$(cd lib && git-rev-parse HEAD) &&
+	if test -z "$head"
+	then
+		echo "[OOPS] submodule git-rev-parse returned nothing"
+		false
+	elif test "$head" != "$rev1"
+	then
+		echo "[OOPS] init did not checkout correct head"
+		false
+	fi
+'
+
+test_expect_success 'status should be "up-to-date" after update' '
+	git-submodule status | grep "^ $rev1"
+'
+
+test_done
-- 
1.5.2.839.ga3b1-dirty
