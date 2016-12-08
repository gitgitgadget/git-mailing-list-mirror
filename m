Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE32E1FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbcLHPgf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:59986 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932353AbcLHPge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:34 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLfLH-1cFHrP1tXn-000qgK; Thu, 08
 Dec 2016 16:36:24 +0100
Date:   Thu, 8 Dec 2016 16:36:23 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 5/7] read_early_config(): really discover .git/
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <15fa873f3d6960c14fb3195ed2d9dc4ec58ba402.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4fQsbtK1hStDdlX71Edhf6mD4WeoK0Aj+2q9lpPdanOF/WEnvXM
 KUZ9QZmfP8OXN2mAScrDnDSmPOFucv0MnBUh0jz7SD3Yl5OFkCCziSp1cpNAtcQZEaDLa0d
 MlGFeTav+XI/vfLQa9PxlID/3EQ5h5dSygYLYpFxvK9AecwhaYNu3ezPAHlyvjhmVIWt6d+
 rqv1b5n7iVu3g5qhYb8ew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3deVGP7CAJw=:wd4KoA1gs6gIIvdGnrxaXq
 /8nIZD9mE7jnDzRFOnhmwEkg8/ERB27qgVJEkN+vk5tc9zvfvElyy+H9/ZSVWMQGBrGlaEAVZ
 HPE97dO3h3xF9AzFHzWtQghacJCc82tn5wFCDVkaGhTHTy9OAYNFEGKW7IW8D17E3n4e44+sY
 Vg6Ucu2mObShemLr+Jh55wXRoSszkt7piXq4VXXGh/1rpDZrxpVWd1CiKG6rGSiWAexn4aWrO
 C+NaXpLA53qUYSXmodwKTfUa0npPXP0/syyJviBZASwHe5eVpMdnOlOj7PxTcHAssNMtxy4wn
 vOuYkqEof1xFNndrtLDmv+WDmm7U9lBi0+RW7NcD3zhbetS5Oey8HxMuo5/UErWQTfX55XUpU
 7h/xZhiBKIu8AOSJSgolva6odQRuXmdgqpjqDsF8Cm5YrHa2jt1SIbsOlbrfNVkCL3Wq9sHTw
 n5c3YqrRGDHDKtexFxpXFQwod4H4wbPcM2iprQQFwYPb32y28hTGnA92M2jlZ0EE+qSt+yjj0
 PurnmWM90J/JOW9ONIRhdIkNe/uWxEhrva9PzLe1ssRp7HghjQasLeVXfnxgsoA8f7dyl6RJd
 WCh4H31qYDYzcqNDl+seV+1IfW+m/9vs4W5DHO7rtH50+sjGdzG0gakMARASfnSRl32myqIpe
 Cro2Z4gllPNDagV6cKw/7vZ2t4QVRh/H79U50n5Susxb0V4q58HxNWEPqdqfpoCKpJivBAEYC
 abQAZwjFlCZ6dN8Jh4FraesdaPRzgWI3O4Teh1ykGH6Nr/3QacKjnDaGTsMHcZQt7M53WxyHR
 D5vzaK3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, we punted and simply assumed that we are in the top-level
directory of the project, and that there is no .git file but a .git/
directory so that we can read directly from .git/config.

Let's discover the .git/ directory correctly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 69 +++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 20 deletions(-)

diff --git a/config.c b/config.c
index 4c756edca1..286d3cad66 100644
--- a/config.c
+++ b/config.c
@@ -1385,35 +1385,64 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 	}
 }
 
+/*
+ * Note that this is a really dirty hack that replicates what the
+ * setup_git_directory() function does, without changing the current
+ * working directory. The crux of the problem is that we cannot run
+ * setup_git_directory() early on in git's setup, so we have to
+ * duplicate the work that setup_git_directory() would otherwise do.
+ */
+static int discover_git_directory_gently(struct strbuf *result)
+{
+	const char *p;
+
+	if (strbuf_getcwd(result) < 0)
+		return -1;
+	p = real_path_if_valid(result->buf);
+	if (!p)
+		return -1;
+	strbuf_reset(result);
+	strbuf_addstr(result, p);
+	for (;;) {
+		int len = result->len, i;
+
+		strbuf_addstr(result, "/" DEFAULT_GIT_DIR_ENVIRONMENT);
+		p = read_gitfile_gently(result->buf, &i);
+		if (p) {
+			strbuf_reset(result);
+			strbuf_addstr(result, p);
+			return 0;
+		}
+		if (is_git_directory(result->buf))
+			return 0;
+		strbuf_setlen(result, len);
+		if (is_git_directory(result->buf))
+			return 0;
+		for (i = len; i > 0; )
+			if (is_dir_sep(result->buf[--i]))
+				break;
+		if (!i)
+			return -1;
+		strbuf_setlen(result, i);
+	}
+}
+
 void read_early_config(config_fn_t cb, void *data, int discover_git_dir)
 {
+	struct strbuf buf = STRBUF_INIT;
+
 	git_config_with_options(cb, data, NULL, 1);
 
-	/*
-	 * Note that this is a really dirty hack that does the wrong thing in
-	 * many cases. The crux of the problem is that we cannot run
-	 * setup_git_directory() early on in git's setup, so we have no idea if
-	 * we are in a repository or not, and therefore are not sure whether
-	 * and how to read repository-local config.
-	 *
-	 * So if we _aren't_ in a repository (or we are but we would reject its
-	 * core.repositoryformatversion), we'll read whatever is in .git/config
-	 * blindly. Similarly, if we _are_ in a repository, but not at the
-	 * root, we'll fail to find .git/config (because it's really
-	 * ../.git/config, etc). See t7006 for a complete set of failures.
-	 *
-	 * However, we have historically provided this hack because it does
-	 * work some of the time (namely when you are at the top-level of a
-	 * valid repository), and would rarely make things worse (i.e., you do
-	 * not generally have a .git/config file sitting around).
-	 */
-	if (discover_git_dir && !have_git_dir()) {
+	if (discover_git_dir && !have_git_dir() &&
+	    !discover_git_directory_gently(&buf)) {
 		struct git_config_source repo_config;
 
 		memset(&repo_config, 0, sizeof(repo_config));
-		repo_config.file = ".git/config";
+		strbuf_addstr(&buf, "/config");
+		repo_config.file = buf.buf;
 		git_config_with_options(cb, data, &repo_config, 1);
 	}
+	strbuf_release(&buf);
 }
 
 static void git_config_check_init(void);
-- 
2.11.0.rc3.windows.1


