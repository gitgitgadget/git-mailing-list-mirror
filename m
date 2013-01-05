From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 08/10] test: add test for --use-mailmap option
Date: Sat,  5 Jan 2013 22:26:44 +0100
Message-ID: <1357421206-5014-9-git-send-email-apelisse@gmail.com>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:28:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbHa-0000ix-L4
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3AEV1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:27:32 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:57331 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab3AEV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:27:22 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so8725759wgb.9
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=iUhMNRnQm2BObXvgOiSMQgjfM3BoDYRmCAzjp2iQ9Lc=;
        b=Kl7Bg0BEeDZcKszABeooVfg8naFDg9WkaT1OZrlyAqiqhfSrpQgsETLCIJj2CVzAjO
         odz8zFqsm/eT2fQEohXhUTaYLbCiWzKPv4xJLuCqGZhhTt6FLM+FYQRivw2Yw2KIJlOU
         7G0QnnAU7igBOJOwsmDwziT92/YZkknITXarfdPhXaTwdz7CGQKzST0J61uN1uuKkr/D
         GAwBq91AdMc92+trdkvxyYu2IRj3G1XmlZBkZgkc3MuXzcrzpOspjwUIQgtRTSXaXaXP
         PMkxtYGF11RbJir93q+gDylMq+Ja80meno00rlAVUdbduDCc76KgZVFJLyinR5gaG5l4
         dyQQ==
X-Received: by 10.180.87.102 with SMTP id w6mr3153427wiz.19.1357421241598;
        Sat, 05 Jan 2013 13:27:21 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id t17sm5623711wiv.6.2013.01.05.13.27.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 13:27:21 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.15.g5ddde70
In-Reply-To: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212720>

The new option '--use-mailmap' can be used to make
sure that mailmap file is used to convert name
when running log commands.

The test is simple and checks that the Author line
is correctly replaced when running log.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 t/t4203-mailmap.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..db043dc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -239,6 +239,20 @@ test_expect_success 'Log output (complex mapping)' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Author: CTO <cto@company.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Other Author <other@author.xx>
+Author: Other Author <other@author.xx>
+Author: Some Dude <some@dude.xx>
+Author: A U Thor <author@example.com>
+EOF
+test_expect_success 'Log output with --use-mailmap' '
+	git log --use-mailmap | grep Author >actual &&
+	test_cmp expect actual
+'
+
 # git blame
 cat >expect <<\EOF
 ^OBJI (A U Thor     DATE 1) one
-- 
1.7.12.4.3.g2036a08.dirty
