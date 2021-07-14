Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B0C07E96
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D89061370
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhGNA5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhGNA5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0541C0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a13so947655wrf.10
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvx7RbkgKgtMKEZECAKV9jbqO3jm4XogqQa2d33ZYtA=;
        b=OesMWjl50kI5WrF3JRkY879GcLwkCb2zu1g7D2eFmJh3YuImHu/eiMVdZoyN+cCIJb
         pw/ecICCAEElKRqZHfuyTbZl1oqJyvVLwP4CVxcKxb0dhxoUI8WK8iOJy+LX1mwb7YYc
         TZ0HZZgzR6I9Q/Ha0j24tSdai5WlAHCz2v2BjkJE3u/xR2oKftuPLx6QFuYze4rL/PTD
         yZDWyWXcoVhdul4WxlNjBramxQ2mnvQDObL5lMlYcKKZI5WZflp78Q+OGs2ysApIK3hR
         T4wmkWU+vLW2vdEbsOhwln0PXjLT9Z0+vhHAVpseS52BzRTdTGY5heFw1gxvwEWfWNXY
         Z0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvx7RbkgKgtMKEZECAKV9jbqO3jm4XogqQa2d33ZYtA=;
        b=YsSx5V4jU8l3oXTBpD2FZTay9GGLyn3jLF5FeAa36W5iK0bGUVj5m/kqPMz99GxKfi
         /vw5ARO3o6e4gm3/utb/+c206BRS5ry1036DPiwwI1m9BJQWoMKJ83+7euuJhtzy8Bod
         wMDZavEELCvaIGDSjWHKx9yCd0O746qxs7HBpva5r5QVU52VdDRx0x++mnR0reX5gvnV
         AtGf/y9r0SP6EIJQubQ3dmA2A296CG7kZD8W/B6dU5DU0rPf/CV0UTA95WCIeOoCq6fH
         gzJc4rowsC97EJVFHOANxZnw4jQ9HcZ3O8UtS8lyg6HZ4r7YrvHNiai1GaJQZycDwFbv
         R7Sw==
X-Gm-Message-State: AOAM530ybfdsR1BhZjVWHYlB21B9RJWMvc5zA7hFuspwU6p8NVQEoJCo
        tz4/1U5WD9DRbOau0eByfQl85ja0H47rypvv
X-Google-Smtp-Source: ABdhPJytctKN9JHCV7D3jf9s9fvcILpuRqxvJmksvtavOGdqWk1yUzEc1Q2xdzmpA87aikirvVyYEg==
X-Received: by 2002:a5d:6c6e:: with SMTP id r14mr9405511wrz.242.1626224048323;
        Tue, 13 Jul 2021 17:54:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] serve tests: use test_cmp in "protocol violations" test
Date:   Wed, 14 Jul 2021 02:54:02 +0200
Message-Id: <patch-2.5-64dfd14865-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the protocol violations tests to check the full output, not just
grep it. This changes code added in 4845b772458 (upload-pack: handle
unexpected delim packets, 2020-03-27). The newly added test in the
preceding commit already did the full test_cmp.

I have a related series to tweak the output from upload-pack et al, we
really want to make sure we have this exact output, and not fewer or
more lines etc.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5704-protocol-violations.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 95f68e1d4b..038fffd3d0 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -14,9 +14,12 @@ test_expect_success 'extra delim packet in v2 ls-refs args' '
 		# protocol expects 0000 flush here
 		printf 0001
 	} >input &&
+	cat >err.expect <<-\EOF &&
+	fatal: expected flush after ls-refs arguments
+	EOF
 	test_must_fail env GIT_PROTOCOL=version=2 \
-		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after ls-refs arguments" err
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
 '
 
 test_expect_success 'extra delim packet in v2 fetch args' '
@@ -27,9 +30,12 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 		# protocol expects 0000 flush here
 		printf 0001
 	} >input &&
+	cat >err.expect <<-\EOF &&
+	fatal: expected flush after fetch arguments
+	EOF
 	test_must_fail env GIT_PROTOCOL=version=2 \
-		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after fetch arguments" err
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
 '
 
 test_expect_success 'extra delim packet in v2 object-info args' '
-- 
2.32.0.788.ge724008458

