From: =?us-ascii?B?PT9VVEYtOD9xP05ndXk9RTE9QkI9ODVuPTIwVGg9QzM9QTFpPTIw?=
	 =?us-ascii?B?Tmc9RTE9QkI9OERjPTIwRHV5Pz0=?= <pclouds@gmail.com>
Subject: [PATCH v3 3/5] Move offset_1st_component() to path.c
Date: Tue, 16 Feb 2010 12:22:08 +0700
Message-ID: <20100216052208.GA18438@do>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com> <1266162285-10955-3-git-send-email-pclouds@gmail.com> <4B79A3ED.4090308@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Carlos_Mendes_Lu=EDs?= <jonny@jonny.eng.br>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 06:25:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhFve-0002b6-6e
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 06:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090Ab0BPFYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 00:24:52 -0500
Received: from mail-px0-f191.google.com ([209.85.216.191]:54503 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab0BPFYv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 00:24:51 -0500
Received: by pxi29 with SMTP id 29so1546764pxi.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 21:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Qd/DYxT4DZBQg0h0Mw3jP6M/FY91CxAnrPSDcfCyX0=;
        b=g4z1JAJkEd38H0UlpY9EVGLqbau+a0s4sVEVsq59LdTmTjvAb/mU1y32AZUaxyfVhR
         lmR0muNS3Sf0YcChBinASHERG234fmugUJExnjq+u12fSe/f3Fcex/hQX3IKg7HocCJG
         515ykzAd/XP+wa0Yk6xBnRL6aWXzitEUjY4Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=e5OHD8U7SCBvLAfwElNxxyohpeZPOQQRE7YBAe/yO0K2tkebI4VVWjX1k6I5VOUfkq
         l7SjxjPymumkPF9sVnOTacpiz8KhKYmmOss5lwrHrf5rH6+bn/a+TwrPf0K5RTYfCmB7
         h/DGhhP3YhHypqd27q6BN3PWMLY1QjQkGV1Zc=
Received: by 10.142.8.38 with SMTP id 38mr4041938wfh.125.1266297890594;
        Mon, 15 Feb 2010 21:24:50 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 22sm6480272pzk.13.2010.02.15.21.24.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 21:24:49 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 12:22:08 +0700
Content-Disposition: inline
In-Reply-To: <4B79A3ED.4090308@kdbg.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140067>

The implementation is also lightly modified to use is_dir_sep()
instead of hardcoding '/'.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
  On Mon, Feb 15, 2010 at 08:43:41PM +0100, Johannes Sixt wrote:
  > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
  >> +int offset_1st_component(const char *path)
  >> +{
  >> +	if (has_dos_drive_prefix(path))
  >> +		return 2 + (path[2] =3D=3D '/');
  >> +	return *path =3D=3D '/';
  >> +}
  >
  > I'd have expected that you future-proofed this function by using=20
  > is_dir_sep() or even use your previous implementation of is_root_pa=
th=20
  > (because this implementation is a bit cryptic).
  >
  > But if the new callers of this function will only pass the results =
of=20
  > normalize_path_copy() and getcwd() (both return only forward-slashe=
s on=20
  > Windows), then I'm fine with this version. Do they?

  They do. But future-proofing can never be a bad thing.

 cache.h     |    1 +
 path.c      |   10 ++++++++++
 sha1_file.c |    7 -------
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index d478eff..ff23cd1 100644
--- a/cache.h
+++ b/cache.h
@@ -675,6 +675,7 @@ int normalize_path_copy(char *dst, const char *src)=
;
 int longest_ancestor_length(const char *path, const char *prefix_list)=
;
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
+int offset_1st_component(const char *path);
=20
 /* Read and unpack a sha1 file into memory, write memory to a sha1 fil=
e */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 0005df3..6304805 100644
--- a/path.c
+++ b/path.c
@@ -649,3 +649,13 @@ int daemon_avoid_alias(const char *p)
 		}
 	}
 }
+
+int offset_1st_component(const char *path)
+{
+	int len =3D 0;
+	if (has_dos_drive_prefix(path))
+		len +=3D 2;
+	if (is_dir_sep(path[len]))
+		return len++;
+	return len;
+}
diff --git a/sha1_file.c b/sha1_file.c
index 657825e..52052b9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -35,13 +35,6 @@ static size_t sz_fmt(size_t s) { return s; }
=20
 const unsigned char null_sha1[20];
=20
-static inline int offset_1st_component(const char *path)
-{
-	if (has_dos_drive_prefix(path))
-		return 2 + (path[2] =3D=3D '/');
-	return *path =3D=3D '/';
-}
-
 int safe_create_leading_directories(char *path)
 {
 	char *pos =3D path + offset_1st_component(path);
--=20
1.7.0.195.g637a2
