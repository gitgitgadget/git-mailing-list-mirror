From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/16] parseopt: OPT_COLUMN to set struct column_layout.mode
Date: Wed,  9 Feb 2011 19:24:35 +0700
Message-ID: <1297254284-3729-8-git-send-email-pclouds@gmail.com>
References: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 13:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pn98g-0007RE-8P
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 13:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab1BIM1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 07:27:12 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48725 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1BIM1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 07:27:10 -0500
Received: by pva4 with SMTP id 4so17481pva.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+Zgn/jSGtRHevrD2PbV9XSJRJadrgqGEHbRnon/v600=;
        b=NBwOSBaExMGc0rc+SxlGdI3keSU7I6rQWFjH6lTER4MTOqBMmV+06hTJFnnGW5Xw+n
         MsqD7HBlj++PHHCvZVtXTY7tFXcJeh4fyRi0XUEzSasCWwpu+SV3ndJfa/NcnW1Ayj3H
         r+H0hlt5Y68OxPKGzMQctoUH93U1I8B0D+9Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B28JMMyESgEXh2OmByXogPHEuMbtOmOfEkF/7QJaVbSOunDUssViHg6iBYUznjMLAs
         S3c/jGghz0BMR99QJ7b5kpAzlMXaavPBbIehZh/TOLH+dH0n0JpdxlrQ6vCoiNKpeEdx
         HY7vs7ngQVZeN8EMWYJ3bs1o/IFBTspyE5b/Y=
Received: by 10.142.47.2 with SMTP id u2mr18382405wfu.63.1297254430117;
        Wed, 09 Feb 2011 04:27:10 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id b11sm330289wff.21.2011.02.09.04.27.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 04:27:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 09 Feb 2011 19:25:39 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
In-Reply-To: <1297254284-3729-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166411>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 column.c        |   15 +++++++++++++++
 column.h        |    3 +++
 parse-options.h |    2 ++
 3 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/column.c b/column.c
index 615a698..c08a885 100644
--- a/column.c
+++ b/column.c
@@ -270,3 +270,18 @@ int git_config_column(const char *var, const char =
*value, int stdout_is_tty)
=20
 	return 0;
 }
+
+int parseopt_column_callback(const struct option *opt, const char *arg=
, int unset)
+{
+	int *mode =3D opt->value;
+	if (unset) {
+		*mode =3D COL_MODE_PLAIN;
+		return 0;
+	}
+	if (!arg) {
+		if (!MODE(*mode))
+			*mode |=3D COL_MODE_COLUMN;
+		return 0;
+	}
+	return parse_column_option(arg, strlen(arg), mode);
+}
diff --git a/column.h b/column.h
index 0749793..99ec848 100644
--- a/column.h
+++ b/column.h
@@ -12,4 +12,7 @@ extern int term_columns(void);
 extern void display_columns(const struct string_list *list, int mode, =
int width, int padding, const char *indent);
 extern int git_config_column(const char *var, const char *value, int s=
tdout_is_tty);
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
