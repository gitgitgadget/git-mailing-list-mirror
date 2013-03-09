From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 12:08:15 +0100
Message-ID: <20130309110815.GA8328@paksenarrion.iveqy.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
 <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
 <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 12:08:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEHdV-0007vj-1M
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 12:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084Ab3CILHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 06:07:54 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:55062 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab3CILHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 06:07:53 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so2526508lab.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 03:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uwPRL+CVOeBGTtw0pl15bIrshMzWR7OkwQ0Aq6RhT8k=;
        b=QLR4+w0Whf/n6iFtUr3H9zEzbVewqX01E5n4svRrQvfbFHrXctBp4UmexUy4/aVAY4
         PQQH5V5bCUGmGApFkxE6CmnF4oBPPRkUDQouHcmqQfJh6505KrR/MSonZuAa4NdLkEY8
         Mak4/uwIeBSirU6LXY34Nx4w3mCUOwaIihlWlq2Dck+tNKTdiOircRP7KxSjr8uJz/KX
         XuNGrIVkZJufFs4by7po3dvD+xdn14+PDDK8BUa7tAsTzt84CbN916DnxR5jqxNVu6Bi
         cKGbBxBPsrY70+dvqeb4Dl+G+706zrOB3dH4Z8Ef7sGg65EPuVwcax5hNnP7+1Gow9XA
         s/mg==
X-Received: by 10.112.17.196 with SMTP id q4mr2161586lbd.21.1362827271749;
        Sat, 09 Mar 2013 03:07:51 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id ev7sm2513406lbb.15.2013.03.09.03.07.49
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 03:07:50 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UEHdP-0000ub-8Y; Sat, 09 Mar 2013 12:08:15 +0100
Content-Disposition: inline
In-Reply-To: <CACsJy8BbXjJeTgo0DzKKMY7B3NZB=r3r+Z-WsWJR=t00DkTVzQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217721>

On Sat, Mar 09, 2013 at 05:54:45PM +0700, Duy Nguyen wrote:
> On Sat, Mar 9, 2013 at 5:40 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sat, Mar 9, 2013 at 3:42 PM, Fredrik Gustafsson <iveqy@iveqy.com=
> wrote:
> >> To improve performance.
> >
> > BTW, by rolling our own string comparison, we may lose certain
> > optimizations done by C library. In case of glibc, it may choose to
> > run an sse4.2 version where 16 bytes are compared at a time. Maybe =
we
> > encounter "string not equal" much often than "string equal" and suc=
h
> > an optimization is unncessary, I don't know. Measured numbers say i=
t's
> > unncessary as my cpu supports sse4.2.
>=20
> Another problem is locale. Git's toupper() does not care about locale=
,
> which should be fine in most cases. strcasecmp is locale-aware, our
> new str[n]equal_icase is not. It probably does not matter for
> (ascii-based) pathnames, I guess. core.ignorecase users, any comments=
?
> --=20
> Duy

Actually when implemented a str[n]equal_icase that actually should work=
=2E
I break the test suite when trying to replace
strncmp_icase(pathname, base, baselen)) on line 711 in dir.c and I don'=
t
get any significant improvements.

I like work in this area though, slow commit's are my worst git problem=
=2E
I often have to wait 10s. for a commit to be calculated.


--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com


=46rom c5d1f436cdbe7b12c67e81cf1d2904d1fb2e9b6b Mon Sep 17 00:00:00 200=
1
=46rom: Fredrik Gustafsson <iveqy@iveqy.com>
Date: Sat, 9 Mar 2013 09:27:16 +0100
Subject: [PATCH] Replace strcmp_icase with strequal_icase

To improve performance.
git status before:
user    0m0.020s
user    0m0.024s
user    0m0.024s
user    0m0.020s
user    0m0.024s
user    0m0.028s
user    0m0.024s
user    0m0.024s
user    0m0.016s
user    0m0.028s

git status after:
wip

Tried to replace strncmp_icase on line 711 in dir.c but then failed to
run the testsuite. Did not got any relevant speed improvements of this.
---
 dir.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..aace36a 100644
--- a/dir.c
+++ b/dir.c
@@ -37,6 +37,51 @@ int fnmatch_icase(const char *pattern, const char *s=
tring, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD :=
 0));
 }
=20
+int strnequal_icase(const char *first, const char *second, size_t coun=
t)
+{
+	if (ignore_case) {
+		while (*first && *second && count) {
+			if( toupper(*first) !=3D toupper(*second))
+				break;
+			first++;
+			second++;
+			count--;
+		}
+		return toupper(*first) =3D=3D toupper(*second);
+	} else {
+		while (*first && *second && count) {
+			if( *first !=3D *second)
+				break;
+			first++;
+			second++;
+			count--;
+		}
+		return *first =3D=3D *second;
+	}
+
+}
+
+int strequal_icase(const char *first, const char *second)
+{
+	if (ignore_case) {
+		while (*first && *second) {
+			if( toupper(*first) !=3D toupper(*second))
+				break;
+			first++;
+			second++;
+		}
+		return toupper(*first) =3D=3D toupper(*second);
+	} else {
+		while (*first && *second) {
+			if( *first !=3D *second)
+				break;
+			first++;
+			second++;
+		}
+		return *first =3D=3D *second;
+	}
+}
+
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
@@ -626,11 +671,11 @@ int match_basename(const char *basename, int base=
namelen,
 		   int flags)
 {
 	if (prefix =3D=3D patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (strequal_icase(pattern, basename))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strcmp_icase(pattern + 1,
+		    strequal_icase(pattern + 1,
 				  basename + basenamelen - patternlen + 1))
 			return 1;
 	} else {
--=20
1.7.2.5
