Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E7C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F79061247
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbhI1CUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbhI1CUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB2C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d21so55081066wra.12
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOTtP7QG8bBmVdro4EjXBoilQTXKAEyvSH13/rvxGOE=;
        b=Ih8oAEb3olRPcrx8joifg/+hbapiR6EBy7Z6dZHpY/Fk834jN7scsxvE+mUo2AHgXS
         iP4Uw2fSF3Dz34BxiMsiwwUrQ8x2ZJ4fLIHldrHodCej+7iW71zMkcm35Uf+5Dsi+lO7
         IIfocnOVtHMh8Hbk0v2lWyA2Vv5wvIaWn34t8hH2Bh41aKWL4TuY7LIMt/sYp/T3L88Q
         8RcEKqKmkX5DTTCddKGDvOJxGs+eHaQxUXw2dFbUyzEBfnxNWAAhlkLhPUY6J5WsuR8V
         nTdxblkODLFnr/ycO32KI8/3yHI8Wfri0UKjQueCpYbHnSRznloOSQhqXKMqavvMUeNP
         PouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOTtP7QG8bBmVdro4EjXBoilQTXKAEyvSH13/rvxGOE=;
        b=Ydqkow+8roSnwkQ+NX+gsRd23r3MTsWS+7w87sLG//i71y1GzufYCMVMLxS2UakV2S
         I1EBcMlJvL1qvnRxX6xoxFCpC7DMR3rzh5P7+bQb0dlUTQ5cms0RH3bbA4YaHWpcQEay
         YtWOmumS+SZh05vaLb5LmMhyrvbZNc1Vo9U7WDPI1gUXz3hbtetVCZA1BuKQvSqUo5iP
         6CuiY/4KgDyW3Jdk7fJhNNVip5H8e5pWr1qVE0eevrEox8grgpyH+e01aYVAJ2F/NhZg
         Cv6J102muFvw3f+I6D4i1ozdtFZuuTQ7oFBU5qvgtGmNakOgWbaXvB7X9YzU0tB5l6ax
         wa/w==
X-Gm-Message-State: AOAM533xSJr6dUx+jvMtBHVRkZnWmmmpXXu5a0P+Fj0baLAVDgMau8Ze
        mIlqb7Naowmo+NVExzTKW/1XvBG1j6+QqA==
X-Google-Smtp-Source: ABdhPJxry7FOdeFmKftEWcYVjmNrorvlD5dAG0G3Uhdt63LgAjRyRS/ctE/qtcHRKyTseAHJF87tPQ==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr3534483wrv.90.1632795540886;
        Mon, 27 Sep 2021 19:19:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 01/17] fsck tests: add test for fsck-ing an unknown type
Date:   Tue, 28 Sep 2021 04:18:42 +0200
Message-Id: <patch-v8-01.17-b999ab695d9-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5b..969bfbbdd8f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -865,4 +865,21 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	git init --bare garbage-type &&
+	(
+		cd garbage-type &&
+
+		empty=$(git hash-object --stdin -w -t blob </dev/null) &&
+		garbage=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
+
+		cat >err.expect <<-\EOF &&
+		fatal: invalid object type
+		EOF
+		test_must_fail git fsck >out 2>err &&
+		test_cmp err.expect err &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.33.0.1327.g9926af6cb02

