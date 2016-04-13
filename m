From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 10/16] update-index: enable/disable watchman support
Date: Tue, 12 Apr 2016 20:33:03 -0400
Message-ID: <1460507589-25525-11-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:34:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kp-0002sP-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957AbcDMAds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:48 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34824 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919AbcDMAdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:33 -0400
Received: by mail-qg0-f51.google.com with SMTP id f105so31006351qge.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L+5s+oRSfXwK61WSvfkyVtN8rC2BPEQH8Rd+GzD9XVo=;
        b=IFaFcav4jniqJwbiN/ktJzHEQs+9k2iMdT8IECpnjpe/DI88p5RxLlRaY/UEjfFGke
         XjelUxhtoJbtNxhtCdwVQ2E9QsIjwZNCPcPMhPNqpQHCcgP6K3xteT7kylpujxmhgcyq
         VTrVqSDff6CKnExGtDDDYBnbwhTDrUiZk7t8wH8nhuAkd2pJEHKctXNGlmsSJD2Cn8hs
         PDX3OyQ994KjaK6fnzWlA4/aYyTud7Nugn7AvnkLc4XZJw6Zk4Z8V6iSSY9BdezPk8IN
         cpp8zaOUkJdwpEbY2XdxA0b9pRMYMdXOuIr1bkzmw7XOV/48tu6hg4rxPJ5teVI5inaK
         qMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L+5s+oRSfXwK61WSvfkyVtN8rC2BPEQH8Rd+GzD9XVo=;
        b=l/spqPg7vyZY6TQSIgNB22Ncg2cdR1Xs20ouwdF7RZP6454ri+0xT4Ivb3pMl1ouH5
         x37Q5XOETHafVly52L+hjVQ/+yKtWKw7ZPK3z/VUvRbebtpIToVkApa+Wnm99CJqOkCD
         ar2CALPV87pZBRa8zkgZZmk2tdljNyxt2uWjL66y88GdAGukbqwL/v4umajnQRSxDgEr
         IPeJn6z0mGHeix2lZAtmMxaX6j5jkZIOXJoL4MvuTkfFlQCGZbTlMHWR8T5K5tBIKyNe
         qFE4qiGmW7RUtCrKDLr29ny8Ltlb8EEISA5ID3mcY3ghfxcDDsfw1D+27J1vLm5pnQDz
         XcGQ==
X-Gm-Message-State: AOPr4FVvQ1hEA2bcdsZvQrNGLeXzwl4gECJnVq8qZ7VkvDX5VHFbjVw0olj5wupqHNNFNg==
X-Received: by 10.140.226.19 with SMTP id w19mr8055263qhb.55.1460507612199;
        Tue, 12 Apr 2016 17:33:32 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291348>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
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
