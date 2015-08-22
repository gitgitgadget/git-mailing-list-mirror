From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] diff.h: extend "flags" field to 64 bits because we're out of bits
Date: Sat, 22 Aug 2015 08:14:22 +0700
Message-ID: <1440206062-20504-1-git-send-email-pclouds@gmail.com>
References: <1440205700-19749-1-git-send-email-pclouds>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, phiggins@google.com,
	snoksrud@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:14:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxOE-00087m-Tj
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbbHVBOb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:14:31 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33991 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbHVBOa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:14:30 -0400
Received: by padfo6 with SMTP id fo6so17857165pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zqSjcUZ++j/ONAmq5QUzPqF0TvzLhLqKAQzGamKAAvE=;
        b=Qv9TFJWHNhikzxPzwkllBxs0b/ewaW+r556c43oj7uJ4YFKzTsi8qCHBmCuzGAn3F8
         VebAGo6Hx6bHrHT3UdDlG1Hu2EQnnZ6Az9FYomPCNtdj7VEW6peVfXy1JAtlUtmye2oq
         MYD4tVG42z/rT0bpU6xTzEF3o5lDJVMTbKFPedY2wjU1CJS06Labd0/n1MaexRAwvmKn
         HSmOWVUUUDbJOvsedr4eyFszc0VkrxWJ+xWHeDTkZc4euEu1BuupNvT0oroJtf3qkQaN
         aFGl7wQy8b9IiLkVUO+SUvouuXJ88D/WJrLfADqELkYVOBLIG4q/TekRGQlU06BN+XVv
         ABfQ==
X-Received: by 10.66.194.201 with SMTP id hy9mr12946383pac.45.1440206070174;
        Fri, 21 Aug 2015 18:14:30 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id bz4sm9157255pbd.6.2015.08.21.18.14.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:14:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:14:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-1-git-send-email-pclouds>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276360>

I renamed both "flags" and "touched_flags" fields while making this
patch to make sure I was aware of how these flags were manipulated
(besides DIFF_OPT* macros). So hopefully I didn't miss anything.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Resend to the right recipients. I screwed send-email up..

 builtin/commit.c | 2 +-
 diff-lib.c       | 4 ++--
 diff.c           | 2 +-
 diff.h           | 8 +++++---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4cbd5ff..95f7296 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -895,7 +895,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 			 * submodules which were manually staged, which would
 			 * be really confusing.
 			 */
-			int diff_flags =3D DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
+			diff_flags_t diff_flags =3D DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG;
 			if (ignore_submodule_arg &&
 			    !strcmp(ignore_submodule_arg, "all"))
 				diff_flags |=3D DIFF_OPT_IGNORE_SUBMODULES;
diff --git a/diff-lib.c b/diff-lib.c
index 241a843..ae09034 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -71,7 +71,7 @@ static int match_stat_with_submodule(struct diff_opti=
ons *diffopt,
 {
 	int changed =3D ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
-		unsigned orig_flags =3D diffopt->flags;
+		diff_flags_t orig_flags =3D diffopt->flags;
 		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
 		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
@@ -516,7 +516,7 @@ int do_diff_cache(const unsigned char *tree_sha1, s=
truct diff_options *opt)
 	return 0;
 }
=20
-int index_differs_from(const char *def, int diff_flags)
+int index_differs_from(const char *def, diff_flags_t diff_flags)
 {
 	struct rev_info rev;
 	struct setup_revision_opt opt;
diff --git a/diff.c b/diff.c
index 7deac90..2485870 100644
--- a/diff.c
+++ b/diff.c
@@ -4912,7 +4912,7 @@ int diff_can_quit_early(struct diff_options *opt)
 static int is_submodule_ignored(const char *path, struct diff_options =
*options)
 {
 	int ignored =3D 0;
-	unsigned orig_flags =3D options->flags;
+	diff_flags_t orig_flags =3D options->flags;
 	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
 		set_diffopt_flags_from_submodule_config(options, path);
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
diff --git a/diff.h b/diff.h
index f7208ad..4241aa5 100644
--- a/diff.h
+++ b/diff.h
@@ -110,13 +110,15 @@ enum diff_words_type {
 	DIFF_WORDS_COLOR
 };
=20
+typedef uint64_t diff_flags_t;
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
-	unsigned flags;
-	unsigned touched_flags;
+	diff_flags_t flags;
+	diff_flags_t touched_flags;
=20
 	/* diff-filter bits */
 	unsigned int filter;
@@ -347,7 +349,7 @@ extern int diff_result_code(struct diff_options *, =
int);
=20
 extern void diff_no_index(struct rev_info *, int, const char **, const=
 char *);
=20
-extern int index_differs_from(const char *def, int diff_flags);
+extern int index_differs_from(const char *def, diff_flags_t diff_flags=
);
=20
 extern size_t fill_textconv(struct userdiff_driver *driver,
 			    struct diff_filespec *df,
--=20
2.3.0.rc1.137.g477eb31
