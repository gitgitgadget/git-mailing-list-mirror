Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90B02047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752119AbdHGVTT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:19 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33487 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdHGVTS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so1467690pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=TXds3/Vhj6DtyscIA4zlNjSQffKSn8Oz9aZZIv9+y/LGuIE1k7tg5br7WB+rnbrEfK
         Lo6QWCkW/mrWhFVJZjeaatAAmGQQSNQzOur5rK4B+Vtkq7L7NloylJ0DxESsNlN52a1M
         WUk/1qNiwiTD3YSW0+RvUYmDqE9bS5/2L/CO9oaMTlW4jQWwEFXP6/SV2zHBZ352/kcr
         GrUNRwqw1N0E8YIWM6JD9SR5/M3RF0IDD68Qrk/6pLTH+R4k7z7XHc2fDDAUt3W8Zw+t
         Sv7E8msJ08FJofPC+x2yfjOP/QWIYTXOZ6m9cqtnC+nAAxxCclWt1I5IjkxfDaLAUWB0
         k2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=PrkLHtVyvZ7jGU2mUsQWsJJ5y9DK5knaKRZHv6OqMVUsXk5OyO8C9FzArFPFw1WYdm
         GXd8t6lGpqXhbOpuDDLlVbQ5gqM+VXfPPtL96oaN36fv4uwyPML+pJ1E78Z06+yiGhHq
         aaRhHVVf+IHq9bygv//CPKhdpLq/bYM0Fp7p8QnFnPbY3tYBRDNuJmonWyLCK/r31Zzo
         ytY/5d4Fda61khEr6NO1UTgrvD40syteek+oBYmji2dD2tmlZ2CEW1yN/EsGvmcDjgw3
         lFzI6YDvi16ww5QjnwlAdgOnfWUO4zKyro91stmnzGY77An9q/8MSrZrFtADJSrn7pQh
         kLqA==
X-Gm-Message-State: AHYfb5h7r+6Lw6xxfKWE8YVgCvH+FKkp9OK/RCjaXalaWLza6mlYWVti
        hB34iaNMuJiPfzIoybM=
X-Received: by 10.84.172.1 with SMTP id m1mr2076819plb.174.1502140757338;
        Mon, 07 Aug 2017 14:19:17 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:16 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 01/13] submodule--helper: introduce get_submodule_displaypath()
Date:   Tue,  8 Aug 2017 02:48:48 +0530
Message-Id: <20170807211900.15001-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
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

