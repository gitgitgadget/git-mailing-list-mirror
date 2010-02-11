From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] Add is_root_path()
Date: Thu, 11 Feb 2010 21:43:21 +0700
Message-ID: <1265899403-15904-4-git-send-email-pclouds@gmail.com>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:54:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaQw-0003xV-VT
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0BKOyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:54:14 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:53462 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab0BKOyN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:54:13 -0500
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 09:54:06 EST
Received: by mail-yx0-f196.google.com with SMTP id 34so1205993yxe.16
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BHSzEC6pdryRsljZSrAyIX5/UymFGjqln4pK1/qnrr4=;
        b=NVdDt7Lc8RlWXm/cJ54v0Xp44MqjginVg7iGw+Ytna75t+zsLs8ZhuzdqCP4eqgaTy
         KNu55Pzn3HoNNodUyj8P7aHfI4VVFPK8bNjYLkLKtMkbDdx01AA+sVtsZfUITN5xOO85
         +ubtJO3Zign6NPJSguT94jh9nieGaXBYGFN24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KiqMVjxuAnoK4DZw3/5iv3IrCDN/mOgzf1BLDSEQPg70RzhiZge9Ub8/dLB4fhQOQL
         SwInpygf7clPzYxq3DxC6WVMQLRuYJzzPzQ+ef+DMQ72+A+0fwWj0eU3Orm4jVJuAyU+
         s+GyhLN/1DAcGD16VoChYhz2yteyaNwfKc0nk=
Received: by 10.150.128.29 with SMTP id a29mr291300ybd.243.1265899586483;
        Thu, 11 Feb 2010 06:46:26 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 23sm936749ywh.3.2010.02.11.06.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:45 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139598>

This function returns the length of the root part of a path, or zero if
there is no root.

"The root part" is the leading slash on Linux/Unix, or 'C:/' on Windows=
=2E

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ... and can be extended to recognize "//machine/share/" as a root part=
?

 git-compat-util.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..4d0398d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -210,6 +210,17 @@ static inline const char *skip_prefix(const char *=
str, const char *prefix)
 	return strncmp(str, prefix, len) ? NULL : str + len;
 }
=20
+/* path must be canonical */
+static inline int is_root_path(const char *path)
+{
+	int len =3D 0;
+	if (has_dos_drive_prefix(path))
+		len +=3D 2;
+	if (is_dir_sep(path[len]))
+		len++;
+	return len;
+}
+
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
=20
 #ifndef PROT_READ
--=20
1.7.0.rc2.182.g3adef
