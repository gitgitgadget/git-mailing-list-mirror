From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 7/8] diff.h: extend "flags" field to 64 bits because we're out of bits
Date: Sat, 22 Aug 2015 08:11:14 +0700
Message-ID: <1440205874-20295-1-git-send-email-pclouds@gmail.com>
References: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 03:11:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSxLK-0006Lq-5g
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 03:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbbHVBL3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 21:11:29 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34593 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbbHVBL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 21:11:29 -0400
Received: by padfo6 with SMTP id fo6so17821013pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mHnN1NaQjFEenc8uCy35NbQOvwhxmgoU5MEgZZ5dtvQ=;
        b=DfZmuS4LyyjBeFFeO2EeNhW7b81hUT0jEj/BwE6uv/o3M4jB2goZASTqotDuuTwzjq
         1vaqZqDjhOL/pDEApQnuKqt/t0GZOqOLtZqX4jl22qr8zFlP56ssFE+gWBPGnioqVSkA
         dWeTmsxnRyI/2Y/xMVzdenR50TX+M1CTEAei+bFM96y5Ra85k4POEuFgTRr35CYzXeDa
         yNKRJibdutBSDZEZaiFM5rLaGZz6sUSvpASCgzaeK97KrEZX9E/jTbwMI0U7vBsI5EYY
         pmMbEvanynFEiVwAwZYFUPWPF9ogPZLLPMG9swtBMjVp/br+FI6B/GfavO1XwTy5tCOS
         o3eQ==
X-Received: by 10.66.243.225 with SMTP id xb1mr22659114pac.78.1440205888774;
        Fri, 21 Aug 2015 18:11:28 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id gx1sm9135765pbc.29.2015.08.21.18.11.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 18:11:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Aug 2015 08:11:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440205700-19749-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276359>

I renamed both "flags" and "touched_flags" fields while making this
patch to make sure I was aware of how these flags were manipulated
(besides DIFF_OPT* macros). So hopefully I didn't miss anything.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
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
