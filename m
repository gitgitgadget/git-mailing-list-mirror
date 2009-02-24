From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add tests for git log --pretty, --format and --oneline.
Date: Tue, 24 Feb 2009 23:06:37 +0200
Message-ID: <1235509597-18336-1-git-send-email-felipe.contreras@gmail.com>
References: <7vljrvhh13.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 22:08:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc4Vg-0008UO-S9
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932AbZBXVGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbZBXVGp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:06:45 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39896 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781AbZBXVGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:06:44 -0500
Received: by bwz5 with SMTP id 5so6166634bwz.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=b/OYHxIzaJsJ6mBYhLxcEHR3ybBe1nSHO3twtmpsQMg=;
        b=ceMCeqDwgHgeLgXmjCSGRdSO1DcGO06HTUUYREi+X7mq1+qwZ93BZdnGu4DSik2Py8
         jr9QdenEZn6jaV0eLpsiF/ju17m5UM1ynhJM5zl1FdL6fn8qKtl2MfbF7TkObCT+3Chl
         r7dKO2eR3Xfl/1D+a/pMHyTLVnlVBMsg5879Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uvzJQE1RBQfETVHDapT+hr3WxvnBinZH+Iz1r/v8rXwPz6JOS1emcWoNKbDftBGQxO
         V6ou4dYU9lnFqT5kzEdtSvB5VVffNFV5JjVohS518Ca0t/cmV8ZvqDdYPJ0lnxqJhq8o
         4VW4pNOnAlYQj3gDsW1kiYa0za2dbxkEfyg60=
Received: by 10.223.113.136 with SMTP id a8mr96208faq.76.1235509600425;
        Tue, 24 Feb 2009 13:06:40 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 22sm11227644fkr.34.2009.02.24.13.06.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 13:06:39 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <7vljrvhh13.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111339>

More specifically; --pretty=format, tformat and new %foo shortcut.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4202-log.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 7b976ee..f1287fe 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -37,6 +37,46 @@ test_expect_success setup '
 
 '
 
+echo -ne "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
+test_expect_success 'pretty' '
+
+	git log --pretty="format:%s" > actual &&
+	test_cmp expect actual
+'
+
+echo -ne "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
+test_expect_success 'pretty (tformat)' '
+
+	git log --pretty="tformat:%s" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pretty (shortcut)' '
+
+	git log --pretty="%s" > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format' '
+
+	git log --format="%s" > actual &&
+	test_cmp expect actual
+'
+
+cat > expect << EOF
+804a787 sixth
+394ef78 fifth
+5d31159 fourth
+2fbe8c0 third
+f7dab8e second
+3a2fdcb initial
+EOF
+test_expect_success 'oneline' '
+
+	git log --oneline > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'diff-filter=A' '
 
 	actual=$(git log --pretty="format:%s" --diff-filter=A HEAD) &&
-- 
1.6.1.3
