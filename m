From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] parseopt: OPT_COLUMN to set struct column_layout.mode
Date: Tue,  8 Feb 2011 22:22:17 +0700
Message-ID: <1297178541-31124-4-git-send-email-pclouds@gmail.com>
References: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 16:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmpQS-0006js-Tb
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 16:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1BHPYQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 10:24:16 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab1BHPYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 10:24:15 -0500
Received: by mail-pz0-f46.google.com with SMTP id 35so1140930pzk.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 07:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=bqAYMZQlM9Q4B1LLQkSsis0pzGcMjtdvHolIG4107PU=;
        b=x6uqDhknbnAHC5T6wWmzNFbo0NgEcet0J05H1tpfdlZZIS+yHkqyvc+RELbYsmShou
         9PrjESwwnsOJS4pnFEhtMWZdH89spfJYGVd9GRPHrfXm2keWmQJ1LOrAkVfUwPCv6TW5
         dg6oHaz5RP035u1YA1TMTNSi9BbUY5nHwstSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mPsAlXHCgy0e5/R8/6N7RU6fAbf2wht6GAFRk1x82dIwswu2Xucw7S6EbOAaPSQXMd
         sue2LzJyDEykhf0kCFFi10Tp8G5D/MTjSvnyMnRMnP0v9rPb5jLVLtvyYLzA1ZcE9q6D
         QGeUTgGSNhAh9+AmYVeAmsf5+8MJ6+cUvjJkY=
Received: by 10.142.104.10 with SMTP id b10mr17384301wfc.37.1297178655351;
        Tue, 08 Feb 2011 07:24:15 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id x35sm7717507wfd.1.2011.02.08.07.24.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 07:24:14 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 Feb 2011 22:22:47 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297178541-31124-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166354>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c        |   18 ++++++++++++++++++
 column.h        |    3 +++
 parse-options.h |    2 ++
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 4b92fa5..c4a90d5 100644
--- a/column.c
+++ b/column.c
@@ -175,3 +175,21 @@ void display_columns(const struct column_layout *c=
, int padding, const char *ind
 		die("BUG: invalid mode %d", c->mode & COL_MODE);
 	}
 }
+
+int parseopt_column_callback(const struct option *opt, const char *arg=
, int unset)
+{
+	struct column_layout *cp =3D opt->value;
+	if (unset) {
+		cp->mode =3D COL_PLAIN;
+		return 0;
+	}
+	if (!arg || !strcmp(arg, "column")) {
+		cp->mode |=3D COL_COLUMN_FIRST;
+		return 0;
+	}
+	if (!strcmp(arg, "dense")) {
+		cp->mode |=3D COL_DENSE;
+		return 0;
+	}
+	return error("unsupported style '%s'", arg);
+}
diff --git a/column.h b/column.h
index 34435b0..7f0ae74 100644
--- a/column.h
+++ b/column.h
@@ -17,4 +17,7 @@ struct column_layout {
=20
 extern void display_columns(const struct column_layout *c, int padding=
, const char *indent);
=20
+struct option;
+extern int parseopt_column_callback(const struct option *opt, const ch=
ar *arg, int unset);
+
 #endif
diff --git a/parse-options.h b/parse-options.h
index 31ec5d2..2fed453 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -145,6 +145,8 @@ struct option {
 #define OPT_COLOR_FLAG(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "when", (h), PARSE_OPT_OPTARG, \
 		parse_opt_color_flag_cb, (intptr_t)"always" }
+#define OPT_COLUMN(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), "style", (h), PARSE_OPT_OPTARG, par=
seopt_column_callback }
=20
=20
 /* parse_options() will filter out the processed options and leave the
--=20
1.7.2.2
