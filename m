From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] parse-options: remove OPT_BOOLEAN
Date: Sat,  7 Dec 2013 12:02:53 +0700
Message-ID: <1386392573-27367-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 05:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp9y4-0001ee-PC
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 05:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab3LGE6M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 23:58:12 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:62172 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3LGE6M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 23:58:12 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so2210367pbc.25
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 20:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=moseNrdSiwUBmpkzP8yJ1rsR+4ZkMbv/xWyKaydVTug=;
        b=TfE8xWT+n65IRhQOfTM0mglbiT6RZkw0yuHWFBFj8rkvdwNnDhUirkv+EMxG2SySrM
         KlQLY0q2C8/91E6I8sukzOOsvE3qWXr4AU7/HvLqZBwhnpg5EBdou6M/90DcXpIdsgW4
         NKM/cfp0KqUuP21lrriI2jP/HtEXhdJ5O89eLkNSzjntvaqpahIHAkgl0tJpsCWRrRqo
         Hf34DCSrNlQHqvN+IMQvbPZAIK3VG18rrbemLqscgzB+iVMRTsErXoSpAcGfZcmck3oX
         smYvv24s3hatG2iTNyxUlXAwfgtKQC4A+BiUqySoNHKwjmM2jefSyFOZuHu4wbgLi+wz
         guJQ==
X-Received: by 10.68.189.101 with SMTP id gh5mr8335618pbc.39.1386392291543;
        Fri, 06 Dec 2013 20:58:11 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id vi2sm1477227pbc.21.2013.12.06.20.58.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 20:58:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Dec 2013 12:02:56 +0700
X-Mailer: git-send-email 1.8.5.1.77.g42c48fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238971>

After a86a8b9 (sb/parseopt-boolean-removal), the deprecated
OPT_BOOLEAN is not used anywhere except by OPT__* macros. Kill
OPT_BOOLEAN and make OPT__* use OPT_COUNTUP directly instead. This
should stop OPT_BOOLEAN from entering the tree again in new patches.

OPT__DRY_RUN() is converted to use OPT_BOOL though because it does not
make sense to increase the level of dryness. All OPT__DRY_RUN call
sites have been checked and they look safe for OPT_BOOL.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 8736006..d670cb9 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -161,9 +161,6 @@ struct option {
 	  N_("no-op (backward compatibility)"),		\
 	  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, parse_opt_noop_cb }
=20
-/* Deprecated synonym */
-#define OPT_BOOLEAN OPT_COUNTUP
-
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. usagestr strings should be marked
  * for translation with N_().
@@ -232,15 +229,15 @@ extern int parse_opt_tertiary(const struct option=
 *, const char *, int);
 extern int parse_opt_string_list(const struct option *, const char *, =
int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int)=
;
=20
-#define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
-#define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
+#define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
+#define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose")=
, \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
 	{ OPTION_CALLBACK, 'q', "quiet", (var), NULL, N_("be more quiet"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }
-#define OPT__DRY_RUN(var, h)  OPT_BOOLEAN('n', "dry-run", (var), (h))
-#define OPT__FORCE(var, h)    OPT_BOOLEAN('f', "force",   (var), (h))
+#define OPT__DRY_RUN(var, h)  OPT_BOOL('n', "dry-run", (var), (h))
+#define OPT__FORCE(var, h)    OPT_COUNTUP('f', "force",   (var), (h))
 #define OPT__ABBREV(var)  \
 	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
 	  N_("use <n> digits to display SHA-1s"),	\
--=20
1.8.5.1.77.g42c48fa
