From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] test: add git apply whitespace expansion tests
Date: Sun, 18 Jan 2015 02:49:45 -0800
Message-ID: <102e322e68e78e39a7c227f3f3e102c@74d39fa044aa309eaea14b9f57fe79c>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com> <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com> <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com> <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com> <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com> <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com> <4157F6B0-DDF4-4F71-A09B-EE216537CA89@gmail.com> <xmqqbnly1oqo.fsf@gitster.dls.corp.google.com> <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com>
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 11:50:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCnQf-00019c-J7
	for gcvg-git-2@plane.gmane.org; Sun, 18 Jan 2015 11:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbbARKt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2015 05:49:57 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38925 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbARKt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2015 05:49:56 -0500
Received: by mail-pd0-f181.google.com with SMTP id z10so19489040pdj.12
        for <git@vger.kernel.org>; Sun, 18 Jan 2015 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfoiCHSCV77eIH1UnJw0iWP8PsT9LJCB07z/jaWyul0=;
        b=WS0lStlHMqMP8yNtmRt77uIPup7GjpXwxbNGcX5iqmFbVGrc8G8JKCQhW2Kwa0nn0N
         EdFXPgtn2LjH0Q7KPTlg2dOOclxDkCgxErtl8divkBOtzH82+jlwPmKE0ry//or98h4m
         nUbu+1zx3BDp9p0DTjF8eEzm2NYRpb8bIHYIfSjvXTFty5SjkK3zVhZzP5jAUQ4cZcVt
         19agxaQOE4Enyz1f/qY5a+zpN4yzGodaeyw+E0m4ihPUmqa1mqyZkjxlOVs00iuV9KUz
         zhO84XwsTExodsE9pP5cl+iBgRA9Oq7cEoqU8fcczEXyiQdQhfeif6GuxvB9sQsQXrfv
         FgXQ==
X-Received: by 10.70.102.193 with SMTP id fq1mr36417104pdb.19.1421578195473;
        Sun, 18 Jan 2015 02:49:55 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id mb9sm8734743pdb.40.2015.01.18.02.49.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 Jan 2015 02:49:54 -0800 (PST)
In-Reply-To: <xmqqzj9iz3gu.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262595>

When git apply fixes whitespace, the result can end up being
longer than the initial text if whitespace ends up being expanded
(such as with the tab-in-indent option).

Since 250b3c6c (apply --whitespace=fix: avoid running over the
postimage buffer, 2013-03-22) an attempt has been made to compute
the correct final length in such a case.

These tests all stress the whitespace-expansion-during-apply
condition and can result in core dump failures when the final
length is not computed correctly.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

* Here's some tests.  With "apply: make update_pre_post_images() sanity
  check the given postlen" but not "apply: count the size of postimage
  correctly" test 1/4 and 4/4 trigger the 'die("BUG: postlen...' but
  test 2/4 and 3/4 do not although they fail because git apply generates
  garbage.

* After applying "apply: count the size of postimage correctly" all 4
  tests pass whereas they all fail without that.  It's interesting that
  the "BUG: postlen" check does not trigger for 2/4 or 3/4 but the output
  is garbage in those cases without the fix.

* Theses tests can easily trigger core dumps.  It seems to depend on how
  the git binary was built and what exactly ends up getting stepped on as
  I have several different Git builds and some of them core dump on tests
  that others pass or just produce garbage for, but none of them passes
  2/4 or 3/4 without the "count postimage size correctly" fix.

 t/t4138-apply-ws-expansion.sh | 121 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100755 t/t4138-apply-ws-expansion.sh

diff --git a/t/t4138-apply-ws-expansion.sh b/t/t4138-apply-ws-expansion.sh
new file mode 100755
index 00000000..140ed9ac
--- /dev/null
+++ b/t/t4138-apply-ws-expansion.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# Copyright (C) 2015 Kyle J. McKay
+#
+
+# NOTE: To facilitate separate testing, this script can be run
+# standalone to just create the test files and do nothing else
+# by first setting the environment variable MAKE_PATCHES=1.
+
+test_description='git apply test patches with whitespace expansion.'
+
+[ -n "$MAKE_PATCHES" ] || \
+. ./test-lib.sh
+
+#
+## create test-N, patchN.patch, expect-N files
+#
+
+# test 1
+printf '\t%s\n' 1 2 3 4 5 6 > before
+printf '\t%s\n' 1 2 3 > after
+printf '%64s\n' a b c $x >> after
+printf '\t%s\n' 4 5 6 >> after
+git diff --no-index before after | \
+sed -e 's/before/test-1/' -e 's/after/test-1/' > patch1.patch
+printf '%64s\n' 1 2 3 4 5 6 > test-1
+printf '%64s\n' 1 2 3 a b c 4 5 6 > expect-1
+
+# test 2
+printf '\t%s\n' a b c d e f > before
+printf '\t%s\n' a b c > after
+n=10
+x=1
+while [ $x -lt $n ]; do
+	printf '%63s%d\n' '' $x >> after
+	x=$(( $x + 1 ))
+done
+printf '\t%s\n' d e f >> after
+git diff --no-index before after | \
+sed -e 's/before/test-2/' -e 's/after/test-2/' > patch2.patch
+printf '%64s\n' a b c d e f > test-2
+printf '%64s\n' a b c > expect-2
+x=1
+while [ $x -lt $n ]; do
+	printf '%63s%d\n' '' $x >> expect-2
+	x=$(( $x + 1 ))
+done
+printf '%64s\n' d e f >> expect-2
+
+# test 3
+printf '\t%s\n' a b c d e f > before
+printf '\t%s\n' a b c > after
+n=100
+x=0
+while [ $x -lt $n ]; do
+	printf '%63s%02d\n' '' $x >> after
+	x=$(( $x + 1 ))
+done
+printf '\t%s\n' d e f >> after
+git diff --no-index before after | \
+sed -e 's/before/test-3/' -e 's/after/test-3/' > patch3.patch
+printf '%64s\n' a b c d e f > test-3
+printf '%64s\n' a b c > expect-3
+x=0
+while [ $x -lt $n ]; do
+	printf '%63s%02d\n' '' $x >> expect-3
+	x=$(( $x + 1 ))
+done
+printf '%64s\n' d e f >> expect-3
+
+# test 4
+> before
+x=0
+while [ $x -lt 50 ]; do
+	printf '\t%02d\n' $x >> before
+	x=$(( $x + 1 ))
+done
+cat before > after
+printf '%64s\n' a b c >> after
+while [ $x -lt 100 ]; do
+	printf '\t%02d\n' $x >> before
+	printf '\t%02d\n' $x >> after
+	x=$(( $x + 1 ))
+done
+git diff --no-index before after | \
+sed -e 's/before/test-4/' -e 's/after/test-4/' > patch4.patch
+> test-4
+x=0
+while [ $x -lt 50 ]; do
+	printf '%63s%02d\n' '' $x >> test-4
+	x=$(( $x + 1 ))
+done
+cat test-4 > expect-4
+printf '%64s\n' a b c >> expect-4
+while [ $x -lt 100 ]; do
+	printf '%63s%02d\n' '' $x >> test-4
+	printf '%63s%02d\n' '' $x >> expect-4
+	x=$(( $x + 1 ))
+done
+
+# cleanup
+rm before after
+
+[ -z "$MAKE_PATCHES" ] || exit 0
+
+#
+## Run the tests
+#
+
+# Note that `patch` can successfully apply all patches when run
+# with the --ignore-whitespace option.
+
+for t in 1 2 3 4; do
+	test_expect_success "apply with ws expansion (t=$t)" '
+		git -c core.whitespace=tab-in-indent,tabwidth=63 \
+			apply --whitespace=fix patch$t.patch &&
+		test_cmp test-$t expect-$t
+	'
+done
+
+test_done
--
