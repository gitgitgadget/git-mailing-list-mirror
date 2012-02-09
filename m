From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix build problems related to profile-directed optimization
Date: Thu, 09 Feb 2012 09:22:26 +0100
Message-ID: <4F338242.8080907@viscovery.net>
References: <20120206055750.GA6615@thunk.org> <1328508017-7277-1-git-send-email-tytso@mit.edu> <20120208185319.GB9397@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 09 09:22:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvPH6-0000ae-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 09:22:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977Ab2BIIWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 03:22:35 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61250 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab2BIIWe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 03:22:34 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RvPGt-0000ae-Mx; Thu, 09 Feb 2012 09:22:27 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 40CD31660F;
	Thu,  9 Feb 2012 09:22:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120208185319.GB9397@thunk.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190281>

Am 2/8/2012 19:53, schrieb Ted Ts'o:
> Junio, any comments on my most recent spin of this patch?  Any changes
> you'd like to see?

I need the following to unbreak my build on Windows.

--- >8 ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Makefile: fix syntax for older make

It is necessary to write the else branch as a nested conditional. Also,
write the conditions with parentheses because we use them throughout the
Makefile.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bfc5daa..01a3c77 100644
--- a/Makefile
+++ b/Makefile
@@ -1784,16 +1784,18 @@ endif
 # data gathering
 PROFILE_DIR := $(CURDIR)
 
-ifeq "$(PROFILE)" "GEN"
+ifeq ("$(PROFILE)","GEN")
 	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
 	EXTLIBS += -lgcov
 	export CCACHE_DISABLE=t
 	V=1
-else ifneq "$(PROFILE)" ""
+else
+ifneq ("$(PROFILE)","")
 	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
 	export CCACHE_DISABLE=t
 	V=1
 endif
+endif
 
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
-- 
1.7.9.1420.gae2d6
