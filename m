Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B441C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71953206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JK5DU3Dh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgHKWwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F3EC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:31 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id a6so317335pjd.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bfnczTnXw8CEsvNQ+zFRvEgwXldfKc0Uajp2AQ2rAfg=;
        b=JK5DU3Dh26NHRxPEl1I7eUTC8jCJl+6smuVuUe9abriHzWsiFVDmrrOa4erqLQd/Py
         PYX8JxHcIzv9AKn5ESHBtk/l5WH1B0gnQ9VA7Fgs8tjY/ZCNdV9aLIvDqf8X8STBmiyK
         7eS8Piw5ir4c1aVG3PTEnWVOLblYhlEa2F7yOJVG9ylYb3Ne8TiQE+G7oe4SkCr9B0la
         wS2MlWVcRv+2/yZ1gyVKtLqduhVOO6wUq2mWnxR+y06ISvXjL76uqn5eGPMcUUj9GSBT
         G6+Xnjim/TLADivBlpap7tOvrjJmNGV54nJmBt/qF2wHWAQoZ7ZrSZCViLB3/BSrmzrt
         KNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bfnczTnXw8CEsvNQ+zFRvEgwXldfKc0Uajp2AQ2rAfg=;
        b=ZhNf/XziBbTuGyHkn5mjkiu0UK9qmXm9bgG/Nn9ofOCF8W1agHzKjenqpnjwUO3RqC
         CeJ70eqa+MUKnFv4ZO1+EJtUnk6E4UBsuVld6jtE9Q9Mi+LimYE6Gx7GxMswVRz4agEz
         RDM1UUzCaOfk3e6or+kBs66PkOLLPymMf/kXRVpbrNpZ+SkSZ8FfDw/9UF/qUNG7u6re
         tuFuUT/NYZM/He6zN0R/fm25JTE78ztn3ijgvRmZj3h+lVE3pXEawli8ai1o4pnbIthR
         JrPDFOS3+bFhOEsZTkJS2WdAdRHFI2pFz3Nuv3+QqEFWYPesV9WoRWfjNSYxDjRVmsvx
         2XTw==
X-Gm-Message-State: AOAM531GBcHKVCseVQLkHMcklzSilssBmTRdDwjWYjUQ2RZQ2ZMsTR0e
        hN0OcN+TJ9qwLJfVwCqEeZGewFGJ82Sfe72/9g+GLezxyz2xCAl4YLQoeUQZGbLR6bEGtZ99fhI
        zpvOlNpXaHq0RWPnThSMK9+y+dsDKWSAoQVb1vY5JEuknExo6Gy0mv/1p1yUxHuu78rHYj6pmzj
        Jr
X-Google-Smtp-Source: ABdhPJxp1wakPQk7SUBK0wS0HekcSCxybSkae5csFTjmdajs12h5wQi2RoPCzYRZ9eXsqqHqx+8JVVJ4zunnF93EkiO9
X-Received: by 2002:a17:90a:f2c7:: with SMTP id gt7mr3066130pjb.204.1597186349952;
 Tue, 11 Aug 2020 15:52:29 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:16 -0700
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Message-Id: <35bdd372ae3691f54775dd616576e8ed6d68f1d3.1597184949.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597184948.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 1/7] negotiator/null: add null fetch negotiator
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a null fetch negotiator. This is introduced to allow partial clones
to skip the unneeded negotiation step when fetching missing objects
using a "git fetch" subprocess. (The implementation of spawning a "git
fetch" subprocess will be done in a subsequent patch.) But this can also
be useful for end users, e.g. as a blunt fix for object corruption.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/fetch.txt   |  5 +++-
 Makefile                         |  1 +
 fetch-negotiator.c               |  5 ++++
 negotiator/null.c                | 44 ++++++++++++++++++++++++++++++++
 negotiator/null.h                |  8 ++++++
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 t/t5554-null-fetch-negotiator.sh | 22 ++++++++++++++++
 8 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 negotiator/null.c
 create mode 100644 negotiator/null.h
 create mode 100755 t/t5554-null-fetch-negotiator.sh

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 0aaa05e8c0..09aff404be 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -60,7 +60,10 @@ fetch.negotiationAlgorithm::
 	sent when negotiating the contents of the packfile to be sent by the
 	server. Set to "skipping" to use an algorithm that skips commits in an
 	effort to converge faster, but may result in a larger-than-necessary
-	packfile; The default is "default" which instructs Git to use the default algorithm
+	packfile; or set to "null" to not send any information at all, which
+	will almost certainly result in a larger-than-necessary packfile, but
+	will skip the negotiation step.
+	The default is "default" which instructs Git to use the default algorithm
 	that never skips commits (unless the server has acknowledged it or one
 	of its descendants). If `feature.experimental` is enabled, then this
 	setting defaults to "skipping".
diff --git a/Makefile b/Makefile
index 372139f1f2..297ea5e517 100644
--- a/Makefile
+++ b/Makefile
@@ -917,6 +917,7 @@ LIB_OBJS += mergesort.o
 LIB_OBJS += midx.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += negotiator/default.o
+LIB_OBJS += negotiator/null.o
 LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes-cache.o
 LIB_OBJS += notes-merge.o
diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index 0a1357dc9d..e2ecbe4367 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -2,6 +2,7 @@
 #include "fetch-negotiator.h"
 #include "negotiator/default.h"
 #include "negotiator/skipping.h"
+#include "negotiator/null.h"
 #include "repository.h"
 
 void fetch_negotiator_init(struct repository *r,
@@ -13,6 +14,10 @@ void fetch_negotiator_init(struct repository *r,
 		skipping_negotiator_init(negotiator);
 		return;
 
+	case FETCH_NEGOTIATION_NULL:
+		null_negotiator_init(negotiator);
+		return;
+
 	case FETCH_NEGOTIATION_DEFAULT:
 	default:
 		default_negotiator_init(negotiator);
diff --git a/negotiator/null.c b/negotiator/null.c
new file mode 100644
index 0000000000..1bd834f121
--- /dev/null
+++ b/negotiator/null.c
@@ -0,0 +1,44 @@
+#include "cache.h"
+#include "null.h"
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
+	BUG("ack with null negotiator, which does not emit any commits");
+	return 0;
+}
+
+static void release(struct fetch_negotiator *n)
+{
+	/* nothing to release */
+}
+
+void null_negotiator_init(struct fetch_negotiator *negotiator)
+{
+	negotiator->known_common = known_common;
+	negotiator->add_tip = add_tip;
+	negotiator->next = next;
+	negotiator->ack = ack;
+	negotiator->release = release;
+	negotiator->data = NULL;
+}
diff --git a/negotiator/null.h b/negotiator/null.h
new file mode 100644
index 0000000000..96713f280e
--- /dev/null
+++ b/negotiator/null.h
@@ -0,0 +1,8 @@
+#ifndef NEGOTIATOR_NULL_H
+#define NEGOTIATOR_NULL_H
+
+struct fetch_negotiator;
+
+void null_negotiator_init(struct fetch_negotiator *negotiator);
+
+#endif
diff --git a/repo-settings.c b/repo-settings.c
index 0918408b34..a8c7e1edd7 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -39,6 +39,8 @@ void prepare_repo_settings(struct repository *r)
 	if (!repo_config_get_string(r, "fetch.negotiationalgorithm", &strval)) {
 		if (!strcasecmp(strval, "skipping"))
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
+		else if (!strcasecmp(strval, "null"))
+			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_NULL;
 		else
 			r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_DEFAULT;
 	}
diff --git a/repository.h b/repository.h
index 3c1f7d54bd..f72911a185 100644
--- a/repository.h
+++ b/repository.h
@@ -23,6 +23,7 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NONE = 0,
 	FETCH_NEGOTIATION_DEFAULT = 1,
 	FETCH_NEGOTIATION_SKIPPING = 2,
+	FETCH_NEGOTIATION_NULL = 3,
 };
 
 struct repo_settings {
diff --git a/t/t5554-null-fetch-negotiator.sh b/t/t5554-null-fetch-negotiator.sh
new file mode 100755
index 0000000000..09a8f0d608
--- /dev/null
+++ b/t/t5554-null-fetch-negotiator.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+
+test_description='test null fetch negotiator'
+. ./test-lib.sh
+
+test_expect_success 'null negotiator does not emit any "have"' '
+	rm -f trace &&
+
+	test_create_repo server &&
+	test_commit -C server to_fetch &&
+
+	test_create_repo client &&
+	test_commit -C client we_have &&
+
+	test_config -C client fetch.negotiationalgorithm null &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch "$(pwd)/server" &&
+
+	! grep "fetch> have" trace &&
+	grep "fetch> done" trace
+'
+
+test_done
-- 
2.28.0.236.gb10cc79966-goog

