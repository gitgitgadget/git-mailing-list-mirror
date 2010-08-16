From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] t7606 (merge-theirs): modernize style
Date: Sun, 15 Aug 2010 20:08:46 -0500
Message-ID: <20100816010846.GA22573@burratino>
References: <20100816010652.GA22546@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 03:10:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkoDc-00056o-10
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab0HPBKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 21:10:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41467 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab0HPBKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 21:10:22 -0400
Received: by gxk23 with SMTP id 23so1717724gxk.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WzBv8nRZ6j2TaG2CYth2o8q3kAm7ex/Rn6lp4PDKP3Q=;
        b=IkBH6y1DE4zeDF0jU3Aw+yz9FQ+HWqyvyT3MYfILlk6dKh550JVLcQ09MMePHlf3t8
         1wQH5E2gsxX/9RkSvQ/yamu3SvtzgwvRmY3zlrPHgVwRlzELJovxu27JpY/j/gEOcWJn
         nYSfoLd7Z7tO7JIOFIgvOsPfCicAFh6RYCJ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BZ4NR+h27D8rAgOplrI0+nsl2tJJ7WxZqYlRjBxRH1XOCOcEoeX3PtZg3LLN0IZQlS
         sjy3DRyfGPmTJERbfPPKykAL2Cbq0IhFhFEQE8W6sSUuLWNzKlEGNLcJeTw2iIbzL9Mx
         aoGgfFYFc0quI+TfcpreDh7YuXC9T8/8vEb7E=
Received: by 10.150.243.10 with SMTP id q10mr4774923ybh.113.1281921021623;
        Sun, 15 Aug 2010 18:10:21 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm5900493ybk.13.2010.08.15.18.10.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 15 Aug 2010 18:10:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100816010652.GA22546@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153639>

Guard setup commands with test_expect_success, so they are easier
to visually skip over and get to the good part.  While at it:

 - use test_commit for brevity and reproducible object names;

 - use test_cmp instead of using the test builtin to compare the
   result of command substitution, for better output with -v on
   failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7606-merge-custom.sh |   66 ++++++++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/t/t7606-merge-custom.sh b/t/t7606-merge-custom.sh
index 52a451d..82045cd 100755
--- a/t/t7606-merge-custom.sh
+++ b/t/t7606-merge-custom.sh
@@ -1,46 +1,60 @@
 #!/bin/sh
 
-test_description='git merge
+test_description="git merge
 
-Testing a custom strategy.'
+Testing a custom strategy.
+
+*   (HEAD, master) Merge commit 'c2'
+|\
+| * (tag: c2) c2
+* | (tag: c1) c1
+|/
+* (tag: c0) c0
+"
 
 . ./test-lib.sh
 
-cat >git-merge-theirs <<EOF
-#!$SHELL_PATH
-eval git read-tree --reset -u \\\$\$#
-EOF
-chmod +x git-merge-theirs
-PATH=.:$PATH
-export PATH
+test_expect_success 'set up custom strategy' '
+	cat >git-merge-theirs <<-EOF &&
+	#!$SHELL_PATH
+	eval git read-tree --reset -u \\\$\$#
+	EOF
+
+	chmod +x git-merge-theirs &&
+	PATH=.:$PATH &&
+	export PATH
+'
 
 test_expect_success 'setup' '
-	echo c0 >c0.c &&
-	git add c0.c &&
-	git commit -m c0 &&
-	git tag c0 &&
-	echo c1 >c1.c &&
-	git add c1.c &&
-	git commit -m c1 &&
-	git tag c1 &&
-	git reset --hard c0 &&
+	test_commit c0 c0.c &&
+	test_commit c1 c1.c &&
+	git reset --keep c0 &&
 	echo c1c1 >c1.c &&
-	echo c2 >c2.c &&
-	git add c1.c c2.c &&
-	git commit -m c2 &&
-	git tag c2
+	git add c1.c &&
+	test_commit c2 c2.c
 '
 
 test_expect_success 'merge c2 with a custom strategy' '
 	git reset --hard c1 &&
+
+	git rev-parse c1 >head.old &&
+	git rev-parse c2 >second-parent.expected &&
+	git rev-parse c2^{tree} >tree.expected &&
 	git merge -s theirs c2 &&
-	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
-	test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
-	test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
-	test "$(git rev-parse c2^{tree})" = "$(git rev-parse HEAD^{tree})" &&
+
+	git rev-parse HEAD >head &&
+	git rev-parse HEAD^1 >first-parent &&
+	git rev-parse HEAD^2 >second-parent &&
+	git rev-parse HEAD^{tree} >tree &&
+	git update-index --refresh &&
 	git diff --exit-code &&
 	git diff --exit-code c2 HEAD &&
 	git diff --exit-code c2 &&
+
+	! test_cmp head.old head &&
+	test_cmp head.old first-parent &&
+	test_cmp second-parent.expected second-parent &&
+	test_cmp tree.expected tree &&
 	test -f c0.c &&
 	grep c1c1 c1.c &&
 	test -f c2.c
-- 
1.7.2.1.544.ga752d.dirty
