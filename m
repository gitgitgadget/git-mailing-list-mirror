Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598222021E
	for <e@80x24.org>; Mon, 31 Oct 2016 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945699AbcJaWix (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 18:38:53 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34389 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945612AbcJaWix (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 18:38:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so83408082pfi.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2016 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QwHd05CIlmVtl18Rr/USydzE9jJ4De/k64voNC16FWs=;
        b=MohFeUTRgqdkB+fkGDUCPOxyKeXYHySx706svcznFlRgj7bMMd7powmTNFo0nNV39o
         1cZ94H95bh/VJNoxVdWT09Bli9hfMlVFv/l5W8LywpwMXzdF+OsPQRc2ekzYSpSMyo2s
         gkq9nKGLP410BvSr+bwxFPzDubVrODYbJrIjcLGo22N3QXbgN4qOhaKGd5Q45whe0GP3
         zCWlql4fQqC0Ft6TpIsZwk37VYZ1G+oJwwSnnoZ3NG2aUesCOvAZ/XQbjnf4Tk1gnlE6
         Li1eQWClCZ82KkE3Ojsyw6ITuiGt4R7MrK1NpxlEvYtcB5mLGqxl4J7CQhQEduKMhIbT
         tXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QwHd05CIlmVtl18Rr/USydzE9jJ4De/k64voNC16FWs=;
        b=h6iNil7DwGVGqxRlGyaZVzyqP3/gEJ+KyDZiifIYGbESBSsoWdpJP229I3VXSs61lw
         L2wk+Ar63v1p85WED/zyKO1oY5mYCzGi9lf7zuEifRHaqPS7Cs2R62QKUoYWWIsN/EHS
         sWP90YaIiZLXuQlhU0izWxoZL8M6G5VXZ7jVv1+PVAixtCLWy7E4D53ofY3tnhJPeDAm
         Psj5QG5lr5ttL4el/BvMSOB1ilbIYALbjrofFy/em3g07SD4aCnE2WDRNMt4rk4gFM8U
         DCg9QIGraLpyCWAhgSbeVRS64/FW9rHBGzyiVX4pHcLoiyXuKOk67YSsIsMTb2TLn+aK
         CNaQ==
X-Gm-Message-State: ABUngvd88LTc7bVHG4GKNvwiUFCBQxG016pHyz+Z3xasD2HnxnAz7k/m93ETIzIM8veVukD/
X-Received: by 10.99.221.85 with SMTP id g21mr44304359pgj.121.1477953532224;
        Mon, 31 Oct 2016 15:38:52 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id uh10sm37847280pab.5.2016.10.31.15.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Oct 2016 15:38:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, sbeller@google.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 1/6] submodules: add helper functions to determine presence of submodules
Date:   Mon, 31 Oct 2016 15:38:11 -0700
Message-Id: <1477953496-103596-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1477953496-103596-1-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two helper functions to submodules.c.
`is_submodule_initialized()` checks if a submodule has been initialized
at a given path and `is_submodule_checked_out()` check if a submodule
has been checked out at a given path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 39 +++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/submodule.c b/submodule.c
index 6f7d883..ff4e7b2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -198,6 +198,45 @@ void gitmodules_config(void)
 	}
 }
 
+/*
+ * Determine if a submodule has been initialized at a given 'path'
+ */
+int is_submodule_initialized(const char *path)
+{
+	int ret = 0;
+	const struct submodule *module = NULL;
+
+	module = submodule_from_path(null_sha1, path);
+
+	if (module) {
+		struct strbuf buf = STRBUF_INIT;
+		char *submodule_url = NULL;
+
+		strbuf_addf(&buf, "submodule.%s.url", module->name);
+		ret = !git_config_get_string(buf.buf, &submodule_url);
+
+		free(submodule_url);
+		strbuf_release(&buf);
+	}
+
+	return ret;
+}
+
+/*
+ * Determine if a submodule has been checked out at a given 'path'
+ */
+int is_submodule_checked_out(const char *path)
+{
+	int ret = 0;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	ret = file_exists(buf.buf);
+
+	strbuf_release(&buf);
+	return ret;
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d9e197a..bd039ca 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_initialized(const char *path);
+extern int is_submodule_checked_out(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.8.0.rc3.226.g39d4020

