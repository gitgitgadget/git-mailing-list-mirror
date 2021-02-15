Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77586C433E6
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463E764DEB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 16:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbhBOQCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhBOPrt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:47:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4ABC061A2A
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v1so9454511wrd.6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BEmWeL2mu70TMCSOR3ZAfQYWVafLLq/2AYoyAPMhI1s=;
        b=rnDmyH6wGggQCtlSFOmzn6Ek1akUiuO8OU1fNVpZPITg/ACDm7eFKytxNZnZWqNw16
         7z/h+m1cTfYY2BZw5anWuz3HT0uBIy5Qw/Lv3uJQ34yzRmHTDZbQldF7oh03l5egg0vp
         9vnbByVQKZ3GKGcthqy6hhysSVu8Ri7bLcaBio/yrYsvMJsmBtqzOYkzgpq1p3PVIlsF
         J+hFR1REKz7d2pQM/m2gisFurUJ4J/v2dNwLZRfBobiTcw9t6XL87Fc9ll+06zDZ3hz4
         oUyHg42y4RZCOWlFaa4y1AGkRAD6plxux+WliVqwl6i940uFiSl6zN0GgDjMg/MjmVxi
         idjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BEmWeL2mu70TMCSOR3ZAfQYWVafLLq/2AYoyAPMhI1s=;
        b=Txxbdve6DsL/hN8rgfD3cJx/R+Q7GTEbBKIMPdphbSvopaA20k5IHQKzP9PRc3SAm7
         El/pCyW0cKRbJYLbbL80/RUINAoKw+kOjv9HajtzbmTB7ktpfM9j+56RX1E35wWOQ5hZ
         sgiGlUwcUeLgcxQNEUmI/aNVkn9Ply2mNoqUdHh09K3XhM7/bRahskMv3Yqln2knkf1E
         FkJr++LzZyFGtR1ux8gYwus/1mZNJMaR/ww1DVx6IoL39vUGkN98BYkwM55JlDn5VX6y
         ulIJ+vyCmPne6UCyir0R7us6D4pgapP54MjDzrIkGqYYLDvrp2jy/umY4AUjntFfUJe+
         dn+w==
X-Gm-Message-State: AOAM531Sjnb0AIZfeBcCgXl249Zm1Ezr4vFxjY+OXvEb6Oi6RIywpnBD
        wuxOaNYmAH9qq8d9/3bUqeu6gKxhObu2kw==
X-Google-Smtp-Source: ABdhPJxZZcyJ9IG4FIr8Bc9EiX5YPvVigoAB5Uq85bgVt1lMBBR4LuBUJs7/xoR+TCINWkWW9W1FmQ==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr19765094wrq.121.1613403908771;
        Mon, 15 Feb 2021 07:45:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:45:08 -0800 (PST)
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
Subject: [PATCH v2 27/27] userdiff tests: add basic test for ruby
Date:   Mon, 15 Feb 2021 16:44:27 +0100
Message-Id: <20210215154427.32693-28-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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
 t/t4018/ruby.sh | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100755 t/t4018/ruby.sh

diff --git a/t/t4018/ruby.sh b/t/t4018/ruby.sh
new file mode 100755
index 0000000000..1e9bfef863
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
+	"class Two" \
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

