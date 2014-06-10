From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] index-helper: add --detach
Date: Tue, 10 Jun 2014 20:24:25 +0700
Message-ID: <1402406665-27988-6-git-send-email-pclouds@gmail.com>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4m-0004OS-Ix
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbaFJN0v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:51 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:34312 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaFJN0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:50 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so822906pbb.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IXIeKI4SgoKYTRfy3aj/h8RdD7VYzDubMFIMFV5kJZU=;
        b=BZZwmgCXPKcAiK5zLaj1+QKty1u9IfUwnaTA5bgavOwn7TmNhbZJDehJEka9G4YB3z
         h2733C5C6+58nWaoVTYo2xIEHHbbQL65yryeKVo/fwvj1VDCVlYPJ2buXC1m8salH5zw
         8HN5awFOufHD/ot7cFiX1tbv/OIeW83IpjsuFHYX8zXF3pCujmskTa9XxdrKgQxR/loa
         B5ioYU+9oMS3A87SfdB57Mhy7zlS/VCvrZg4GMCv3EwooOb2DA66y7Pgc9EXi6kz7jHl
         ygeWD0QnBLwPqR1hZiwtJBRKKpl9919L9NClWBrvac+Aj2YxQcWhOh5UtrVFB/r1Et8b
         Zedw==
X-Received: by 10.66.179.111 with SMTP id df15mr5673735pac.52.1402406810334;
        Tue, 10 Jun 2014 06:26:50 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id iq10sm69641541pbc.14.2014.06.10.06.26.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:46 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251191>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-index-helper.txt | 4 +++-
 index-helper.c                     | 6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index afeb334..303cda0 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -8,7 +8,7 @@ git-index-helper - A simple cache server for speeding u=
p index file access
 SYNOPSIS
 --------
 [verse]
-'git index-helper
+'git index-helper [--detach]
=20
 DESCRIPTION
 -----------
@@ -18,6 +18,8 @@ shared memory support (e.g. Linux or Windows)
=20
 OPTIONS
 -------
+--detach::
+	Detach from the shell.
=20
 GIT
 ---
diff --git a/index-helper.c b/index-helper.c
index f92326a..9420591 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -159,8 +159,9 @@ int main(int argc, char **argv)
 	static struct lock_file lock;
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *prefix;
-	int fd;
+	int fd, detach =3D 0;
 	struct option options[] =3D {
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -188,6 +189,9 @@ int main(int argc, char **argv)
 	sigchain_push(SIGQUIT, cleanup_on_signal);
 	sigchain_push(SIGPIPE, cleanup_on_signal);
=20
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
 	loop(sb.buf, 600);
 	strbuf_release(&sb);
 	return 0;
--=20
1.9.1.346.ga2b5940
