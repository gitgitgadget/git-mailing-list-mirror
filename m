From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/12] refs.c: replace some use of starts_with() with skip_prefix()
Date: Wed, 18 Dec 2013 21:53:53 +0700
Message-ID: <1387378437-20646-9-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWY-0003vl-VE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195Ab3LROyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:54:54 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60040 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROyx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:53 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so6040377pad.31
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zaE20htY0YQl4jN4NQ+xNIsAI7KO0A005Lvyvw6pBZo=;
        b=ZVS4mL81XwL3sU+SQi1jMMDYUKumYGdWOEvv26nuKOwDsyq9Yw5cESEgsI7Eeuk0eF
         m62W8EBs3cJtwoVQRGcqx2NnMPLT/aoswrk7JqaM/j4LnmIqKkkl9KJyeigphQh1q7fJ
         gIXrFFTiZHBbd/sj2PmZNjAQ4L46Q/amvY78bzdUI/gCqs4S6nCYmZNcQywMvmxXPVAL
         rp2Veq+vDWgL4PhHTcfD+kBvjM9x1MK6HG9d1eKVwUL3qR+F9qbxsDhdMmcyHOVbb6Oq
         0lLZhP5ySwM0jbSbuBDrhxPzC+9VktY7rK5y6J0pX5+6GCUGKpH9gDorQsmP8VfYnHg/
         RYJw==
X-Received: by 10.68.200.129 with SMTP id js1mr7051524pbc.14.1387378492736;
        Wed, 18 Dec 2013 06:54:52 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id qz9sm581180pbc.3.2013.12.18.06.54.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:52 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:50 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239446>

It's out of context, but there are neither changes in buffer nor buf
between two chunks.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 5e378bc..1fb658f 100644
--- a/refs.c
+++ b/refs.c
@@ -1339,7 +1339,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 	for (;;) {
 		char path[PATH_MAX];
 		struct stat st;
-		char *buf;
+		const char *buf;
 		int fd;
=20
 		if (--depth < 0)
@@ -1415,7 +1415,7 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (!starts_with(buffer, "ref:")) {
+		if ((buf =3D skip_prefix(buffer, "ref:")) =3D=3D NULL) {
 			/*
 			 * Please note that FETCH_HEAD has a second
 			 * line containing other data.
@@ -1430,7 +1430,6 @@ const char *resolve_ref_unsafe(const char *refnam=
e, unsigned char *sha1, int rea
 		}
 		if (flag)
 			*flag |=3D REF_ISSYMREF;
-		buf =3D buffer + 4;
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
--=20
1.8.5.1.208.g019362e
