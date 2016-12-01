Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1651FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 01:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754869AbcLAB2s (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 20:28:48 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33339 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754635AbcLAB2r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 20:28:47 -0500
Received: by mail-pf0-f171.google.com with SMTP id d2so42369113pfd.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 17:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CJ/607EHfWlN3PJ3++DJwVZGnQKFSLyujTr+ajU3Xpo=;
        b=gSyoQD/Wjc0q/pyMJbEN2MZ2+pdlmnfS12Rsyf1bEnRVRelZipL1Hay8bv2jG/c7NI
         odG2dzWwY+rJJuHptULzIBITU3PfTkqWFF3ifSTXhdGKjIuzTDy0hqOMFg+UVviT5mzD
         R4Eog3l9bL6DX9x5WFA68hUr4JFU736J5qlUgDflNcgkH5LJ88R2JdlXUN8vITInPyQ1
         k6Ln5axjj7B1FK3jsvaOatzM5pkXLatN6QnXb9dZKey7PM5Mb/TPwYY2KE1yFrOfPNOI
         w/pNG1LMwphlA4QAw1lu9XLdf40Rc2KWWMz2l61LgEuzQWriRQeyaYNmHCD2Ppj/qfeR
         xhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CJ/607EHfWlN3PJ3++DJwVZGnQKFSLyujTr+ajU3Xpo=;
        b=lpucz0euOqVTIlF1idoT5OoCPdV+LqOiOmdacwugSn/vNsU3nVe8C5QlmKy5CKWAGJ
         AUXgWiaAorE5UPcDE9rx74zRC3SBkMs0XJRTEsreHVlMoEvr9UPLxgSNDg6RkKPJxOUm
         s1/EWAGF5rfe8F6MfLyL0ixdQpkldMUS9lUd9NjowhebzC+bIp71PEWo5wtKAFwAk1oJ
         NmPnWNe2GJ5Nz+aypisRLDpnHwwtIgzusgdINwSAvs0hg4V5CqmDQiPiGvZldAgukOHk
         lg21xOkvGIrlKPf6vSKrwIRddkDO4DkvUkVv2W9KSPUl3TuPFlFTy4mkFOnFAtLPCtzN
         +ECg==
X-Gm-Message-State: AKaTC00LIuGx3jdyGrN9b9PBP3w1Iqz8VfYu/+J2Hsxb371P5QjX7a52I6XUP6VGfJX9wtTb
X-Received: by 10.84.134.3 with SMTP id 3mr78132336plg.90.1480555726610;
        Wed, 30 Nov 2016 17:28:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id i194sm87872386pgc.46.2016.11.30.17.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 17:28:45 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: [PATCH v6 1/6] submodules: add helper functions to determine presence of submodules
Date:   Wed, 30 Nov 2016 17:28:29 -0800
Message-Id: <1480555714-186183-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480555714-186183-1-git-send-email-bmwill@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add two helper functions to submodules.c.
`is_submodule_initialized()` checks if a submodule has been initialized
at a given path and `is_submodule_populated()` check if a submodule
has been checked out at a given path.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c | 39 +++++++++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/submodule.c b/submodule.c
index 6f7d883..f336ca9 100644
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
+		char *key = xstrfmt("submodule.%s.url", module->name);
+		char *value = NULL;
+
+		ret = !git_config_get_string(key, &value);
+
+		free(value);
+		free(key);
+	}
+
+	return ret;
+}
+
+/*
+ * Determine if a submodule has been populated at a given 'path'
+ */
+int is_submodule_populated(const char *path)
+{
+	int ret = 0;
+	struct stat st;
+	char *gitdir = xstrfmt("%s/.git", path);
+
+	if (!stat(gitdir, &st))
+		ret = 1;
+
+	free(gitdir);
+	return ret;
+}
+
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst)
 {
diff --git a/submodule.h b/submodule.h
index d9e197a..6ec5f2f 100644
--- a/submodule.h
+++ b/submodule.h
@@ -37,6 +37,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		const char *path);
 int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
+extern int is_submodule_initialized(const char *path);
+extern int is_submodule_populated(const char *path);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-- 
2.8.0.rc3.226.g39d4020

