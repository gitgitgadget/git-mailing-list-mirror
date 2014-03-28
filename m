From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH v2] MSVC: define INLINE=__inline so simple `make MSVC=1` actually works
Date: Fri, 28 Mar 2014 11:33:51 +0400
Message-ID: <1395992031-27200-1-git-send-email-marat@slonopotamus.org>
References: <xmqqzjkbegdt.fsf@gitster.dls.corp.google.com>
Cc: Marat Radchenko <marat@slonopotamus.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 08:34:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTRJ0-0005py-VR
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 08:34:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaC1HeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 03:34:17 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:35787 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaC1HeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 03:34:16 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WTRIq-0002MP-Oe; Fri, 28 Mar 2014 11:34:13 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <xmqqzjkbegdt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245368>

Without this, xdiff/xutils.c fails to compile.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---

I thought about removing #define inline __inline from compat/msvc.h but:

 * compat/msvc.h is included based on #if defined(_MSC_VER)
   and can be enabled even if MSVC != 1
 * compat/msvc.h also has #define __inline__ __inline and I don't see
   a nice way to handle both of them in config.mak.uname

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6c7b904..38c60af 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -355,6 +355,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	INLINE = __inline
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
-- 
1.9.1
