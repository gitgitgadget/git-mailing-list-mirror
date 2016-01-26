From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 01/19] mingw: let's use gettext with MSYS2
Date: Tue, 26 Jan 2016 15:34:16 +0100 (CET)
Message-ID: <4473801e86c03bd48b79806029b61a3ba761d067.1453818790.git.johannes.schindelin@gmx.de>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 15:37:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO4k2-0005jG-0I
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 15:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966081AbcAZOhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 09:37:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:63833 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965973AbcAZOeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M5a9E-1aD21p1YDo-00xbz2; Tue, 26 Jan 2016 15:34:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SlE/FmL2mb4TtMgyWd70cfgkhQ1QDhtBNutv3Uz/abJXR5SOFCo
 iAJ6BTAJFjhmb0Lh7ELCBSNPs5t9Xj68B0vlIc645UDX2LTs0rCn+zKF8pERd1fn+DR5+r0
 zdpnpKlcupOblqYCXm3FVdMrhJVaT1zpjBRjOTs51ClsLW07JFNF31augllN9idhYHeSeKz
 cL6HYBuSyoqtQMsKaqsHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oKPlWft5Cik=:oShtFg90JJiCvekJaogzSy
 BRj+iqo19Y2gqa38fM0lDaC0dCwiqq2sfa8G9FER9kgXLmKmHsvmLcaJusrcdU/aS/lOpc00o
 znvK1+5Qg2yMkeZqdBRbXBliHOB31DGUjayibXxG62eHFSwSY4el5D+Kmehtb8fiag/kw00qo
 pIoCWW1C843rfKsCEmrOKyg2IbztwhhY3B4pJOLOen/OImUXmyrvCdkC/FBPDCgbsPa3WWuK2
 vN9d6Eq4a9h8f03klTM1dzqjOeO6LAGbVnfD3mzVsDfkzKdQyMlTgs2iFEJFZ9AjCYSqAWIxu
 ZozHhTM8HWKy9HqDlpHVpY40KWFQeStTqSZCof9RsBkW+y19GPiIpHnL5ccWN2UR5198+pm1y
 hPx+SPtgmidx5RoakLAPJwFNgCLrHoaTXls/hWo5iucJyfEF5X06+FDs/pdry2GxEUzqIMpB0
 eteSf9ppW37Gzlw4DnaWpkWSHOH38J6GF9Z3pV0MrLqR4PNJS96rTRI1ffuAjlfQ75yJd7HAp
 ri3hx7kZ4gY7cN6mynLCkXgBfyQqLcvrzorK3dRcIGGyS8h81+iLoPBZBaGz0gvms4iA1PJxZ
 3vtKU/pCQYCf7kXzd8IMaZRRcC+AlhL9KKBtWcvqnWchs2eWo/zR7I5sPBwU++NceFYC70IkF
 BVSVIEiyTOXO3fcKOspXpRy4hJEaepLGCwQYmX/kHYYY8Vj7YflevavDKqQz3GyE8aUegHw45
 yOlTIbGBlxzBPaJJFHZPTz7XAv87131ssbmQ1ZRdaBSNSlW5RdBDyEOibOPQk6bxWXA3Co5H 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284833>

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
