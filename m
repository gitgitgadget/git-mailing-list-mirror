From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 11/19] update-index: enable/disable watchman support
Date: Mon,  9 May 2016 16:48:41 -0400
Message-ID: <1462826929-7567-12-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:49:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7O-0003yU-OO
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcEIUtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:22 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33444 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcEIUtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:19 -0400
Received: by mail-qg0-f50.google.com with SMTP id f92so95678699qgf.0
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=xRKp6q9KMgiLyny7XPoMlW23bMsFe1la/KnuiF213cqec/XsWr1wgR0bJmUSy44C74
         XlpWNS/Qa2TGOQkOmXpHKwcV784vUabJdzzxvUvEgjDFBTjzSiUo7VoYotM8GXDO/DI4
         5y27SStZpxmzEDJHES7kXMCE6tD6LhYVoqsGdv0wBgOFyBL7mwBblWMV5PbNmCJnbd6q
         nDDvlLkTGoFflgfbdFYMnbo7p9MYjWVCh+da0yKit68kZczQtJ50p/s9SHwXa9FPAPdv
         dnUcT4bDMwFzJVpa0wFlsWEYG2lIgKTSB/1mr6Nq4nfZwdzrXdqE6y0rLycKWvK59RM3
         Bckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=jfr1bRG1XpuvQcz+00OgiJBt2D/QFFhENmO0EiYOHypdM98xTy6ZebeJnkSw19HaDU
         DKhnEIBlGzqiEs3CNzzBARQZONCy1FVJam7J1NgzQYWQv3neiUeuM23snuLbNKp0xgp7
         XlxMDz2SWpXdHE4Nn/29fgwDkEYZwF3M/SjYEWOBcEkZ4p0J7XCSLSL9kVvdZTmEYXtb
         dNO7WBnYh48gKVsm+M9wNEqM8/1VTm/r06b5J7tXbpiEGHbQBS1ofUxDxtqbmu9KxVG8
         8IxgyypPHPxqDWfribDhcU5pCIVTeDE05ymCGuCem5eo7KB2SrTVT6bz9kLwIfztuZ8Y
         iE7A==
X-Gm-Message-State: AOPr4FXYOBuj4/R6J5d1+TioxxrCVcjC0u2AR/2A6xuydVCw4CoNpUeZZ8Gog3i49EUGjw==
X-Received: by 10.140.156.81 with SMTP id c78mr39989434qhc.58.1462826958515;
        Mon, 09 May 2016 13:49:18 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294050>

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
