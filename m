Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F08F20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbdGMUFv (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:05:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34649 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbdGMUFv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:05:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so8040602pge.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=iuRvYvlK4y5KW2zWcGsblMlf1Z/VmRcGQIZdg5HErI2fs0CVRt/LctZyM3oDYxhXNi
         FndSJysZFohHwvI7UkOGiwCT5bS0yAr/CQHVARmYdczZ0xUJQ9+NjBwgmhcdkmk2mRMb
         xhDOGNH1Xp5gbfsU4I1sqx6Nu9xdcKA5Pa+629R3FgOO9SwTTp70SZV8UnRy6d4xyfBD
         tWZedrQ5QfhqAESu1kS3zY/O9Xd2TVmNahqpaJVhA+kQyNOXb6LrJwOVpHdL4OJmfTqe
         GVvfndexdrq4o2j+m2MPUOn2WPsBF98x3hWPTS5FajSKrDgBF7brIO4wFeznBdduxVfZ
         pu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=a7VX9qtoJ4yBnj2FSAMwJQhST4s8uuOci5fvNpsdUblaqsS4Ge1N0gcPo8WYH9VPQt
         jpVFV9ngzkImznto1pONQEKRsEpqcQ8+w8NUDttOstDIB0jMymG/HWSgarE0kqA6la++
         k6C+HSIEycFDyIykUQIlvV7EQMoAksImbJzFPoNroMx46+LPwOAdjareKRhT7Vwon3JX
         op34itGh0/fTb0ZxMay8If/LDvW+xojHUKnGZU6ec4/M/yiXdC4NCZ2VOY3X16eYG0Xl
         /KMslIlzKoXHlAEaMPPo3NiwzfaTsVxoR1HOmdkStRZOMUCQabJ1rZcinWJKu/NM5kHX
         y8tg==
X-Gm-Message-State: AIVw110ozUdth2ZswG3ypwniJWxNgwV1TtWAxESi76Im3bXteEuuAhai
        SeHuvhp9EPzZkENz
X-Received: by 10.101.77.6 with SMTP id i6mr10965608pgt.43.1499976350129;
        Thu, 13 Jul 2017 13:05:50 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id h123sm10914350pgc.36.2017.07.13.13.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:05:49 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/5 v4] submodule--helper: introduce get_submodule_displaypath()
Date:   Fri, 14 Jul 2017 01:35:34 +0530
Message-Id: <20170713200538.25806-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170630194727.29787-1-pc44800@gmail.com>
References: <20170630194727.29787-1-pc44800@gmail.com>
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

