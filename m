Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D742AC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B463B610C7
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 07:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhHGHRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 03:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhHGHRT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 03:17:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD516C0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 00:17:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so10184365plr.12
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=Ke+/A6wjvbg5a+cTq4tdjo8RUZTAmZFC7JdH0YcA6UAYyakq5xTyxfg34kqajGRzFW
         zwreQlS/TawOH7Ws0ExidFb/cOvlhyWCMACWhoVviAw4/mOODwQSoOoXAjT/HI3d0Dqe
         7nG6ohzZAtgqNGcl4d6TLB2APNdB61pY1kmXAnvsdVAt3hhNd+3yK6FpgCvFhtcD1P4J
         tQavKmdosHzcXd1cYI5LyNuKDg0630qsLaRVsE4c03EzC1P/9uD4VTd0DFX2HFGD0q2z
         F7mfDsdg0uorhS/AQeipGwXpJ8FUInpd448mNVXdip+JKlK+yM6IYvTL2TwSt6ZFaXtC
         ngAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=p/vKveH6QtaWJFIKACveTRrhqIProKgmpTw625/Ir9OavDhEtjAptvJxjUOkjXsLeu
         N4MayLHxwuamgazyqWPLWo3T2LugByoHmHMBdl0m8BEK0MsQWILiUCnMYvR2o9nYsp6r
         GDueLQJwojKMe2wy2pJ+IZ4MBwoyL06fvqIzB3OZn1f+OhKR0aHGfmHe/OV1W7dI+eOX
         3UvmLu9U7+gRqXsNiDlGuh6Cs74YdVWC7R6yjl07lcK9egQ0uTQBAEe33T8UVEA0VB3y
         72b5wjrxHpPPmgKSKyZBDpfecXfk5uVgk1jtGKfqcpLOoVH3L3z6UGKJEK7cif/6r1K0
         SV7g==
X-Gm-Message-State: AOAM532Z+iECjbTF0ax0KYgeQ6XGefpE40wOGvhzmL7wlIe77ZuHtWQ6
        9Vt2sebvYVwN59/omSranIM=
X-Google-Smtp-Source: ABdhPJwsJNrLZH5/hSY5o2C5lz0kZ9AadXppwJqBa4qZ+Eapc7D2q3Mor6XSZ+xLei6pZ2cBMfNt7w==
X-Received: by 2002:a63:5244:: with SMTP id s4mr58019pgl.267.1628320621268;
        Sat, 07 Aug 2021 00:17:01 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b15sm14604981pgm.15.2021.08.07.00.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Aug 2021 00:17:00 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v4 2/8] submodule--helper: refactor resolve_relative_url() helper
Date:   Sat,  7 Aug 2021 12:46:07 +0530
Message-Id: <20210807071613.99610-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the helper function to resolve a relative url, by reusing the
existing `compute_submodule_clone_url()` function.

`compute_submodule_clone_url()` performs the same work that
`resolve_relative_url()` is doing, so we eliminate this code repetition
by moving the former function's definition up, and calling it inside
`resolve_relative_url()`.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 61 +++++++++++++++----------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2d2d8ac637..f4b496bac6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -199,33 +199,46 @@ static char *relative_url(const char *remote_url,
 	return strbuf_detach(&sb, NULL);
 }
 
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
+{
+	char *remoteurl, *relurl;
+	char *remote = get_default_remote();
+	struct strbuf remotesb = STRBUF_INIT;
+
+	strbuf_addf(&remotesb, "remote.%s.url", remote);
+	if (git_config_get_string(remotesb.buf, &remoteurl)) {
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
+		remoteurl = xgetcwd();
+	}
+	relurl = relative_url(remoteurl, rel_url, up_path);
+
+	free(remote);
+	free(remoteurl);
+	strbuf_release(&remotesb);
+
+	return relurl;
+}
+
 static int resolve_relative_url(int argc, const char **argv, const char *prefix)
 {
-	char *remoteurl = NULL;
-	char *remote = get_default_remote();
 	const char *up_path = NULL;
 	char *res;
 	const char *url;
-	struct strbuf sb = STRBUF_INIT;
 
 	if (argc != 2 && argc != 3)
 		die("resolve-relative-url only accepts one or two arguments");
 
 	url = argv[1];
-	strbuf_addf(&sb, "remote.%s.url", remote);
-	free(remote);
-
-	if (git_config_get_string(sb.buf, &remoteurl))
-		/* the repository is its own authoritative upstream */
-		remoteurl = xgetcwd();
-
 	if (argc == 3)
 		up_path = argv[2];
 
-	res = relative_url(remoteurl, url, up_path);
+	res = compute_submodule_clone_url(url, up_path, 1);
 	puts(res);
 	free(res);
-	free(remoteurl);
 	return 0;
 }
 
@@ -590,30 +603,6 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
-{
-	char *remoteurl, *relurl;
-	char *remote = get_default_remote();
-	struct strbuf remotesb = STRBUF_INIT;
-
-	strbuf_addf(&remotesb, "remote.%s.url", remote);
-	if (git_config_get_string(remotesb.buf, &remoteurl)) {
-		if (!quiet)
-			warning(_("could not look up configuration '%s'. "
-				  "Assuming this repository is its own "
-				  "authoritative upstream."),
-				remotesb.buf);
-		remoteurl = xgetcwd();
-	}
-	relurl = relative_url(remoteurl, rel_url, up_path);
-
-	free(remote);
-	free(remoteurl);
-	strbuf_release(&remotesb);
-
-	return relurl;
-}
-
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
-- 
2.32.0

