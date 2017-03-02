Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6962023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbdCBA4v (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:56:51 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33670 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pg0-f49.google.com with SMTP id 25so25856608pgy.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+elW3utxHEE0hR3cQUEQqGvEgDb9w4+GTIiQ/iM6PYs=;
        b=cLhyOwki/XMN4GhhPmXPRXDaaPgZLCAl2NPMKO4FQOB+/G+X12ig9nnh55GbYJqBLT
         6LvC1E1cgtiIn045Hi4ickmVtTyuAQypGLrZwdf+0Kk5mTRvfFkygnoGaAT5g0jdidkM
         5pQmKB98/0XUwYuPsjrLQxiz7IPcVtndcb09VPOLUSqo99UE4oQ4mCK6zGwyYl07kYaW
         GTyGIcBeZT3e7QZJvPIxmpPRqz8R2n4RwoXx7XOVxVjIXbGPsHrePVU8hpotmq6EacyP
         2sWD9EVLzuFAMOp5JS+uaMVTYqR2ZIFY0X7QOsHa8TcyOYoEjBZznmMIt/7GvppRUdQZ
         ppBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+elW3utxHEE0hR3cQUEQqGvEgDb9w4+GTIiQ/iM6PYs=;
        b=AUHEzW67pbPesRsj3wiS4Kt1T/z8loGflUUpoAh9R/hODVQ5Oq2Nl7P9Hzh9CPEpFX
         9q/BnI9XbBMbsVkm1kyt2KZwYk+s7uJe7DejzJfD39gJRaq8hbFpj/6wgAvQIbmBRJAp
         prdTJVRzhzheTanzqnBcHBLAeYf4ERJTLUqetXt3syL2W/14HtnRCr839wDBOGSvbIjd
         gz9cwxDPtoeMrc1d99OR51SP6tc8guIzPyLOgego7/xVmQCTOOuf770mR43BuxwPM8y2
         DISF1Cw1+/SijIoF8M+cSuZDW8sGBYvEbtFqC8EInlFec6340ch4pgR10BfQjDsY7j2v
         ARKw==
X-Gm-Message-State: AMke39nMRhrvA+l5DzX5FOLuqBgrxCve8KC94TmO8hVG5HFtpy5NMmsHWvqL/KlMmME2M34a
X-Received: by 10.99.127.27 with SMTP id a27mr11515204pgd.87.1488415693820;
        Wed, 01 Mar 2017 16:48:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id m12sm12848239pgc.46.2017.03.01.16.48.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:13 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 08/18] update submodules: add submodule config parsing
Date:   Wed,  1 Mar 2017 16:47:49 -0800
Message-Id: <20170302004759.27852-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to b33a15b08 (push: add recurseSubmodules config option,
2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
that is later used to parse whether we are interested in updating
submodules.

We need the `die_on_error` parameter to be able to call this parsing
function for the config file as well, which if incorrect lets Git die.

As we're just touching the header file, also mark all functions extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 20 ++++++++++++++++++++
 submodule-config.h | 17 +++++++++--------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 93453909cf..3e8e380d98 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -234,6 +234,26 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
 	return parse_fetch_recurse(opt, arg, 1);
 }
 
+static int parse_update_recurse(const char *opt, const char *arg,
+				int die_on_error)
+{
+	switch (git_config_maybe_bool(opt, arg)) {
+	case 1:
+		return RECURSE_SUBMODULES_ON;
+	case 0:
+		return RECURSE_SUBMODULES_OFF;
+	default:
+		if (die_on_error)
+			die("bad %s argument: %s", opt, arg);
+		return RECURSE_SUBMODULES_ERROR;
+	}
+}
+
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg)
+{
+	return parse_update_recurse(opt, arg, 1);
+}
+
 static int parse_push_recurse(const char *opt, const char *arg,
 			       int die_on_error)
 {
diff --git a/submodule-config.h b/submodule-config.h
index 70f19363fd..d434ecdb45 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -22,16 +22,17 @@ struct submodule {
 	int recommend_shallow;
 };
 
-int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-int parse_submodule_config_option(const char *var, const char *value);
-const struct submodule *submodule_from_name(const unsigned char *commit_or_tree,
-		const char *name);
-const struct submodule *submodule_from_path(const unsigned char *commit_or_tree,
-		const char *path);
+extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+extern int parse_submodule_config_option(const char *var, const char *value);
+extern const struct submodule *submodule_from_name(
+		const unsigned char *commit_or_tree, const char *name);
+extern const struct submodule *submodule_from_path(
+		const unsigned char *commit_or_tree, const char *path);
 extern int gitmodule_sha1_from_commit(const unsigned char *commit_sha1,
 				      unsigned char *gitmodules_sha1,
 				      struct strbuf *rev);
-void submodule_free(void);
+extern void submodule_free(void);
 
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.12.0.rc1.52.ge239d7e709.dirty

