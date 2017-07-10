Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3D820357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755040AbdGJWy2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:54:28 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34145 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755026AbdGJWy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:54:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id j186so14319300pge.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=Tt4NoZPDUbuOgjMXNL4qLu5vt1FFw8xBjKhv6pvZJ9Gba7l+48sFOe1Y6kll3VsUmq
         HeyXmXttUfMR9/hcnsN9otjTvmwFOjYPmzA/hj+MhFzkzZjaHVPLS3xLa1crtA7Om095
         FfCfES311YoIho3iDQsfFIwAGPNgL6UUMiT2I4zkNucBHH2HGoagGE9JvnQTxtQjiF5P
         mIgANfesg6MohtVIXobxDtGEK1tmt3Fl35NRtUOc9H0uby2OUdrDYnzHbyeb3HemKnxl
         xXK/E61//x5zL+6nz6lLGXVTFuwEC/6two8P8TJ02vm+M1QbU9yiPnIcahqYkJAp9/RK
         WKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uifl4K2osCvghD7KhtZcuheg0SILRjUalsatIfQnr8o=;
        b=ePCfuXcnztNSRDOdIJkHnTI/ngaH1zkbkFdYcmKoHmn8SVRfrZugvXernNHyjOSXTF
         GByTZj+5mgqiuVE3NFrfCevj6+O6FvZRAxjKy77uV7V2gJrkCiy+Fw7mzu8cIg6g84mf
         H2zElMU9NYYjoZt+00egRXDkLXk7RYotREV3d+y4RWGOZ81e+2jvgvLfShLusXl2NaoL
         TgcOcrNMqxY651PPXkcATiDM2995hGvO5ZJC5s3hiSUZTu6CoiquwxuCFaBb8f6PYQWp
         C95EZNtBkpDkCCkvtK0UJTqakczotEFzcxB34czARzDvZshEFmce/S0l7I810T+Rcsf6
         7SfQ==
X-Gm-Message-State: AIVw110S2QcQh4BqT5C907bCIHNdbRLE04O++BNU6dyJaeNbwNHI4bGK
        fPUaGfKTef/8O0Gd
X-Received: by 10.98.150.16 with SMTP id c16mr42661033pfe.64.1499727261081;
        Mon, 10 Jul 2017 15:54:21 -0700 (PDT)
Received: from prathampc-X550JX.domain.name ([116.73.72.60])
        by smtp.gmail.com with ESMTPSA id o6sm20586774pgs.43.2017.07.10.15.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 15:54:20 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, gitster@pobox.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 1/8] submodule--helper: introduce get_submodule_displaypath()
Date:   Tue, 11 Jul 2017 04:24:00 +0530
Message-Id: <20170710225407.29344-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
References: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
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

