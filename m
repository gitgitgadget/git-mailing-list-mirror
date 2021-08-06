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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB082C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3FC60EBC
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 12:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbhHFMCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbhHFMCd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 08:02:33 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DEC06179A
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 05:02:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a8001b029017700de3903so12176584pjn.1
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 05:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=NDcD8wOsnBvdo7WVBeryMaFdwXFBqi3m72QmPYaTNpsV7GnvRekNbCnwrHB7bcFS0V
         bOX2kn5MtPjaCwdpIbPmNpaAyJsT1ohLCNdiSGrWg2KA/QrhyuhPSAwIk4ngR4KKGZhq
         qyMy8NGEmcm12NjSEKbcaPvR9ns6tmE/M5da53LHCbPLg/r6tD1Jt5nLOEoIOh3O0ths
         jJvz26MKbIXi4rDl/SCLpH8MEfTWwUVk510yF/QUWgP3Ddl/fFqx3cjgDcQKHIyqNU3M
         c9kkCyxdIT4bzvAa/XFOVFsWrZxVcmEUarWBdPrCMg+EoMORlLpUU1X6Yr3TH9uXWwnC
         wLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=GemJx3XdyiO9gknvbuw1lInP05HHgHJ9EUcqM4xol6KQxuz0TTayeRLxCa9BVa2Pyy
         JHZ8xMLIqZcx8R8/gkwZYHi33CpajOQFgpIRAGoX0WWsdJalSOfYJTpkspyGvDO7hreN
         rCMLPDUeyUfOqiDoCZNIp2+JKSgd6yNCSqblnIbKKbMSfctDPGFe9XCxTIn4jvzBDsss
         p+/GqRNjIaOE+iKcYKqgR6+AECKYPVBDuxbE8jCO73NRXQEzJUyWwQeJr0++og5yDVOz
         KxEFQlycIYTb8iu7BXKUjxUn6fi7MWkk7yCdCsfvj7zIJ9dEgpDGwshF15I9Uo0umz6a
         JDdg==
X-Gm-Message-State: AOAM5323qh9nguO2xTSjtyd7wV0g90ZeU6apB8Jun+Rim1HeYUH4s+Yf
        aRDGfqEUBG5e8D7XmS8l754=
X-Google-Smtp-Source: ABdhPJzn2o+7jnEUXkbpJtzGHm9Qm0dYL7gPPDSlN48x9cMUK1is4/+f5VKVu3KOCwWut8BrrE6dZA==
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id t3-20020a1709028c83b029012917e5a1ccmr8264413plo.49.1628251336303;
        Fri, 06 Aug 2021 05:02:16 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id z8sm10338162pfa.113.2021.08.06.05.02.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Aug 2021 05:02:16 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v3 2/8] submodule--helper: refactor resolve_relative_url() helper
Date:   Fri,  6 Aug 2021 17:31:41 +0530
Message-Id: <20210806120147.73349-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806120147.73349-1-raykar.ath@gmail.com>
References: <20210805074054.29916-1-raykar.ath@gmail.com>
 <20210806120147.73349-1-raykar.ath@gmail.com>
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

