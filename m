From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X releases
Date: Tue,  2 Jun 2015 17:15:43 -0400
Message-ID: <1433279744-23379-2-git-send-email-sunshine@sunshineco.com>
References: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 23:16:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztXu-0007zy-UI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbbFBVQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:16:22 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34743 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbFBVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:16:04 -0400
Received: by ieczm2 with SMTP id zm2so143180862iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1y9w0p4zBvAmBCuw2XXG4QdreTQjfMbgqkN5OEgiqo=;
        b=FpBQzIFsjxq0xXulJqgw4mnuxtprNFkDEMxTmR8DFbXWnnlP6as/AEdUKwz568T4ek
         yo/AkHO2nJEe+lNjxDRuf8o0ZnEAW26N1tUmsPc5iSXQJ2BOMAM6nUgHZlMCx5PSTR81
         oeaJVfxG8Pjjt3xZjycnyEBML66MYIQ0kbNR147U2GLacxaEOkx26v99QfNVhQ0PJGty
         XJK6HWulNZNjGsiVsb1JDeJtpfPwEsNuPRMCQ8Fg1W/zmUU9DfxwFvKzmbDNqk/T4WFz
         wXQd0IZlWeH5/qZupxv/nR/Vc4X+ZV2xhq6NJg0ZCm5d+Z92gWdJ7u5Ws12hQPI4MyKy
         TTcA==
X-Received: by 10.43.76.195 with SMTP id zf3mr36287425icb.62.1433279763918;
        Tue, 02 Jun 2015 14:16:03 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id h128sm13302227ioh.38.2015.06.02.14.16.03
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jun 2015 14:16:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.674.gb037150
In-Reply-To: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270599>

On Mac OS X, getdelim() first became available with Xcode 4.1[1], which
was released the same day as OS X 10.7 "Lion", so assume getdelim()
availability from 10.7 onward. (As of this writing, OS X is at 10.10
"Yosemite".)

According to Wikipedia[2], 4.1 was also available for download by paying
developers on OS X 10.6 "Snow Leopard", so it's possible that some 10.6
machines may have getdelim(). However, as strbuf's use of getdelim() is
purely an optimization, let's be conservative and assume 10.6 and
earlier lack getdelim().

[1]: Or, possibly with Xcode 4.0, but that version is no longer
     available for download, or not available to non-paying developers,
     so testing is not possible.

[2]: http://en.wikipedia.org/wiki/Xcode

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 config.mak.uname | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index d26665f..943c439 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -102,6 +102,9 @@ ifeq ($(uname_S),Darwin)
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
 	endif
+	ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 11 && echo 1),1)
+		HAVE_GETDELIM = YesPlease
+	endif
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-- 
2.4.2.598.gb4379f4
