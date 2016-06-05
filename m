From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 6/6] fetch: reduce duplicate in ref update status lines with placeholder
Date: Sun,  5 Jun 2016 10:11:41 +0700
Message-ID: <20160605031141.23513-7-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Jun 05 05:12:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9OUN-0004hu-Qr
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 05:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbcFEDM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Jun 2016 23:12:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35409 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbcFEDM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 23:12:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id z187so628096pfz.2
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 20:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10dZKpc6GHRT5ezCxJSJaxFtfLk8Bdqo7d6uR0ddUsw=;
        b=nD6YPCpCe6mhp7PNUjes7w7VuxViqrL243t6UvqtBKYnJX+kDrO7NnKMm4SE4oP837
         eyRzHpvs2zbr/e45ozYF7R+QbYlzU3of8KtKVSU0A6oB4dIw7tUmgWu0LKjRj0JcEnxm
         If5juRdm0PtwZZTqJMcvY557YNOoW4YUjCRN9Yx8Lzs7JokOZug+p+kuWq5L2eOtItu0
         vOop0IjZlY+21wcjEwgAlqQCBIX0T8pC26hyJzBpWuWxnAmplSah478y5wcxz7yo3+TH
         Nj5QKSYR7/bVfNb+91YD3LQ5h12kQm3xtut+j9u66OKyhDTu0DnwKk+m8U2x8NArqfwe
         hQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10dZKpc6GHRT5ezCxJSJaxFtfLk8Bdqo7d6uR0ddUsw=;
        b=jQwePey3ev4gkF4yX/v9D7HO5pS4MUw+7Jk3H2zqnsc/PlaEKLHD/j21vhp82msuzV
         AtHDdP6LSXDK3i+DlkkEp5aie9jMoAhUm/Fk5uCivLMhfJBc56fV2kLX4DIoLrsWUok5
         EelUml/5f1/PjkVGwY+aid43qQ85X0Mdc/2cYJ9nKo7NKJ2ZNngFI+HE0KyEWF1P66yJ
         P7Cuyi6OJH7YDJ4tQTwYhRp5MhfLx+KGvs01i+yPE2pEl9VXzDvriOpNvpRIJOgsmmoa
         kJjmyd2g8oP6FBlhA52CW7WE0q71+5jUrJruvP3mmsBnpRbfeWLNglK+Dugs4bUJMsGY
         5zwg==
X-Gm-Message-State: ALyK8tJp0BqHtJufYx0FoHbKf0U9BXtOComYUMHgMc3TLun9Swtxh0d0Ga83QV+PJ74hnQ==
X-Received: by 10.98.10.137 with SMTP id 9mr3132692pfk.28.1465096346455;
        Sat, 04 Jun 2016 20:12:26 -0700 (PDT)
Received: from ash ([115.76.150.26])
        by smtp.gmail.com with ESMTPSA id c206sm18077407pfc.40.2016.06.04.20.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 20:12:25 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 05 Jun 2016 10:12:21 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160605031141.23513-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296457>

In the "remote -> local" line, if either ref is a substring of the
other, the common part in the other string is replaced with "$". For
example

    abc                -> origin/abc
    refs/pull/123/head -> pull/123

become

    abc         -> origin/$
    refs/$/head -> pull/123

Activated with fetch.format=3Ddollar.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e2ca6bc..c63f913 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -488,11 +488,13 @@ static void prepare_format_display(struct ref *re=
f_map)
 		compact_format =3D 0;
 	else if (!strcasecmp(format, "compact"))
 		compact_format =3D 1;
+	else if (!strcasecmp(format, "dollar"))
+		compact_format =3D 2;
 	else
 		die(_("configuration fetch.output contains invalid value %s"),
 		    format);
=20
-	if (compact_format)
+	if (compact_format =3D=3D 1)
 		return;
=20
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
@@ -549,6 +551,48 @@ static void print_compact(struct strbuf *display,
 	print_remote_to_local(display, remote, local);
 }
=20
+static int dollarize(struct strbuf *haystack, const char *needle)
+{
+	const char *p =3D strstr(haystack->buf, needle);
+	int plen, nlen;
+
+	if (!p)
+		return 0;
+
+	if (p > haystack->buf && p[-1] !=3D '/')
+		return 0;
+
+	plen =3D strlen(p);
+	nlen =3D strlen(needle);
+	if (plen > nlen && p[nlen] !=3D '/')
+		return 0;
+
+	strbuf_splice(haystack, p - haystack->buf, nlen, "$", 1);
+	return 1;
+}
+
+static void print_dollar(struct strbuf *display,
+			 const char *remote, const char *local)
+{
+	struct strbuf r =3D STRBUF_INIT;
+	struct strbuf l =3D STRBUF_INIT;
+
+	if (!strcmp(remote, local)) {
+		strbuf_addf(display, "%s -> $", remote);
+		return;
+	}
+
+	strbuf_addstr(&r, remote);
+	strbuf_addstr(&l, local);
+
+	if (!dollarize(&r, local))
+		dollarize(&l, remote);
+	print_remote_to_local(display, r.buf, l.buf);
+
+	strbuf_release(&r);
+	strbuf_release(&l);
+}
+
 static void format_display(struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local)
@@ -561,6 +605,9 @@ static void format_display(struct strbuf *display, =
char code,
 	case 1:
 		print_compact(display, remote, local);
 		break;
+	case 2:
+		print_dollar(display, remote, local);
+		break;
 	}
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
--=20
2.8.2.524.g6ff3d78
