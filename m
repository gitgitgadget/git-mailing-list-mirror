Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F01C77B7E
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 17:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbjD0RuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbjD0RuW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 13:50:22 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D33A8D
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:50:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f808d894fso163423287b3.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682617818; x=1685209818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1O3Fhw9IUUjLtQ4l78orMUU4s63irjL/50TsVF1T2w=;
        b=szY7MIP7xyV7RggmatOxxicz9cPuICPVjPtuL0DXLkgETjUGlrjbMWUAdHWAfeHYXX
         qR4WYS1J2iPC04YczibQs2/MB06LPIBln4fveKFkGo6hnbVMO4pCELuP/Os9JlH8jch2
         if+PUZAUMNXI8E1UYEHNcCHqejQPC99m4RthyhZ42WXf4h9Z4KHmI8Sbrs5HJg7vLoqY
         Ms7q4kTGv6lblRZdewz2bhh4GqCwHOs6Miptkmj1wx55JIpIXunuwxVKesvnLCuDE48g
         XZ+ZC8V2NFgkAXNha/aAvY6O46dqGi9oWwqYi19+FSUFw/l+DDpffLXyUZcqrbSJgiJp
         a7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682617818; x=1685209818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1O3Fhw9IUUjLtQ4l78orMUU4s63irjL/50TsVF1T2w=;
        b=OBwf65QjTyxrQLXks4A0eFjjltJlaQe3He5us9n9WY6Eck3BWCqUCVACLjephOcXzF
         qLKacB+amFTPPDh1rRaLk/RkHLNLai2KfsE13G42KkGce5h6nTrMO0BjxuZaiiiyxf2f
         40uJzeGPfVB3d91JYKd/OLdR4qVxfglBEPRqdabtozNzb/80FplLBSqAyv+KtK59CFw8
         lTT/DWpKlDom5m4QT2riHnFU3cu5qjXQ13rhVfZgWaZcO3r8pGBv7jlerY+Shuwpcv6G
         W9k75a/ngVM8kUUpCyVGAixZVty73WVOSVWr/7aYdEdxLsp5Is5Wawlb5+1TCc/XeH9Y
         dUjw==
X-Gm-Message-State: AC+VfDx0tDyQm+t9Ykw8qds1FW9d0JvuZbfHkRyPyJ3OJmKwt8NwMpGk
        cWoIwNpGulfDsJDsocTq+3Ss4oYUclgtC+j8KSgKspo8fS2MV2vANLueIcDysXjAPXVV0oHiBqs
        6an84i4zhKJhC0vG75w1S2VtIFJegEERTQzITi3av4Jfn5F/PkuJ3KJ7WiQQFRw+Y2Q==
X-Google-Smtp-Source: ACHHUZ6MpDhCqUDhIXVd7hvLgEUzS6E6VrTa/UZEqlLyFMOgTi6L1In2VHr+EI1UlD25GnFbo/Lv19OggV1eFjY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ac67:0:b0:54f:84c0:93ff with SMTP id
 z39-20020a81ac67000000b0054f84c093ffmr1573616ywj.5.1682617817960; Thu, 27 Apr
 2023 10:50:17 -0700 (PDT)
Date:   Thu, 27 Apr 2023 17:50:07 +0000
In-Reply-To: <20230427175007.902278-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427175007.902278-3-calvinwan@google.com>
Subject: [RFC PATCH 2/2] unit test: add basic example
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although this commit doesn't showcase unit tests running against
anything in Git, locally, I have a smaller set of Git files compiling
into a library with unit tests running against it using this C TAP
harness.

However, you can run `make ctap` to get an idea of how the output looks
and use it as a baseline to play around with the other features of the
library.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Makefile      | 11 +++++++++++
 t/TESTS       |  1 +
 t/unit-test.c | 14 ++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 t/unit-test.c

diff --git a/Makefile b/Makefile
index 60ab1a8b4f..b67b81e312 100644
--- a/Makefile
+++ b/Makefile
@@ -3831,3 +3831,14 @@ $(FUZZ_PROGRAMS): all
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
 fuzz-all: $(FUZZ_PROGRAMS)
+
+LIB_CTAP_SOURCES = t/tap/basic.c t/tap/basic.h t/tap/macros.h
+
+PHONY: ctap
+ctap:
+	cc -It -c $(LIB_CTAP_SOURCES)
+	ar -rc libtap.a basic.o
+	mkdir -p t/unit-test
+	cc -It -o t/unit-test/unit-test-t t/unit-test.c -L. -l:libtap.a
+	cc -o t/runtests t/runtests.c
+	cd t && ./runtests -l TESTS
diff --git a/t/TESTS b/t/TESTS
index e69de29bb2..4b1899a115 100644
--- a/t/TESTS
+++ b/t/TESTS
@@ -0,0 +1 @@
+unit-test/unit-test-t
diff --git a/t/unit-test.c b/t/unit-test.c
new file mode 100644
index 0000000000..6eceb50ee6
--- /dev/null
+++ b/t/unit-test.c
@@ -0,0 +1,14 @@
+#include <tap/basic.h>
+
+int unit_test() {
+	if (1 != 1)
+		return 0;
+	return 1;
+}
+
+int main(void)
+{
+	plan(1);
+	ok(unit_test(), "unit test runs successfully");
+	return 0;
+}
-- 
2.40.1.495.gc816e09b53d-goog

