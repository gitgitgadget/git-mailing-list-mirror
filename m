Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA0C433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7712098B
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 01:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+xSDzZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388418AbgFXB2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387842AbgFXB2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 21:28:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B008C061755
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a188so592291ybg.20
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Lo26tiHO+9f9HPf5ytUKuhgqaHnhgouLFXzAm4wNgkI=;
        b=m+xSDzZ5n9lHhT8zR0a46ehCLv2d3ojO9WJ8am6M/WrIhWznI88N+UVXH5X/7/5vFX
         6sJHZho4JxLf4mMZcbyQv3eqyDCnoN9kDxdfltpLTEe/GV/OqIVqgftAWcQmxmQmqILb
         9D58CeyX+FpxajSn8ryoe1mnmfyKerG0I27CtuUz1GHdYlUPS9K8OduQ+sXlKY6GEQzV
         QS5pmD4cbaGRyHBQ1gYvo2qQZ+9yGJ+ajmxnfJ5Z/OEVlJ+v4y3ECvnVEf6SAJ1AsT9g
         BDkUggiQ5dLFFdLPzVG8C2W1F2PUCAS4RcPHshltsuvmhnKearFEsVpTv3Kf5iZHAHaj
         zhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Lo26tiHO+9f9HPf5ytUKuhgqaHnhgouLFXzAm4wNgkI=;
        b=gVdNn9pst3/KGC/IL7KyS0IrNVIObdLS3VMiRNTyIoYg5ICt502LDUjUEKDiakjct4
         YhPUG8u1QQ3Bdmjcrlg6Qn2isANFh6aBUKmQH4wJHMU4Hhsoqb2NiSTM3WfRWeIyWfVJ
         5Gh6LQJihBaj4O+XGhT29XkxAVPZPJqI7I3/hrZsz0O/fzykaOM5zj/BoggIXlGNVRez
         vsHzNvlvvG2ioetzKvs8szZzZmrgePhqWHVGchgT8OnkFZ2D9lxcrqL6Nb0WUOlOe7t6
         HKDZ1r7a0BV3KSU+QizyT6+w8FG9H2ROa/X4KaW86SvTkA9kIJ9yS9IRFRa3Kvc2YYed
         FK6Q==
X-Gm-Message-State: AOAM533wBOZaiyd7HKMvOW75+FFNthDIJbGuBr5n79YSYCasLFxvTdP1
        ZQXjUwE4RcEVCQ4EOlpnbciv5gsM8xgxWFjdP5jNjMzUMQe6fHxBdFY9hF6BMl1ajsGrs1euQyi
        i7SEXpxmUKS8Zq25RlZLBfjq1yoSmfOyYrl9GpWBNit29SdCaq/MG+EgviRVqYSoTkD1hMeg+zQ
        ==
X-Google-Smtp-Source: ABdhPJwGg1wI4uFsS2AhfISovYW8RatAMKxBzISlB/GEP+w9NX6utjHI4jQSpE8k8VqEPnywh1yeTwOVSbm5FOLIHXY=
X-Received: by 2002:a25:7744:: with SMTP id s65mr39142084ybc.400.1592962120664;
 Tue, 23 Jun 2020 18:28:40 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:28:27 -0700
In-Reply-To: <20200624012827.34126-1-emilyshaffer@google.com>
Message-Id: <20200624012827.34126-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200624012827.34126-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH 2/2] bugreport: add config values from safelist
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach bugreport to gather the values of config options which are present
in 'bugreport-config-safelist.h', and show their origin scope.

Many config options are sensitive, and many Git add-ons use config
options which git-core does not know about; it is better only to gather
config options which we know to be safe, rather than excluding options
which we know to be unsafe.

Rather than including the path to someone's config, which can reveal
filesystem layout and project names, just name the scope (e.g. system,
global, local) of the config source.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-bugreport.txt |  1 +
 Makefile                        |  2 ++
 bugreport.c                     | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 66e88c2e31..827063d69b 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -30,6 +30,7 @@ The following information is captured automatically:
  - Compiler-specific info string
  - A list of enabled hooks
  - $SHELL
+ - Selected config values
 
 This tool is invoked via the typical Git setup process, which means that in some
 cases, it might not be able to launch - for example, if a relevant config file
diff --git a/Makefile b/Makefile
index 11d4029003..a88f918c77 100644
--- a/Makefile
+++ b/Makefile
@@ -2132,6 +2132,8 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
+bugreport.sp bugreport.s bugreport.o: bugreport-config-safelist.h
+
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
diff --git a/bugreport.c b/bugreport.c
index 28f4568b01..f988939bba 100644
--- a/bugreport.c
+++ b/bugreport.c
@@ -4,6 +4,8 @@
 #include "help.h"
 #include "compat/compiler.h"
 #include "run-command.h"
+#include "config.h"
+#include "bugreport-config-safelist.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -86,6 +88,29 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 			strbuf_addf(hook_info, "%s\n", hook[i]);
 }
 
+static void get_safelisted_config(struct strbuf *config_info)
+{
+	size_t idx;
+	struct string_list_item *it = NULL;
+	struct key_value_info *kv_info = NULL;
+
+	for (idx = 0; idx < ARRAY_SIZE(bugreport_config_safelist); idx++) {
+		const struct string_list *list =
+			git_config_get_value_multi(bugreport_config_safelist[idx]);
+
+		if (!list)
+			continue;
+
+		strbuf_addf(config_info, "%s:\n", bugreport_config_safelist[idx]);
+		for_each_string_list_item(it, list) {
+			kv_info = it->util;
+			strbuf_addf(config_info, "  %s (%s)\n", it->string,
+				    kv_info ? config_scope_name(kv_info->scope)
+					    : _("source unknown"));
+		}
+	}
+}
+
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
 	NULL
@@ -172,6 +197,9 @@ int cmd_main(int argc, const char **argv)
 	get_header(&buffer, _("Enabled Hooks"));
 	get_populated_hooks(&buffer, nongit_ok);
 
+	get_header(&buffer, _("Safelisted Config Info"));
+	get_safelisted_config(&buffer);
+
 	/* fopen doesn't offer us an O_EXCL alternative, except with glibc. */
 	report = open(report_path.buf, O_CREAT | O_EXCL | O_WRONLY, 0666);
 
-- 
2.27.0.111.gc72c7da667-goog

