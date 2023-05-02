Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69BCC77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 04:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjEBEL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 00:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEBELW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 00:11:22 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE040D0
        for <git@vger.kernel.org>; Mon,  1 May 2023 21:11:20 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-18b5c8c2a49so2425886fac.3
        for <git@vger.kernel.org>; Mon, 01 May 2023 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683000679; x=1685592679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIOdgPocvci8gU8qii/E2cEf6qJiHwf7PCNpLURO77Q=;
        b=s39SThj4XJUfgLPQNfSUCND8ALAXNJrpeKoy1Tv23YO66FYm4/RwiZCBRsxliQio7p
         fIg4aUNdHsIws+WiyiiPexrUjBnVDar5mDkhrv7krm+v+krOiZOn7cgbC+p7BS1qw89c
         Y4l9LSMVC+L9FjwRTUF2afOW0hTvt1OYCC7PkeVWwbDWUxg58ZmAcwsrq4D/q2CIivZ7
         Mo8mMtsJNlTFMlULavjkkSrJzjvGg7WAEcj08e6GVNVaOaaMFnfuhcbPKkDFE2xX1sTS
         u4AbStmDFKqWYmR9T8YgZCIGfre9fzUj1QnQKtrajEJyXuGSqdUooWqY2VCDolaM269t
         GqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000679; x=1685592679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIOdgPocvci8gU8qii/E2cEf6qJiHwf7PCNpLURO77Q=;
        b=C5mee4jqy8sf3ABKnEMj187SYU4q6o+57pxXSAq3SQ0E9wBvs4cuEzUFxrVl8P/E5v
         rHj4N60UbhtlGfM3Il8WtduJvS9OAoGG10i9B5LaYSY76WxtJTEoHYfm326CPzmS9Iio
         Ij8BvJAYiWNXXZBuVbZbZE1MvIuPFKTnnI4axXbvG4NY9rhfoxspp2Tnl6CdYR86j28h
         PNEIsbCgG42L69ihoTY6/XoTw3y4K4PRBX6jXzL5XX19P8v2NeCRjXiZ0gtDFoIcg/2L
         PsWYl6aOfWNpSGI/QVmYhBn1wapkBzubf1aAnJpboA9op/xJGtEP9bZ+vVhLlR4mfb3i
         T0Zw==
X-Gm-Message-State: AC+VfDzzW1/sSOAOmWQEQ+2dixB79yduMP+di8CXg6zg219KAlt1+qZP
        rDPuCmsGVUo87gK5ihUlRBchaWTRvBo=
X-Google-Smtp-Source: ACHHUZ65a9Q1ENKAiG0ne0KQN1RyHQunD604RPAvHCCF1BNAWhE2wm/JmRDTEuRCwLQ07AutXI2D3g==
X-Received: by 2002:a05:6870:3747:b0:187:fc0b:22e3 with SMTP id a7-20020a056870374700b00187fc0b22e3mr7247666oak.30.1683000679543;
        Mon, 01 May 2023 21:11:19 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dt47-20020a0568705aaf00b0016a37572d17sm11970906oab.2.2023.05.01.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 21:11:18 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 3/3] test: add basic unit test
Date:   Mon,  1 May 2023 22:11:13 -0600
Message-Id: <20230502041113.103385-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230502041113.103385-1-felipe.contreras@gmail.com>
References: <20230502041113.103385-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We simply add that function, and test that function.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/lib/git.c   | 5 +++++
 t/lib/git.h   | 2 ++
 t/ruby/git.c  | 6 ++++++
 t/unit-test.t | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/t/lib/git.c b/t/lib/git.c
index 40d96ee354..54206171cb 100644
--- a/t/lib/git.c
+++ b/t/lib/git.c
@@ -1 +1,6 @@
 #include <git.h>
+
+int ok(void)
+{
+	return 1;
+}
diff --git a/t/lib/git.h b/t/lib/git.h
index 58a28085f5..dbbac9e406 100644
--- a/t/lib/git.h
+++ b/t/lib/git.h
@@ -1,4 +1,6 @@
 #ifndef GIT_H
 #define GIT_H
 
+int ok(void);
+
 #endif /* GIT_H */
diff --git a/t/ruby/git.c b/t/ruby/git.c
index e75692c582..e173dfe03d 100644
--- a/t/ruby/git.c
+++ b/t/ruby/git.c
@@ -1,7 +1,13 @@
 #include <ruby.h>
 #include <git.h>
 
+VALUE rb_ok(VALUE self)
+{
+	return RTEST(ok());
+}
+
 void Init_git(void)
 {
 	VALUE mod = rb_define_module("Git");
+	rb_define_singleton_method(mod, "ok", rb_ok, 0);
 }
diff --git a/t/unit-test.t b/t/unit-test.t
index 97d8a14ec3..27303f9c49 100644
--- a/t/unit-test.t
+++ b/t/unit-test.t
@@ -7,4 +7,8 @@ test 'basic' do
   ok(true)
 end
 
+test 'ok' do
+  ok(Git::ok())
+end
+
 # vim: ft=ruby
-- 
2.40.0+fc1

