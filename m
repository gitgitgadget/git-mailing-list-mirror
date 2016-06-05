From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 5/6] fetch: reduce duplicate in ref update status lines with { -> }
Date: Sun,  5 Jun 2016 10:11:40 +0700
Message-ID: <20160605031141.23513-6-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OUH-0004cw-Er
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbcFEDMX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34121 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcFEDMW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id c84so14989696pfc.1
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uJEswSrRlYImTDK1r0XDC6cgIjgEsJwnfboj02CSV8=;
        b=LTfCRAd2WEvIzPvj4HVEqJYbMxbkCStfzYEjz/R7hX68WFwqCwi5kbExH5AkRSTQIg
         EYgPlUuFMZrwo4luU+Gqrz9LWPce6+IdrMuYMKZ2kSQAj9iXo7jk/YKbFeVvI2vjYvIZ
         QxvRv70z0kFPavUlHMSkM6453GzXggvs9hG+aoA/MaYWpJFu4cyUh2Ek9nE8gN/mOLfG
         yAkL1paYLtDqvD96ZSRFs1v4iyeFzli8R9gxq/gNhSN2FMif4zyc6WA4nT6FHPA/E279
         GxeWYmijAwx56pSQu8LOfFmgnHZYk9aCHBGkJajjobOAP0Q79LUkuq4UZiSdzAgntMO3
         aWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uJEswSrRlYImTDK1r0XDC6cgIjgEsJwnfboj02CSV8=;
        b=eFz5FEMYiMwLP1zzcOfMSyFQSpaaL+3vTIGN3et7TivhdbqV0nkNmIsAdoWFCvwdAL
         hIiK6An+j2eGD97sb+/N7ghn0Uu7I/aG95KcTtdshAjdYQdc0BSworgkVgwhDrc/TOr7
         dirOVYlumHBTFqGcvEVxh7tAuWL2Cv4Hlt1VcsabaPK9+suwE93mqxAKb409iUuao3bp
         3+RB2S58J4FGzuRCd4FFph6WcAFGPibgCXN3qxfUh20S3EBS1tsvSbxz0pCjmzf2Bvxn
         Z5NRRS2QVeS7WlgbNXZoddovPr2favJaE3HkJknhv74kRW4MAO28ol2reLListeSo6OU
         wCIw==
X-Gm-Message-State: ALyK8tJBA3bLZIo5f7nU0CwzAGk2Aj/uD/dnQIg3NR4l9RSc97a5lr25dtRH8LeLVN8Ikg==
X-Received: by 10.98.43.210 with SMTP id r201mr16391389pfr.9.1465096341188;
        Sat, 04 Jun 2016 20:12:21 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id 132sm18042756pfc.52.2016.06.04.20.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:12:20 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:12:16 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296456>

Most of the time, ref update lines are

    variable-long-name -> fixed-remote/variable-long-name

With fetch.output set to "compact" such a line will be shown as

    { -> fixed-remote}/variable-long-name

This keeps the output aligned (because the variable part is always at
the end) and reduce duplication.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt    |  4 +++
 Documentation/git-fetch.txt |  8 ++++++
 builtin/fetch.c             | 67 +++++++++++++++++++++++++++++++++++++=
+++++++-
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e1b2e4..a59aa32 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1220,6 +1220,10 @@ fetch.prune::
 	If true, fetch will automatically behave as if the `--prune`
 	option was given on the command line.  See also `remote.<name>.prune`=
=2E
=20
+fetch.output::
+	Valid values are "compact" or "full". See OUTPUT section in
+	linkgit:git-fetch[1] for detail.
+
 format.attach::
 	Enable multipart/mixed attachments as the default for
 	'format-patch'.  The value can also be a double quoted string
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 6c6b2c1..856796b 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -113,6 +113,14 @@ representing the status of a single ref. Each line=
 is of the form:
  <flag> <summary> <from> -> <to> (<reason>)
 -------------------------------
=20
+When configuration variable `fetch.output` contains `compact` and
+`from` and `to` share a common suffix, the line could be displayed in
+the form:
+
+-------------------------------
+ <flag> <summary> {<from> -> <to>}<common-suffix> (<reason>)
+-------------------------------
+
 The status of up-to-date refs is shown only if --verbose option is
 used.
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c42795b..e2ca6bc 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -451,6 +451,7 @@ fail:
 }
=20
 static int refcol_width =3D 10;
+static int compact_format;
=20
 static void adjust_refcol_width(const struct ref *ref)
 {
@@ -480,6 +481,19 @@ static void adjust_refcol_width(const struct ref *=
ref)
 static void prepare_format_display(struct ref *ref_map)
 {
 	struct ref *rm;
+	const char *format =3D "full";
+
+	git_config_get_string_const("fetch.output", &format);
+	if (!strcasecmp(format, "full"))
+		compact_format =3D 0;
+	else if (!strcasecmp(format, "compact"))
+		compact_format =3D 1;
+	else
+		die(_("configuration fetch.output contains invalid value %s"),
+		    format);
+
+	if (compact_format)
+		return;
=20
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
 		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
@@ -491,12 +505,63 @@ static void prepare_format_display(struct ref *re=
f_map)
 	}
 }
=20
+static int common_suffix_length(const char *a, const char *b)
+{
+	const char *pa =3D a + strlen(a);
+	const char *pb =3D b + strlen(b);
+	int count =3D 0, final_count =3D 0;
+
+	while (pa > a && pb > b && pa[-1] =3D=3D pb[-1]) {
+		pa--;
+		pb--;
+		count++;
+		if (*pa =3D=3D '/' ||
+		    /*
+		     * if a and b are "abc" and "origin/abc" respectively,
+		     * accept "a" as the suffix boundary too.
+		     */
+		    (pa =3D=3D a && pb > b && pb[-1] =3D=3D '/') ||
+		    (pb =3D=3D b && pa > a && pa[-1] =3D=3D '/'))
+			final_count =3D count;
+	}
+
+	return final_count;
+}
+
+static void print_remote_to_local(struct strbuf *display,
+				  const char *remote, const char *local)
+{
+	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+}
+
+static void print_compact(struct strbuf *display,
+			  const char *remote, const char *local)
+{
+	int len =3D common_suffix_length(remote, local);
+
+	if (len) {
+		strbuf_addf(display, "{%.*s -> %.*s}%s",
+			    (int)strlen(remote) - len, remote,
+			    (int)strlen(local) - len, local,
+			    remote + strlen(remote) - len);
+		return;
+	}
+	print_remote_to_local(display, remote, local);
+}
+
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
 {
 	strbuf_addf(display, "%c %-*s ", code, TRANSPORT_SUMMARY(summary));
-	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+	switch (compact_format) {
+	case 0:
+		print_remote_to_local(display, remote, local);
+		break;
+	case 1:
+		print_compact(display, remote, local);
+		break;
+	}
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
--=20
2.8.2.524.g6ff3d78
