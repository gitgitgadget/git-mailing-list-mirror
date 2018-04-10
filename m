Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FF81F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754329AbeDJPGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:44541 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754319AbeDJPGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:16 -0400
Received: by mail-qk0-f195.google.com with SMTP id n139so13690533qke.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lxJH2ULEJnRlLMp47YAcq41n7zGkzl906JcyOdUSaPo=;
        b=N5pObvojHadkr6GlrrRrrS+8qgIJ9Epglk8ywX1cWuOGXPAS1iZGL+EkMzn2kUSkVQ
         MsijDOpPxmKrdZtO229RuljE2moZuApvCxQdCpV5GZkd/cte95UV6Ige5nOO5w1uL59O
         Am0x8tKaEZzPs7vL3SZp6noZf3blFvnvH93+75qDN2NU4I3MVhu79GbdIDyhpJ9Dqawp
         L+60bGCxe+Nx0GOUcetB6Qf9DXxT1J3C3NI1HhZnJLEIJBc/XbMQxrq7kDchyAmLtB2Z
         nztysgspnL267aQuS4m8HUafBoIYMJLRUAFDhCZ71OMDN/gp8urZtZaWKN1c1zwNGb6V
         Ep0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lxJH2ULEJnRlLMp47YAcq41n7zGkzl906JcyOdUSaPo=;
        b=X/a3cDOn3VIsJ8RKzMPyETm7W7vQrDh4DTUO7o9YgKRKxg6/aXOzU7UVz7mixrcW/Q
         8e81k8KR2z4lnrf9Vk7XI6NicsTuDSZtH2yIIt3xnT8kAjsWa3usxxmS2Bcr4aJ1Lw80
         5SbfkQrsEgiTuIM6Jy/kdSF92bkVLHNQFD5lLUZrn8x+6g1lpaTjukV011sMLo++OCWJ
         xS7/39zxc3ybpo/QfmwPz1H4ivLYk9O1XTvUoeDzg6b0zZaGGwcJPUUH9YB1K1c2sQu5
         J6No11UVEL4HarntQiooP59oB9ZUB1JsH11/RTIBDoWBzQvFAAi/i0vW6P6WNytEHRRS
         FNTQ==
X-Gm-Message-State: ALQs6tDxNz5wWNKljg0j7HNlOvXOFw7SgOEpGeBM6Gmx8NzHIU5m2gUS
        0r3bxIZK7Ak91VM5SQ9CLWDLYXMGI3U=
X-Google-Smtp-Source: AIpwx49EKIjdhdZQesLTFB9zh6OS8os+4K9MPG4lcORLWQV58R2hPLayZgPIayvkj5KLMrlJSSwr6Q==
X-Received: by 10.55.65.21 with SMTP id o21mr1166177qka.98.1523372774590;
        Tue, 10 Apr 2018 08:06:14 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:06:11 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v8 4/5] exec_cmd: provide a new-style RUNTIME_PREFIX helper for Windows
Date:   Tue, 10 Apr 2018 11:05:45 -0400
Message-Id: <20180410150546.38062-5-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180410150546.38062-1-dnj@google.com>
References: <20180410150546.38062-1-dnj@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The RUNTIME_PREFIX feature comes from Git for Windows, but it was
enhanced to allow support for other platforms. While changing the
original idea, the concept was also improved by not forcing argv[0] to
be adjusted.

Let's allow the same for Windows by implementing a helper just as for
the other platforms.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile   |  8 ++++++++
 exec_cmd.c | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Makefile b/Makefile
index 960541e77..8fc5559c7 100644
--- a/Makefile
+++ b/Makefile
@@ -460,6 +460,10 @@ all::
 # When using RUNTIME_PREFIX, define HAVE_NS_GET_EXECUTABLE_PATH if your platform
 # supports calling _NSGetExecutablePath to retrieve the path of the running
 # executable.
+#
+# When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
+# the global variable _wpgmptr containing the absolute path of the current
+# executable (this is the case on Windows).
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1700,6 +1704,10 @@ ifdef HAVE_NS_GET_EXECUTABLE_PATH
 	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
 endif
 
+ifdef HAVE_WPGMPTR
+	BASIC_CFLAGS += -DHAVE_WPGMPTR
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/exec_cmd.c b/exec_cmd.c
index 38d52d90a..6e114f8b3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -144,6 +144,24 @@ static int git_get_exec_path_darwin(struct strbuf *buf)
 }
 #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
 
+#ifdef HAVE_WPGMPTR
+/*
+ * Resolves the executable path by using the global variable _wpgmptr.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_wpgmptr(struct strbuf *buf)
+{
+	int len = wcslen(_wpgmptr) * 3 + 1;
+	strbuf_grow(buf, len);
+	len = xwcstoutf(buf->buf, _wpgmptr, len);
+	if (len < 0)
+		return -1;
+	buf->len += len;
+	return 0;
+}
+#endif /* HAVE_WPGMPTR */
+
 /*
  * Resolves the absolute path of the current executable.
  *
@@ -178,6 +196,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 		git_get_exec_path_procfs(buf) &&
 #endif /* PROCFS_EXECUTABLE_PATH */
 
+#ifdef HAVE_WPGMPTR
+		git_get_exec_path_wpgmptr(buf) &&
+#endif /* HAVE_WPGMPTR */
+
 		git_get_exec_path_from_argv0(buf, argv0)) {
 		return -1;
 	}
-- 
2.15.0.chromium12

