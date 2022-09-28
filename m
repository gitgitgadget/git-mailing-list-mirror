Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71223C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI1IlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiI1IkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:40:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297A13F09
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s14so18713410wro.0
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I3VY8Oqa0CK4Qje2po1DKhEOoJNjAhWWiTyMYiYxVQY=;
        b=InwzOKt70y8TvocPBW6UvT+iliOWPGXXDeeeuc5bwFd1QDD1sCQyy0qBkSbiG5UyyI
         WZJh/DTUqaoY/yhnSYyDyAmLJhLEKHgggzaa4zG9L8tTSIqRvzfwJz4PbNfkTm7JEzBP
         DCr2NozlSM/OXOdoMMbQ2MdUohQmkItdcRMGt+vTjVb23hwqlaZtz5OIH50biV/Y4Tkw
         EeULEbjzW0ye7yx28FuVpJ0UCPlHiKCkUwxc7Y0CGRYM0X94trQyio8nsvOFjn6hAFPN
         p/4IAiFTt5b206M2dI39eJXBzS700U8JYoE1cY5qqJasXzCmcTFU1rRgGYl3nkwZAffb
         rNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I3VY8Oqa0CK4Qje2po1DKhEOoJNjAhWWiTyMYiYxVQY=;
        b=Ej2LwV/Uu7WM9KUZ+Dv5fQTNtaOVsZC7VMOS6Q5nkA11XNbZZIAkCAO+nOwI8qva2g
         wRA1gqtlzXMBqqvrgE4Bmna2ims7wfeafK/mJcOKrfRXXHluwW70rB3eNL8WWV8yzTqk
         GOsR8yEkZv/+aSW+fpG7BmfUGE1P3rKcXjFWpIxgJfcfM3vsSPvlIDjF9lsNd8mxNhem
         UvVrHkf7AgVdWMIcdjb/WT6ewQpn0TfNfuQc0+0odMlDn5nUJmOd/6hyMGA0QcyGiBSt
         f2mIP65BeoefsLEHHqYWA/2OIbdupJEdUxySMl0iyzJQgSYcNqmvqUg8IkVk9bzfqsyc
         Gsgg==
X-Gm-Message-State: ACrzQf09tH5RRtwSrMn/y16m30iEoguWmFGT3yu0kgO93JBCG/Ei6OgF
        CSOI/nyQI1iLxNKaKBUlp7AGhfOn7D3ZgQ==
X-Google-Smtp-Source: AMsMyM5w7eZGBLw1XpTxqOvBula0XdLAhZVInm0MPAnAh3KDb41Vm2aWZFSmveUEYpn+pS/K5eihbA==
X-Received: by 2002:adf:f68a:0:b0:22a:ea5c:893f with SMTP id v10-20020adff68a000000b0022aea5c893fmr21064044wrp.671.1664354395098;
        Wed, 28 Sep 2022 01:39:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/35] doc txt & -h consistency: add or fix optional "--" syntax
Date:   Wed, 28 Sep 2022 10:39:13 +0200
Message-Id: <patch-v2-18.35-301280c9c3a-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "[--]" for those cases where the *.txt and -h were
inconsistent, or where we incorrectly stated in one but not the other
that the "--" was mandatory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-repo.c | 2 +-
 builtin/rev-list.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index c6379b783c8..d45d873f579 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 
 static const char * const for_each_repo_usage[] = {
-	N_("git for-each-repo --config=<config> <arguments>"),
+	N_("git for-each-repo --config=<config> [--] <arguments>"),
 	NULL
 };
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ada68a4af5e..3cc8aad52ed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 
 static const char rev_list_usage[] =
-"git rev-list [<options>] <commit>... [-- <path>...]\n"
+"git rev-list [<options>] <commit>... [[--] <path>...]\n"
 "\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
-- 
2.38.0.rc1.925.gb61c5ccd7da

