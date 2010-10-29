From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/42] builtins: print setup info if repo is found
Date: Fri, 29 Oct 2010 13:48:13 +0700
Message-ID: <1288334934-17216-2-git-send-email-pclouds@gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 08:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBima-0005pv-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 08:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab0J2Gtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 02:49:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64522 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab0J2Gte (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 02:49:34 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so692674pwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=d976VqBZ7gK2EjbuYAUXW9V6DLfvsiyAVEbYvWmNeIY=;
        b=quJs++ZxMxUCaLI0F/vpiQcdnIuND3VsLutbZaI72fx4b9XHSYaDWk7ndxAzr6mCE9
         XiAOaRFyT212r7WRx4MxMGiCvaatd20uVZcKQedb6FtfCujEhPTO3JpjWFCy3czqGdpk
         qWLrG13VheCPeOL5ZYwpqXR0ZGaXl/+nED7b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RLBR1EQGjtKoCXzTjuE7uReE+9cWUzzZYoizYmSg3yuKc/tCulOE9FuDQFXuTD1pEH
         jSKMCUhYdV3n4aKrXK0AbKhJYfQJCfOzzXrHLGYnnn8rAI9doigrlSoyyIwTNoblzTvU
         Ksqvb5fcs5633STEhBbFrzG+ZQ7F9609YDOh0=
Received: by 10.142.103.10 with SMTP id a10mr1079259wfc.116.1288334974492;
        Thu, 28 Oct 2010 23:49:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.235.0])
        by mx.google.com with ESMTPS id v19sm1022674wfh.12.2010.10.28.23.49.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 23:49:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 29 Oct 2010 13:49:33 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160269>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 git.c   |    4 ++++
 trace.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..d1bee5d 100644
--- a/cache.h
+++ b/cache.h
@@ -1062,6 +1062,7 @@ __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, .=
=2E.);
+extern void trace_repo_setup(const char *prefix);
=20
 /* convert.c */
 /* returns 1 if *dst was used */
diff --git a/git.c b/git.c
index 50a1401..75defb3 100644
--- a/git.c
+++ b/git.c
@@ -264,6 +264,10 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 			use_pager =3D check_pager_config(p->cmd);
 		if (use_pager =3D=3D -1 && p->option & USE_PAGER)
 			use_pager =3D 1;
+
+		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
+		    startup_info->have_repository) /* get_git_dir() may set up repo,=
 avoid that */
+			trace_repo_setup(prefix);
 	}
 	commit_pager_choice();
=20
diff --git a/trace.c b/trace.c
index 1e560cb..bdb5d2f 100644
--- a/trace.c
+++ b/trace.c
@@ -131,3 +131,45 @@ void trace_argv_printf(const char **argv, const ch=
ar *fmt, ...)
 	if (need_close)
 		close(fd);
 }
+
+static const char *quote_crnl(const char *path)
+{
+	static char new_path[PATH_MAX];
+	const char *p2 =3D path;
+	char *p1 =3D new_path;
+
+	if (!path)
+		return NULL;
+
+	while (*p2) {
+		switch (*p2) {
+		case '\\': *p1++ =3D '\\'; *p1++ =3D '\\'; break;
+		case '\n': *p1++ =3D '\\'; *p1++ =3D 'n'; break;
+		case '\r': *p1++ =3D '\\'; *p1++ =3D 'r'; break;
+		default:
+			*p1++ =3D *p2;
+		}
+		p2++;
+	}
+	*p1 =3D '\0';
+	return new_path;
+}
+
+/* FIXME: move prefix to startup_info struct and get rid of this arg *=
/
+void trace_repo_setup(const char *prefix)
+{
+	char cwd[PATH_MAX];
+	char *trace =3D getenv("GIT_TRACE");
+
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+		return;
+
+	if (!getcwd(cwd, PATH_MAX))
+		die("Unable to get current working directory");
+
+	trace_printf("setup: git_dir: %s\n", quote_crnl(get_git_dir()));
+	trace_printf("setup: worktree: %s\n", quote_crnl(get_git_work_tree())=
);
+	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
+	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
+}
--=20
1.7.0.2.445.gcbdb3
