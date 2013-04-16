From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/13] pretty: add %C(auto) for auto-coloring
Date: Tue, 16 Apr 2013 18:24:59 +1000
Message-ID: <1366100702-31745-11-git-send-email-pclouds@gmail.com>
References: <1364636112-15065-1-git-send-email-pclouds@gmail.com>
 <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 10:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1Ee-0007Me-D9
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab3DPI1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 04:27:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:60463 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab3DPI1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:27:18 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so217902pab.8
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xK9rbxO8e5wRdgoDUR/0dCBTTjzmyKieKhNZ5OayzIY=;
        b=PHK4mr6pcfPADKbgqO6nVS5gyoRHEvjgQVIaJJjTwlVDtxBBastoHudc0loeZ3axi2
         V18EjaX5L33VKntq4Z+7NB79mrnzZR39++1S9wk7mU1yw+jDwkuLuUmDd6utFcJr9xfC
         743va7SU/3Uwp+ALrkBYHqJ/i6Sk/14+CqhrKLuUMoAk8wi9buf3dcPzqUtPsAfDmOWi
         gnmMPdURyhmlAgGw3Zvg3F4UOCOm2RRSyqxioWVsW6cglsuOUg7NzLMhBk4vnJgz8odL
         PoFPQ6jF6jqmagoJeUMNr5R0b9Er5mq23lU0NN1VGQ8HknH+e1Ag5olPAjY2r9I+4naF
         SjWw==
X-Received: by 10.68.180.67 with SMTP id dm3mr1753594pbc.110.1366100838144;
        Tue, 16 Apr 2013 01:27:18 -0700 (PDT)
Received: from pclouds@gmail.com (xinyep.lnk.telstra.net. [110.143.18.114])
        by mx.google.com with ESMTPS id kd7sm1179929pbb.34.2013.04.16.01.27.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 01:27:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Apr 2013 18:27:04 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221389>

This is not simply convenient over %C(auto,xxx). Some placeholders
(actually only one, %d) do multi coloring and we can't emit a multiple
colors with %C(auto,xxx).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  3 ++-
 pretty.c                         | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 6bde67e..bad627a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -156,7 +156,8 @@ The placeholders are:
   adding `auto,` at the beginning will emit color only when colors are
   enabled for log output (by `color.diff`, `color.ui`, or `--color`, a=
nd
   respecting the `auto` settings of the former if we are going to a
-  terminal)
+  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto coloring
+  on the next placeholders until the color is switched again.
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index e0413e3..f385176 100644
--- a/pretty.c
+++ b/pretty.c
@@ -778,6 +778,7 @@ struct format_commit_context {
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
+	int auto_color_next;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1005,7 +1006,15 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		return parse_color(sb, placeholder, c);
+		if (!prefixcmp(placeholder + 1, "(auto)")) {
+			c->auto_color_next =3D 1;
+			return 7;
+		} else {
+			int ret =3D parse_color(sb, placeholder, c);
+			if (ret)
+				c->auto_color_next =3D 0;
+			return ret;
+		}
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
@@ -1051,13 +1060,17 @@ static size_t format_commit_one(struct strbuf *=
sb, /* in UTF-8 */
=20
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
+		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_COMMIT));
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
+		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_COMMIT));
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 						     c->pretty_ctx->abbrev));
+		strbuf_addstr(sb, diff_get_color(c->auto_color_next, DIFF_RESET));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -1095,7 +1108,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 		return 1;
 	case 'd':
 		load_ref_decorations(DECORATE_SHORT_REFS);
-		format_decorations(sb, commit, 0);
+		format_decorations(sb, commit, c->auto_color_next);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
--=20
1.8.2.82.gc24b958
