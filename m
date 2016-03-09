From: David Turner <dturner@twopensource.com>
Subject: [PATCH 14/19] update-index: enable/disable watchman support
Date: Wed,  9 Mar 2016 13:36:17 -0500
Message-ID: <1457548582-28302-15-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiz1-0007bL-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933876AbcCIShQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:37:16 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34232 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933835AbcCISgr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:47 -0500
Received: by mail-qg0-f54.google.com with SMTP id w104so49420763qge.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=gXJmEJ3LwoMY0mh5xUUVfTM53NO/EJJHxwDQDPXih9w46B1TMIhN0yl5Gvq1XdL0TS
         QykyaTUJU+ZMt7s4TaGx529n42w/4rDUY/2zscATLsGqwCJKOjtAigQQNa+CmUvdLIVd
         M11J6qihOOi0P26uXQvZAC3LCwy3U6C71cKVe4afX/zngjYOs96bmlCm7lGwfdjA1KNW
         Rm/CMEpTH2uNXBhn6EpQLm8O//Zuh7YYiVoq5UkQEq5s8vSPRATCgaSaExg7z1G/3m27
         SoJASP7J8c1uaMUCmQDpy6330sH0TzpcUcHRmktrKfMM/5qUYRgsiX0fgJOSpb4n+eZh
         iQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=LrNoo+Hzn2caG5OPdSYVK7MjF/V2zfOPhvrcyzSshP4aUhVttg4yl8RYjFyYXzoXo4
         5iB3LyDwkUzzsMT92nHiKmxC2/I8fCFl05aMaOge0R75TjBxqYs9tuqYaPEkYJdhV3rO
         wjulHc7PSZ5LvJIBNw14HvP0d1duiteLswL1bblcUfprpW2jIulHy7BJ2FQ7Z62BbUYD
         shTTm7S1w1Tw9ilsWFZQULOC124MbLZbRsQJUt2LcGbCBC55PhQqg60dnj2Z6rQgJVMT
         0ZcMVqSGXgeuAJSO6WL/78stQFOHgAusDgK028l06/rLfWEWENlBKQtPwp3cuiXNjx+b
         2djQ==
X-Gm-Message-State: AD7BkJIzj9pQ6Yqaw1WIMdWi/c/bXmI3M/MV0FUoW1UMUovmRcyp2KzPc1hj3LeE7cfmVw==
X-Received: by 10.140.101.5 with SMTP id t5mr45548527qge.24.1457548606180;
        Wed, 09 Mar 2016 10:36:46 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:45 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288559>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

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
