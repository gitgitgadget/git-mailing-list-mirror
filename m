From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/2] t: mailmap: add missing 'git blame -e' tests
Date: Wed, 15 Feb 2012 01:32:27 +0200
Message-ID: <1329262348-9546-2-git-send-email-felipe.contreras@gmail.com>
References: <1329262348-9546-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 00:33:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxRsK-0001w0-0t
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 00:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761340Ab2BNXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 18:33:28 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:50956 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761336Ab2BNXd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 18:33:26 -0500
Received: by mail-lpp01m020-f174.google.com with SMTP id m4so236946lbo.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 15:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eyFPnRZUkMGGJSYLBb9Nh42uZg0DQx1IA7KK7HACFWM=;
        b=CwUOU+ZK4kkp4SZFiakqUlf1rQCYfbnVCNo/MLYHSoLIE3ZXgGdftaCulCEVXYfyhC
         JG28O5mk9hZhZzJXBZ0zBUfvXGjPXeyS71XJTaDJ/ioPYcaHgT+/9DZiWUnSwOwuhDqE
         gpoB7vfHQGCPIry+RRf3zzVMTWFDM0B/1DYAI=
Received: by 10.152.148.106 with SMTP id tr10mr16319075lab.41.1329262406004;
        Tue, 14 Feb 2012 15:33:26 -0800 (PST)
Received: from localhost (a91-153-255-128.elisa-laajakaista.fi. [91.153.255.128])
        by mx.google.com with ESMTPS id mc3sm972880lab.12.2012.02.14.15.33.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 15:33:25 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1329262348-9546-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190798>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4203-mailmap.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..ec5d98c 100755
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
+test_expect_success 'Blame show email output (complex mapping)' '
+	git blame -e one >actual &&
+	cp actual /tmp &&
+	cp internal_mailmap/.mailmap /tmp &&
+	fuzz_blame actual >actual.fuzz &&
+	test_cmp expect actual.fuzz
+'
+
 test_done
-- 
1.7.9
