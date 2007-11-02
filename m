From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 3/4] Export launch_editor() and make it accept ':' as a no-op editor.
Date: Fri,  2 Nov 2007 11:33:08 -0400
Message-ID: <1194017589-4669-3-git-send-email-krh@redhat.com>
References: <1194017589-4669-1-git-send-email-krh@redhat.com>
 <1194017589-4669-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InycS-0004m0-B8
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbXKBPjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 11:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbXKBPjP
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:39:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197AbXKBPjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:39:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA2FXGYd007559;
	Fri, 2 Nov 2007 11:33:16 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXF1k020011;
	Fri, 2 Nov 2007 11:33:15 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lA2FXEIK006415;
	Fri, 2 Nov 2007 11:33:15 -0400
X-Mailer: git-send-email 1.5.3.4.206.g58ba4
In-Reply-To: <1194017589-4669-2-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63134>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-tag.c |    5 ++++-
 strbuf.h      |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 66e5a58..bcb3a7a 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -17,7 +17,7 @@ static const char builtin_tag_usage[] =3D
=20
 static char signingkey[1000];
=20
-static void launch_editor(const char *path, struct strbuf *buffer)
+void launch_editor(const char *path, struct strbuf *buffer)
 {
 	const char *editor, *terminal;
 	struct child_process child;
@@ -42,6 +42,9 @@ static void launch_editor(const char *path, struct st=
rbuf *buffer)
 	if (!editor)
 		editor =3D "vi";
=20
+	if (!strcmp(editor, ":"))
+		return;
+
 	memset(&child, 0, sizeof(child));
 	child.argv =3D args;
 	args[0] =3D editor;
diff --git a/strbuf.h b/strbuf.h
index 9b9e861..9720826 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -113,5 +113,6 @@ extern int strbuf_read_file(struct strbuf *sb, cons=
t char *path, size_t hint);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
=20
 extern void stripspace(struct strbuf *buf, int skip_comments);
+extern void launch_editor(const char *path, struct strbuf *buffer);
=20
 #endif /* STRBUF_H */
--=20
1.5.3.4.206.g58ba4
