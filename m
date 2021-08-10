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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B0C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A99E60E09
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhHJLsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbhHJLra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:47:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4341C061798
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f3so10001452plg.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHeFSdmlvW+yoS8FzEgnzH+iAl6gP8Vkd6+v9xM7+JI=;
        b=Hy2xSueiy9hbRzX4AW/2TFI/o/lMe3tQuqPxnv77VFyFnLi28YKE3MriErafKdJlZd
         R4E/SWdT9D/ikUthyZ7WTxsPPjCkSVd/eOHVWTXhq9zsCJEA4HdQox/i07ihq0mY0WIj
         lDO66vsbI6ZyNMRNTcKaG9fuNLydvg5geqSUkNthHQg/5kiqrFMRXuCcHbuIx0pWQ3hT
         jEx3f5DsoY1lteVVmsItx69m11Lc/6bn29V4kZ0p/4CNZxz6ItO/ieRp4JEsLZbokiGm
         zm5W75N/GMdvahNLjCygHlD1aCIBEGWtcZOTbuw4Z8JgBU3vev9TuuW5GAEtIk593tz3
         qdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHeFSdmlvW+yoS8FzEgnzH+iAl6gP8Vkd6+v9xM7+JI=;
        b=Z+kr+IxFabD2ErDrZ+vJlnuuqQq4lq5K2KoGT7hp1+zoryYv135zqRueDmF1BtzIkh
         Hugx6pOSLFsZdlvk/701p1pYnQZ55BW6gQ3yY0qgUZMA4aXY3/v/1CBwjm+yE4sYYRFh
         fQP+y2X0+ikhFbLIM0aXfnb/imw/NUzi5T+CIcDLLxB5kQ0oaVytJbxviV0v9DFJgbtp
         mqHyXy3IDEbfdLXw5eT9nB6i43Fv1W3RfY4QnixdnsknjhuUsYjUoBsV/lIQ0X5G7gnE
         vNwls1U8ApMyuj3J8kqTvSLO4P0Q8RfFyDghM8YI4auRNKLnDK6Qr1QJsudJ80Ocijr+
         LwUw==
X-Gm-Message-State: AOAM531D8VAUxmpRycVKg3XZ9gYi1NoWuTR4E5xxA39QfgC4WB/9oqTl
        vN//HpnZmWoMl5xmh9p7+Ow=
X-Google-Smtp-Source: ABdhPJzZNMpFp4E0y3u9+l9lGxB0u5gziSFg+nxq6beGT4J8UeyDuO7rIn9gRTxLrP1EWp6H9s0NhA==
X-Received: by 2002:a05:6a00:791:b029:3be:500a:2017 with SMTP id g17-20020a056a000791b02903be500a2017mr28651021pfu.44.1628596026278;
        Tue, 10 Aug 2021 04:47:06 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:05 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 1/9] submodule--helper: add options for compute_submodule_clone_url()
Date:   Tue, 10 Aug 2021 17:16:33 +0530
Message-Id: <20210810114641.27188-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's modify the interface to `compute_submodule_clone_url()` function
by adding two more arguments, so that we can reuse this in various parts
of `submodule--helper.c` that follow a common pattern, which is--read
the remote url configuration of the superproject and then call
`relative_url()`.

This function is nearly identical to `resolve_relative_url()`, the only
difference being the extra warning message. We can add a quiet flag to
it, to suppress that warning when not needed, and then refactor
`resolve_relative_url()` by using this function, something we will do in
the next patch.

We also rename the local variable 'relurl' to avoid potential confusion
with the 'rel_url' parameter while we are at it.

Having this functionality factored out will be useful for converting the
rest of `submodule add` in subsequent patches.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6891480013..d850b30fce 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -590,24 +590,28 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static char *compute_submodule_clone_url(const char *rel_url)
+static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
 {
-	char *remoteurl, *relurl;
+	char *remoteurl, *resolved_url;
 	char *remote = get_default_remote();
 	struct strbuf remotesb = STRBUF_INIT;
 
 	strbuf_addf(&remotesb, "remote.%s.url", remote);
 	if (git_config_get_string(remotesb.buf, &remoteurl)) {
-		warning(_("could not look up configuration '%s'. Assuming this repository is its own authoritative upstream."), remotesb.buf);
+		if (!quiet)
+			warning(_("could not look up configuration '%s'. "
+				  "Assuming this repository is its own "
+				  "authoritative upstream."),
+				remotesb.buf);
 		remoteurl = xgetcwd();
 	}
-	relurl = relative_url(remoteurl, rel_url, NULL);
+	resolved_url = relative_url(remoteurl, rel_url, up_path);
 
 	free(remote);
 	free(remoteurl);
 	strbuf_release(&remotesb);
 
-	return relurl;
+	return resolved_url;
 }
 
 struct init_cb {
@@ -660,7 +664,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
-			url = compute_submodule_clone_url(oldurl);
+			url = compute_submodule_clone_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -2134,7 +2138,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
-			url = compute_submodule_clone_url(sub->url);
+			url = compute_submodule_clone_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
-- 
2.32.0

