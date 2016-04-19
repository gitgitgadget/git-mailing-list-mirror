From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 10/15] update-index: enable/disable watchman support
Date: Tue, 19 Apr 2016 19:28:04 -0400
Message-ID: <1461108489-29376-11-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4Y-0008N0-6L
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbcDSX2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 19:28:39 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34222 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbcDSX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:27 -0400
Received: by mail-qg0-f51.google.com with SMTP id c6so19267369qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzAPoM28+zMVfXpXnGH8QM8WRdHOH2iS3U0x2oE8ZSs=;
        b=sU+aB2zLUr9MvAI/N+UDaGsr3Lq/fvt3UvxquvqWiacKciQSC0zjfJtovjtXageyfB
         fp/vPInRtWUOw4dZqjKO8SAUs8EG8KVEMdfvpJF3ULBOyCpZ9rXXoZ3NsI5Z821YeSDh
         mv2B7uXpDaYjP7ZZgIRQJ6jLg/dJBLA7zPpCDn314UKfnzGzv8A3TFhjv2Sf8cbsIuof
         jDZsAfSjJ95MOAICIFfliaBh4uFKvMcEjt6D66wTxGvPgFA3cjhCOAf6ND6NooDJHLSc
         uiDvqT53/MtEL2HE5OpG4m+bLWLUo4cMYvu1r+pSfuaE+hncXZaD4wv5U5m1yjjIiPcp
         887w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzAPoM28+zMVfXpXnGH8QM8WRdHOH2iS3U0x2oE8ZSs=;
        b=luX+PSaI19jkKH/hBSH64l1Q5SabV0zIs0IjQQ0GVFfxIFwYivqek+OP6nFdLVaCcd
         S2Ko+85/KATWPlk6E7XeDxRo5g9aRWArhxM/8xLTGCFTUJVtWCYdHDKXF156zm4qGIl/
         H/iHw1/ksyI5fyBbBPO+xyNlLLL/4bVIQR+hVGr9MNTBKBC4kPMrXg9irUipjmHiynk4
         RJzdYncs5YYPXyvMJoVKoKHw/Ud1UXT24ExSkxXN0KlTRqcFh+IxRYzu1hZ9GxvBk077
         jKqe/vyqUUxJeriSvgmwkADSNY+PjPxp97Lst8+v8wrFJikt+cdAmHGgX+v3VA8gUXQk
         M5yQ==
X-Gm-Message-State: AOPr4FUZkPrEe8ec3osgxlYRVKebZNpNQ2ufTnwFOLA4nnutE871gi7pLO4fnVQV9A5i5w==
X-Received: by 10.140.226.19 with SMTP id w19mr7579090qhb.55.1461108506462;
        Tue, 19 Apr 2016 16:28:26 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:25 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291962>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 Documentation/git-update-index.txt |  6 ++++++
 builtin/update-index.c             | 11 +++++++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index b1fa49e..dd039a1 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -15,6 +15,9 @@ DESCRIPTION
 Keep the index file in memory for faster access. This daemon is per
 repository.
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
index 1c94ca5..7c08e1c 100644
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
@@ -1149,6 +1152,14 @@ int cmd_update_index(int argc, const char **argv=
, const char *prefix)
 		die("Bug: bad untracked_cache value: %d", untracked_cache);
 	}
=20
+	if (use_watchman > 0) {
+		the_index.last_update    =3D xstrdup("");
+		the_index.cache_changed |=3D WATCHMAN_CHANGED;
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
