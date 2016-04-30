From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 11/19] update-index: enable/disable watchman support
Date: Fri, 29 Apr 2016 21:02:05 -0400
Message-ID: <1461978133-13966-12-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:02:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJB-00082g-6A
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcD3BCn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 21:02:43 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35471 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbcD3BCh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:37 -0400
Received: by mail-qg0-f43.google.com with SMTP id f74so49689480qge.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=uWKFkrSfsBR2cg8XEZVz5ltxm9yoAd0ejkAnQ0J3JDLgadUlV8Sh8yx7ViupLWkJ7f
         I5uSxbutRgGmIwLnyNdmIl7tXdcOZDBBtI6aDAB0wI+Zo/NlWHGj+t895LSemZrLSxhJ
         00WbI1HPg7Npod3UglH6PRTWOcJDEbcZMMGM5yAqyrR6MVN81mAavlO2YFsCz+V73iJ5
         i/Zy6rSnsVK11E1kck7+ZiLPQoWNt95Cz4RdJEpd6ExjGOxO/fhecG5EsHZcd07aZ7T+
         FLnjOlebNydLkxHuq+nCNHheShHFEhbo8yG2j/+tsWpbHqvJuiP7PJjwhEGqdCXpH89o
         0fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=fAwaFkp3VYplZGkWiywEAeBE/XReqocb1FDmkDQGaAJa1CDfYRKZLpvE0hU8W+B75s
         da7CD7Nf4Qjzk3GnTp40055QsZy8nVcm14LwQtGtgYsrBt8I6GKnJiqRL4Mo/a6P1ekh
         xBAerm2Lrt3FdlDVu1UD31S8BsOWVfzogHtfG2ruS6M6irkqoSj4JHJa9tn9pCTD5M5C
         PvsLQOWMGSWCxPC3x3xrzRPLnOhizuhk1PI/J/SxudD49GS5d4lVdegZcORLIw2mh6Vu
         YF7/NHTiVKsscrlSSYyRxykpd9jSzQpJP4Gl9y0A0DmTIZC8aBBK2qwY5rrDJADeZ9cR
         EMXQ==
X-Gm-Message-State: AOPr4FWG7915pKPjz8mrbIe8jYCie0y8knPbDgO1lWGG7J/phhrVrU1ZUWiIalckWceNpg==
X-Received: by 10.140.29.165 with SMTP id b34mr21356334qgb.100.1461978156135;
        Fri, 29 Apr 2016 18:02:36 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293105>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 Documentation/git-update-index.txt |  6 ++++++
 builtin/update-index.c             | 16 ++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index cce00cb..55a8a5a 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -18,6 +18,9 @@ each with a submodule, you might need four index-help=
ers.  (In practice,
 this is only worthwhile for large indexes, so only use it if you notic=
e
 that git status is slow).
=20
+If you want the index-helper to accelerate untracked file checking,
+run git update-index --watchman before using it.
+
 OPTIONS
 -------
=20
diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index c6cbed1..6736487 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -19,6 +19,7 @@ SYNOPSIS
 	     [--ignore-submodules]
 	     [--[no-]split-index]
 	     [--[no-|test-|force-]untracked-cache]
+	     [--[no-]watchman]
 	     [--really-refresh] [--unresolve] [--again | -g]
 	     [--info-only] [--index-info]
 	     [-z] [--stdin] [--index-version <n>]
@@ -176,6 +177,11 @@ may not support it yet.
 --no-untracked-cache::
 	Enable or disable untracked cache feature. Please use
 	`--test-untracked-cache` before enabling it.
+
+--watchman::
+--no-watchman::
+	Enable or disable watchman support. This is, at present,
+	only useful with git index-helper.
 +
 These options take effect whatever the value of the `core.untrackedCac=
he`
 configuration variable (see linkgit:git-config[1]). But a warning is
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 1c94ca5..a3b4b5d 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -914,6 +914,7 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 {
 	int newfd, entries, has_errors =3D 0, nul_term_line =3D 0;
 	enum uc_mode untracked_cache =3D UC_UNSPECIFIED;
+	int use_watchman =3D -1;
 	int read_from_stdin =3D 0;
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	int preferred_index_format =3D 0;
@@ -1012,6 +1013,8 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 			    N_("test if the filesystem supports untracked cache"), UC_TEST)=
,
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
 			    N_("enable untracked cache without testing the filesystem"), UC=
_FORCE),
+		OPT_BOOL(0, "watchman", &use_watchman,
+			N_("use or not use watchman to reduce refresh cost")),
 		OPT_END()
 	};
=20
@@ -1149,6 +1152,19 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
 		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
=20
+	if (use_watchman > 0) {
+		the_index.last_update    =3D xstrdup("");
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+#ifndef USE_WATCHMAN
+		warning("git was built without watchman support -- I'm "
+			"adding the extension here, but it probably won't "
+			"do you any good.");
+#endif
+	} else if (!use_watchman) {
+		the_index.last_update    =3D NULL;
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
+	}
+
 	if (active_cache_changed) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
--=20
2.4.2.767.g62658d5-twtrsrc
