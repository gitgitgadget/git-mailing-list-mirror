From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Revert "excluded_1(): support exclude files in index"
Date: Sat, 27 Nov 2010 01:17:47 +0700
Message-ID: <1290795467-7570-6-git-send-email-pclouds@gmail.com>
References: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>, tfransosi@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 26 19:19:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM2td-0003TJ-Cz
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab0KZSTm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 13:19:42 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:54970 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZSTl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:19:41 -0500
Received: by mail-pz0-f66.google.com with SMTP id 26so481191pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 10:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lM8ZFkDz9y4dn9WZ2nYVIAfCPl9DPwJGND5I5nJpC9U=;
        b=iJMe71zgOw+ZWrrph9atFZTOBSTmxyT/GmP2xdfVR+qvzvqjiqIRd/3ZXqVqysJXhR
         jquFMUFHWVTuX5nYA3HfGEXzVyzZ/XhniJM05JY8NcWEObhaELrwb8ZQBlGTSKjGPG3o
         tw+438OPn1z16qcCEDKTj51LXpFz8Tm8pfYWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YbHWpbU9AeN2e7fWHcxPZ36WPRkNALH2n5n1E3Ne2049bR04rNrdALMvsDkxnuNC6B
         BE4hmaNuCmMq3W0ev+cQBU3Cn/QKE6ZbXE+u20Hbc3zOwQUiqkM4Jnyo9eCQkaLppJhy
         d6PB2FRnfQLlmzAMpcGMSjNPGnAhdPYTuk7Us=
Received: by 10.142.234.1 with SMTP id g1mr2737403wfh.142.1290795581696;
        Fri, 26 Nov 2010 10:19:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id e14sm2858994wfg.20.2010.11.26.10.19.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 10:19:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Nov 2010 01:18:38 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162270>

This reverts commit c84de70781674a35b9bfd20aa5bc8c47582615df.
The commit provided a workaround for matching directories in
index. But it is no longer needed.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 39eb7a3..d059aa1 100644
--- a/dir.c
+++ b/dir.c
@@ -371,13 +371,6 @@ int excluded_from_list(const char *pathname,
 			int to_exclude =3D x->to_exclude;
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
-				if (!dtype) {
-					if (!prefixcmp(pathname, exclude) &&
-					    pathname[x->patternlen] =3D=3D '/')
-						return to_exclude;
-					else
-						continue;
-				}
 				if (*dtype =3D=3D DT_UNKNOWN)
 					*dtype =3D get_dtype(NULL, pathname, pathlen);
 				if (*dtype !=3D DT_DIR)
--=20
1.7.3.2.316.gda8b3
