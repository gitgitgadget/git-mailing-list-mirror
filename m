Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79130202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbdCIWQJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:09 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33850 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753598AbdCIWQH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:07 -0500
Received: by mail-pf0-f175.google.com with SMTP id v190so33698875pfb.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ypsWvswS7P+olyrjRaZJlvdv+c8MDQXqMCp0k8e5w4=;
        b=Z3D8cuOclZmfjw7T9Bc8SdpWRZb+Gks6FdY2vjZEuA8FDb48nHEO1PuG/I7BBM2Wl4
         ha9MibAfO1N6R9vJUgrbOXJtaxGZGx4Az7nfjZsG1WTeno6UD+9QHDzOs20iasOsyQqv
         zhUkWFaqGEEqrtoSN4X4SUyZEH/+4P3GQHGoQG85U4qGIiwsS+txXVno3eCLje7yYUNV
         2crFvLFzB9bbYcFeg5J1zC+jyAAd005kdQeOnm2F7lSk1r0Mf4SLJzEZS9/PX6Q5l/kZ
         W9gWgaCnmW9JwjbAZmd4RTd5+t/KLyQDyqXw1zwU/BqQmCKqigB0Jh60GjBrTfLen9/H
         zjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ypsWvswS7P+olyrjRaZJlvdv+c8MDQXqMCp0k8e5w4=;
        b=AbP3AnRZroEyvD8o5+xV/LJYoGjJtSGfueaoPmZaDbVI9IkD05i2rKt02+L4N9Pe0u
         EeIpgmAzbHYhIpYTQxWTgPBFssAnVEi8WBNcmTYDVBYozFmUEIlMV7abZgWLi3k9IDYN
         O1a19KRUcD0qz4YAAZX9IOWlwVnXm42gEHVk5HgwlRhjtew6Kw0XtRsbzpPcSts3mvFs
         EFzsrTR2IHvBKt/NXVbKHzLUi/HOXyphECRSL0olbMva0kGiAPmDD00Se5DSFPtiWfZs
         1NgAtdv8igEHXFCBbgNJGiEex8vhxH3CWeMZ2UidNlzVaZzmPj5VtEibaCl0B6ERwKc3
         wo2A==
X-Gm-Message-State: AMke39mXf0pw5v+ALjILXXtViYuZ1K2VF6jPA3JI57abJcppvOxXvMryLlaBXTLDoxoj0fRk
X-Received: by 10.98.100.88 with SMTP id y85mr16862639pfb.112.1489097766142;
        Thu, 09 Mar 2017 14:16:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id 10sm14297336pfs.113.2017.03.09.14.16.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:16:05 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 08/17] update submodules: add submodule config parsing
Date:   Thu,  9 Mar 2017 14:15:34 -0800
Message-Id: <20170309221543.15897-9-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

