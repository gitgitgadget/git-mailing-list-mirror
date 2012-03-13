From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 08/9] column: support piping stdout to external git-column process
Date: Tue, 13 Mar 2012 19:09:20 +0700
Message-ID: <45b5fc83af9ef53f79eb66742eedcbfe14a3d532.1331638664.git.pclouds@gmail.com>
References: <1330430331-19945-1-git-send-email-pclouds@gmail.com> <cover.1331638663.git.pclouds@gmail.com> <1294ed94f981a7029b47a44143c3eb9fb6b820f1.1331638663.git.pclouds@gmail.com> <dd6e9c2189fb4502aaf9f7368cb7f13216961cfa.1331638663.git.pclouds@gmail.com> <c439d91ff126e2a9d7fe627de7346e19801dd6d4.1331638663.git.pclouds@gmail.com> <28f1df2d0cc13d69fa571600c4723094b6fe514b.1331638663.git.pclouds@gmail.com> <dfa792c463da82097de69b1fba5dc54147dd1951.1331638663.git.pclouds@gmail.com> <dc618ca926bdbdbb96ae59615cbbe57cde9f763f.1331638663.git.pclouds@gmail.com> <d7319b7a0445fc476ae1e928bdc0750287f7fb42.1331638663.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 13:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7QVu-0005sh-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 13:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878Ab2CMMHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 08:07:16 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59624 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2CMMHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 08:07:13 -0400
Received: by mail-pz0-f52.google.com with SMTP id p12so885281dad.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=v4buU4YZZYSl8pJ58UBGieOJdhXApWbN63QKIIPvjiM=;
        b=S0UyMHYNK+83MlTwN1vVRYFoAEK979EpLEJ39APDKwiD4qmp0lr3yB0dr7VyZCP9QL
         KhaFPjlFDTipQ32k4BJmTfLF9H31vtLAgdcgdMRXkcypWm+WGDbMn9rOlMBkHXBFBkbH
         HdFXEZ+Tr7LAYCvH4w1wDWiFu8OZK+i+iCQvWGO+izJ7jPLtYVQwlUZFLlzJvRR1clve
         Tvo/c0etOTHn3C4DXZQxXAKEf/G6h6YH42rDF+bukJO1RRdHHoeTynLt45MXPYZFDk4/
         eNW0WS5LLp138+hDazDq7TYUevULhlGmt7NzNhOPcDcyiK7ZHTnCI1WinBcegvLtsqpM
         FghA==
Received: by 10.68.221.97 with SMTP id qd1mr9652862pbc.42.1331640433099;
        Tue, 13 Mar 2012 05:07:13 -0700 (PDT)
Received: from tre ([115.74.61.175])
        by mx.google.com with ESMTPS id x8sm640065pbr.11.2012.03.13.05.07.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 05:07:11 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Mar 2012 19:10:21 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <d7319b7a0445fc476ae1e928bdc0750287f7fb42.1331638663.git.pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193004>

=46or too complicated output handling, it'd be easier to just spawn
git-column and redirect stdout to it. This patch provides helpers
to do that.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 column.h |    3 ++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 3aac28b..1e545a0 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "column.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "run-command.h"
 #include "utf8.h"
=20
 #define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) =3D=3D COL_COLUMN=
 ? \
@@ -364,3 +365,71 @@ int parseopt_column_callback(const struct option *=
opt,
=20
 	return 0;
 }
+
+static int fd_out =3D -1;
+static struct child_process column_process;
+
+int run_column_filter(int colopts, const struct column_options *opts)
+{
+	const char *av[10];
+	int ret, ac =3D 0;
+	struct strbuf sb_colopt  =3D STRBUF_INIT;
+	struct strbuf sb_width   =3D STRBUF_INIT;
+	struct strbuf sb_padding =3D STRBUF_INIT;
+
+	if (fd_out !=3D -1)
+		return -1;
+
+	av[ac++] =3D "column";
+	strbuf_addf(&sb_colopt, "--raw-mode=3D%d", colopts);
+	av[ac++] =3D sb_colopt.buf;
+	if (opts && opts->width) {
+		strbuf_addf(&sb_width, "--width=3D%d", opts->width);
+		av[ac++] =3D sb_width.buf;
+	}
+	if (opts && opts->indent) {
+		av[ac++] =3D "--indent";
+		av[ac++] =3D opts->indent;
+	}
+	if (opts && opts->padding) {
+		strbuf_addf(&sb_padding, "--padding=3D%d", opts->padding);
+		av[ac++] =3D sb_padding.buf;
+	}
+	av[ac] =3D NULL;
+
+	fflush(stdout);
+	memset(&column_process, 0, sizeof(column_process));
+	column_process.in =3D -1;
+	column_process.out =3D dup(1);
+	column_process.git_cmd =3D 1;
+	column_process.argv =3D av;
+
+	ret =3D start_command(&column_process);
+
+	strbuf_release(&sb_colopt);
+	strbuf_release(&sb_width);
+	strbuf_release(&sb_padding);
+
+	if (ret)
+		return -2;
+
+	fd_out =3D dup(1);
+	close(1);
+	dup2(column_process.in, 1);
+	close(column_process.in);
+	return 0;
+}
+
+int stop_column_filter(void)
+{
+	if (fd_out =3D=3D -1)
+		return -1;
+
+	fflush(stdout);
+	close(1);
+	finish_command(&column_process);
+	dup2(fd_out, 1);
+	close(fd_out);
+	fd_out =3D -1;
+	return 0;
+}
diff --git a/column.h b/column.h
index b3e979f..b6872fe 100644
--- a/column.h
+++ b/column.h
@@ -36,4 +36,7 @@ extern int finalize_colopts(unsigned int *colopts, in=
t stdout_is_tty);
 extern void print_columns(const struct string_list *list, unsigned int=
 colopts,
 			  const struct column_options *opts);
=20
+extern int run_column_filter(int colopts, const struct column_options =
*);
+extern int stop_column_filter(void);
+
 #endif
--=20
1.7.8.36.g69ee2
