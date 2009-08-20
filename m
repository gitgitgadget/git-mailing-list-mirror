From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 09/19] excluded_1(): support exclude files in index
Date: Thu, 20 Aug 2009 20:47:03 +0700
Message-ID: <1250776033-12395-10-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81H-0007ZS-LC
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669AbZHTNsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbZHTNsK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:32782 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZHTNsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:09 -0400
Received: by wa-out-1112.google.com with SMTP id j5so957051wah.21
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oF6e5EQv/d78t0nqRsyToohZ8D1Iox3lEQalFLo2/Tw=;
        b=ooOCj4lhpl+V/l8g7+iexEWnZa8+scVStX/bKeQZeloH+eBL/ltB4BaHHPqFn2OUhp
         dylgtkcfDXpKTAZHpEu0TZNAvmn0UI//sKzFfiY/AC4nHOcesgimZ8GMXqkNdMW4i0eE
         XD+YpI+B3WcUK+4EleKIynh1aNliqzVtSuRDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Sq1DDFctSlXYI9htZ+C8hqSPohUpTPwuySrvV7r2y07RGHfKKo6sbYNnumAz7AcAZ5
         wOBg+LlHtCLAzA9gNSrDP2zBvXm6k0jxBgDUCSMrPH362aj4P0OqY7LClcIpxhClrUF7
         CTkB6XXwYqxWblzwXYKkF16FlkfsIaObMpFTo=
Received: by 10.115.101.10 with SMTP id d10mr9327705wam.61.1250776090993;
        Thu, 20 Aug 2009 06:48:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 23sm186489pzk.12.2009.08.20.06.48.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:05 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-9-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126632>

Index does not really have "directories", attempts to match "foo/"
against index will fail unless someone tries to reconstruct directories
from a list of file.

Observing that dtype in this function can never be NULL (otherwise
it would segfault), dtype NULL will be used to say "hey.. you are
matching against index" and behave properly.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/dir.c b/dir.c
index cda2556..a4a91d5 100644
--- a/dir.c
+++ b/dir.c
@@ -349,6 +349,12 @@ static int excluded_1(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
+				if (!dtype) {
+					if (!prefixcmp(pathname, exclude))
+						return to_exclude;
+					else
+						continue;
+				}
 				if (*dtype =3D=3D DT_UNKNOWN)
 					*dtype =3D get_dtype(NULL, pathname, pathlen);
 				if (*dtype !=3D DT_DIR)
--=20
1.6.3.GIT
