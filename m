From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] autoconf: Set NO_ICONV if iconv is found neither in libc, nor in libiconv
Date: Thu, 7 Sep 2006 13:48:08 +0200
Message-ID: <200609071348.08808.jnareb@gmail.com>
References: <200609071347.32152.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 07 13:48:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLING-0004c8-N3
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 13:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWIGLss (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 07:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWIGLss
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 07:48:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:63771 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWIGLsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 07:48:46 -0400
Received: by nf-out-0910.google.com with SMTP id o25so422617nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 04:48:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mbN0CUnk+dCpJMUnOUAJsg4Aw+YWnFYHTnLiPE3O3L3nKp5Tdf4VAQXej9vI1fjypzSB1oU0I04U+hT/PGWRyJsaW+57PAn1kjW2CgxHoIZ8eIHj52irIBC/DAx/if1lmsMkIQRbC+cGBZh5KOPFGCU4ddD2Tf6vxi8uABJGcAs=
Received: by 10.49.10.3 with SMTP id n3mr2379498nfi;
        Thu, 07 Sep 2006 04:48:35 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id c10sm3234658nfb.2006.09.07.04.48.35;
        Thu, 07 Sep 2006 04:48:35 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609071347.32152.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26627>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch only adds NO_ICONV=YesPlease, and it never unsets
NO_ICONV. This doesn't matter now because there is no setting
NO_ICONV value in Makefile (no architecture/system based detection).

 configure.ac |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 482c849..8af276c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -143,9 +143,12 @@ AC_CHECK_LIB([expat], [XML_ParserCreate]
 AC_SUBST(NO_EXPAT)
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
+# Define NO_ICONV if neither libc nor libiconv support iconv.
 AC_CHECK_LIB([c], [iconv],
-[NEEDS_LIBICONV=],
-[NEEDS_LIBICONV=YesPlease])
+	[NEEDS_LIBICONV=],
+	AC_CHECK_LIB([iconv], [iconv],
+		[NEEDS_LIBICONV=YesPlease],
+		[GIT_CONF_APPEND_LINE([NO_ICONV=YesPlease])]))
 AC_SUBST(NEEDS_LIBICONV)
 test -n "$NEEDS_LIBICONV" && LIBS="$LIBS -liconv"
 #
-- 
1.4.2
