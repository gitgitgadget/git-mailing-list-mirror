Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10DC20387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdGRUt3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:49:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36008 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdGRUt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:49:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so4188098pgy.3
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=uNRt2/inUcM/fWA3jdxep+i+Idh+08F5fgcJt2Ag5B5KKmGn+OqmDFQKEvFgebWyI3
         wIbS8GaQUEumBBezfcvAYnsQWIg5+d25AAMAmS+RguarIzsH7e22/wKsyRtKy4VaaXe7
         5aYaWCbdR4kcTlwDmbUE8UPZM42CxFJv6J/KzcFVHHt4lGVeekqW8YbOrGR6znnH8Jcc
         l4Gr+XsRpAY2kksdyMaxMiYqE1vMpzSgo8/DwLFFZ8mAvUwOx9e/YKQt7BipVYTNp48L
         HFUm/848O8lcDDqLBZ38GawMwpokjcssSqaQqp7C4AX/xalhI7lUIAcmYOSK66WMkMmr
         UPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=H9Cb8H5siDuFLTAYhA79ZVYaQstHMOrCVc2Tk2VsATYtPohW6YpeB/4jqmuzCPZbYK
         BLdHSRcmVEEJABXowQGUCEsXTPjFQKtSGewoVJEaCDoVD/sbmgjYW+c7P+8cS33PQWEY
         FQ/87oCDY+XImurGvkqrfBgw/VfK1ewzXAMFmylmpfseH4rBZ5DyJbYWh94hsY1fbsoP
         azGklwQ4TeEKK1xD6pC1ln3opaMog5meYw63vtRcclhJ4o9eyvzB/VmFSh7ojgdfFnea
         rTcRv+E+qckfX9mmf4N2xOK7ECBVbOZKv6LVsaG+2aNJVr/OQ5JtM11sN4mAn4X6mOZs
         7bug==
X-Gm-Message-State: AIVw112cZDzK5mvyiFqg9ivJPhB/FSt0r9k8dZgKjwB6z0vY8nEILS7k
        xCjp2GPm5A4wEhNsY8U=
X-Received: by 10.98.18.131 with SMTP id 3mr1387817pfs.19.1500410966731;
        Tue, 18 Jul 2017 13:49:26 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.197])
        by smtp.gmail.com with ESMTPSA id e5sm402742pfd.41.2017.07.18.13.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 13:49:26 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/8] submodule--helper: introduce get_submodule_displaypath()
Date:   Wed, 19 Jul 2017 02:18:57 +0530
Message-Id: <20170718204904.3768-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170718204904.3768-1-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6abdad329..7af4de09b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,27 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +360,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(null_sha1, path);
 
@@ -363,7 +375,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
 	}
-- 
2.13.0

