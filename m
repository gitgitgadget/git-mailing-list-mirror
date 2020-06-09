Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C71C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC3DF20774
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXDFVeXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgFIRXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgFIRXC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 13:23:02 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394B1C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 10:23:02 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l184so17667081qkb.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JCozJmz70KXbSSUYLgwhnPOEH+9oy5Ia3J29tKk+mQY=;
        b=WXDFVeXV47Sn6AGRF8ZIgTQ7ZGW8Fs0cvnxqtnuXiQFwZFpyH0WVfkO4g//MVpkvUN
         ta/hmZ+Dhbl1hMHYlVJcKkhHo1uOdfVxgIUryo72bxqdvSoK4vZy34BvbnAXk51/D0I+
         sOSfiDNaBI0cXNfSNlv08v8vk0gjXFqHtB2zxu789yrFUvSHP8nJs86NwDFkcmRIVrK0
         0Zl2oAu2X7P1Px5kaNJ3Rbl6o0MxwjF8qw3ELcbdIo2+pDEBpYxzhFoWPZfL1mb7K7B8
         aY6BapoUkZZkfXGY5mNS5nXUs5nXxdwRYqN8IDEXZ7AXjsrxweHazWHahXjpRta5/2FR
         nRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JCozJmz70KXbSSUYLgwhnPOEH+9oy5Ia3J29tKk+mQY=;
        b=S8c85JVD91xsnrAEQd0YF2dned1NxbFQhaYA05TPfHp3QyMnaNlB7z6i3un3NEeVs5
         g/+WAKAq5hJHFqLEaqEJFW4ss5Llgc8dhfu3irPS23ZiY6suhH8R86V0bD9ZIv0Z0iCT
         qx9qHmkuRGnvtXYmFOw5cZyjHrsQxBAPhrqhP4ZVmUPEzPaNN75wRue/+mOhUUkv9gwT
         n0WfZPeXFqW+Z+ap0VYBX50ldOkgII7q9Ot/dIvtFKZmPgDkRvcHc7v97u6g+08iAoe+
         yq6nVCqsgTPStqLo1O3HqFj13j2FK7ymGXymKBU+ReSkjfCZe37VUQJRE7YFnTiuGly6
         Uy9w==
X-Gm-Message-State: AOAM533BkXrMkczVxkeG2naKW9YIJxXGb5TQ4SUxqciT3JkRCBeovPk2
        vd9s3+XZY8/T87J8x4akjLfaDSb2P5w=
X-Google-Smtp-Source: ABdhPJzTfRJubJG5Kto9X4/uHpC+6CTmea3F5xki3R2jlVyiKd7ZwTk0FazM6VtN4uegVsQ9Uqy14W2nc+o=
X-Received: by 2002:a0c:fa47:: with SMTP id k7mr4917488qvo.132.1591723380711;
 Tue, 09 Jun 2020 10:23:00 -0700 (PDT)
Date:   Tue,  9 Jun 2020 19:22:44 +0200
In-Reply-To: <xmqq4krll544.fsf@gitster.c.googlers.com>
Message-Id: <20200609172244.257392-1-hanwen@google.com>
Mime-Version: 1.0
References: <xmqq4krll544.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH] Fixup! Add t/helper/test-reftable.c
From:   hanwen@google.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 t/helper/test-reftable.c

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
new file mode 100644
index 0000000000..95d18ba1fa
--- /dev/null
+++ b/t/helper/test-reftable.c
@@ -0,0 +1,15 @@
+#include "reftable/reftable-tests.h"
+#include "test-tool.h"
+
+int cmd__reftable(int argc, const char **argv)
+{
+	block_test_main(argc, argv);
+	merged_test_main(argc, argv);
+	record_test_main(argc, argv);
+	refname_test_main(argc, argv);
+	reftable_test_main(argc, argv);
+	slice_test_main(argc, argv);
+	stack_test_main(argc, argv);
+	tree_test_main(argc, argv);
+	return 0;
+}
-- 
2.27.0.278.ge193c7cf3a9-goog

