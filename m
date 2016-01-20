From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/7] diff.c: take "prefix" argument in diff_opt_parse()
Date: Wed, 20 Jan 2016 18:06:03 +0700
Message-ID: <1453287968-26000-3-git-send-email-pclouds@gmail.com>
References: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 12:06:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLqbB-0003UE-6T
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 12:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbcATLGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 06:06:41 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33501 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817AbcATLGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 06:06:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id e65so268362pfe.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 03:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bhAeBBNuN8WqS3jtEkx9pz0obGN7oLGYNU+zcRaHhZU=;
        b=eU+KNe5TeQL80kvmtriU09z3fhJXma5XUQigPwyZtJ956z7t9t4KGlXphKP7IaGmZT
         8jtZf1/nvIi3qghALRF7OLnFc6ZkbxZ86G/2OrcuGu5ALn36diWO6CtOF1RCEM681pLK
         WXN+y8lG3bhswzXZF0LiiSlApg1C2/jC8hzPjE4S5b0AkVB+B8a5hc7m4OWaeDY+FAqj
         N6IXjmCZG47oya+kydMCKLULfQLZQS1pzD/dUP3d47bwy3OAINutbtn9PLKORv9aoLTG
         qRFZDB36Tnp1+3KQtdr2YwpGsfOsS2HWhHB8hURm/pd4juw1VOCJw1gTLkrbD/THUocx
         BbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=bhAeBBNuN8WqS3jtEkx9pz0obGN7oLGYNU+zcRaHhZU=;
        b=P1mlkl3/7+B/z42o55W2T0UggC8O4wUIQoJuIoEuQx4eTFdvL5g+tq/GE2d+2hZDnl
         MXbLnLw7jmLtcCAcZxI18NFPHrcbp9K/G9x709tVbqmxOBcAtncbCB8Uso48VY6Ggx/G
         HfUoG8Wy//F9bhgWjw5dcMsFAXBpsWayKwwOJ4rJKXJKrwbX0kMFVNuI61TVtHB5J3Hy
         Wyjj2T4dzr3gNgr1fcWFy6zjRy64RS3oJpcez0VgUKC1uOF0oEiHyZW8Uf9hTsKSsN4i
         VgXxQVY1Y9lcRug1kBlxZoAAjSeTf7WTJ0fB1chwIkMenUi3hZ86R8QvwJfcY+yGda7A
         gE+A==
X-Gm-Message-State: ALoCoQlMOfwmebBi4cVVQ0i5usAFcMJxd6tyjpZ+FOKOMptldePThlwsCq3ATkb4dX8If0LHHoGj8qhwciFyUBWYvvT2G9ErXw==
X-Received: by 10.98.75.22 with SMTP id y22mr52129474pfa.147.1453287996894;
        Wed, 20 Jan 2016 03:06:36 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id kw10sm48446355pab.0.2016.01.20.03.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2016 03:06:35 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 20 Jan 2016 18:06:32 +0700
X-Mailer: git-send-email 2.7.0.125.g9eec362
In-Reply-To: <1453287968-26000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284449>

This will be important later when diff_opt_parse() accepts paths as
arguments. Paths must be prefixed before access because setup code
moves cwd but does not (and cannot) update command line options.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/am.c    | 2 +-
 diff-no-index.c | 3 ++-
 diff.c          | 3 ++-
 diff.h          | 2 +-
 revision.c      | 2 +-
 5 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9fb42fd..f009b6c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1657,7 +1657,7 @@ static int fall_back_threeway(const struct am_sta=
te *state, const char *index_pa
=20
 		init_revisions(&rev_info, NULL);
 		rev_info.diffopt.output_format =3D DIFF_FORMAT_NAME_STATUS;
-		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1);
+		diff_opt_parse(&rev_info.diffopt, &diff_filter_str, 1, rev_info.pref=
ix);
 		add_pending_sha1(&rev_info, "HEAD", our_tree, 0);
 		diff_setup_done(&rev_info.diffopt);
 		run_diff_index(&rev_info, 1);
diff --git a/diff-no-index.c b/diff-no-index.c
index 491e842..03daadb 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -252,7 +252,8 @@ void diff_no_index(struct rev_info *revs,
 		else if (!strcmp(argv[i], "--"))
 			i++;
 		else {
-			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i);
+			j =3D diff_opt_parse(&revs->diffopt, argv + i, argc - i,
+					   revs->prefix);
 			if (j <=3D 0)
 				die("invalid diff option/value: %s", argv[i]);
 			i +=3D j;
diff --git a/diff.c b/diff.c
index 80eb0c2..8d38fe8 100644
--- a/diff.c
+++ b/diff.c
@@ -3693,7 +3693,8 @@ static int parse_ws_error_highlight(struct diff_o=
ptions *opt, const char *arg)
 	return 1;
 }
=20
-int diff_opt_parse(struct diff_options *options, const char **av, int =
ac)
+int diff_opt_parse(struct diff_options *options,
+		   const char **av, int ac, const char *prefix)
 {
 	const char *arg =3D av[0];
 	const char *optarg;
diff --git a/diff.h b/diff.h
index f61ee54..76b5536 100644
--- a/diff.h
+++ b/diff.h
@@ -268,7 +268,7 @@ extern int parse_long_opt(const char *opt, const ch=
ar **argv,
 extern int git_diff_basic_config(const char *var, const char *value, v=
oid *cb);
 extern int git_diff_ui_config(const char *var, const char *value, void=
 *cb);
 extern void diff_setup(struct diff_options *);
-extern int diff_opt_parse(struct diff_options *, const char **, int);
+extern int diff_opt_parse(struct diff_options *, const char **, int, c=
onst char *);
 extern void diff_setup_done(struct diff_options *);
=20
 #define DIFF_DETECT_RENAME	1
diff --git a/revision.c b/revision.c
index 0a282f5..14daefb 100644
--- a/revision.c
+++ b/revision.c
@@ -2049,7 +2049,7 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 	} else if (!strcmp(arg, "--ignore-missing")) {
 		revs->ignore_missing =3D 1;
 	} else {
-		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc);
+		int opts =3D diff_opt_parse(&revs->diffopt, argv, argc, revs->prefix=
);
 		if (!opts)
 			unkv[(*unkc)++] =3D arg;
 		return opts;
--=20
2.7.0.125.g9eec362
