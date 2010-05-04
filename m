From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] pretty: Respect --abbrev option
Date: Tue, 4 May 2010 03:34:21 -0500
Message-ID: <20100504083421.GA8338@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
 <20100504025217.GA7322@progeny.tock>
 <20100504031856.GF7322@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 10:34:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Da6-00004v-2f
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 10:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921Ab0EDIeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 04:34:11 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:65271 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab0EDIeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 04:34:10 -0400
Received: by yxe1 with SMTP id 1so845572yxe.33
        for <git@vger.kernel.org>; Tue, 04 May 2010 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qtkPknuYXzfzII0gVo85EE5ofnIIrQzh6/o2hnTL9qw=;
        b=SHs1mTLCYZJ7CBW/pUxMQWr4VswKRbw+6LqxJJdiIBaWhXlg7ceDmkoCellqyaHDaU
         gqrdRtAS3rBHbHEdBxXz2URMW9SpyguYbNpCCYbnZD2LXibbECTIalvpYRa6luOsXpw3
         JWtydBozs8ZDMvTT64I6kW7XL+PlY6GRKUmu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C+Ao1oHpd6Sch1onOCl9FDUru5p+M0FurNWcjcovqMk5ECAa7SUF/R8FXlxEIV49Zx
         bezBLdlxnJfgpIgga3hY1KgcUWetDjYBU/8Q3BqMs8OTR1wCgJubIhQG+tNtSDXA5/q4
         1jcR/BZLqXSzDxGXKTXLBUMls8B+BhcrQCvKE=
Received: by 10.150.165.7 with SMTP id n7mr11388545ybe.38.1272962049221;
        Tue, 04 May 2010 01:34:09 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm5164915iwn.4.2010.05.04.01.34.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 01:34:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504031856.GF7322@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146301>

Jonathan Nieder wrote:

> Subject: [PATCH 5/5] pretty: Respect --abbrev option
[...]
> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

This patch was by Will Palmer <wmpalmer@gmail.com> (except two
of the tests).  Since I don=E2=80=99t use =E2=80=98git send-email=E2=80=
=99, I keep
forgetting to include the From: pseudo-header.

Sorry for the trouble,
Jonathan

diff --git a/pretty.c b/pretty.c
index 1430616..e5dea91 100644
--- a/pretty.c
+++ b/pretty.c
@@ -908,6 +908,7 @@ static void pp_header(enum cmit_fmt fmt,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
+		      const char **author_p,
 		      struct strbuf *sb)
 {
 	int parents_shown =3D 0;
@@ -954,6 +955,8 @@ static void pp_header(enum cmit_fmt fmt,
 		 * FULLER shows both authors and dates.
 		 */
 		if (!memcmp(line, "author ", 7)) {
+			if (author_p)
+				*author_p =3D line + 7;
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info("Author", fmt, sb, line + 7, dmode, encoding);
 		}
@@ -1004,6 +1007,22 @@ void pp_title_line(enum cmit_fmt fmt,
 	strbuf_release(&title);
 }
=20
+static void pp_in_body_author(struct strbuf *sb,
+			      const char *author_line)
+{
+	const char *author_end, *sender;
+
+	author_end =3D strchr(author_line, '>') + 1;
+	sender =3D git_author_info(IDENT_NO_DATE);
+	if (!strncmp(author_line, sender, author_end - author_line))
+		return;
+
+	strbuf_addstr(sb, "From: ");
+	strbuf_add(sb, author_line, author_end - author_line);
+	strbuf_addch(sb, '\n');
+	strbuf_addch(sb, '\n');
+}
+
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
@@ -1057,6 +1076,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const=
 struct commit *commit,
 	unsigned long beginning_of_body;
 	int indent =3D 4;
 	const char *msg =3D commit->buffer;
+	const char *author =3D NULL;
 	char *reencoded;
 	const char *encoding;
 	int need_8bit_cte =3D context->need_8bit_cte;
@@ -1082,15 +1102,13 @@ void pretty_print_commit(enum cmit_fmt fmt, con=
st struct commit *commit,
 		int i, ch, in_body;
=20
 		for (in_body =3D i =3D 0; (ch =3D msg[i]); i++) {
-			if (!in_body) {
-				/* author could be non 7-bit ASCII but
-				 * the log may be so; skip over the
-				 * header part first.
-				 */
-				if (ch =3D=3D '\n' && msg[i+1] =3D=3D '\n')
-					in_body =3D 1;
-			}
-			else if (non_ascii(ch)) {
+			/*
+			 * If the author is non 7-bit ASCII but
+			 * the log is 7bit, we still need a
+			 * Content-type field, in case an in-body
+			 * From: line is required.
+			 */
+			if (non_ascii(ch)) {
 				need_8bit_cte =3D 1;
 				break;
 			}
@@ -1098,7 +1116,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const=
 struct commit *commit,
 	}
=20
 	pp_header(fmt, context->abbrev, context->date_mode, encoding,
-		  commit, &msg, sb);
+		  commit, &msg, &author, sb);
 	if (fmt !=3D CMIT_FMT_ONELINE && !context->subject) {
 		strbuf_addch(sb, '\n');
 	}
@@ -1111,6 +1129,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const=
 struct commit *commit,
 		pp_title_line(fmt, &msg, sb, context->subject,
 			      context->after_subject, encoding, need_8bit_cte);
=20
+	if (fmt =3D=3D CMIT_FMT_EMAIL)
+		pp_in_body_author(sb, author);
+
 	beginning_of_body =3D sb->len;
 	if (fmt !=3D CMIT_FMT_ONELINE)
 		pp_remainder(fmt, &msg, sb, indent);
--=20
