From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] autoconf: Fix NEEDS_SSL_WITH_CRYPTO detection
Date: Fri, 4 Aug 2006 23:28:58 +0200
Message-ID: <200608042328.58539.jnareb@gmail.com>
References: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Aug 04 23:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97PM-0005gS-T9
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161495AbWHDVkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWHDVkf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:40:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:13233 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161495AbWHDVke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 17:40:34 -0400
Received: by nf-out-0910.google.com with SMTP id k26so30467nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:40:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OdQXPUofxaH1IJ5zP2RRsVlHIUf13vABQX4Zdh4P2jVI1qTVCCzHrzb7G2KQ4DSpyfyd09g1PoNEtLsgDVmi2Oy/it8xbgMOW1JY0NSaInLahJKd9LzTRaE2kmz7B4lGIo1QX0m2NCuoxWHde3BiANrnkaioCFD5wp2br/HYFFY=
Received: by 10.49.8.1 with SMTP id l1mr6007996nfi;
        Fri, 04 Aug 2006 14:40:33 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r34sm1038674nfc.2006.08.04.14.40.32;
        Fri, 04 Aug 2006 14:40:32 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608042333.19011.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24846>

>From 7829f2f76c429594602d845168841d378d269fba Mon Sep 17 00:00:00 2001
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 4 Aug 2006 13:06:33 -0700
Subject: [PATCH 3/5] autoconf: Fix NEEDS_SSL_WITH_CRYPTO detection

NEEDS_SSL_WITH_CRYPTO means you cannot just say "-lcrypto" to
use SHA1 stuff, but need to say "-lcrypto -lssl", so the test
should say "if we can get away with -lcrypto, we are happy,
otherwise if we need -lssl, then say NEEDS_SSL_WITH_CRYPTO,
otherwise we cannot use OpenSSL so say NO_OPENSSL", or something
like that.

Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 61c9fa3..a49bd1f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -154,8 +154,8 @@ AC_MSG_NOTICE([CHECKS for libraries])
 #
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
-AC_CHECK_LIB([ssl], [SHA1_Init],[],
-[AC_CHECK_LIB([crypto], [SHA1_Init],
+AC_CHECK_LIB([crypto], [SHA1_Init],[],
+[AC_CHECK_LIB([ssl], [SHA1_Init],
  [GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease)],
  [GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease)])])
 #
-- 
1.4.1.1
