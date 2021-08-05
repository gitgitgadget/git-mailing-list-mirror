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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDFCC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0454F60F94
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhHEHT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhHEHT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:19:56 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E39DC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:19:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j3so6005003plx.4
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=nJ4odmCXpdqL1/WqB33t8kdsaNVDRhiH01Gb3gn18byW5IJWoLKDRLLJqjE3SwJMix
         GrDA7Xb0b3pbDbNHMAIzATI5xbujRyMXHCZqTsM3JSDj7VMnK0t/gDLGAc2LEAhm57KW
         8nOBTI7KvVGIe/G5f+405Rr52wLUqhP8p7TF9X9UlAD/ppMBnaT4bPUkqSU7k8PglIot
         +5EAk1oblZVgKFZH4F+XHl94JeuALifFtpt1TJs5UIOtO8rmSiMdvNRWQ7V2t1qxTYp3
         /iIPkwQ1w5H0UEpVaPEX2uPhPV6JzbR0ZzRyLo6sgnYq1X4A2MRdyGfm0mQNgVDzNkr1
         aEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=q75quKcNeodNZ9KYmUVu6uMGSVNd9pNvthgQjgP0mezGaGiof9dXKSMyxMkXbB1mI2
         Zfvd/js17wNxAiCYDAZmkagiDMmgn+w/vwAfGjyyKnf4OLcgw/k1wFmZnotMVcDzg5Eb
         poYPAW1IR8XW4lrEjDh9rcHRgFxrvhgLU9AJT/rGGzVjtM1A9q2vjIUQVEPrnMtitfnA
         zK3E2QJP9upC8Ufn+Ry5vbSTaKPLEKfJnB+xmoCqN/inVdJjjw+3TKqMQnu/Xnp77LJQ
         kTbmprtW4R2RkN8OSa720AhekIt+1ChtvbLM7L8EHNJ0YyIoHb5efpIZwSUfx0ltkAEu
         DSew==
X-Gm-Message-State: AOAM530YYR8iDWCVXn27dMI8Datlo113zcavtFQ35y1sbv4BbwRJq1A9
        g38YXpknvEENhGdezlqF4Zye9lvGuEtPldJl
X-Google-Smtp-Source: ABdhPJwZEnp9ajPtilNC+gFpMdcJ6Zf7k7rC1W97eMWCD3RRi5FUZVvK4zYQ/jJ1fU8nWwbpZ5qIWA==
X-Received: by 2002:a17:90a:8b81:: with SMTP id z1mr3277343pjn.82.1628147981492;
        Thu, 05 Aug 2021 00:19:41 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id p17sm8569603pjg.54.2021.08.05.00.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:19:41 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, "Emily Shaffer" <emilyshaffer@google.com>,
        "Jonathan Nieder" <jrnieder@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Christian Couder" <christian.couder@gmail.com>,
        "Shourya Shukla" <periperidip@gmail.com>,
        "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Prathamesh Chavan" <pc44800@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Rafael Silva" <rafaeloliveira.cs@gmail.com>
Subject: [GSoC] [PATCH 1/8] submodule--helper: refactor resolve_relative_url() helper
Date:   Thu,  5 Aug 2021 12:49:10 +0530
Message-Id: <20210805071917.29500-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805071917.29500-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
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

