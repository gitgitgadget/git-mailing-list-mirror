From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/8] Re-add resolve_ref() that always returns an allocated buffer
Date: Thu, 17 Nov 2011 16:32:10 +0700
Message-ID: <1321522335-24193-4-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHW-0002hB-D7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab1KQJ3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:07 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36906 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab1KQJ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:05 -0500
Received: by ggnb2 with SMTP id b2so788172ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=t1DBKP587Bdpa5cmN+rV//IydovFeQR2IcSJvP63/A0=;
        b=GbjnFrKgQ76H/k9GUlcH6mdhYR+5ht8jvvl2GuT4G9vfEFB6fQRY2b5P3YWOghSjxT
         lRUIkD+DQZnje+b0+Vt9A+PBeS7XFVhciDIYTuyaV3hQksxfDucUnASe5xSxsgGQ+KY7
         9R3d7phehWVsEWJ6UF8cYFSi4FVvavWJlLp+A=
Received: by 10.50.242.103 with SMTP id wp7mr7438304igc.21.1321522145068;
        Thu, 17 Nov 2011 01:29:05 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id ft1sm19333138igc.3.2011.11.17.01.29.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:32:41 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185583>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 refs.c  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 61f023a..6b8ac8b 100644
--- a/cache.h
+++ b/cache.h
@@ -867,6 +867,7 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  * errno is sometimes set on errors, but not always.
  */
 extern const char *resolve_ref_unsafe(const char *ref, unsigned char *=
sha1, int reading, int *flag);
+extern char *resolve_ref(const char *ref, unsigned char *sha1, int rea=
ding, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/refs.c b/refs.c
index 9e42e36..28496ed 100644
--- a/refs.c
+++ b/refs.c
@@ -605,6 +605,12 @@ const char *resolve_ref_unsafe(const char *ref, un=
signed char *sha1, int reading
 	return ref;
 }
=20
+char *resolve_ref(const char *ref, unsigned char *sha1, int reading, i=
nt *flag)
+{
+	const char *ret =3D resolve_ref_unsafe(ref, sha1, reading, flag);
+	return ret ? xstrdup(ret) : NULL;
+}
+
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
--=20
1.7.4.74.g639db
