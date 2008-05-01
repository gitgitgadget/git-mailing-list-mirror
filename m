From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2 1/3] Preparation to call determine_author_info from prepare_to_commit
Date: Thu,  1 May 2008 14:18:37 +0200
Message-ID: <1209644317-2480-1-git-send-email-sbejar@gmail.com>
References: <1209643775-2362-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 14:19:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrXlU-0008C8-KX
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 14:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbYEAMTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 08:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYEAMTH
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 08:19:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:20605 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbYEAMTG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 08:19:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so529001fgg.17
        for <git@vger.kernel.org>; Thu, 01 May 2008 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=3J8XiiBAsjhSlbSZHTew2aW2KIOByAaMkLFGcmBQvlA=;
        b=LD6Pnu4bbi2RDF/+koR321XRU1Mdli4Sn9sMlQPjArzHu9pbMCMAh/c02c71zJ0kCrKT2NdIQH26XEVxvZNvGXRAaFycdExoEIgm5BvrvsDiktVcCtBS1OW+/AV1F/diZBNutGyV2BP4mH9d34/WYNKNvhs3MKLfrZqGaQJrA3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=krIuTJ5onGFYwxKdW/EsIVHG5ii5trSEvUEFuzOSg2Hn5MJD8vW31O4k6drgd8naGk932y+SktFZoxhma8CJ3/cpbN1eYJdpRU82Z43mH5YKJAnK/hR47izKyfzafI6vndN0PQg8k2t1m2Ns1C0pRZU99/pP6vypJ+4CI7CkJhk=
Received: by 10.86.65.11 with SMTP id n11mr1220507fga.15.1209644344620;
        Thu, 01 May 2008 05:19:04 -0700 (PDT)
Received: from localhost ( [91.13.119.190])
        by mx.google.com with ESMTPS id j9sm9990687mue.5.2008.05.01.05.19.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 May 2008 05:19:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.102.gfcc7d.dirty
In-Reply-To: <1209643775-2362-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80906>

Reorder functions definitions such that determine_author_info is
defined before prepare_to_commit. No code changes.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
Hi *
  somehow my email ended as sbjear instead of sbejar only in this patch=
=2E

  Please use this mail.

  Santi

 builtin-commit.c |   78 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 256181a..a37d8c3 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -395,6 +395,45 @@ static int is_a_merge(const unsigned char *sha1)
=20
 static const char sign_off_header[] =3D "Signed-off-by: ";
=20
+static void determine_author_info(struct strbuf *sb)
+{
+	char *name, *email, *date;
+
+	name =3D getenv("GIT_AUTHOR_NAME");
+	email =3D getenv("GIT_AUTHOR_EMAIL");
+	date =3D getenv("GIT_AUTHOR_DATE");
+
+	if (use_message) {
+		const char *a, *lb, *rb, *eol;
+
+		a =3D strstr(use_message_buffer, "\nauthor ");
+		if (!a)
+			die("invalid commit: %s", use_message);
+
+		lb =3D strstr(a + 8, " <");
+		rb =3D strstr(a + 8, "> ");
+		eol =3D strchr(a + 8, '\n');
+		if (!lb || !rb || !eol)
+			die("invalid commit: %s", use_message);
+
+		name =3D xstrndup(a + 8, lb - (a + 8));
+		email =3D xstrndup(lb + 2, rb - (lb + 2));
+		date =3D xstrndup(rb + 2, eol - (rb + 2));
+	}
+
+	if (force_author) {
+		const char *lb =3D strstr(force_author, " <");
+		const char *rb =3D strchr(force_author, '>');
+
+		if (!lb || !rb)
+			die("malformed --author parameter");
+		name =3D xstrndup(force_author, lb - force_author);
+		email =3D xstrndup(lb + 2, rb - (lb + 2));
+	}
+
+	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERR=
OR_ON_NO_NAME));
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefi=
x)
 {
 	struct stat statbuf;
@@ -622,45 +661,6 @@ static int message_is_empty(struct strbuf *sb, int=
 start)
 	return 1;
 }
=20
-static void determine_author_info(struct strbuf *sb)
-{
-	char *name, *email, *date;
-
-	name =3D getenv("GIT_AUTHOR_NAME");
-	email =3D getenv("GIT_AUTHOR_EMAIL");
-	date =3D getenv("GIT_AUTHOR_DATE");
-
-	if (use_message) {
-		const char *a, *lb, *rb, *eol;
-
-		a =3D strstr(use_message_buffer, "\nauthor ");
-		if (!a)
-			die("invalid commit: %s", use_message);
-
-		lb =3D strstr(a + 8, " <");
-		rb =3D strstr(a + 8, "> ");
-		eol =3D strchr(a + 8, '\n');
-		if (!lb || !rb || !eol)
-			die("invalid commit: %s", use_message);
-
-		name =3D xstrndup(a + 8, lb - (a + 8));
-		email =3D xstrndup(lb + 2, rb - (lb + 2));
-		date =3D xstrndup(rb + 2, eol - (rb + 2));
-	}
-
-	if (force_author) {
-		const char *lb =3D strstr(force_author, " <");
-		const char *rb =3D strchr(force_author, '>');
-
-		if (!lb || !rb)
-			die("malformed --author parameter");
-		name =3D xstrndup(force_author, lb - force_author);
-		email =3D xstrndup(lb + 2, rb - (lb + 2));
-	}
-
-	strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, IDENT_ERR=
OR_ON_NO_NAME));
-}
-
 static int parse_and_validate_options(int argc, const char *argv[],
 				      const char * const usage[])
 {
--=20
1.5.5.1.102.gfcc7d.dirty
