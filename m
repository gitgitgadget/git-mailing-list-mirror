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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587A8C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214E161984
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 02:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhC1C05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 22:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhC1C0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 22:26:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7743CC0613B3
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so4912032wmj.2
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 19:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A13jpEFHgJhKPbzPT9YXc5D3S5lzTexHpNPT9p3vEEg=;
        b=giYkgqf441wHfDfM0rUXd5uHwE9B89Dmd0daaW/uxWNCPJwBtzDnt9BVPH+94pcqLm
         pqr/YPCwPzfdmOkQqZNWlhQB6DXmTJq+hoXt2DjO/Gz4Vt/J/zhvAduZRIkENP7mcY9r
         rNMK/ioZhHPYRIUEZQjn/Sv5UJpu26SAVFbJJtZuUKH3rzKqLik5KscWxbfvfiKMgeQ0
         Ngs6WOaopylF6hBrtx9HYMaE0Chw42pZCBfWMIYep2n92u/o15Ce9kOXKdrhXetCgIMQ
         DIoZG4qdIzLhfbWq9KZ1L0TEz/+YHwTEc3ug/LJClEztubp9l3A1i5E7vxI296lXwPsK
         M4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A13jpEFHgJhKPbzPT9YXc5D3S5lzTexHpNPT9p3vEEg=;
        b=T5PBmn9/iLCDmZVZhB3HRDoN2CCeAD58byHbYpWfBYjbuQ9begBan5+8x9yhzjHwno
         0YEuVYUth6n6ZxvWO/gdArItXzYB1ZhhMJYV2HO4T0gCmLB6OBICJY7MOvp2YHIDtQNW
         zViAtHf/wRXRzJQuwpS1tV/JYEKqpEdxLhGu7ieAkYKHnzFt48xdJkYX0oEdjvCyxz9B
         qoDeVnQF7Rw5fIflzNJ1MtmWZwa0tkWPeFIfTRBiJjrS12Jj8Ft/KYeIAvbROrFmQ75w
         YKkrQTUMRLo2YRCMRk1cXSmiOb0FL8grqw9HEmHjX3QOlfVfcU1GqUTpI5WSP42ppo80
         y/FA==
X-Gm-Message-State: AOAM531nNY4OxZWvEEXyPti1MiGTMGabf0L+Qv3Rny0SB8Xwch57QEXA
        LqJVpLY3ub6ZygV69lW9LhfP6z1ELesiSw==
X-Google-Smtp-Source: ABdhPJxcr15OzKIZiqfjZUfnihLcKMSDgkCfyKBcYxBJmUngUMgydaRM27YG9W6IU9hSuR9N+hWATQ==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr19255362wmc.98.1616898379924;
        Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x11sm17887305wmi.3.2021.03.27.19.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:26:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/4] api docs: document that BUG() emits a trace2 error event
Date:   Sun, 28 Mar 2021 04:26:02 +0200
Message-Id: <patch-3.5-f0e0d0daa6e-20210328T022343Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g91d8e479b0a
In-Reply-To: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct documentation added in e544221d97a (trace2:
Documentation/technical/api-trace2.txt, 2019-02-22) to state that
calling BUG() also emits an "error" event. See ee4512ed481 (trace2:
create new combined trace facility, 2019-02-22) for the initial
implementation.

The BUG() function did not emit an event then however, that was only
changed later in 0a9dde4a04c (usage: trace2 BUG() invocations,
2021-02-05), that commit changed the code, but didn't update any of
the docs.

Let's also add a cross-reference from api-error-handling.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-error-handling.txt | 3 +++
 Documentation/technical/api-trace2.txt         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index 71486abb2f0..8be4f4d0d6a 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -23,6 +23,9 @@ various kinds.
   without running into too many problems.  Like `error`, it
   returns -1 after reporting the situation to the caller.
 
+These reports will be logged via the trace2 facility. See the "error"
+event in link:api-trace2.txt[trace2 API].
+
 Customizable error handlers
 ---------------------------
 
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index c65ffafc485..3f52f981a2d 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -465,7 +465,7 @@ completed.)
 ------------
 
 `"error"`::
-	This event is emitted when one of the `error()`, `die()`,
+	This event is emitted when one of the `BUG()`, `error()`, `die()`,
 	`warning()`, or `usage()` functions are called.
 +
 ------------
-- 
2.31.1.445.g91d8e479b0a

