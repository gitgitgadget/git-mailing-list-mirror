Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43C6C433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbhLUTON (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbhLUTON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4F3C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i22so28850366wrb.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=h5/zMPYjDErTVP8zyB9GUekVtp+7s1Io++t7XULOxgt4YGG+Ztb5R5Btpc2SqijXMh
         xSITSu8xJSRex78KjyKreDGRGhGAZrh01qroY+lxSBINgvVve8o+zoh7N59MB3lT+YL/
         q8X9JCYxvuFlkWcu1e01gcwfEZquDvV0MTQO9JzeRy4TwJbpcwXIzDPE+/YCYSSZ87cj
         4ZuGIqPr8Y1zuNEiXCcSdzZaEL5pJUb0/wZklRM9zU4lPMx6YRcrr5eU3yenr93Q6EMN
         hY1LWlgDLTMWMF/wn2Y1QT644lIqoUSGZUGtdLa4uHqT0Zxv2a2WtMBlLZO4rfcpL/Br
         xMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZHHVedAp8W2JuzN7+w7ympjfdkaHVwsh7qOjVXFvtD0=;
        b=h6Z4bMIrRpX0Jz59lC9GBPkht7bZPxQLqMu+5pkcrFzZOj/yY/QIeTlht5s41D0nIe
         xheMUcxOhjMSAKWLL5b0V95wHp4hbO/QXvIhs0BnsRrcdLuPefOFLRaw/qa6a7uD0v5Q
         swsyG7Gt26R6g4hBVucBNKyLfO+yNYHncneRZS4Qg9BqpgB5yxJXEzNhz0JWEyXn8/JO
         TLNMK4I1OhP7BJeWcXJF8MDSfrqte/yjxkEFLlwtr/p1WjXY1r264VqhZy+hJP+z6+tB
         3XVpDCfqMK7VDsGFdy4wDKaDqeDMjh0Pil49ModMtYosBiz+OLbPeSkAwQu+FTWYRMJ0
         BFDA==
X-Gm-Message-State: AOAM530e0z9od6mXnp1j37SIu8mlb5VtYSs4ThDchlyQRzAsxrPuThjG
        vA4DbZpqpc+en9LD0p8c3I0Y+vVa6Uc=
X-Google-Smtp-Source: ABdhPJwv9vtCw0TwRCJvZ56yZVH5LYyDi387sXR3MnSHaqD5Ns1tMmXk78fcBxwV3qkYLO4V7yaqwg==
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr3608550wrb.583.1640114050736;
        Tue, 21 Dec 2021 11:14:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u13sm3755115wmq.14.2021.12.21.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:10 -0800 (PST)
Message-Id: <3e01356815a84c9356f645735adde04906690f02.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:05 +0000
Subject: [PATCH v2 2/5] config: make some helpers repo-aware
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we prepare to add new config helpers to write into a config.worktree,
let's make some existing methods be available for writing to a config
file relative to a repository.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 config.c | 29 ++++++++++++++++++++++++++---
 config.h |  7 +++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index c5873f3a706..9c9eef16018 100644
--- a/config.c
+++ b/config.c
@@ -2882,7 +2882,12 @@ int git_config_set_gently(const char *key, const char *value)
 
 void git_config_set(const char *key, const char *value)
 {
-	git_config_set_multivar(key, value, NULL, 0);
+	repo_config_set(the_repository, key, value);
+}
+
+void repo_config_set(struct repository *r, const char *key, const char *value)
+{
+	repo_config_set_multivar(r, key, value, NULL, 0);
 
 	trace2_cmd_set_config(key, value);
 }
@@ -3177,14 +3182,32 @@ void git_config_set_multivar_in_file(const char *config_filename,
 int git_config_set_multivar_gently(const char *key, const char *value,
 				   const char *value_pattern, unsigned flags)
 {
-	return git_config_set_multivar_in_file_gently(NULL, key, value, value_pattern,
+	return repo_config_set_multivar_gently(the_repository, key, value,
+					       value_pattern, flags);
+}
+
+int repo_config_set_multivar_gently(struct repository *r, const char *key,
+				    const char *value,
+				    const char *value_pattern, unsigned flags)
+{
+	return git_config_set_multivar_in_file_gently(repo_git_path(r, "config"),
+						      key, value, value_pattern,
 						      flags);
 }
 
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(NULL, key, value, value_pattern,
+	repo_config_set_multivar(the_repository, key, value,
+				 value_pattern, flags);
+}
+
+void repo_config_set_multivar(struct repository *r, const char *key,
+			      const char *value, const char *value_pattern,
+			      unsigned flags)
+{
+	git_config_set_multivar_in_file(repo_git_path(r, "config"),
+					key, value, value_pattern,
 					flags);
 }
 
diff --git a/config.h b/config.h
index f119de01309..5531fc018e3 100644
--- a/config.h
+++ b/config.h
@@ -258,6 +258,11 @@ int git_config_set_gently(const char *, const char *);
  */
 void git_config_set(const char *, const char *);
 
+/**
+ * write config values to `.git/config`, takes a key/value pair as parameter.
+ */
+void repo_config_set(struct repository *, const char *, const char *);
+
 int git_config_parse_key(const char *, char **, size_t *);
 
 /*
@@ -281,6 +286,8 @@ int git_config_parse_key(const char *, char **, size_t *);
 
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
 void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
+void repo_config_set_multivar(struct repository *, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
 
 /**
-- 
gitgitgadget

