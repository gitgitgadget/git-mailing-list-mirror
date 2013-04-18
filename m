From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 10/13] pretty: add %C(auto) for auto-coloring
Date: Fri, 19 Apr 2013 09:08:49 +1000
Message-ID: <1366326532-28517-11-git-send-email-pclouds@gmail.com>
References: <1366100702-31745-1-git-send-email-pclouds@gmail.com>
 <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 01:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxy9-00087n-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967009Ab3DRXKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Apr 2013 19:10:15 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55537 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab3DRXKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:10:14 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so1876046pab.22
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=a17OhIqZbRGIqoG/KzWYKTnS7DR4wYqV3pZ7koIbv0M=;
        b=WH2Vl/NFMOM8CzBlFZclTVkDl2fJfAfqnQ3ZobsF92WPsYm1gsnxiQvHdVjGK7hseD
         TbwVHOelpMxKxLQGHgsHIHZR7CAiXUDgdYgGTmMH0k55LZGbuq2TGusyXOm55AxhrqlK
         C7H3SAR2tgnOXKaC6onVeGGSY+TfS2H0jIsJrjFgV/WjMF/JsLiC6+ZFbErkV4dS4Muy
         Y4KMsCvt3MF/rNBYHHGX++yqKjEAP7BWmJc1f8QintXdv0g/oGL0224DiMHFVjhX09en
         37ULQTm7dwcGKYy/I8DiXByIo0Rdu+UB0jRpSDeC+BJ+MCFQcfOqJPp4d43D3UJnVgVM
         yzSQ==
X-Received: by 10.66.88.39 with SMTP id bd7mr2607213pab.184.1366326613574;
        Thu, 18 Apr 2013 16:10:13 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id qh4sm12384832pac.8.2013.04.18.16.10.10
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 16:10:12 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 19 Apr 2013 09:10:02 +1000
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1366326532-28517-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221712>

This is not simply convenient over %C(auto,xxx). Some placeholders
(actually only one, %d) do multi coloring and we can't emit a multiple
colors with %C(auto,xxx).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/pretty-formats.txt |  3 ++-
 pretty.c                         | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

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
index e0413e3..3612f82 100644
--- a/pretty.c
+++ b/pretty.c
@@ -778,6 +778,7 @@ struct format_commit_context {
 	char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
+	int auto_color;
=20
 	/* These offsets are relative to the start of the commit message. */
 	struct chunk author;
@@ -1005,7 +1006,20 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
-		return parse_color(sb, placeholder, c);
+		if (!prefixcmp(placeholder + 1, "(auto)")) {
+			c->auto_color =3D 1;
+			return 7; /* consumed 7 bytes, "C(auto)" */
+		} else {
+			int ret =3D parse_color(sb, placeholder, c);
+			if (ret)
+				c->auto_color =3D 0;
+			/*
+			 * Otherwise, we decided to treat %C<unknown>
+			 * as a literal string, and the previous
+			 * %C(auto) is still valid.
+			 */
+			return ret;
+		}
 	case 'n':		/* newline */
 		strbuf_addch(sb, '\n');
 		return 1;
@@ -1051,13 +1065,19 @@ static size_t format_commit_one(struct strbuf *=
sb, /* in UTF-8 */
=20
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
+		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
 		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'h':		/* abbreviated commit hash */
-		if (add_again(sb, &c->abbrev_commit_hash))
+		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
+		if (add_again(sb, &c->abbrev_commit_hash)) {
+			strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 			return 1;
+		}
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
 						     c->pretty_ctx->abbrev));
+		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		c->abbrev_commit_hash.len =3D sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -1095,7 +1115,7 @@ static size_t format_commit_one(struct strbuf *sb=
, /* in UTF-8 */
 		return 1;
 	case 'd':
 		load_ref_decorations(DECORATE_SHORT_REFS);
-		format_decorations(sb, commit, 0);
+		format_decorations(sb, commit, c->auto_color);
 		return 1;
 	case 'g':		/* reflog info */
 		switch(placeholder[1]) {
--=20
1.8.2.82.gc24b958
