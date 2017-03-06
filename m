Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 711481FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbdCFJwD (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:52:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34810 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdCFJvz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:51:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id u132so4738743wmg.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDSdjrPG6hZFSG+qnCorLvBP6CWSS1xleqqIsUzmE2s=;
        b=AjW87TpsxsoChrxKFAi6YPbjVfWBd2yPxtcKwfHeqN85hETc0jM27j22k/Djuln3X8
         mdSW+YZm3PKsWYlVe8q7SFwk4GddL/mPX9uBlbctVecUoYFSqrdVl3s616Fp353I6DVi
         XylDJ3jv8yFWLfLbvSqLfhpzNDcNB9yIlr0oK+3XA4fvIy1z/dwC3+cmM3lwhDj33tsu
         5pgjG2sXcnj2epPvJ9pIOOI0o1VnwJXTL9yPfTfJr/pRjJi65uxUq9vYz1sLeEFLTKZJ
         r0Ege0DQDyAbQoxitVKWo9j8cfhYPmnewLwIbI56OJFto2ybqJ/q+HSVGFZVSiCE93OO
         X6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDSdjrPG6hZFSG+qnCorLvBP6CWSS1xleqqIsUzmE2s=;
        b=jADfdMs+YoAx4qnoPvlnU0BYCxv/9+Ypfu8+9orWA6XjBRpu7eoEx5RB95wAc/CwWV
         kIW2taHLN5765Ze4lPGp05g5I13F2GnKeZ659sJ22gFUuOlUG40YK+uvjrgeedhwRLfM
         AbCfkE0FPtDx4wevk6WN3YHHBpAnHOSDGr+2HqmrG3ILnhxYau4Hqfqy30hhANZKlxET
         9GkktsIq+n/z6Fa00PELdiTsT4Oqizz/tZHa31eUvRyENcsIRF7qyGYJhbduQDcmAoJ0
         QpGmN7NR5JQAuDaUypRnjIIRspBc5jzQqwJc5z5HRYfBdzvsjtEDf89vceBwTW9LA/KD
         CLMQ==
X-Gm-Message-State: AMke39n97N+Cy4uiW5KPUuolocDibsy4wuZ4Gua2zgYiu6I3F4GKc/+aYDF6Z8L+PGdK3Q==
X-Received: by 10.28.141.16 with SMTP id p16mr11765408wmd.42.1488793359744;
        Mon, 06 Mar 2017 01:42:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:38 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 16/22] config: add git_config_get_expiry() from gc.c
Date:   Mon,  6 Mar 2017 10:41:57 +0100
Message-Id: <20170306094203.28250-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a following commit to get the expiration
time of the shared index files from the config, and it is generic
enough to be put in "config.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/gc.c | 18 +++---------------
 cache.h      |  3 +++
 config.c     | 13 +++++++++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index a2b9e8924e..56ab74f6ba 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -64,17 +64,6 @@ static void report_pack_garbage(unsigned seen_bits, const char *path)
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
@@ -131,10 +120,9 @@ static void gc_config(void)
 	git_config_get_int("gc.auto", &gc_auto_threshold);
 	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_date_string("gc.pruneexpire", &prune_expire);
-	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
-	git_config_date_string("gc.logexpiry", &gc_log_expire);
-
+	git_config_get_expiry("gc.pruneexpire", &prune_expire);
+	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
+	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 	git_config(git_default_config, NULL);
 }
 
diff --git a/cache.h b/cache.h
index a35e9d5187..65ab507a76 100644
--- a/cache.h
+++ b/cache.h
@@ -1932,6 +1932,9 @@ extern int git_config_get_untracked_cache(void);
 extern int git_config_get_split_index(void);
 extern int git_config_get_max_percent_split_change(void);
 
+/* This dies if the configured or default date is in the future */
+extern int git_config_get_expiry(const char *key, const char **output);
+
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
  * ensure that they do not modify the untracked cache when reading it.
diff --git a/config.c b/config.c
index 35b6f02960..f20d7d88f7 100644
--- a/config.c
+++ b/config.c
@@ -1712,6 +1712,19 @@ int git_config_get_pathname(const char *key, const char **dest)
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
2.12.0.206.g74921e51d6.dirty

