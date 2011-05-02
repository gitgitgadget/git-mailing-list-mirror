From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] grep: add known breakage of coloring when using extended patterns
Date: Mon,  2 May 2011 13:35:40 +0200
Message-ID: <328649cbd9fe7f2ee5f43d1e860d712f4204bdc5.1304333975.git.bert.wesarg@googlemail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Thiago dos Santos Alvest <hiago.salves@gmail.com>,
	git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon May 02 13:35:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGrPs-0007Fw-KK
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 13:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758185Ab1EBLfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 07:35:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60651 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab1EBLfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 07:35:46 -0400
Received: by bwz15 with SMTP id 15so4518687bwz.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=E2zGjOSSYVVUYLF1ZscZ142wJVrZdcWNC3b+aQp3lbg=;
        b=FvpAzMbNLS3NIwl1ksnI27qg7Hp5aXLzM665Jdxr3kT2Jh3x0vubLsISHqKSGxl6M3
         ECm+KT7nTSawbJGmCZfQSooKcg1EJF/LkyVeMyRT6nqW8RV9xYyNkKc/mEB29Mc6+XHZ
         Q2KxVOtN8UAgsj8FT4i1ubhUuAGw/siKu/YOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xfx/1DIfxt9Wz8xi1V/wJawajnIVGItouMnTvOgyw7Q+WJ6A0m/sW7/kHiTL+UFyP1
         lVWII+1Hh/0ya8wpIKWZWrfQzMB7MpZ/CFxIhyp5NeYruDW5Jvt72NgQWJ7Z8oMILgHY
         39iTW1NN++TX4NG/wGG5QBiJiHzVA97jM9ovE=
Received: by 10.204.15.139 with SMTP id k11mr2916275bka.49.1304336143872;
        Mon, 02 May 2011 04:35:43 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de [141.30.68.111])
        by mx.google.com with ESMTPS id q18sm3239258bka.3.2011.05.02.04.35.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 04:35:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.349.gfeb1a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172569>

The coloring code does not respect the extended pattern format, expose
this with an known breakage test.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 t/t7812-grep-color.sh |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100755 t/t7812-grep-color.sh

diff --git a/t/t7812-grep-color.sh b/t/t7812-grep-color.sh
new file mode 100755
index 0000000..2cffff3
--- /dev/null
+++ b/t/t7812-grep-color.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+test_description='git grep --color
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit initial input "foo bar baz
+bar baz
+"
+'
+
+cat >expected <<EOF
+input<CYAN>:<RESET><BOLD;RED>foo<RESET> bar baz
+EOF
+
+
+test_expect_failure 'grep coloring does not honor boolean algebra' '
+	git grep --color -e foo --or \( -e bar --and --not -e baz \) |
+		test_decode_color >actual
+    test_cmp expected actual
+'
+
+test_done
-- 
1.7.5.349.gfeb1a
