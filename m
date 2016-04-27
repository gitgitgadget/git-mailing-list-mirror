From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 11/19] update-index: enable/disable watchman support
Date: Wed, 27 Apr 2016 16:04:33 -0400
Message-ID: <1461787481-877-12-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:06:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avVjM-0003h7-O4
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbcD0UGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:06:30 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34292 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbcD0UFX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:23 -0400
Received: by mail-qk0-f176.google.com with SMTP id r184so23560638qkc.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BiE/4MghRhUUz0x3FvRk6J8y3I48vOVYv5CR/E/pCi4=;
        b=TGtWzaxaSsCV/o6z/cC1WwsqpFzUYa69iY99i3FHC7v9HF/o37QB4LtFjAd510FJ6h
         0Yr0Q/p2xYUbn+asbEe8PlL9s/2e1TYjGD5nZlW/x54Gc1Qmy29WsZNkXe1nMwLVw89H
         hu76vGAjJpaDZ9BBoy2xVb5aMnh6TGq10ANRH4E18zRg8bm1JAdletpad/uPUD/3ip7E
         cQXwgqOzdCeKInErGTlkrUChq7dq8lQxiXS0yTqokEEK1YJTYqDa1Y9Pv6xPyeoAqA4B
         roHPO/94nPe2vew0p/2uq3PqeAZzTgyXRMRCNeFKfXe+C8NN9TM49Tr5zkwTlNpNS8/j
         meJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BiE/4MghRhUUz0x3FvRk6J8y3I48vOVYv5CR/E/pCi4=;
        b=anNJRAII8/rL2xG6IYp1BbLzPH57YlViDYu2he9Hce3VUH+FC85B9v5/ZbtARxzjx6
         i+U0KRSkeYMcRbviw/BjWHPJWZtuPc9//mt0RRD2EuSG+9JqB63Hav5lGlvdct/2Crsc
         tzmfvMZIx4NE7SgmYkC52TlC07JznYRIW67F6Prxymwvj2vzmqt6LnfgcVwEeZtRmpVA
         MxNbjme53NcqXmesTt6YJPTWowyf3Pv1WlhX9gKtObkk+TZHb+ldZjybf5fp04EC1ihY
         uAEP6kqkJmjcUz0GPr8qYH3lFV3hLJzgjn5CsrMqT9ax7Aw2UEnfhT5jj3YtPFeGrx0y
         BDiA==
X-Gm-Message-State: AOPr4FWAjiiBkZqBbArzev3aKQ1xhFCUaIkS2qQVcF5RIqaVl52D6vFYSvrShzLHnLqn+Q==
X-Received: by 10.55.70.66 with SMTP id t63mr11107591qka.173.1461787522001;
        Wed, 27 Apr 2016 13:05:22 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292802>

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
index 647b796..d8b8efb 100644
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
