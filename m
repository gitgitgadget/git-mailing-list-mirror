Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3CA0203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754235AbdGXUfU (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37903 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbdGXUfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:18 -0400
Received: by mail-pg0-f68.google.com with SMTP id s4so12684018pgr.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=fOioWfkLXZfE7wrRxaHi4V8moZ5wXFSGJbT4lYKcs/Xm9ZomG9wfoBN19heS6676NW
         ptyWJ3DoqoxS9h70EpyCRLhNAQJLgG81g5q7AI7L7bcfGjxlcg5z8FScWZZkUCrFhUxD
         hn32kJhr1GgqC+DinQuIcNG/cIVikP5HWcImAEyWTITBzetL7GGqHjc01XE+AovX73mL
         LlH83yb8+LehvSmaT4GZxuSPyKpEfbWrm0wlxTg2gzmCgxL02S5O4WyzrjDasSxy+wOH
         Knj4qA5tYKWrmMIBQdfRz2LOgDXXeXpphEpV5HBnjkd8+PfPbFyIltYmXPDYV7M9Cf6m
         2ATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=Zn+8UtJFaCjSrX9LHMpOVQd0EGDTmaGPh8YEDn3Lpl+2rmKQ70lJt0iIQ7NqemTDgq
         Xe4Nkm/rjP+36VkYT6WJHnmwBGHZjLzSuOwOml8oxG0W3vXpRTFm7wynKQ4/IEX1nut0
         VNBgL2M/8LSu+s1ltbZlkd+ijZcsJAku8sfJ1vo32m5fSF+Rg37eP7QewyfMcKMGosTY
         f0bhOSY3pOqByTjB/5p9b5YqxiqHJKLHrLidf/6Mr3nZ/n5nVwe5uFRgH5rzY57mPK37
         DAf7FKH6Fb8BEIzgrbQKM5LP4q0xCUVcFT2PVCKjJUqAclXi3VsKaA5SfzhDt1TQmgUb
         Hr/w==
X-Gm-Message-State: AIVw1124UMv3YrrrrBsgg6sBWC9SclLzVsS2amcFnVLvNze8eVrCLyxz
        QEkx9BvE98vZ2dFIOXE=
X-Received: by 10.84.209.130 with SMTP id y2mr14353845plh.453.1500928518295;
        Mon, 24 Jul 2017 13:35:18 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:17 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 01/13] submodule--helper: introduce get_submodule_displaypath()
Date:   Tue, 25 Jul 2017 02:04:42 +0530
Message-Id: <20170724203454.13947-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
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

