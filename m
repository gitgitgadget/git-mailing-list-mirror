Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B732022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdBWXFK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:10 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34848 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdBWXFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:09 -0500
Received: by mail-pg0-f49.google.com with SMTP id b129so2294735pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skbdvf+IPqG2B1OU28o73eRHTbSQ7ouizHHy0njrU30=;
        b=im/KVWZko9s/C7f5tn5D2xwU60s93Uo9VNM/217nxNVVBWl7mMt6c+zl2zAS5pvot1
         wxTJAQQpRrorfcn+9QYo/TPB3hgnEkHhW7xCsM+c0fujp4gvDJQ3iC3fC83jiZOawVZY
         16osYyzoc9NncxQnlu/5bDdN3PI2byWpIDWiKL9ITlsKtna6nE5Ajf2LXbPwyFmMZ7GU
         p0fniRr1oPj5Td8tHHjJHF+CVNZjTluSgXjcr77e6G5YAhgbe7QeKgtVfyMU0yUXKYJ1
         P6yYxFom133kOZL7QFT6sl/curKjam5xqP7JE+6jX5ENCKoxajlaQ7K/FReIw4gwzt17
         2M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skbdvf+IPqG2B1OU28o73eRHTbSQ7ouizHHy0njrU30=;
        b=CUMe2++67lqiOtDoHQ1+wNBEX2TUs7GiTe4gkWJVAWXLdNsD0k8yS3jLIACdwJR3pB
         p8XbzjwfyE9rsO/Ru512DdLKJV6PTpoVrJ1DgXFljdu++YkHErD0eWrXLoNHyBj63kom
         QZIE3yJakuImzznzQl5NVLrGlcydB+jat+GlQXfGJ9qMaEcTKaT8xpk7HfcXCxb0a/wM
         vGIsBNWwWmWUoz8KQi24sSUmppWv1VV6NkDvrAoGvFKmhsmOHixU1K0Y7mZReLbmmXvk
         l2VrRRDnaKU4tpwKhHa0eBb/n0iZgKY067mM9YrVG7TkfTlsFhId6u4OrOsogZ2xitfD
         UdOQ==
X-Gm-Message-State: AMke39n4EwmFzQ7BhzYQgEAP+glcOwZFLUxFtUdVk2hxuagwhrsBMlVOcMFzuOn4d7T69Kvu
X-Received: by 10.98.215.70 with SMTP id v6mr48926486pfl.141.1487890678982;
        Thu, 23 Feb 2017 14:57:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id r66sm11544891pfj.125.2017.02.23.14.57.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 06/15] update submodules: add submodule config parsing
Date:   Thu, 23 Feb 2017 14:57:26 -0800
Message-Id: <20170223225735.10994-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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
2.12.0.rc1.16.ge4278d41a0.dirty

