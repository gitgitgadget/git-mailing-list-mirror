From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] t: mailmap: add 'git blame -e' tests
Date: Tue, 14 Feb 2012 18:11:33 +0200
Message-ID: <1329235894-20581-2-git-send-email-felipe.contreras@gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 17:12:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxKzp-00034t-LB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 17:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab2BNQMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 11:12:44 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34475 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756300Ab2BNQMh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 11:12:37 -0500
Received: by lagu2 with SMTP id u2so116492lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ogUDWuLas9F7GAWS2I+LthqoGyZxMaUsdSS9yr4jhi4=;
        b=FX9z4ueeq0NM4YYLd3XqLiTFE6zrmLFdal0SrzfukEFXMNijOcyLl8AGkxxxE6fQqS
         i/5CA9o0KWfZmsSakoJgG9G6y4pqIsetYCkdbsPN300zzuAM6kqHKQYNpY6GKURkfE/3
         UUiWkmKCG66OPcguKOlf+yXo8a2jFIyESuzt0=
Received: by 10.152.145.137 with SMTP id su9mr14841913lab.23.1329235955772;
        Tue, 14 Feb 2012 08:12:35 -0800 (PST)
Received: from localhost (a91-153-255-128.elisa-laajakaista.fi. [91.153.255.128])
        by mx.google.com with ESMTPS id os5sm16508406lab.13.2012.02.14.08.12.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 08:12:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
In-Reply-To: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190725>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4203-mailmap.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..db12265 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -255,4 +255,22 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+# git blame -e
+cat >expect <<\EOF
+^OBJI (<author@example.com>       DATE 1) one
+OBJID (<some@dude.xx>             DATE 2) two
+OBJID (<other@author.xx>          DATE 3) three
+OBJID (<other@author.xx>          DATE 4) four
+OBJID (<santa.claus@northpole.xx> DATE 5) five
+OBJID (<santa.claus@northpole.xx> DATE 6) six
+OBJID (<cto@company.xx>           DATE 7) seven
+EOF
+test_expect_success 'Blame output (complex mapping)' '
+	git blame -e one >actual &&
+	cp actual /tmp &&
+	cp internal_mailmap/.mailmap /tmp &&
+	fuzz_blame actual >actual.fuzz &&
+	test_cmp expect actual.fuzz
+'
+
 test_done
-- 
1.7.9.1.g97f7d
