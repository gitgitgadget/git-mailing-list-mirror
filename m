Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39AB1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeKGFaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:30:05 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:38004 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbeKGFaF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Nov 2018 00:30:05 -0500
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 00:30:03 EST
Received: from mxback11j.mail.yandex.net (mxback11j.mail.yandex.net [IPv6:2a02:6b8:0:1619::84])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 2BB874447DC5;
        Tue,  6 Nov 2018 22:55:06 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback11j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id fe2TosY9WM-t5hCjEOQ;
        Tue, 06 Nov 2018 22:55:06 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1541534106; bh=cl0Si/0vX8t8P0rOchaUiLDrp3VBhNrx1OQBM0fki7w=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=RByQUnnAY4XVCplK7g673C4neGLJW3fFhTY5TMKQVBMq3usnwqfEo+V597kjoK3+9
         yT7abAMSVwnXQ8sKqujm4NpC57jJkNWD3qnKmgfA0iJLCrQg3UekTQna1a8UdTAdFI
         FmcdnouMCf3nLQc2tfEPQtrnFxLKZ5zj2/smZvvU=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id RpBnGmS4CZ-t4Ie20pR;
        Tue, 06 Nov 2018 22:55:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1541534104; bh=cl0Si/0vX8t8P0rOchaUiLDrp3VBhNrx1OQBM0fki7w=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=Cn8n8jWBZOQbUtMrSybh9zBONXYO1wShc/xR22Z/SB9ko9YTNhvFSOK4Xb9EON/EQ
         M2pk7cvWk0Iuo+5MeN5bg3IOMOlcHxudH2FtBTA7YvOw3TzVKhqZYOobojAZro7o9B
         Mn2czY2l3pmFak8/sL36krwHHqLgeGpIxrpNeQQY=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
From:   =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
        <dpb@corrigendum.ru>
To:     git@vger.kernel.org
Cc:     paulus@ozlabs.org,
        =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87?=
         =?UTF-8?q?=D0=B5=D0=BD=D0=BA=D0=BE?= <dpb@corrigendum.ru>
Subject: [PATCH] gitk: don't highlight submodule diff lines outside submodule diffs
Date:   Tue,  6 Nov 2018 22:54:17 +0300
Message-Id: <20181106195417.5456-1-dpb@corrigendum.ru>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A line that starts with "  <" or "  >" is not necessarily a submodule
diff line. It might just be a context line in a normal diff, representing
a line starting with " <" or " >" respectively.

Use the currdiffsubmod variable to track whether we are currently
inside a submodule diff and only highlight these lines if we are.

Signed-off-by: Роман Донченко <dpb@corrigendum.ru>
---
 gitk | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index a14d7a1..6bb6dc6 100755
--- a/gitk
+++ b/gitk
@@ -8109,6 +8109,8 @@ proc parseblobdiffline {ids line} {
 	}
 	# start of a new file
 	set diffinhdr 1
+	set currdiffsubmod ""
+
 	$ctext insert end "\n"
 	set curdiffstart [$ctext index "end - 1c"]
 	lappend ctext_file_names ""
@@ -8191,12 +8193,10 @@ proc parseblobdiffline {ids line} {
 	} else {
 	    $ctext insert end "$line\n" filesep
 	}
-    } elseif {![string compare -length 3 "  >" $line]} {
-	set $currdiffsubmod ""
+    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  >" $line]} {
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" dresult
-    } elseif {![string compare -length 3 "  <" $line]} {
-	set $currdiffsubmod ""
+    } elseif {$currdiffsubmod ne "" && ![string compare -length 3 "  <" $line]} {
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" d0
     } elseif {$diffinhdr} {
-- 
2.19.1.windows.1

