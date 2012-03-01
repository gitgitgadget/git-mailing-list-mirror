From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCH 2/5] t5512 (ls-remote): modernize style
Date: Wed, 29 Feb 2012 17:45:18 -0800
Message-ID: <1330566326-26075-3-git-send-email-tmgrennan@gmail.com>
References: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Carlos Rica <jasampler@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Amos Waterland <apw@rossby.metr.ou.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 02:46:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2v6N-0004Mc-2V
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 02:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758098Ab2CABp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 20:45:59 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52025 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369Ab2CABpu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 20:45:50 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so74765vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 17:45:50 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.52.71.80 as permitted sender) client-ip=10.52.71.80;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.52.71.80 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.52.71.80])
        by 10.52.71.80 with SMTP id s16mr4055788vdu.131.1330566350272 (num_hops = 1);
        Wed, 29 Feb 2012 17:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=A0pJjALlY6g6VWQ3TbHGgAkhuPjE8PIjcKc0KzxcelM=;
        b=OT/u+4OO+9ilhj/vCM5MYe+4pFVKqPLsipcvr/AYZvEsIDWxHpafVQmLV+YybG3x1C
         jQS09lRk+WV/q6m+8/u2dj28rximLGvqnASrNNzA+1coOQXjOFKev0/qHuCSM/TPclS8
         UeCajkQwbJ1fh4pvBcTUTEn1CnX8Y1GE5L6WI=
Received: by 10.52.71.80 with SMTP id s16mr3479750vdu.131.1330566350134;
        Wed, 29 Feb 2012 17:45:50 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n14sm502335vdj.22.2012.02.29.17.45.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 29 Feb 2012 17:45:49 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1330566326-26075-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120223002215.GE2410@tgrennan-laptop>
References: <20120223002215.GE2410@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191880>

- Guard setup with test_expect_success
- Single-quoted, tab prefaced test blocks of < 80 cols
- Redirect unwanted output

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 t/t5512-ls-remote.sh |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 5c546c9..bbe650f 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -2,14 +2,22 @@
 
 test_description='git ls-remote'
 
+if ! test -r test-lib.sh ; then
+	(cd ${0%/*} && ./${0##*/} $@)
+	exit $?
+fi
+
 . ./test-lib.sh
 
+quiet () { "$@" >/dev/null; }
+silent () { "$@" >/dev/null 2>&1; }
+
 test_expect_success setup '
 
 	>file &&
 	git add file &&
 	test_tick &&
-	git commit -m initial &&
+	git commit -q -m initial &&
 	git tag mark &&
 	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
 	(
@@ -51,7 +59,7 @@ test_expect_success 'ls-remote self' '
 
 test_expect_success 'dies when no remote specified and no default remotes found' '
 
-	test_must_fail git ls-remote
+	silent test_must_fail git ls-remote
 
 '
 
@@ -70,8 +78,8 @@ test_expect_success 'use "origin" when no remote specified' '
 
 test_expect_success 'suppress "From <url>" with -q' '
 
-	git ls-remote -q 2>actual_err &&
-	test_must_fail test_cmp exp_err actual_err
+	quiet git ls-remote -q 2>actual_err &&
+	test_must_fail cmp -s exp_err actual_err
 
 '
 
@@ -83,7 +91,7 @@ test_expect_success 'use branch.<name>.remote if possible' '
 	#
 
 	# setup a new remote to differentiate from "origin"
-	git clone . other.git &&
+	git clone -q . other.git &&
 	(
 		cd other.git &&
 		echo "$(git rev-parse HEAD)	HEAD"
@@ -102,11 +110,13 @@ test_expect_success 'use branch.<name>.remote if possible' '
 
 '
 
-cat >exp <<EOF
-fatal: 'refs*master' does not appear to be a git repository
-fatal: The remote end hung up unexpectedly
-EOF
 test_expect_success 'confuses pattern as remote when no remote specified' '
+	'"
+	cat >exp <<-EOF
+		fatal: 'refs*master' does not appear to be a git repository
+		fatal: The remote end hung up unexpectedly
+	EOF
+	"'
 	#
 	# Do not expect "git ls-remote <pattern>" to work; ls-remote, correctly,
 	# confuses <pattern> for <remote>. Although ugly, this behaviour is akin
@@ -124,7 +134,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 '
 
 test_expect_success 'die with non-2 for wrong repository even with --exit-code' '
-	git ls-remote --exit-code ./no-such-repository ;# not &&
+	silent git ls-remote --exit-code ./no-such-repository ;# not &&
 	status=$? &&
 	test $status != 2 && test $status != 0
 '
@@ -136,7 +146,8 @@ test_expect_success 'Report success even when nothing matches' '
 '
 
 test_expect_success 'Report no-match with --exit-code' '
-	test_expect_code 2 git ls-remote --exit-code other.git "refs/nsn/*" >actual &&
+	test_expect_code 2 git ls-remote --exit-code other.git "refs/nsn/*" \
+		>actual &&
 	>expect &&
 	test_cmp expect actual
 '
-- 
1.7.8
