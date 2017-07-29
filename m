Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D0622047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbdG2WY3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:24:29 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37629 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbdG2WY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:24:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id k190so11206292pgk.4
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=Gx67RmVed24UfJq+7NLREk6FC8jrRa5LBNmDOdJLWh0btAsWdtRJS1R04WpBWos90W
         m0gej4Xm8rui0Ga+pKNVqGp4o2tif+yF419gQCvf5qa6ZH5dAA6zDYpbbe1LwpTbVfAf
         04STxa8gGtfiyYLJ7eRbfvgtFeJ7IkzJ/6MrnlWDdoWzRg0cK7JFxw12VrB/f5/N1kwc
         DI9VwrTKnu8heXlRVDkRWDFJNkTbvJIHQNVpB4+h6HWUER+qPsJWPUY31QQcHmMLPFh+
         x2PKCbBSbMKF36vt5Ro6YX/PnDUtRrOBwx1ZyiS68uGd4OJXFTp6HzNRHo2hKkyF2Fhl
         Mkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=qeWFbKxP+Fieav0Hef1PFJss1zjC1romcaxUHRVLFsee3THTO1/Wzhm+MKH2ElR+Ux
         mdWbvV/HU5xJjERwUSz/Oj78tmbRklkUW2n5rSe6ers8DYj/poP2RXp1qjonFd+NNBOI
         /ckaePCoglkHarCSSATH+D6Hpte1jyZfin7wfLhiOBYanrVOYHpbaiq8aDRiOHfEcGI/
         LBXBywQQ9RQJMKAEhNUO9l5fzAgGIalqYQQzzdWt0CvMsg6PO1UiqadRzwOyUawMTIu8
         FPA/BR4GVxMUxKowb8t9kzzpEj5l5/99L3vL4aUqXoCWGjsqGdGhdo0W6DXIxZ1sLWMl
         PdAA==
X-Gm-Message-State: AIVw111JSly2ckIPUVnYh54rRaqmwZTlNlJ+SF44pa4y3H8zRf7kUZTE
        p8mAB4ul8o3Uy70mG6Y=
X-Received: by 10.84.224.137 with SMTP id s9mr12456942plj.427.1501367067454;
        Sat, 29 Jul 2017 15:24:27 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:24:26 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 01/13] submodule--helper: introduce get_submodule_displaypath()
Date:   Sun, 30 Jul 2017 03:53:49 +0530
Message-Id: <20170729222401.12381-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
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

