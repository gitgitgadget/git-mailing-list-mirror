Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C44AC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E9420842
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 01:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8u2N3B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgHEBVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgHEBVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 21:21:01 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9ADC061757
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 18:21:01 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x142so6319239pfc.14
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jQRk6XnMqgw0IvuWmUklA/LbL76Yl6tFeoZ4vnMo7tY=;
        b=X8u2N3B1mzBiiwOsvzP5DRguQkmXbGSI2CJx+FgoacVeRqTyIs6zsZ/yilNL3e3LYc
         PT2RehNDACrJb0j4E2cpABlNdtH8NEFF00Ug6D0zSzwtWiuQDYAsshX4jxKlBoCTwgs+
         8OlIjaRG6mxfqek7utbSX8mA6eiUzebkoackood2Gk9Fq/TR5N4Yx+8FO1Y/NxrZoSPZ
         fH1I7iRy7KPi7eUXUROVy2pCd/ArJDZ56qd4CdJ9F50cUsnUg6r1LW3lEZssp5gDaOQ+
         wP6tbjxCXndBB8DDlCtPmm4XbBTDhlRG1Ja62lfjZ8sksupMvDpey3ApZhKR+tFEYoSH
         U3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jQRk6XnMqgw0IvuWmUklA/LbL76Yl6tFeoZ4vnMo7tY=;
        b=o3zXPRkiJoVQOzs1zO9yJYWU5FdTvVMTziQmye61cmbe7HJ4sFAuIqzAoQgdwOBsYo
         XW2Eeq5TfmmwONjydWCtilL+Uf7461oLYVZ9M8Vh8+PFu84cjEl280CEed9ghhDvW9S3
         weh2vuojmp9uwFLWW+naC/H5BgWUUyXEQ/O/rKrsuVvmTEs0vDp9R3avwYOlLsZVUYVY
         0G9dYEnBxnZtSBRcKeJ4RedgUtmyITDkn2E72iF6EzMVqp8tqZg8bVKyTTlJ4ioncgi7
         L6Im4/bRBN6uZzkybtTI0Dx4R7X40ewPutTdQ0Wvu8M+A7mC8pzDFENHKGxdM7aKElqI
         /E5Q==
X-Gm-Message-State: AOAM532Mi4zxy8X7guWTZ/9/Q9Kpz5IyeO7SphxN2ET8s2W59jLIwJvF
        IIhknPnpIda3SVPJuoLj7NgoGLG5legwYAWqNMTjq1XliWysyQg8XvOMhCF4uNaJRZ/D31FLuqZ
        hEjTf1qMNad69DF1TuIkbEF8gq28OOgPAF2yTccZYS5l30b7JeGK1XIkFxEmHT6s0VaXQpSAxHH
        6c
X-Google-Smtp-Source: ABdhPJzHlXQ2KyocOpoJdDCBXJsfXHoW2cJNcdQqJ2AQuNMS7MwHG8HR5SPgILi4WCE9ek5lLRhl9n8LyRhOD27azszI
X-Received: by 2002:aa7:947b:: with SMTP id t27mr985175pfq.117.1596590460751;
 Tue, 04 Aug 2020 18:21:00 -0700 (PDT)
Date:   Tue,  4 Aug 2020 18:20:46 -0700
In-Reply-To: <cover.1596590295.git.jonathantanmy@google.com>
Message-Id: <78d47204044dbe650cc782001de793a7cdf85692.1596590295.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1596590295.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH 3/7] negotiator/null: add null fetch negotiator
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a null fetch negotiator. This is introduced to allow partial clones
to perform lazy fetches (which do not need negotiation at all) by
spawning a subprocess (to be done in a subsequent patch), but can be
useful for end users, e.g. as a blunt fix for object corruption.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/config/fetch.txt   |  5 ++++-
 Makefile                         |  1 +
 fetch-negotiator.c               |  5 +++++
 negotiator/null.c                | 34 ++++++++++++++++++++++++++++++++
 negotiator/null.h                |  8 ++++++++
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 t/t5554-null-fetch-negotiator.sh | 22 +++++++++++++++++++++
 8 files changed, 77 insertions(+), 1 deletion(-)
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
index 0000000000..db63ce66c2
--- /dev/null
+++ b/negotiator/null.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "null.h"
+#include "../commit.h"
+#include "../fetch-negotiator.h"
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
+	negotiator->known_common = NULL;
+	negotiator->add_tip = NULL;
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
2.28.0.163.g6104cc2f0b6-goog

