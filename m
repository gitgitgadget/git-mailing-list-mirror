Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2FC433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CB164F09
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbhBXT6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhBXTyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA814C061A2B
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:23 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e10so2825630wro.12
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVsRH/pRLpHiEheWqNzoRFeT+Q+1ia2kdJrwOg41Bk8=;
        b=h+CE7cOTETQ+WfSpQcHCbB0fpEgfHKTZ6RfMD6i69BkVI81gLZdzZzMgsOsjJEB4Md
         hCd2+NVpqN6cqzLZzUfDArQ3BdEHJI6WieOTU0ab5l0yH9UKOZruAYoewIGyLv98oldn
         2pwMXRiAWjmV8Xzg3HP3fu9lTNwRDD2ibyWzdFIk4xu2BvxzROkGs3Iod6EFutGTSfAW
         +liYte+NKATXYSNEfD7pn3oFrMwoxazYNaAD+1egSRz8j6j4rt3yVB3kYvqxH9yJ3KH/
         a2QYI/6+LPPKQiFc/XITYSYw+k55ZtwJU+My5z/oyUivL6PvuWTGjYw3vySZV3YxM28X
         In8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVsRH/pRLpHiEheWqNzoRFeT+Q+1ia2kdJrwOg41Bk8=;
        b=ltUDbWO/7j25IfUClzE0SoF3AVsi5Deuh7gvrZpP/li0IBE7Y9r2Zl/Q4Xg/Iy9kS5
         zuHVMVBWgEpoZOYw/wJf5Pzi0E0MfXXnepE2w1KoyZbYoX0g5j7aIdHwnDUeTSJYjG68
         tFJJ5gfP1zojKGUMJy2G3Ithfs0taBy4dwGclNGk02WevLzXcqqLDRUd/fAcrUDSRU7d
         F+GSOOg1YKlq5UBV2mr2fSmX7bWOfuMad/bHHbkbFAFE5yjPN5tiOVmNTOewLtXBavAd
         GCh0mkCtppY5MvZwt27RDiETUFgVYIcTSBTLDs6t0mIZ1v/sW/3Hdmd7T18OH5uqO01G
         cDpw==
X-Gm-Message-State: AOAM532VnK3j0XjK5wGue/GOdF2sdJ7Uc1iuzdA1BtXdNvB0hEuRMY1C
        tLeMoB1sITHzXcpUknPpe9Wu9RgxHTcWDA==
X-Google-Smtp-Source: ABdhPJwUkiWr0apyqT0xjqchxbqu4TNufwn87rFd6+bcmAsBV94XFmjxIa/QpXN/rTJNBdjIYLtTJg==
X-Received: by 2002:adf:bc01:: with SMTP id s1mr3418163wrg.240.1614196342398;
        Wed, 24 Feb 2021 11:52:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 35/35] userdiff tests: add basic test for ruby
Date:   Wed, 24 Feb 2021 20:51:29 +0100
Message-Id: <20210224195129.4004-36-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the Ruby pattern added way back in ad8c1d9260 (diff:
add ruby funcname pattern, 2008-07-31).

The "One/Two" picking demonstrates existing behavior, and a general
case where we may not do what the user expects since we're not aware
of the indentation level.

The code is modified from the Ruby code we have in-tree at
Documentation/asciidoctor-extensions.rb.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh |  1 -
 t/t4018/ruby.sh          | 58 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100755 t/t4018/ruby.sh

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index b0c2782d067..7793d7652d5 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -23,7 +23,6 @@ test_expect_success 'setup' '
 	html
 	objc
 	pascal
-	ruby
 	tex
 	EOF
 
diff --git a/t/t4018/ruby.sh b/t/t4018/ruby.sh
new file mode 100755
index 00000000000..ef8a154421a
--- /dev/null
+++ b/t/t4018/ruby.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+#
+# See ../t4018-diff-funcname.sh's test_diff_funcname()
+#
+
+test_diff_funcname 'ruby: "def" over "class/module"' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+def process(parent)
+EOF_HUNK
+require 'asciidoctor'
+
+module Git
+  module Documentation
+    class SomeClass
+      use_some
+
+      def process(parent)
+        puts("hello")
+	puts(ChangeMe)
+      end
+    end
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'ruby: "class" over "class/module"' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class Two
+EOF_HUNK
+module Git
+  module Documentation
+    class One
+    end
+
+    class Two
+      # Spacing for -U1
+      ChangeMe
+    end
+  end
+end
+EOF_TEST
+
+test_diff_funcname 'ruby: picks first "class/module/def" before changed context' \
+	'-U1' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+class One
+EOF_HUNK
+module Git
+  module Documentation
+    class One
+    end
+
+    class Two
+      ChangeMe
+    end
+  end
+end
+EOF_TEST
-- 
2.30.0.284.gd98b1dd5eaa7

