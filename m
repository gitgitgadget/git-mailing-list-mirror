Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF8920899
	for <e@80x24.org>; Wed, 23 Aug 2017 18:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932521AbdHWSTa (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 14:19:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35964 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdHWST2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 14:19:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id m7so226143pga.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkRpwIl8GiKfCf86T+6euVOOyt76WM/13BaFsCzN2nI=;
        b=J7pLGxsFyLJNgp7UUVnPROM9WTO5p8Sk3YL2jS9gsCIAdfUCpEsNC75J5bOZLj0ya4
         SgvHjm+J5ZUJHQSt3PufuEH+C5kifi3lHySc2JSF9i6s9cuQSmJScmRxEU87m030l6Rb
         InnsPKIHx5E4JyixOqpNFHYNV05eiZw9RS4kqrdJQrwrMqa9C+4b199g8wgDC3ILi8Zr
         oeCfAsObi9DlCiPFKPDsZZNjHCqRCokVQQt5byxHGkwmrHjb72i0hTwn0wbp47iRXoE/
         sb6nA/jQ3gfUbkTZLNOoaz/KrExeWq55uj1CYeN7SZhMSS5ykaFCeW4jdx9Wi12Yt9uG
         uonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkRpwIl8GiKfCf86T+6euVOOyt76WM/13BaFsCzN2nI=;
        b=RQY3y/b7M8MJQ6eiAZfmT21nhdLavCqOa8ts3/kuC+Nx5TXO1ZHpaWHIdQzYXI3Jau
         boiqgUeQ+l9na8p2Ugt3E57jd5UFrL44kCYFr25t6xqtlHOaI7O0AEHSF3cD1TysO9ij
         vS9ghUhdYtQRTN9AA503oGBNkfs02/TVxAfNvWK8Yc2mbSU+enJOdIu7+/WkcTn80v8R
         nXdNbPIBzz5JzN0fHZoowiY2++9XIYM5WW4NI3d+vYlTTLatOIzDGS3agtLxM/t0WPMl
         03SLUu+xc6WsVJsaiNiY+YMtQXM4RroVhbYkUkKLq7cJpg1B7cOINXFtidlqveeZovYZ
         zx1A==
X-Gm-Message-State: AHYfb5h+FFIJMWhLoZ9CrH1isYG6QowDIYoCPDv7NEWh1xHKuJzdti1a
        71PLWaNlkXP7K2DlhYM=
X-Received: by 10.84.141.1 with SMTP id 1mr4054631plu.141.1503512368147;
        Wed, 23 Aug 2017 11:19:28 -0700 (PDT)
Received: from localhost.localdomain ([27.63.165.170])
        by smtp.gmail.com with ESMTPSA id 74sm5007812pfk.58.2017.08.23.11.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Aug 2017 11:19:27 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v2 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Wed, 23 Aug 2017 23:45:03 +0530
Message-Id: <20170823181506.8557-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170823181506.8557-1-pc44800@gmail.com>
References: <xmqqinhf1bjf.fsf@gitster.mtv.corp.google.com>
 <20170823181506.8557-1-pc44800@gmail.com>
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
 builtin/submodule--helper.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 84562ec83..e666f84ba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,28 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
+
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +361,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
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
 
 	sub = submodule_from_path(&null_oid, path);
 
@@ -363,9 +376,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -373,7 +386,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -410,9 +422,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
+	strbuf_reset(&sb);
 
 	/* Copy "update" setting when it is not set yet */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
 	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
-- 
2.13.0

