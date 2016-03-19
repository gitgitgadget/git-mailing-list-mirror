From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 11/17] update-index: enable/disable watchman support
Date: Fri, 18 Mar 2016 21:04:44 -0400
Message-ID: <1458349490-1704-12-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:08:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5NR-0000we-EO
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbcCSBIW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:08:22 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:32944 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbcCSBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:08:20 -0400
Received: by mail-qg0-f44.google.com with SMTP id a36so83021607qge.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=gSscqFFv8QLJvSMSda6xQziCOQXCFCdbbMiUyMmuVi9QSfBVm9tpWuWFj6iWvEavud
         cPMOerc/RcNl5BMme9cB2GzbBqDQPlE+XblICiiNDTeyha1fvHecV3PEr4eqnYlODC8/
         1f95LI0u3hQCmq15Ja9/D1GHIOKxyO17PfoOiSjCtlofQ7cAJ5KbUD9cPkuy+1KIdKiJ
         HtDXDdyzurvZExb8qAAjnT4ksp8sF12M2HbkbSs2lDZP25JTfcfZz1sg/UnqM6OlTxZG
         EyXJ4xbkCCsRzDxBneI9B+m4CkMygpGwPRnT4j1PAwirreb2C4VEINY68JSMwsByCmig
         eRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFNzZjvvTxmWTcKe/LI11MXuaMgJp6qS3yKiIbNqxGg=;
        b=OPvap+T+fj4u0hZUTDIcpAC09MsYOmoBfuYudes0qhUuKmEhlDSiQdVHItdj7tZovV
         U96R/QS6CQMKygg39TU69OfMkZY5NMYP56/bJgjnVldg/tH1ZdwivOMItzK85yAfP4c3
         I7q3p1RhJs7E7zruoCk9opAiYyAK4CP41tGX6+/aAmIVmlipgwnhvgr3TsY3HIOUPEci
         HqUk8PvLt2+BFNdeIVikNKytvMtOzM4s62vIZpT/4t1TZbFG1CixcohzjaUTitA9joqX
         OzmZxqjTEtIUMxj721MvgrYzdo25xcsP2147TCuPSeo4eNd6GNHULDEgE710qtrFf/Vt
         jTwQ==
X-Gm-Message-State: AD7BkJJqjRgDi4TGTa4GglDHXGA7YXKF/z1y3k6eTgYmQfxbaHPoDSC1GLi76ACY5tpiyQ==
X-Received: by 10.140.247.68 with SMTP id s65mr27339834qhc.72.1458349699511;
        Fri, 18 Mar 2016 18:08:19 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.08.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:08:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289278>

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
