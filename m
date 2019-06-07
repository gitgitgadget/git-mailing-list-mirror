Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6311F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfFGBJE (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:09:04 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:51342 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBJD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:09:03 -0400
Received: by mail-ot1-f73.google.com with SMTP id h12so190155otn.18
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oJIjpnCSpSzYYh21eeU7c2+dddEDozm+4MtuwVQHXZY=;
        b=RR/rpOBAIvWrpwWO1x9vndZyKelj0s3d/huNZ2mmboZds3qF4qApdMKXS7ndUqsLBs
         vke8iN1BgaH2/eFf3UD8geDSTnrqWjwujOI+rpElUQk3lC4CI/a5+v8rTtuE9SRY78b1
         fxVD/JSQYVltppzIgtK0rZB9eJPJ50KhsZJyONjW+bdWGi1+I1ky5BcVSQ+3saCXEks5
         gEGLfqvUEBJmNoaQlE+jdRLjm5YFJXqUruUJIkfrgW23Zecxmzg6+NP9U9dOPEMVe7cb
         nBD3y9AEu28Gzvs08O2b90zkITm7EKypIboZh5KmCr70/Qjitt0XXRqRqa+vR3Fkv6S/
         kyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oJIjpnCSpSzYYh21eeU7c2+dddEDozm+4MtuwVQHXZY=;
        b=odC4mlj9qs3dVpVrmzJrX+HwdrOZaEPKLDz0OfJ725hxYhforWQwSC/H0cvUiTOzCv
         W0I+uZNh+KwPaYhgjz9ubloGUX5szc8dxcyhwUyxPU7fOAesk1jmYdjuM0waRypewIKb
         JfwJGIl4rbAYGNMRt2LHzhTfu/4DPAaxeCJyJFkmHtdhlq1qZ/eaNgpCTg3BD7L9xPka
         ZlLKpgXjQpxcNG+jV7VPMNOhyGBS5gjvr15y39qYo/E2WeKvE2d1swUvm/+zT63bCTNA
         eRwsp6Uo7e6E6WQu3BnCNv5B6vuW2Xw79NyFrJvc9o7VY8F4nien8ZShvlXyd/m09Rh9
         vo4g==
X-Gm-Message-State: APjAAAVurvUgfEpigCHRwM4Ujuql0YAWlibu0R6/6BeWcDagVKeYRN6P
        xqgVyELTvSB/if9c32WAduOHrBmbHRgRqrGgSasaa/hdJOtPj+u/HInyCtsNSEuQ36eX11yJoSv
        xb4xxbrQg+DSdDCVt2ma67AH6rYfA8u6Ab5NGfjgV4bdbmmDYTIkA/hj3MEb72l3JK+jroI09ew
        ==
X-Google-Smtp-Source: APXvYqxFO91p/CaoEvkmuqV8zk4f8Wcw0ELANkxzPdGIk5uR2PkgiN0ziRlOy28dDGcTYXlpnCeM5HBP90m5TtP8mro=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr16986097oti.221.1559869742943;
 Thu, 06 Jun 2019 18:09:02 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:08:02 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 04/13] walken: add handler to git_config
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now, we have no configuration options we want to set up for
ourselves, but in the future we may need to. At the very least, we
should invoke git_default_config() for each config option; we will do so
inside of a skeleton config callback so that we know where to add
configuration handling later on when we need it.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/walken.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index dcee906556..5d1666a5da 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include "builtin.h"
+#include "config.h"
 #include "parse-options.h"
 
 static const char * const walken_usage[] = {
@@ -25,6 +26,28 @@ static void init_walken_defaults(void)
 	 */
 }
 
+/*
+ * This method will be called back by git_config(). It is used to gather values
+ * from the configuration files available to Git.
+ *
+ * Each time git_config() finds a configuration file entry, it calls this
+ * callback. Then, this function should compare it to entries which concern us,
+ * and make settings changes as necessary.
+ *
+ * If we are called with a config setting we care about, we should use one of
+ * the helpers which exist in config.h to pull out the value for ourselves, i.e.
+ * git_config_string(...) or git_config_bool(...).
+ *
+ * If we don't match anything, we should pass it along to another stakeholder
+ * who may otherwise care - in log's case, grep, gpg, and diff-ui. For our case,
+ * we'll ignore everybody else.
+ */
+static int git_walken_config(const char *var, const char *value, void *cb)
+{
+	/* For now, let's not bother with anything. */
+	return git_default_config(var, value, cb);
+}
+
 int cmd_walken(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -34,6 +57,9 @@ int cmd_walken(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, walken_usage, 0);
 
 	init_walken_defaults();
+
+	git_config(git_walken_config, NULL);
+
 	printf(_("cmd_walken incoming...\n"));
 	return 0;
 }
-- 
2.22.0.rc1.311.g5d7573a151-goog

