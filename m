Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDEA120281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbdI2UMQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:16 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44516 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdI2UMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:13 -0400
Received: by mail-pg0-f43.google.com with SMTP id j16so358268pga.1
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IBwvENPNg4XNd3avJzsT5InrqZu6ufewa3hcGR4Z+gc=;
        b=XK49RIcXy8dlDLk0sRkmYObJ/cPuFAO1iYEehmMqAiZ144EN8hgwzuIUN9fng1+e5B
         lijhGJ/9+LMBieA15JIm+NRUdDwG5ULcJHnTLjjqV7WKONokeAZT0sIHtRz7y/pDa20N
         MP891qzzRKKAdhFg/Qw3nMxrf40417xSNVmOSP2Zj5Oe6brGnFcfOLEmOUVtlvT6Iu2z
         EXxC8qKGz13ZIIFlC4IEhPjbeIzZkG/yb7bToObH6KehewqUN+gVVxet4IIZg7u9GOTf
         H+4LGdjLMTihAk69hpBB4log10Hv7VJHFnieHGvqBCzmuyzydncATUxbkikDVssVLN3C
         a5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IBwvENPNg4XNd3avJzsT5InrqZu6ufewa3hcGR4Z+gc=;
        b=DIfXL1+FPZff7R3vfPUOncC+RhiUhc2LplbNmI9wjTlUAFNDZrvUQtxAZNVphVJ/0P
         OmQyEl/tp1IbCaeq4/hwW9dBaiM0CbdcQTEes87daA9DiA7Qymk9t+zPh4pM/nJiO4HQ
         uZgsghZ/jhsjZaGw0NPu37iMT6L7hfhNZGA8C2Cs86CdV3A75R7qDSVFxrFlxEcGLBaT
         q9GLNSJWp+NjXgfG4wy4JBqjeonHzWaLx7UqRMxF6wxOS3fzeFIybKO89sSZlg9q/755
         cta0WMiBsJos8V0/SPe9RdNpoGL9/33lSf8AUF0MVmyuVZZ7dEXK64C0dA9Gw/jxxwY1
         ODWg==
X-Gm-Message-State: AHPjjUiQ8G/5YGEjSvivBUZZGGCuYvgd3dUOe28Ss08QAQYFNvjuTXhG
        2d21eLnbYwiAJ3TSVXok/LN4JMFuHA4=
X-Google-Smtp-Source: AOwi7QCXW8COTu7/BzpdYT5vgpIr96VPINn8a9YpJbAJz6zwkwmT9F3DPHZPOQcCosjpE/uuXyEFCA==
X-Received: by 10.98.76.134 with SMTP id e6mr8795191pfj.180.1506715932863;
        Fri, 29 Sep 2017 13:12:12 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:12 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 04/18] fsck: support promisor objects as CLI argument
Date:   Fri, 29 Sep 2017 13:11:40 -0700
Message-Id: <d21a3364d56827794cade1bb506acad5b3cc405e.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fsck to not treat missing promisor objects provided on the CLI as
an error when extensions.partialclone is set.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fsck.c           |  2 ++
 t/t0410-partial-clone.sh | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4492a4fab..f6cb4d755 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -755,6 +755,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			struct object *obj = lookup_object(oid.hash);
 
 			if (!obj || !(obj->flags & HAS_OBJ)) {
+				if (is_promisor_object(&oid))
+					continue;
 				error("%s: object missing", oid_to_hex(&oid));
 				errors_found |= ERROR_OBJECT;
 				continue;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 4f9931f9b..e96f436b0 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -125,4 +125,17 @@ test_expect_success 'missing object, but promised, passes fsck' '
 	git -C repo fsck
 '
 
+test_expect_success 'missing CLI object, but promised, passes fsck' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo my_commit &&
+
+	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
+	promise_and_delete "$A" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+	git -C repo fsck "$A"
+'
+
 test_done
-- 
2.14.2.822.g60be5d43e6-goog

