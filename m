Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65385C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E88A21655
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uk1RpqhD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfLMAnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:53 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:37366 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfLMAnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:52 -0500
Received: by mail-qv1-f74.google.com with SMTP id w13so635848qvb.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hYTq6RD1kAa21zZMC8IE5749jJWPV/sWT52ODcbe7dE=;
        b=Uk1RpqhDp7Pwild/rBF4dgycg97JBJZ+r03BynTD3+ml6wHh3/bUgxh3cC/eojhl9B
         iBGQcIClSgCe1sTrBWNBKnzDSAtBb+zW5r0FUR44715fouXf1l6jXfXNv6w0LRvGyQe0
         2pwZJXUsCQGKPE6sEi2ki7QFIvt1qRdteSe8iDwIUdlovwxy72cmweNYeDmI3uksckOB
         y80b4eCb3nyh0TQV8LT06DASYsvdLDN5iZDLXdxkd6gnCGhN3zF0TDXjyA+hUBb9AHG/
         MRTei48YqYKMQhfuzeeeFHT5a/1l6z3Y5HQ9IBmrmxNq+TDgiV1dkeZm0/8Vz+2THV1E
         XDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hYTq6RD1kAa21zZMC8IE5749jJWPV/sWT52ODcbe7dE=;
        b=NNYWGp2q8aCbnGkDSgpH08+jEEV0aBV38geghsNhqit1b+xfxDLIa5DJjcfylTjrwi
         EwUvtxDMmUwQsmtLqG+Jzu35p/+Qh5G17yHUlOiwg/2+rnbojPU9ylNRgR0HJgiVZ383
         Q7lKQ9MsY9YksYLBHxAKwITvqNATP5iJQNCcPv8OwJTqzvqdOn9xKIC+m+gnCoQkolXn
         ggZM4v2PLY7/8aW+yhs50nywoR+hhDL4NFEmXsgAR/lox2mukis7xewMLhE1piIfVkAV
         xM7FNLADy0QLDOMbE2xqIT/6/zy6zXrUsgalbKqCKApLS0kQdE3jHSfYpo/j5j7+6C9E
         YJtQ==
X-Gm-Message-State: APjAAAWhvcBclIdL+/v2VgTZUj+H/+RsO9uX2TaiRDcOHQXyFsg4dIrj
        32h8NXoWvbDqq8eCcGBCFHxIZvbOBtU2myW92EVkQJIBLZVNd5pXqRX7ksnMkxFzTvuDP0i7uID
        uINecQIUAvTeIn78qKrYZldnNUzZiqn4Mm301V/ICv99mYwMvtd0Ybew94/6oYjJjEvUOeQ7ikA
        ==
X-Google-Smtp-Source: APXvYqwUWQ3v/fnf5qfTbzSTFrpB8CPP4PI1LB0Vz+GWqPFggc5fndEjB5VamQ/AJ/8ammuLqXhn7QAAgTUDoY594/I=
X-Received: by 2002:a37:644:: with SMTP id 65mr11232910qkg.309.1576197831251;
 Thu, 12 Dec 2019 16:43:51 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:43:07 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-11-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 10/15] bugreport: add config values from safelist
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach bugreport to gather the values of config options which are present
in 'bugreport-config-safelist.h'.

Many config options are sensitive, and many Git add-ons use config
options which git-core does not know about; it is better only to gather
config options which we know to be safe, rather than excluding options
which we know to be unsafe.

Taking the build-time generated array and putting it into a set saves us
time - since git_config_bugreport() is called for every option the user
has configured, performing option lookup in constant time is a useful
optimization.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 bugreport.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/bugreport.c b/bugreport.c
index 759cc0b0f8..1fca28f0b9 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -6,6 +6,9 @@
 #include "help.h"
 #include <gnu/libc-version.h>
 #include "run-command.h"
+#include "config.h"
+#include "bugreport-config-safelist.h"
+#include "khash.h"
 
 static void get_http_version_info(struct strbuf *http_info)
 {
@@ -18,6 +21,41 @@ static void get_http_version_info(struct strbuf *http_info)
 	    strbuf_addstr(http_info, "'git-http-fetch -V' not supported\n");
 }
 
+KHASH_INIT(cfg_set, const char*, int, 0, kh_str_hash_func, kh_str_hash_equal);
+
+struct cfgset {
+	kh_cfg_set_t set;
+};
+
+struct cfgset safelist;
+
+static void cfgset_init(struct cfgset *set, size_t initial_size)
+{
+	memset(&set->set, 0, sizeof(set->set));
+	if (initial_size)
+		kh_resize_cfg_set(&set->set, initial_size);
+}
+
+static int cfgset_insert(struct cfgset *set, const char *cfg_key)
+{
+	int added;
+	kh_put_cfg_set(&set->set, cfg_key, &added);
+	printf("ESS: added %s\n", cfg_key);
+	return !added;
+}
+
+static int cfgset_contains(struct cfgset *set, const char *cfg_key)
+{
+	khiter_t pos = kh_get_cfg_set(&set->set, cfg_key);
+	return pos != kh_end(&set->set);
+}
+
+static void cfgset_clear(struct cfgset *set)
+{
+	kh_release_cfg_set(&set->set);
+	cfgset_init(set, 0);
+}
+
 static void get_system_info(struct strbuf *sys_info)
 {
 	struct strbuf version_info = STRBUF_INIT;
@@ -53,6 +91,36 @@ static void get_system_info(struct strbuf *sys_info)
 	strbuf_complete_line(sys_info);
 }
 
+static void gather_safelist()
+{
+	int index;
+	int safelist_len = sizeof(bugreport_config_safelist) / sizeof(const char *);
+	cfgset_init(&safelist, safelist_len);
+	for (index = 0; index < safelist_len; index++)
+		cfgset_insert(&safelist, bugreport_config_safelist[index]);
+
+}
+
+static int git_config_bugreport(const char *var, const char *value, void *cb)
+{
+	struct strbuf *config_info = (struct strbuf *)cb;
+
+	if (cfgset_contains(&safelist, var))
+		strbuf_addf(config_info,
+			    "%s (%s) : %s\n",
+			    var, config_scope_to_string(current_config_scope()),
+			    value);
+
+	return 0;
+}
+
+static void get_safelisted_config(struct strbuf *config_info)
+{
+	gather_safelist();
+	git_config(git_config_bugreport, config_info);
+	cfgset_clear(&safelist);
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output <file>]"),
 	NULL
@@ -114,10 +182,12 @@ int cmd_main(int argc, const char **argv)
 
 	get_bug_template(&buffer);
 
-	// add other contents
 	get_header(&buffer, "System Info");
 	get_system_info(&buffer);
 
+	get_header(&buffer, "Safelisted Config Info");
+	get_safelisted_config(&buffer);
+
 	report = fopen_for_writing(report_path.buf);
 	strbuf_write(&buffer, report);
 	fclose(report);
-- 
2.24.1.735.g03f4e72817-goog

