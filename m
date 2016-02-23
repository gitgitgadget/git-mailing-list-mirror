From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 18/25] refs: add expand_ref()
Date: Tue, 23 Feb 2016 20:44:56 +0700
Message-ID: <1456235103-26317-19-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDIh-0000xz-6j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbcBWNqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:46:44 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35521 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBWNql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:46:41 -0500
Received: by mail-pf0-f175.google.com with SMTP id c10so116395591pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=23/q5dceNLYao8l1gqyY3UNNkgF5lkTwQHb8pVokI+4=;
        b=Kaw3Q99gRmqrpCGjqE7rCOTah/ScwaW+pu8U1yeWoLpS10mXkXEU5AEo12Gf4IdFcK
         UyawXei48Dque/XWXYkjHkCTUjQPolxljlvJv1TYrh4CHgjIz56hf5WFfv+QA5jyZCcf
         a3ECSBniu6ed7XEvck87bILn5LH6Jf4UUaYroPHQbifgld0ysx7vzeav+43KlFr0aH3d
         Rp9Tvcb5diZw9f7vvWk545w+6I44VeXckecNT7lFY2+nvCw+URu1sTst9KzQmozvKCOX
         09RIFeAx0bq1B7Jya8KEsu6eCZRk/WK+JQryQZD0UtNnITI870Z1ffEcZ4VjbHQUQd6L
         0hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=23/q5dceNLYao8l1gqyY3UNNkgF5lkTwQHb8pVokI+4=;
        b=ImrRy3mr7zmj4N5BQ+D+ZmXzQIQFUOuc4XmdBQHpD1KiBa2tJBQLg2QYpQ4vWDwoSm
         XcgXNw9QQvxjmdw9cy6omcAFdjxWeGIYfk0JJf3JlfjUBX8XaiXUBXHP8P8COB41VOSx
         KRlHbr1QLWc5W7SIz+m5gnlY7sOwFEHs5akijsZuxu/4GAzHCmeoiDBIup2yYVmy2Yyc
         nrBfpwOYNbeAhBMhRPSCvGmcQoPJALA6Bdr3/Q2Ls4ABMXqQ1+t+pkZG0eVLSRrHaOua
         2yODUSNgqx5UZEmBdrg/Si+7HOMg4ZjKHaX6qELqkD73n49LraZqGHVbBzPecUXWirHR
         qKLw==
X-Gm-Message-State: AG10YORu17GhJzys0CDaRiAluGBTAaBTBrJOfl1hKxOFhCFDNk1HO+j3Wnx0YpKLQYEjZQ==
X-Received: by 10.98.72.193 with SMTP id q62mr46634396pfi.117.1456235201405;
        Tue, 23 Feb 2016 05:46:41 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id tb10sm44680209pab.22.2016.02.23.05.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:46:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:47:09 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287068>

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
2.7.1.532.gd9e3aaa
