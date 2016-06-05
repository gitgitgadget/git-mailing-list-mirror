From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/6] fetch: refactor ref update status formatting code
Date: Sun,  5 Jun 2016 10:11:37 +0700
Message-ID: <20160605031141.23513-3-pclouds@gmail.com>
References: <20160603110843.15434-1-pclouds@gmail.com>
 <20160605031141.23513-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OU3-0004PM-0D
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbcFEDMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:10 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35853 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDMG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:06 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so9017976pad.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vaYiHEC5QhlVZEomes6VOdN426N9BuUfdRVLst5K100=;
        b=LOaDGko4e9d19c+EHOjGFw5iwRZuhnfGQG7zXK7d5psyxe6SlsF/zbzZyGICt43xMl
         IOc7ltI59Z9W3wWGZ16agy3UBqM4I5OEJVhGubj/1lc2yr/Oova5coh6bQKqf9srFpEj
         KOQn3Xwzm3cNOqErgSqH7qW3s/TZQNi8EyIZ7zlzF/OF2R/7azxHKgBWBEdaaLBaY51m
         2Fp77sL97G6UhTVHd5cptYV9/jiGWKrCMvdMg2pzJXDsLcySwPkYPeruuLvvtEX767qt
         /vsAmOAIBRG/1yXWlR8L69A5ezcFUPjXqj5UICRCBXW0OpjwU0FR5QgiNC1r0Dtu3iVT
         Lyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaYiHEC5QhlVZEomes6VOdN426N9BuUfdRVLst5K100=;
        b=mEJoolo1CiULqLsO83Bsm6xlmrHwiyo9pEUyqNkUvipnN9zb/RS5SpZYzEHYtgpPQa
         TeZp/f38WEMeN5GyDNV2mFxbJomrlSyJryg2pGVzYbeSpBZUICChSALre+eOrsbCbIj8
         PVtuyRR6xQtfAWGGLVCrEBxwUFtW0mrPsyunest3/OYtrmrusr3N/ktJHV/2HQE+71i5
         F93ODami5/2tADShowPzLpeuWtz0ul1QP5KtdX9lyyUKf8Xheg3EFmmdi3ktqbssughP
         LZh1gZbtGxs+t4wh6u/Ii6Z4Ur+LrGPULV95NpV5Vt23xmIgyug/Ut0JImrf51eVqwxm
         LYxw==
X-Gm-Message-State: ALyK8tIkCx9rfChGMGJMOtblYYCv77laxJZdCU2a913iyAMDabOOJf9IfHgfh38x3kRaLg==
X-Received: by 10.67.3.161 with SMTP id bx1mr15600271pad.86.1465096325645;
        Sat, 04 Jun 2016 20:12:05 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id x71sm18050083pfj.43.2016.06.04.20.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:12:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:12:00 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296453>

This makes it easier to change the formatting later. And it makes sure
translators cannot mess up format specifiers and break Git.

There are a couple call sites where the length of the second column is
TRANSPORT_SUMMARY_WIDTH instead of calculated by TRANSPORT_SUMMARY(),
which is enforced now. The result should be the same because these call
sites do not contain characters outside ASCII range.

The two strbuf_addf() calls instead of one is mostly to reduce
diff-noise in a future patch where "ref -> ref" is reformatted
differently.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 77 ++++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 38 insertions(+), 39 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1582ca7..a7f152a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,6 +451,16 @@ fail:
=20
 #define REFCOL_WIDTH  10
=20
+static void format_display(struct strbuf *display, char code,
+			   const char *summary, const char *error,
+			   const char *remote, const char *local)
+{
+	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
+	strbuf_addf(display, "%-*s -> %s", REFCOL_WIDTH, remote, local);
+	if (error)
+		strbuf_addf(display, "  (%s)", error);
+}
+
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
 			    const struct ref *remote_ref,
@@ -467,9 +477,8 @@ static int update_local_ref(struct ref *ref,
=20
 	if (!oidcmp(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			strbuf_addf(display, "=3D %-*s %-*s -> %s",
-				    TRANSPORT_SUMMARY(_("[up to date]")),
-				    REFCOL_WIDTH, remote, pretty_ref);
+			format_display(display, '=3D', _("[up to date]"), NULL,
+				       remote, pretty_ref);
 		return 0;
 	}
=20
@@ -481,10 +490,9 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		strbuf_addf(display,
-			    _("! %-*s %-*s -> %s  (can't fetch in current branch)"),
-			    TRANSPORT_SUMMARY(_("[rejected]")),
-			    REFCOL_WIDTH, remote, pretty_ref);
+		format_display(display, '!', _("[rejected]"),
+			       _("can't fetch in current branch"),
+			       remote, pretty_ref);
 		return 1;
 	}
=20
@@ -492,11 +500,9 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		int r;
 		r =3D s_update_ref("updating tag", ref, 0);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : '-',
-			    TRANSPORT_SUMMARY(_("[tag update]")),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : '-', _("[tag update]"),
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		return r;
 	}
=20
@@ -527,11 +533,9 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules !=3D RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r =3D s_update_ref(msg, ref, 0);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : '*',
-			    TRANSPORT_SUMMARY(what),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : '*', what,
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		return r;
 	}
=20
@@ -545,11 +549,9 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules !=3D RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r =3D s_update_ref("fast-forward", ref, 1);
-		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
-			    r ? '!' : ' ',
-			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("  (unable to update local ref)") : "");
+		format_display(display, r ? '!' : ' ', quickref.buf,
+			       r ? _("unable to update local ref") : NULL,
+			       remote, pretty_ref);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -562,18 +564,14 @@ static int update_local_ref(struct ref *ref,
 		    (recurse_submodules !=3D RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(ref->new_oid.hash);
 		r =3D s_update_ref("forced-update", ref, 1);
-		strbuf_addf(display, "%c %-*s %-*s -> %s  (%s)",
-			    r ? '!' : '+',
-			    TRANSPORT_SUMMARY_WIDTH, quickref.buf,
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    r ? _("unable to update local ref") : _("forced update"));
+		format_display(display, r ? '!' : '+', quickref.buf,
+			       r ? _("unable to update local ref") : _("forced update"),
+			       remote, pretty_ref);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		strbuf_addf(display, "! %-*s %-*s -> %s  %s",
-			    TRANSPORT_SUMMARY(_("[rejected]")),
-			    REFCOL_WIDTH, remote, pretty_ref,
-			    _("(non-fast-forward)"));
+		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
+			       remote, pretty_ref);
 		return 1;
 	}
 }
@@ -714,11 +712,10 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 				rc |=3D update_local_ref(ref, what, rm, &note);
 				free(ref);
 			} else
-				strbuf_addf(&note, "* %-*s %-*s -> FETCH_HEAD",
-					    TRANSPORT_SUMMARY_WIDTH,
-					    *kind ? kind : "branch",
-					    REFCOL_WIDTH,
-					    *what ? what : "HEAD");
+				format_display(&note, '*',
+					       *kind ? kind : "branch", NULL,
+					       *what ? what : "HEAD",
+					       "FETCH_HEAD");
 			if (note.len) {
 				if (verbosity >=3D 0 && !shown_url) {
 					fprintf(stderr, _("From %.*s\n"),
@@ -812,13 +809,15 @@ static int prune_refs(struct refspec *refs, int r=
ef_count, struct ref *ref_map,
=20
 	if (verbosity >=3D 0) {
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
+			struct strbuf sb =3D STRBUF_INIT;
 			if (!shown_url) {
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url =3D 1;
 			}
-			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY(_("[deleted]")),
-				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
+			format_display(&sb, 'x', _("[deleted]"), NULL,
+				       _("(none)"), prettify_refname(ref->name));
+			fprintf(stderr, " %s\n",sb.buf);
+			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
--=20
2.8.2.524.g6ff3d78
