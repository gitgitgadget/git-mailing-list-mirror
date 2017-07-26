Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA8E2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdGZXaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 19:30:15 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35151 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdGZXaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 19:30:13 -0400
Received: by mail-pg0-f46.google.com with SMTP id v190so90189872pgv.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=045hNLko+GmyWGjLtQMSSJzdMc4vsFPyRm2FJm4sHx8=;
        b=X9qNCpEStRrl/R2gEtN1o1likrCtfs+4S/Ush4utTtOD0lka7iOiplsZiU3FEcp7Lv
         /Lmt4dq9fBxLC8D6R6+QPoS4MSpZkCqV5RhaLd/NOSNCKBCifh4ws9/I4lZgYERPqHoC
         GeBAueUbYDnbvXRY5rVWN0OP1mk9B0/7G+UVDQDCkyiFCTD0SLqo8916d/OH7pee5zUX
         dypcAB3Z4lnKDd/q463yiOMo+5aj3MZIqyN5SUJUsPZSsQcqm1V8ZNRkKC3Js8kbaQDO
         tTcC6dvItOy+FQxHOc6oJ/o/o3eHjZGP6hCxAZDZQ/Fxk+Goznb26i1iI0wVIeMFm6Pl
         VUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=045hNLko+GmyWGjLtQMSSJzdMc4vsFPyRm2FJm4sHx8=;
        b=pkWhAMk0XSxryjm13vTzxoyz2MHOga0n1+MxEWotaAB08ZwRDn6Ccc+YYXobWffKKm
         C8otb0kDLBkJhvCm+K9SZ0hKFu7nndKJ5xJEwuh4OPUdOZrNqmVDFhkN7gG54Nooks8f
         09MZcCUm9YI9JVXLynyzDR6WwZgpuYjfD7X6bUkW6DWirpDOuaW+JvXvFrHAnRjE7Wih
         g9kJBt4/GU1IBpJt2rGTyhk+BpffnweYKHV2+BewUFPtrdOCkQKKHGXMd8SFqjA2BNV9
         Not+Su/nlXIwvqyteneDFKXshIGK32I7wYb36eFZdJx+4uBE7BDY9/sQ+fvXX72l6PZq
         3ehg==
X-Gm-Message-State: AIVw110PAHqrZ3DPwccb/8fLGkYwHQCurNe4jE9Z6Eb0ODRcBTQ5LUs+
        eRcexnmIn171zabuXe7yeQ==
X-Received: by 10.84.128.14 with SMTP id 14mr2454586pla.285.1501111811970;
        Wed, 26 Jul 2017 16:30:11 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id e131sm299668pfc.93.2017.07.26.16.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 16:30:10 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [RFC PATCH 4/4] fsck: support lazy objects as CLI argument
Date:   Wed, 26 Jul 2017 16:30:02 -0700
Message-Id: <926ff80cb9b5dc9d0d75257f261ddc27c1d250b7.1501111615.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
In-Reply-To: <cover.1501111615.git.jonathantanmy@google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing objects provided on the CLI as an error
when extensions.lazyobject is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c         |  2 ++
 t/t0410-lazy-object.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 238532cc2..592e64172 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -755,6 +755,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
+				if (repository_format_lazy_object)
+					continue;
 				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
diff --git a/t/t0410-lazy-object.sh b/t/t0410-lazy-object.sh
index 45f665a15..3ac61c1c5 100755
--- a/t/t0410-lazy-object.sh
+++ b/t/t0410-lazy-object.sh
@@ -76,4 +76,20 @@ test_expect_success '...but succeeds if lazyobject is set' '
 	git -C repo fsck
 '
 
+test_expect_success 'fsck fails on lazy object directly given in command-line' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo 1 &&
+	HASH=$(git hash-object repo/1.t) &&
+	delete_object repo "$HASH" &&
+
+	test_must_fail git -C repo fsck "$HASH"
+'
+
+test_expect_success '...but succeeds if lazyobject is set' '
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.lazyobject "arbitrary string" &&
+	git -C repo fsck "$HASH"
+'
+
 test_done
-- 
2.14.0.rc0.400.g1c36432dff-goog

