From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 01/20] mingw: let's use gettext with MSYS2
Date: Wed, 27 Jan 2016 17:19:07 +0100 (CET)
Message-ID: <8ac78eac5606d74d8c62bcdb2b0346f4a9b0a9a4.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:19:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSoe-00021T-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933663AbcA0QT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:19:26 -0500
Received: from mout.gmx.net ([212.227.17.22]:51257 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbcA0QTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:19:20 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lyi0B-1a4A7n30jf-0167BF; Wed, 27 Jan 2016 17:19:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:9UbYI67kyPdyk7X41VtLiEFHINDjM1zYH8F49sD5SdQM7k+fuz3
 zBBgQLtFgbwZntUxuRWGhnVbllpJDJ/J60bCrt9WooQM+h3phwNRIWdGZmXhRd/ngm96QC8
 4GqlgFt1C/oN3av+RnVRx/J63r9mGO+78Zpx8TgknKEz78+R9V4XMmZ+gLR8XguemXNU8JZ
 h8WrAFDkvAtm5l2emjfTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YbHq4piPi1c=:HQy5aUYJsjAL0G5Lpyvf2S
 cQzss5UEGG22t7lNVHVSJFP91GtgzOdTsvqofQTPRY6l2kvTGa4MllXkWfKSwJTkAviSHj53U
 gB6yjNrzuHvod69wT2EyRzSVYNXs6RCNkpWZuplXMyMUUeumlt5dGB5MvP0rG8sqM9RQ/IzjR
 g1P3ENczx26oREggYA++RCGuehKJa10mAJwxDt3k0uJ1ePIcyG6wLGaesivBYyjJanceX8VC9
 kdNVrkH88I9wqvtQcQVmxouxTW7JF8Sz0f0dyAgRs+DjdVIS9++wAiU2DuegKsjVrtE2D5hHb
 cTeTzfYAuLcSJE5Uwhf1pJ4C2R2m1DjFMah52liZoMQXk1inFfVZvIQ7i53chngEWiAcKoYeU
 E8A/rfsHeqq3LBawA78vFjqT52+12Vg6yMgtzNmUTEIKLqTGFAZCgNJP7yR7FHNEg9rBR3Xwe
 exfOaFbmrQtPtxHXE426quImfERLc50fBML8Pf7pIjxuGrXRsNNxJX+tqKmJRK9gfjL6mG87N
 ZSur+YPpNyUuvXGmGAaC/NUnFGFIxhaGsaZlLJMPkrfk5glVbNwWsXJqj2NSXTXIb8BSCZ3GY
 CW3xsxHWSL8iyT78QT0A2or3ZHEVMuUtwK1sX+409BTQCx/Y9sI79YqUmkRI7CQGyDR6bUj2x
 bJWooRC2+mVrTnueasjU/N/EkvAlpjYtmSPWyKHRuf52Piq4NCLyCar+EIBjwS/HBhJESi82J
 YsEI5oGevf28Vqkkjl2h9Ybgb25HDP8h3TakQl669F4igS4WPEmnNADa8URpwZ59r2MsnGPF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284921>

This solves two problems:

- we now have proper localisation even on Windows

- we sidestep the infamous "BUG: your vsnprintf is broken (returned -1)"
  message when running "git init" (which otherwise prevents the entire
  test suite from running) because libintl.h overrides vsnprintf() with
  libintl_vsnprintf() [*1*]

The latter issue is rather crucial, as *no* test passes in Git for
Windows without this fix.

Footnote *1*: gettext_git=http://git.savannah.gnu.org/cgit/gettext.git
$gettext_git/tree/gettext-runtime/intl/libgnuintl.in.h#n380

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index 4b2e1b8..6b25661 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -560,7 +560,7 @@ else
 		NO_R_TO_GCC_LINKER = YesPlease
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
-		NO_GETTEXT = YesPlease
+		NO_GETTEXT =
 		USE_LIBPCRE= YesPlease
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
-- 
2.7.0.windows.1.7.g55a05c8
