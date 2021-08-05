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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF8C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014C861040
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 07:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbhHEHlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237793AbhHEHlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 03:41:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56257C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 00:41:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so12809015pjb.2
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 00:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=UCruLmf9Dw+gYz9Ybuf6IHAJwXTz2q9P9EcrymL2Z1loyfP3+2xpxWJ6sbbDfq+0+3
         +ZUzupwpnrSoGyB6b/+qKBgGrBWZPrCi2eRzgbYWJ1A93hXIhgAwXx+yRB+anbIVvytj
         LhtMha0oAH0Q+S5euCn7qwW7SNX1AjUD6VlUEhE5Rgwaxy+hpteuv50vZCv4xuMxBODs
         6AOoDQo/jBZgcNvrCM9G0xtH757t+4FQvazJq1sUIN13oitO8VnYBf51CZEPA+aoffub
         XW2egY9rQ2Y0dh+B8WrFAs2YKgDzGd1OTUHIIatB6OKcdXzSdYnF5jhAKtBCkohXAc7M
         8tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0dczKJTO5baTemhmXZeMRVP4jza28YNvT8kLN9WZLY=;
        b=G0L3zZJGmGKBJupIBOTrXzqjQAu09nnCRHRnk3nder7xtzjE2ku2xQrlZZ12YNCqHq
         IIndsMN5SczPiaWodbnMidfKsV4hvXdlyqJSl+JAsYwt4YbAA9QeuKBYUIujmoMHZ5u5
         QBKGM8NLjNo6meN2GKBRT85itngDbKAEKgfX0l7x4N13ID2BXe/eem6139naS+G8s9be
         Bjzk6WPmBXO5tLXhMlkY6z6KNxif9Eu3yT0YGrFCV0KTdhNwBjovt3Y4V/4+zUJ7FnLY
         EurkP3kjnaCC9CgeB3MKbwgnTqCMnfFIz4tLZQiUmNkTVm6zh2su82w5Y3qiGc7WEW0M
         oOUQ==
X-Gm-Message-State: AOAM533fhf/6hu2GK2PT8rqXYKuzTiyYv6UWNwn9PHofrYxdjySOoh+d
        LrI7jx9YZonZjBqJLQ3SAqg=
X-Google-Smtp-Source: ABdhPJwIQxyyW1Vv7cw12Lwsxkzk5qutrOX1ykuSKB7wmM5i8pYaDGnuLaxqEFopsh8pqoIU87tUYA==
X-Received: by 2002:a17:90a:b795:: with SMTP id m21mr3349045pjr.143.1628149295958;
        Thu, 05 Aug 2021 00:41:35 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id b2sm4885153pjh.18.2021.08.05.00.41.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:41:35 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v2 2/9] submodule--helper: refactor resolve_relative_url() helper
Date:   Thu,  5 Aug 2021 13:10:47 +0530
Message-Id: <20210805074054.29916-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805074054.29916-1-raykar.ath@gmail.com>
References: <20210805071917.29500-1-raykar.ath@gmail.com>
 <20210805074054.29916-1-raykar.ath@gmail.com>
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

