From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 12/20] update-index: enable/disable watchman support
Date: Thu, 12 May 2016 16:20:07 -0400
Message-ID: <1463084415-19826-13-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6k-0005OJ-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcELUVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:21:13 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35021 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcELUUs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:48 -0400
Received: by mail-ig0-f179.google.com with SMTP id bi2so185171023igb.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=kICX6uVPSuGPXAm6qnhezNNtug7izJW5jcKTb3T/iSA0ETeYikjyAoTkP4y76jx1/7
         BM8hP69jGVacu2YvKuE11DgLIxBZVT04uz+PIEEy6PbySZ6pbwuc7Q2qYC0R3wzNRDq2
         J4YuqkEU/Ad8LL8BoHEvGzxrc+QLv78oyIEaFy47zrwK+rFnxKW0yNFQoh672wL/KfG3
         XxkOTC5S3F5wYrpxhA8AJl5ZJAoTBjBUJe05vcIYNI0qcv6gkMGrPxRrAEugorXuRp3q
         OUqBmSRHUQ+iQWWPclexXvoy3XofGINihtgLiYb3lmcNrqJhJINjDRiHOoQALcuguvD4
         bH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=GpgT3LkWj7w7H8mv6zTRzgogpzEA+j13hMVMec03W98MakyUPe6WpvxJ6tNgcodcXg
         DBbKm5iR0580M0z3oTSPWeR+0Q0pCpnOOcMV14Q2fh0stLiSe1Rs9WZpRlgnAd6Lb9Mg
         pt5IZDFJPa6WUWkT0OEpdTrVUHaDozTWMGRcGRJUEKFBSrM3gmiJpSvlgaMBKPuwSc58
         Jk7CFuk0DOadn61Ig4xc8uCoXzVafRfv2JTRjyKuKlWFlPThMQg+Xsr4PNAvDIFT9tRk
         N7zAa68SMbOdXHqYsXWrIa2visHf/jINjMoPiahXM4Mze4OmZ5ufc1t/LO42lyF/b/sU
         eDlg==
X-Gm-Message-State: AOPr4FUL0FxBpGAvvKO8g1xPBOFSkTr7mczMEKe0FIusk91TM4MH9X7vZ4eC9IJbG2NfBw==
X-Received: by 10.50.176.134 with SMTP id ci6mr9802304igc.32.1463084442725;
        Thu, 12 May 2016 13:20:42 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294466>

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
