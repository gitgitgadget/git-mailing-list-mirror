Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF0CC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86BD2076D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtV2vixi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgHREBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHREBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:52 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98575C061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 36so11381915pgz.18
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qi+9PZY30isaq82on5tkbS94W0BWjhHFDQvwqi9G7NQ=;
        b=JtV2vixigVjiqmLWICiego7zOFEFugGBYCLhGQL2zx/F27DbEKvghby65qGEmG7OyJ
         PSzEKAs/VGe1AY/frdmWstJojxOILiahSXahB8mbzo/tMMrpk6C0m42JRwwH5AlPnnsu
         2e6L43P2G6QArEjZSmss84PXAQ5VYcfQCjUk3IhGiAH4bJ06feip5ini4/iF/ZYAsCZd
         qPDesuH/30ya+0ctXWGieIYAtZDo1MNfC9zni6o3tGYdm2oiSvt6VKywoIx1zuBF7OHK
         rhCd4KBHhcuQKAh5EC3k5TPj1xdO4zL7/TnVeJH9gHUp8QAq9CkP9HqaZ+UTAxSj5faI
         VCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qi+9PZY30isaq82on5tkbS94W0BWjhHFDQvwqi9G7NQ=;
        b=CK9Ee2vHDWAU9SqgLTDfhMmxnOgEJDUu9UMTmgohYywRqPn4VZeCYCUI8Yda7i5hB0
         ICksTjac0+qMZs8nIulRtrFLNeYBEZTvfwC/Tw8xbDyTOEBcngMTsFeLbfNpHEthNDgw
         NhTRewQ0ZnM2cM04pWjktrGy8qd9HLTuHMuGkJ9JfNVkKo9fHQxu90435Vn+kzGWoicA
         w27UdM7Ht8QohxEyXFvnP/+NeMiWbK/zxykA1VqxzMkd30i+J0Qf2fY/pRDzxHYv1A64
         bL64vQfZEfBnbQ3v1q71DhC3NAkgwtOvkpUVCvgOEZWCj64bKK7N46F4yBDnG4oGrBon
         Uk2w==
X-Gm-Message-State: AOAM5305YP7daATn+NMpgCptaXM1IXx/jsQEKFuKOUYXfvowA42Aeyrn
        K07PH6n6CXMFgpzjsB8cVO7c3u7pbVICQ4s32Z4F7mzk7j9+eIV1LcbSaWIpE5JHgwM/qBKVCKY
        +n/HI4E3YscxfJhba5znAbOtyuSbRJHpE1aNng1SOE9piYH+8vu5vo5l4x7TtHN94JIGNUslhyH
        Dh
X-Google-Smtp-Source: ABdhPJwJ3pQ6Sx8z31YDMflUHDq7i0W4V5yhCj9Rk4EhbJM4ssio0l9eC5Gm4S2hLua6FPc0nbUUxecwN6/Fh0UbhaiV
X-Received: by 2002:a17:90a:e508:: with SMTP id t8mr15110230pjy.32.1597723311795;
 Mon, 17 Aug 2020 21:01:51 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:31 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <5b3b49d1236756dc65479f7e6c062479f2e19b3c.1597722941.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 1/7] negotiator/noop: add noop fetch negotiator
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a noop fetch negotiator. This is introduced to allow partial clones
to skip the unneeded negotiation step when fetching missing objects
using a "git fetch" subprocess. (The implementation of spawning a "git
fetch" subprocess will be done in a subsequent patch.) But this can also
be useful for end users, e.g. as a blunt fix for object corruption.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/fetch.txt   |  5 +++-
 Makefile                         |  1 +
 fetch-negotiator.c               |  5 ++++
 negotiator/noop.c                | 44 ++++++++++++++++++++++++++++++++
 negotiator/noop.h                |  8 ++++++
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 t/t5554-noop-fetch-negotiator.sh | 22 ++++++++++++++++
 8 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 negotiator/noop.c
 create mode 100644 negotiator/noop.h
 create mode 100755 t/t5554-noop-fetch-negotiator.sh

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 0aaa05e8c0..19383ddf7b 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -60,7 +60,10 @@ fetch.negotiationAlgorithm::
 	sent when negotiating the contents of the packfile to be sent by the
 	server. Set to "skipping" to use an algorithm that skips commits in an
 	effort to converge faster, but may result in a larger-than-necessary
-	packfile; The default is "default" which instructs Git to use the default algorithm
+	packfile; or set to "noop" to not send any information at all, which
+	will almost certainly result in a larger-than-necessary packfile, but
+	will skip the negotiation step.
+	The default is "default" which instructs Git to use the default algorithm
 	that never skips commits (unless the server has acknowledged it or one
 	of its descendants). If `feature.experimental` is enabled, then this
 	setting defaults to "skipping".
diff --git a/Makefile b/Makefile
index 372139f1f2..94a8fb54d1 100644
--- a/Makefile
+++ b/Makefile
@@ -917,6 +917,7 @@ LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
+LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 0a1357dc9d..57ed5784e1 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -2,6 +2,7 @@
 #include "fetch-negotiator.h"
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
+#include "negotiator/noop.h"
 #include "repository.h"
 
 void fetch_negotiator_init(struct repository *r,
@@ -13,6 +14,10 @@ void fetch_negotiator_init(struct repository *r,
 		skipping_negotiator_init(negotiator);
 		return;
 
+	case FETCH_NEGOTIATION_NOOP:
+		noop_negotiator_init(negotiator);
+		return;
+
 	case FETCH_NEGOTIATION_DEFAULT:
 	default:
 		default_negotiator_init(negotiator);
diff --git a/negotiator/noop.c b/negotiator/noop.c
new file mode 100644
index 0000000000..60569b8350
--- /dev/null
+++ b/negotiator/noop.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "noop.h"
+#include "../commit.h"
+#include "../fetch-negotiator.h"
+
+static void known_common(struct fetch_negotiator *n, struct commit *c)
+{
+	/* do nothing */
+}
+
+static void add_tip(struct fetch_negotiator *n, struct commit *c)
+{
+	/* do nothing */
+}
+
+static const struct object_id *next(struct fetch_negotiator *n)
+{
+	return NULL;
+}
+
+static int ack(struct fetch_negotiator *n, struct commit *c)
+{
+	/*
+	 * This negotiator does not emit any commits, so there is no commit to
+	 * be acknowledged. If there is any ack, there is a bug.
+	 */
+	BUG("ack with noop negotiator, which does not emit any commits");
+	return 0;
+}
+
+static void release(struct fetch_negotiator *n)
+{
+	/* nothing to release */
+}
+
+void noop_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	negotiator->known_common = known_common;
+	negotiator->add_tip = add_tip;
+	negotiator->next = next;
+	negotiator->ack = ack;
+	negotiator->release = release;
+	negotiator->data = NULL;
+}
diff --git a/negotiator/noop.h b/negotiator/noop.h
new file mode 100644
index 0000000000..2b4ec5d07a
--- /dev/null
+++ b/negotiator/noop.h
@@ -0,0 +1,8 @@
+#ifndef NEGOTIATOR_NOOP_H
+#define NEGOTIATOR_NOOP_H
+
+struct fetch_negotiator;
+
+void noop_negotiator_init(struct fetch_negotiator *negotiator);
+
+#endif
diff --git a/repo-settings.c b/repo-settings.c
index 0918408b34..aa61a35338 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -39,6 +39,8 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
 		if (!strcasecmp(strval, "skipping"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		else if (!strcasecmp(strval, "noop"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NOOP;
 		else
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
diff --git a/repository.h b/repository.h
index 3c1f7d54bd..628c834367 100644
--- a/repository.h
+++ b/repository.h
@@ -23,6 +23,7 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NONE = 0,
 	FETCH_NEGOTIATION_DEFAULT = 1,
 	FETCH_NEGOTIATION_SKIPPING = 2,
+	FETCH_NEGOTIATION_NOOP = 3,
 };
 
 struct repo_settings {
diff --git a/t/t5554-noop-fetch-negotiator.sh b/t/t5554-noop-fetch-negotiator.sh
new file mode 100755
index 0000000000..2ac7b5859e
--- /dev/null
+++ b/t/t5554-noop-fetch-negotiator.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='test noop fetch negotiator'
+. ./test-lib.sh
+
+test_expect_success 'noop negotiator does not emit any "have"' '
+	rm -f trace &&
+
+	test_create_repo server &&
+	test_commit -C server to_fetch &&
+
+	test_create_repo client &&
+	test_commit -C client we_have &&
+
+	test_config -C client fetch.negotiationalgorithm noop &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+
+	! grep "fetch> have" trace &&
+	grep "fetch> done" trace
+'
+
+test_done
-- 
2.28.0.220.ged08abb693-goog

