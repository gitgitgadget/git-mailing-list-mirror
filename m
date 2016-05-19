From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 12/20] update-index: enable/disable watchman support
Date: Thu, 19 May 2016 17:45:49 -0400
Message-ID: <1463694357-6503-13-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmY-0006fg-Vo
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbcESVq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:57 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36513 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbcESVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:52 -0400
Received: by mail-qg0-f51.google.com with SMTP id w36so51242657qge.3
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=HGMb69ILxNNyLWZRGb5Rev3R7kIKOcKyier0RP3BgcrCsJXzGmujHvWHAkJ2oVqYtu
         6Rs3OO/OFVXzVJPIJv6fzlZ7Pidi/gn6e8BcBcBOkM7E3rJpJlkLIF8VZyIiMg5Jyi0Z
         VfWsHcysa+Nd1CYF1atsIC38swjtfk4DrxPo8hrpvjDS+VdSfm/a3Cn4H9QjbkGgrFEV
         k4/kT3Pu9DzSXeG2bmAbhX5K4KFddPZIuxT1e9fBemoA+KQE2hsOs+TGjzH1xmxOKLhb
         i4+VZoeUVtxDEGJhby/XoSDV19peEIfv1783k7M+Yw9ZFUUPx9QaiPlwIKdQJWQoMg5q
         th0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSr2DGtyMt6TUopcmYTDQ2btCuOfdB6/kMtI5ERbNfM=;
        b=RAj34QhGzXDlEa/CRTYGX4mSJo4UTvXUNH9y3g7cJSBAjgilNaSyW5AVczhNeFj2Eu
         GpSjNlYGnQKa6D3Yq6G0A2HZtq1Nyfk8HUzcyI14P34onyPaJkbiFq58dqOYMPzSwGWS
         oa8Ho8IoMtat+78HCG5bwtWgie1QZutay5sg38PjkcQwt8/j9Xe0skC1V0qXAACZk0wJ
         89DPuCv+jASml6BKc8QfBoPskUiSbvyAX9bII2ioSSgJDehTZ6POvQyFCpl1nozMmE9c
         YmmhknhhgEGhJazX9Pn85Wu4CENc9XIfdUTgIQswqe2RDR36tNoJlOE06x3cmnSbY0wS
         bhDw==
X-Gm-Message-State: AOPr4FUjhOQ8nD6DvbjIcYGkUnXVr7LaRtCR0ZU50QHIz/QnXSmEzYXe6QlyUhrkio5Byw==
X-Received: by 10.140.29.162 with SMTP id b31mr1268635qgb.2.1463694411610;
        Thu, 19 May 2016 14:46:51 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295113>

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
