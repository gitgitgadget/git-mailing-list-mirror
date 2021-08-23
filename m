Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F4BC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA1C613D2
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhHWQGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhHWQGB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:06:01 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C748C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 09:05:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o2so17072586pgr.9
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftTIo9vtJrQf79GtUo0gVrA/YVK8SGoTQInCZy8/a6Q=;
        b=kgdtFiJK27zs7YCdcxHqmDdcyOR1uxQF4tXKpvSkEgXtpQ1dh3zE+YwyXTdu4E6rNR
         MpubzK9b6pk5V+asXsRBJNr6R9AhZHZcqj8TEsArf9S4WBLZs7XbKKbMk3pZ6V43PgUL
         p3cDNODfbTBsbrW6XMmKsYP14iQKYnio1I3Ty/uqu3JqWD1Ps9i3LHCdDGUPNb9dWGgO
         3+8b9OSsEl33JHPRazfLm/urIT7w0kOdTiMUBujrCk0GB8YIF+rk6hxHY0/qExSouesr
         UGL2Madf8kl2eL+ZWVuTQXZpDAqj6Lh/jX4uCd5b4Nq8H79FyTKq79KE1IRjFmEgFsqO
         XVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftTIo9vtJrQf79GtUo0gVrA/YVK8SGoTQInCZy8/a6Q=;
        b=H0qVXsID7QjpCrldYcKBuYttJKFqhrxmbcyAyqei8lnr1EBzfxOOVotOz0D29LfLNO
         JSAUqvQ/ZqEycIaDbUXG3tt1Tj+GfGQSoqK+W+PuZZ6/A5SWi0Kz7/9rVH10kvGfz53O
         YXkEzsBw20QxFOALYK04b8SNVS+NKDeQj8kmwfdeDh+7ymx0wxnsrsMgn9hF9ZmlxbBI
         q9/g4FfDoamRjGpGJyDMjS2tTUPfRADnLLYx8NzjPuOQ0oKgX9HpYFsXEcKCN+Z8Hqme
         WADoIsQsPDSbqlPoKDbCPxf7ZdqfxvbDjB8OZg+QaW2BasnOVUnWUt14gC3ZGF6H94uw
         3+Nw==
X-Gm-Message-State: AOAM530suKi//DpKrH/0AobWZvJWpzdVKMtkrmUIZxQ40/31pumf+dIu
        HElsVV9X4ZPZhC2czfq3ByJZgxjbaG0du8BrdmwdZw==
X-Google-Smtp-Source: ABdhPJyskbpdf76c0Df4TPEOg0Qa4I7rNGqDs8irI26Dcke0wNupyS/NoZqeKAsDD9So3DkF8F0dGw==
X-Received: by 2002:a63:f501:: with SMTP id w1mr32702855pgh.57.1629734717822;
        Mon, 23 Aug 2021 09:05:17 -0700 (PDT)
Received: from localhost.localdomain ([183.159.196.131])
        by smtp.gmail.com with ESMTPSA id g4sm11240323pjt.56.2021.08.23.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 09:05:17 -0700 (PDT)
From:   "chenan.xxw" <haoyurenzhuxia@gmail.com>
X-Google-Original-From: "chenan.xxw" <chenan.xxw@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chenan.xxw@alibaba-inc.com, peff@peff.net,
        worldhello.net@gmail.com
Subject: [PATCH v2] http: add http.maxReceiveSpeed to limit receiving speed of "git-receive-pack"
Date:   Tue, 24 Aug 2021 00:04:55 +0800
Message-Id: <20210823160455.32397-1-chenan.xxw@alibaba-inc.com>
X-Mailer: git-send-email 2.33.0.1.g26e5a845c1.dirty
In-Reply-To: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to avoid hogging all the available network bandwidth, users may want to
limit the speed of receiving traffic for "git clone" or "git fetch".

Add `http.maxReceiveSpeed` to limit receiving speed of `git-receive-pack`.
Can be overridden by `GIT_HTTP_MAX_RECEIVE_SPEED` environment variable.

The default is unlimited, same if the value is 0. The default unit is Bytes/s,
common unit suffixes of k, m, or g are supported.

This configuration is valid for `clone`, `fetch`, `pull` commands of the https
protocol.

Signed-off-by: chenan.xxw <chenan.xxw@alibaba-inc.com>
---
 Documentation/config/http.txt |  4 ++++
 http.c                        | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 7003661c0d..9b9fb5e9c7 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -235,6 +235,10 @@ http.lowSpeedLimit, http.lowSpeedTime::
 	Can be overridden by the `GIT_HTTP_LOW_SPEED_LIMIT` and
 	`GIT_HTTP_LOW_SPEED_TIME` environment variables.
 
+http.maxReceiveSpeed::
+	Limit the speed of receiving traffic, defaults to unlimited. Can be
+	overridden by the `GIT_HTTP_MAX_RECEIVE_SPEED` environment variable.
+
 http.noEPSV::
 	A boolean which disables using of EPSV ftp command by curl.
 	This can helpful with some "poor" ftp servers which don't
diff --git a/http.c b/http.c
index 8119247149..b12d192ffe 100644
--- a/http.c
+++ b/http.c
@@ -83,6 +83,7 @@ static const char *ssl_pinnedkey;
 static const char *ssl_cainfo;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
+static long curl_max_receive_speed;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static const char *http_proxy_authmethod;
@@ -362,6 +363,13 @@ static int http_options(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp("http.maxreceivespeed", var)) {
+		curl_max_receive_speed = (long)git_config_int(var, value);
+		if (curl_max_receive_speed < 0)
+			die(_("negative values are not allowed for http.maxreceivespeed"));
+		return 0;
+	}
+
 	if (!strcmp("http.noepsv", var)) {
 		curl_ftp_no_epsv = git_config_bool(var, value);
 		return 0;
@@ -974,6 +982,10 @@ static CURL *get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
+	if (curl_max_receive_speed >= 0)
+		curl_easy_setopt(result, CURLOPT_MAX_RECV_SPEED_LARGE,
+				 (curl_off_t)curl_max_receive_speed);
+
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20);
 #if LIBCURL_VERSION_NUM >= 0x071301
 	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
@@ -1105,6 +1117,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 {
 	char *low_speed_limit;
 	char *low_speed_time;
+	char *mrs;
+	static const char mrs_env[] = "GIT_HTTP_MAX_RECEIVE_SPEED";
 	char *normalized_url;
 	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
 
@@ -1197,6 +1211,13 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (low_speed_time != NULL)
 		curl_low_speed_time = strtol(low_speed_time, NULL, 10);
 
+	mrs = getenv(mrs_env);
+	if (mrs != NULL) {
+		curl_max_receive_speed = strtol(mrs, NULL, 10);
+		if (curl_max_receive_speed < 0)
+			die(_("negative values are not allowed for %s"), mrs_env);
+	}
+
 	if (curl_ssl_verify == -1)
 		curl_ssl_verify = 1;
 
-- 
2.33.0.1.g26e5a845c1.dirty

