Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD349C636D6
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 15:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBIPpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBIPpa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 10:45:30 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626B6565B
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 07:44:55 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a5so984804ilk.6
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 07:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qj6iV8Jk+40tsJDKvnzqGxJ5AjMLS0+V/A65FOA41c=;
        b=j4Y84wSbh9PvTOAC0l2EFa3sFSkOhLHyiw1CHJF+oT7ulItQxcKk6x3+0FuAYDvQF9
         iSKcHdyihsAfUXQgttv6JfeCR5BMLjd/MyqXLubevvFmDQbBfKKgnVqKXv94O9hUmOMT
         Jbqb0EfByjWF1g830NGCjVOKwT7ZwONhNtG2WHUWXNeDoC0IWxqti82oE8W7KfbqkPdm
         1bLfIhyXKMe2wC2ow9ry/npJos4p60ygXLctMcZKjY5Ijozz+7oqu6G/avpt24Df1t1D
         wI9YMHlD7Wtr8hbT50v3Q+m2TR3tGJ2UaPRGZjLPNp8klp3CcKmqd/XDi6nQEdES5rzA
         l4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qj6iV8Jk+40tsJDKvnzqGxJ5AjMLS0+V/A65FOA41c=;
        b=cvvLb+5B8Lvs90vt/DoaqZkMRdSUe6g4VkOGSenDwmP85ogzj0rPJ4ItHQX2U+F/Dx
         hIFLKS1XwwVErTPQLJDA1hfRW9S7DtcHE7Gh8PqUa1I2n1SmAo3hrO82sUueC6rREP38
         Z9HbqFZph19aXOGNN3d2aL/myCe684oWMofjRtVACiN0HkL7plxFGE81+5B1BWOTizRE
         WYoIzZazny9Pl732bXZSdutDVTBL7SbleW2RcTvKBLtK3bJkjbqvMT4TR3u7moi2R019
         EIFfLkPzVcykPyTUwGPBNVEfkbyMrnP0q06QaZUJ+iWKinD8mhgfPOrqfGMjLtJpUGvM
         rPgQ==
X-Gm-Message-State: AO0yUKX753tCTTwduzOFl2lXM/xFjDNJcwfpxQGJ+8pvOGs6UHyvif9Q
        mbUgOabV5PoNW20LK+eoa0lr5SAVuO1OYw==
X-Google-Smtp-Source: AK7set8D187XBZppZQKqddUDcEqFObeu1jASa0MvTFOT+TIxIh6vdrI2vGYVJ6BoSrIexcj8kivRXA==
X-Received: by 2002:a92:c241:0:b0:310:fa45:ac78 with SMTP id k1-20020a92c241000000b00310fa45ac78mr8609744ilo.29.1675957485646;
        Thu, 09 Feb 2023 07:44:45 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a1-20020a92d581000000b0030c0dce44b1sm563570iln.15.2023.02.09.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:44:45 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v5 1/3] t4113: modernize test script
Date:   Thu,  9 Feb 2023 10:44:15 -0500
Message-Id: <20230209154417.10763-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209154417.10763-1-cheskaqiqi@gmail.com>
References: <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230209154417.10763-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file in this script are written in old style,
where the test_expect_success command and test title are written on
separate lines. Change the old style to modern style.

for example :
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 66fa51591e..41526ca805 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -24,14 +24,14 @@ echo 'a' >file
 echo 'b' >>file
 echo 'c' >>file
 
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'
 # test
 
-test_expect_success 'apply at the end' \
-    'test_must_fail git apply --index test-patch'
-
+test_expect_success 'apply at the end' '
+    test_must_fail git apply --index test-patch
+'
 cat >test-patch <<\EOF
 diff a/file b/file
 --- a/file
@@ -47,7 +47,7 @@ b
 c'
 git update-index file
 
-test_expect_success 'apply at the beginning' \
-	'test_must_fail git apply --index test-patch'
-
+test_expect_success 'apply at the beginning' '
+	test_must_fail git apply --index test-patch
+'
 test_done
-- 
2.39.0

