From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 18:52:20 +0700
Message-ID: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 13:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEIpM-000840-4E
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 13:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251Ab2ISLwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 07:52:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60813 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab2ISLwP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 07:52:15 -0400
Received: by pbbrr13 with SMTP id rr13so2285151pbb.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=KyFSGPXGtFT2zmspNLueJ+bO2btxe5XYYwD+awm/V7w=;
        b=DCLuwVg2it2d2F3oFi66NLrFE9oBvQ7fxu5wNBEWwjQwkix8ZepeKTdZSUohex/9PQ
         mqqmA5gQ5WRZ+M/3IzI63eVC4s2BrX5ktvYbVC25fO8JCWRlExbH+8LKA7UGIhyJnaiu
         gE/prrdDXdozHaIo6i1qKx0uwBkB3gEu7DVLXEGPn9AWw2YSUlBOWR+OjcAjbaLarGEH
         2URXu7RXy7jmYdOcalQIhqnNM1aI4ChZKr/V+cyAkNH1CsQV8u5WU1a8P5p83m2Lz29k
         Z5vyp2CC+cv/TGJwo0vBYR6J4cmrmicHdprHbWizNtqUS1I9py6MFxgFBMNWTRrTlMtk
         nm1w==
Received: by 10.68.222.167 with SMTP id qn7mr6685539pbc.98.1348055534527;
        Wed, 19 Sep 2012 04:52:14 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id b4sm1726970pbw.28.2012.09.19.04.52.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 04:52:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 19 Sep 2012 18:52:21 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205922>

I find it easier to read "git log --oneline" when the subject lines
align, which they don't when the log is decorated because the
decoration stands before the subject line.

I'm on colored output so moving decoration to the end of line does not
make it harder to recognize refs. What about black-and-white people?
We could right align the decoration if it makes it easier for
the black-and-whites to read (but not to the right edge when the screen
is too wide)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 log-tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c894930..c51c942 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -616,11 +616,12 @@ void show_log(struct rev_info *opt)
 			printf(" (from %s)",
 			       find_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
-		show_decorations(opt, commit);
-		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		if (opt->commit_format =3D=3D CMIT_FMT_ONELINE) {
+			printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 			putchar(' ');
 		} else {
+			show_decorations(opt, commit);
+			printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 			putchar('\n');
 			graph_show_oneline(opt->graph);
 		}
@@ -682,6 +683,10 @@ void show_log(struct rev_info *opt)
 		graph_show_commit_msg(opt->graph, &msgbuf);
 	else
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
+	if (opt->commit_format =3D=3D CMIT_FMT_ONELINE) {
+		show_decorations(opt, commit);
+		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
+	}
 	if (opt->use_terminator) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
--=20
1.7.12.403.gce5cf6f.dirty
