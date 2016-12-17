Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43FA7203EA
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758379AbcLQO4l (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:41 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35059 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756968AbcLQO4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so10611013wme.2
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UwW1PW1GyRg3CQe6ypHlrx5+SC4OlegqJaARGGM+Yh4=;
        b=qP9YK0wf5VNMKl7V9P68y5HjgCmbpyapKWmZi+JMzneBgnf/+aGjUBfMTDiNekqZzn
         0p6p5xKX11LNE2OYDv6sahCNoGegd/1pfMnhOU2zYo5wl8oknHc2kxD/SEbBYp89O+Z5
         mZFaALaIx+KaAmCHlWQJW1U63aAByCSlrS4MAkmu5qUuqg1cHlyTLrONB24IxJWdAVSG
         AJK1F4doFgtDn0DvefbQuZNI/MgU9U2pNPiyXq9DFfi9y5K/EZGghhmTjh6k1KNrKVmO
         WxRfZSgRu3KxdseG0B/dYQ0DpmC+x/g97eBM3gvv99Ff6WMc0UuQ43X0Zz48prGq1FY7
         rw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UwW1PW1GyRg3CQe6ypHlrx5+SC4OlegqJaARGGM+Yh4=;
        b=mw2T4vuitBrB7DJ76B7LmOu7kdIgHiPnRqk6rqHnRRfee7G9bgSgghizPXAxvp3vzm
         SVs8jvlQ4GFHYGV9y48V8Lrg7K9Jjeb/ILW5miZsaRdGDdvpmrPZpehQ8tlPHHGwJ+eg
         nFQcYdxtDTVX9bde9uUbfq7u4XQ1n1oCPh+Q29Ei38bM3u8qRDoEbf4KmxGUh2CzD+0t
         o/vuIYRu3mFd7ASdR3PWgee0e+Hgdt19fJqu03LZZHOU1BhqEJAXwBaFCkK+3dDdySxi
         zLLVCZmTI6SugjojfY8IoBmjnHPEK9I/By4O1UeYGNSgCtuBI9TCTRgiZJK6Vl2336jK
         ne5A==
X-Gm-Message-State: AIkVDXI4j8frrxP/uPQ2/9BPBtVs8eCBx/cUlZi5EfXipuJ+jUJZklvWEcfV63ziGZB3jw==
X-Received: by 10.28.135.5 with SMTP id j5mr7667861wmd.3.1481986579992;
        Sat, 17 Dec 2016 06:56:19 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:19 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 15/21] config: add git_config_get_expiry() from gc.c
Date:   Sat, 17 Dec 2016 15:55:41 +0100
Message-Id: <20161217145547.11748-16-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a following commit to get the expiration
time of the shared index files from the config, and it is generic
enough to be put in "config.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/gc.c | 15 ++-------------
 cache.h      |  3 +++
 config.c     | 13 +++++++++++++
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 069950d0b4..1e40d45aa2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -62,17 +62,6 @@ static void report_pack_garbage(unsigned seen_bits, const char *path)
 		string_list_append(&pack_garbage, path);
 }
 
-static void git_config_date_string(const char *key, const char **output)
-{
-	if (git_config_get_string_const(key, output))
-		return;
-	if (strcmp(*output, "now")) {
-		unsigned long now = approxidate("now");
-		if (approxidate(*output) >= now)
-			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
-	}
-}
-
 static void process_log_file(void)
 {
 	struct stat st;
@@ -111,8 +100,8 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
+	git_config_get_expiry("gc.pruneexpire", &prune_expire);
+	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config(git_default_config, NULL);
 }
 
diff --git a/cache.h b/cache.h
index f442f28189..279415afbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1827,6 +1827,9 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 
+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/config.c b/config.c
index 3e96c223f5..5c52cefd78 100644
--- a/config.c
+++ b/config.c
@@ -1685,6 +1685,19 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return ret;
 }
 
+int git_config_get_expiry(const char *key, const char **output)
+{
+	int ret = git_config_get_string_const(key, output);
+	if (ret)
+		return ret;
+	if (strcmp(*output, "now")) {
+		unsigned long now = approxidate("now");
+		if (approxidate(*output) >= now)
+			git_die_config(key, _("Invalid %s: '%s'"), key, *output);
+	}
+	return ret;
+}
+
 int git_config_get_untracked_cache(void)
 {
 	int val = -1;
-- 
2.11.0.49.g2414764.dirty

