From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] update-index: fix worktree setup
Date: Sat, 30 Aug 2008 16:13:58 +0700
Message-ID: <1220087638-2202-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 11:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZMYH-0002gO-MO
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbYH3JOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 05:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbYH3JOT
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 05:14:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:10568 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYH3JOT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 05:14:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1110047wfd.4
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=m9R1pR5fVU1ioxnGYdmIdWOM/OvjRmXtn8Kguu3G1kk=;
        b=Qoq2L/ZHT0paN5jBk8jNsgFYUDHgQhPUaYW/Y2H9VqcJHVJunFjQxekDguJjOD46Ns
         spk1E+Jb6o+sqk9AYELPe+8DaC28haOxOOgctdqrvTzn5brSZBOoxl6ai+PWZ73xr65F
         /7xFZf8CaQHkxVNencq+7saRiCw/h/ZtMCTj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Tkyil9Klr8XrMDKU1QoHxl2swgeTaHv/8+94gRrIATCQCuSPUcLMRU4fgnNTL1EtAK
         MQ6sf4GfIdx985KR3wmwn8sxlla/C8zIIj4A6B6CX5Xn3hndDIi1h6WfZ0x/Y/XnY6pc
         0mdr+Z/SuXRAneXhsMlWXDiLHHtuaO7h8QUVA=
Received: by 10.142.203.19 with SMTP id a19mr1309881wfg.179.1220087658219;
        Sat, 30 Aug 2008 02:14:18 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.54.222])
        by mx.google.com with ESMTPS id 30sm5995019wfg.9.2008.08.30.02.14.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 02:14:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 30 Aug 2008 16:13:58 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94362>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 434cb8e..f201cf4 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -617,10 +617,12 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "--refresh")) {
+				setup_work_tree();
 				has_errors |=3D refresh_cache(refresh_flags);
 				continue;
 			}
 			if (!strcmp(path, "--really-refresh")) {
+				setup_work_tree();
 				has_errors |=3D refresh_cache(REFRESH_REALLY | refresh_flags);
 				continue;
 			}
@@ -687,6 +689,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 				goto finish;
 			}
 			if (!strcmp(path, "--again") || !strcmp(path, "-g")) {
+				setup_work_tree();
 				has_errors =3D do_reupdate(argc - i, argv + i,
 							 prefix, prefix_length);
 				if (has_errors)
@@ -705,6 +708,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 				usage(update_index_usage);
 			die("unknown option %s", path);
 		}
+		setup_work_tree();
 		p =3D prefix_path(prefix, prefix_length, path);
 		update_one(p, NULL, 0);
 		if (set_executable_bit)
@@ -717,6 +721,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
=20
 		strbuf_init(&buf, 0);
 		strbuf_init(&nbuf, 0);
+		setup_work_tree();
 		while (strbuf_getline(&buf, stdin, line_termination) !=3D EOF) {
 			const char *p;
 			if (line_termination && buf.buf[0] =3D=3D '"') {
--=20
1.6.0.96.g2fad1.dirty
