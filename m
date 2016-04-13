From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/26] refs: add expand_ref()
Date: Wed, 13 Apr 2016 19:55:03 +0700
Message-ID: <1460552110-5554-20-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:56:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKLq-0004V8-LZ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030841AbcDMM4z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:56:55 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35967 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030810AbcDMM4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:56:53 -0400
Received: by mail-pa0-f66.google.com with SMTP id k3so3876733pav.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XbkFbr5EGIkejfMhnD4B8AWeAFi5+tzcQV2HTFmJhTQ=;
        b=FpxVCBonCpPl5B7YxZO49BphpfdGGPhkyuBjYa28IhEl3XVQvkSmyisnTAvdkkEkzX
         w03XVpShXJSNml19JB+aK6Y+2m77U6nIZScmST/vRonOlhJCK79KjE3guIzEQQA9ZUCm
         KO91uqzd2YMbL68uXqhebr7NIoPRYRABkpcw3uNiaXD0hTs100IEebbGyG49I/Y0COPX
         ltKpBxIP5U8p3mTBIrTgGqDT5Xe0ebyCU8OPIIef2u30rbqPaOiJDq5XlFdM7sbut+nm
         FCTvcGRyURZ4pBVh5pG4/XScYvEWrVPHxNFC+p6BTaFK/q82F9TXpHhwrmLjGQb8zQtV
         8jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XbkFbr5EGIkejfMhnD4B8AWeAFi5+tzcQV2HTFmJhTQ=;
        b=NEtFU2h3S9ubv7J56XsDshnyZF+EnyU+q8QdUoEcGctswAO1VJYcvAgHiTg18+AGC2
         7vEEjeLqZs9XYqp/xYHWWUgXUdw6LYcrErjtjtb98Qm8GRkKxu/QzzMr8CpKXE7zYocB
         XL8kvAcg2PqLkyjWsPjoud6bDPakf1DuCdRruumRVU1vRU3ykv5jq/1bBEJf7WldLrSF
         Jy7XMpMz9tsSFhS//hUwYz55/0lAYm0MY8A2hINycXqLi8dg5vwUQdOIrNDjTHTdM3FZ
         S40E26iAp/CpuV38IeO0ipMnrHLbo8b1IbTNTpgtCj7c7bu3C7WyPlwuWYysLuZvESCJ
         Fp5Q==
X-Gm-Message-State: AOPr4FV28Cl9XJQbQKv1kPyn+c5ZLVzWXmZr42kJ6URK0rrUnTbxxAWFAb0RU/l2HdNXjQ==
X-Received: by 10.66.54.78 with SMTP id h14mr12590172pap.95.1460552213251;
        Wed, 13 Apr 2016 05:56:53 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id w20sm51063021pfi.31.2016.04.13.05.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:56:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:56:59 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291412>

This is basically dwim_ref() without @{} support. To be used on the
server side where we want to expand abbreviated to full ref names and
nothing else. The first user is "git clone/fetch --shallow-exclude".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 8 +++++++-
 refs.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index e2d34b2..842e4d8 100644
--- a/refs.c
+++ b/refs.c
@@ -392,6 +392,13 @@ static char *substitute_branch_name(const char **s=
tring, int *len)
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref=
)
 {
 	char *last_branch =3D substitute_branch_name(&str, &len);
+	int   refs_found  =3D expand_ref(str, len, sha1, ref);
+	free(last_branch);
+	return refs_found;
+}
+
+int expand_ref(const char *str, int len, unsigned char *sha1, char **r=
ef)
+{
 	const char **p, *r;
 	int refs_found =3D 0;
=20
@@ -417,7 +424,6 @@ int dwim_ref(const char *str, int len, unsigned cha=
r *sha1, char **ref)
 			warning("ignoring broken ref %s.", fullref);
 		}
 	}
-	free(last_branch);
 	return refs_found;
 }
=20
diff --git a/refs.h b/refs.h
index 3c3da29..31a2fa6 100644
--- a/refs.h
+++ b/refs.h
@@ -90,6 +90,7 @@ extern int resolve_gitlink_ref(const char *path, cons=
t char *refname, unsigned c
  */
 extern int refname_match(const char *abbrev_name, const char *full_nam=
e);
=20
+extern int expand_ref(const char *str, int len, unsigned char *sha1, c=
har **ref);
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
=20
--=20
2.8.0.rc0.210.gd302cd2
