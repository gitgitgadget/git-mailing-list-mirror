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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE29C432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55A16023E
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbhHJLs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbhHJLrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC56C061384
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bo18so10608661pjb.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fy1OcdMEKc2d4JvJGoAPeVHxTGq5FJ+Qqo302IldmMM=;
        b=gMWRu6xCK65rT+BzZIn7QKSv8RFGVztMafhzToaljuBGaFA79bPo6eSQfiXTR7ufzY
         wHTc0q63/yZ/LCYYN4HDXJyY9zpyBZlIO9XenvCvfEd4THoDZvvxgefQbPYDFLBHwG5f
         R25tGxCY7gKmc+T/bks7pgF1dkI629wDJMgDXRlxxQkxa0rqyGTx61fBpAtyH9d8DQw/
         73UrFePt8mO4uOVhaQoI6WB7845xTxiR7XaPDeF6nnTvmnNo/g3fHc+Qb/ky/dMuKGxW
         lrEfQDy9SmKvjpKNA3HkbhtEUNgjMd4+hg81SG9FwCf38TairkwKPAIAywogig+rT6yM
         qAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fy1OcdMEKc2d4JvJGoAPeVHxTGq5FJ+Qqo302IldmMM=;
        b=OCsYoyAqfIe6WE8mCrLr6QzjEJdWx+hFifIWiTs0iUttNKumiJGE1v0MDK2bFLDQzJ
         a4oP/IRbJAqC4Pei8j4m+89EcfzZ741GtQQfMjM4sLCGLzpkpcVZcaAWogVsfThBs5ef
         ExfDWgP/giwXiGeZQVUDRb4nVJx/SiYvUwU74qf4QG+ULSH7Fa8OapB0PIXTj6I+SnGS
         TDNmE5Ly1nLdeaWLuXkG8LqoivWc2AyIB8GEGgLtY0w4TSBMSwtZ+0wtz8MriELIBeY6
         HdfcshsdNRo8OmBtl86is5h7HJ6INdPNCpZFhtaR8aoWRhcJFIaV214FoTSb4MWEGAu1
         Mk9g==
X-Gm-Message-State: AOAM5317X5itqUs2yXrFrY9sm/U8Y4j48xznTEK2/sJI7dhaqFaaZD0I
        k0Na7LUazLUWuWXCu3Jf4OQ=
X-Google-Smtp-Source: ABdhPJwfeYUwPrnHLhDL0c42eLB/3ulCdFiywEhBWy9InWw7FK72CbY8z4TZui8G8Q0fTJOyiDpehg==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr600417pgm.143.1628596030579;
        Tue, 10 Aug 2021 04:47:10 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:10 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 2/9] submodule--helper: refactor resolve_relative_url() helper
Date:   Tue, 10 Aug 2021 17:16:34 +0530
Message-Id: <20210810114641.27188-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
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
index d850b30fce..fe126cdee9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -199,33 +199,46 @@ static char *relative_url(const char *remote_url,
 	return strbuf_detach(&sb, NULL);
 }
 
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
+{
+	char *remoteurl, *resolved_url;
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
+	resolved_url = relative_url(remoteurl, rel_url, up_path);
+
+	free(remote);
+	free(remoteurl);
+	strbuf_release(&remotesb);
+
+	return resolved_url;
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
-	char *remoteurl, *resolved_url;
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
-	resolved_url = relative_url(remoteurl, rel_url, up_path);
-
-	free(remote);
-	free(remoteurl);
-	strbuf_release(&remotesb);
-
-	return resolved_url;
-}
-
 struct init_cb {
 	const char *prefix;
 	unsigned int flags;
-- 
2.32.0

