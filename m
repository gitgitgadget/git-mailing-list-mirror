From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/27] refs: add expand_ref()
Date: Fri, 10 Jun 2016 19:27:07 +0700
Message-ID: <20160610122714.3341-21-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:32:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLZF-0001at-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbcFJM3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:29:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33327 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbcFJM3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:29:32 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so5079948pfb.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8BJz/OVuYuaDN2/LD+gykERaRaiH3rMqFJj+A+WzhE=;
        b=grLh40m0stmK5xewtTj6vWjylFOY428EEGhvL3JHzr5yjVEA28fzwm6jFPydivej/n
         ude7xDEDop8FVqTP5/Cln/rus4ZqhTu/1vVr/xYbIjE8hjItCxMo2VFjttgQdk+zcZQM
         SbF/hOHHyr+E1jQ4hQcSBejJrykYOqm91dx7crTbVc/a2umHoIN55i+Ylognh3Nnd8sl
         aHyLmZVB8j0ecqfO0xf77MO67wzbAHoAB2iwOjIoIpTMc/cbYp36LuLl5gAvEhBB8qid
         o1cnar4E6kqDXtyhf0dXLJFV2pQ80pjWgVDg1Yey5WbsE+wuopjmOriNVY771xuSZ5ru
         KScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8BJz/OVuYuaDN2/LD+gykERaRaiH3rMqFJj+A+WzhE=;
        b=UscLqtYFsJdyIi9RxmhyY/7AECqq3vkoRW+a0AbHc03ADms7O2iQVdNqNln5cvwikr
         52+uMfGRgphoK/lZ3d2WwWzrwBLlYDUlNll9uMMXVDCjv1JMisPoW+qkI7NXVhfpF9jF
         V0rubjcMBPGYcIfl16z0JE258jFlPydHb8m/tfr9v/OCVT/kBoWrAsEd+krGtlQj++l/
         jvvcbzNSVUgPBl0KA6dVRS4F7Dv80+ZqdGqBIT0Y6djlTTCiXjWGirdc6R1kaklDsRPz
         k4NMP60SV1W2AZx94gupaYL+fmGEk4/V8HpemZ5fDaHYteYYVodlvOKu3Qal9nzqTHY6
         +e0g==
X-Gm-Message-State: ALyK8tKesJgUmKnUdvNX6k4ZmUu/3SNU0BQBodshQmUfykylIoCPwGz5Twt15OyC8cJlow==
X-Received: by 10.98.79.90 with SMTP id d87mr2026052pfb.120.1465561771381;
        Fri, 10 Jun 2016 05:29:31 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id h5sm11021115pfb.81.2016.06.10.05.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:29:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:29:26 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296998>

This is basically dwim_ref() without @{} support. To be used on the
server side where we want to expand abbreviated to full ref names and
nothing else. The first user is "git clone/fetch --shallow-exclude".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.8.2.524.g6ff3d78
