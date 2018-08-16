Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B0C1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbeHPF03 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:29 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:51817 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF03 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:29 -0400
Received: by mail-it0-f74.google.com with SMTP id q5-v6so3054924ith.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Qv7QfPS5qrcTtvfQBRbhRtyf+qGYCQTnjx5PRsmBesk=;
        b=Q2nl0dEZRtwKBuoV/HtW72WUFPOy2wVZDuS1/b1zzo/7BXjyix6HrkE5QuNpaurH4Q
         Q98hLz/nMceMNQyoMShZRWjf8nQhy7X8v/t0ChqJJEL3x3KGaERF1sQOSRvszs8uY+hA
         2/lDwNx3ZE/K5n9M09UnziDsvRkll+9l2OWNwL1ep+9uayIQKIDvXUW1RgzyjUu9CCxf
         aIMUU+Rval+3LKz/QZVv0WU8BW6Ywg0VVOdfH3OFZuuvn4uEH6V012hRrVYDl1zqtmq9
         IPnd3AlRH6qx8xPyY/nTrhFMraf1pRpoiHzZZKUBrbCZTocevQ3dw+19qS96067WxDGM
         0xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Qv7QfPS5qrcTtvfQBRbhRtyf+qGYCQTnjx5PRsmBesk=;
        b=V37sZSoCzZZiCiBH2O/Dmy68Rf8pyqZT525/usBFXtPoCmFYy5HFGdNcsN++AoutkW
         r3s0PbiCUo6LLoDkJADMR2+kPkNleGZ4Bc7B3Teo3+qNrgCX/42s8XPNqGMyMKQx7XBh
         MVRuyjQASSvz1oEbs/FMhOsvn/V/W2tWVVpX6qC6IY3vRs1u2qz8NpIwjsEQmcvYOoer
         R4UC1mWtcTzoG2qz1s65KGrNzV03x0c+rAWW97clxHzTu4jcsj6QOHZfMAcfAZd2dskB
         oNuVv0uwtWvAK6OYjXVzIoCjVhfHFGQ+aJFlieddMHh8CZ3F+j+z3/ZFCPSqVXNIBm2D
         nyPQ==
X-Gm-Message-State: AOUpUlE1Km7ILyZ+uxwmpttErSkw9vUk0uIG24kpuRrMOPBZapF0c6il
        WpZcxXsHhGbG4Xr8z+RT7A7ePutd+5gRnERucxAdcOrqnVHppKx+9iUIheCKta1xJxrdhZeQrfx
        FRomIBgBYYaPa4h2JikmA4rPzwWKRhs657dunnpDfiuTzT4Sf69gbcdhd1Aux
X-Google-Smtp-Source: AA+uWPwp1osaiQPep/GWk5uOP0YtKhmxJrQJ5n4x25MJE/lym+WD7eCnq4YgZ4+HMUMHg9AFAJdeXCkteWYj
MIME-Version: 1.0
X-Received: by 2002:a6b:6a18:: with SMTP id x24-v6mr4164855iog.48.1534386681148;
 Wed, 15 Aug 2018 19:31:21 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:57 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-5-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 4/7] submodule sync: omit setting submodule URL in config if possible
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do not need to update the submodule url in the superprojects config
if the url is not used to keep the submodule active.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2f20bd4abdc..639d0bb20a1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -922,8 +922,10 @@ static void sync_submodule(const char *path, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
+	int active, r;
 
-	if (!is_submodule_active(the_repository, path))
+	active = is_submodule_active(the_repository, path);
+	if (!active)
 		return;
 
 	sub = submodule_from_path(the_repository, &null_oid, path);
@@ -983,13 +985,15 @@ static void sync_submodule(const char *path, const char *prefix,
 	strbuf_strip_suffix(&sb, "\n");
 	remote_key = xstrfmt("remote.%s.url", sb.buf);
 
+	if (active == SUBMODULE_ACTIVE_VIA_URL)
+		FREE_AND_NULL(sub_origin_url);
 	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
-
-	if (git_config_set_in_file_gently(sb.buf, remote_key, sub_origin_url))
-		die(_("failed to update remote for submodule '%s'"),
-		      path);
+	if ((r = git_config_set_in_file_gently(sb.buf, remote_key, sub_origin_url)))
+		if (sub_origin_url || r != CONFIG_NOTHING_SET)
+			die(_("failed to update remote for submodule '%s'"),
+			      path);
 
 	if (flags & OPT_RECURSIVE) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
-- 
2.18.0.265.g16de1b435c9.dirty

