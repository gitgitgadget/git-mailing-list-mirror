Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B955EC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1A460FEF
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhDMJI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhDMJIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:08:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFDC06138C
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h10so18474744edt.13
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7nlRxHxUs16/8/WENVju9TsSyJ2A3dzqcqGwnf+r6s=;
        b=rvjMgvLdwbuztsMmYdytUvLDKTMZP3O16QZW2N2s0otMwykGoIbietiPnrMibGecfR
         7Y/GFCxLc9lOQB+moOh6EkplPazVnqewdeuJwOVVOVRJVrO0Ph3/snuunizEbs1+L6eO
         26b3hrvuWLDLKd1BsKFkzYk3+Q0MZHK3tEuLRngR1BH76h/YWaIIJrfPXH6l1dEgWOX9
         l6TwjDh0J8S/YnpwfW5RaiNBfLWsTVagiWGDhl6FABofBmG8DVK8D9pXg2yJJxS+16lf
         /NAy/TyZeDoELSOtxRVWsqGJDOydc3yUIu72TzvY003xDwWoKx9sJXUyQfHcRcQoZi8q
         XMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7nlRxHxUs16/8/WENVju9TsSyJ2A3dzqcqGwnf+r6s=;
        b=q/Zk+3sBya3u+fEjf/cp7OUj7+O8pB9iuRnWPcOT8bi18eViuYYHclI9HVuyCVv0WN
         OZG90Z9odFg0kQzM1HlWnkZwUKoOOVY9if2L9RQi7XXYimIOzDi/WZe+vNBP5S4wlRpB
         kLrjqH7wQaibJ69K2O7H0DEG8uw5LzRo3v2m2D4Lf9y+g8nIssG8QxzWMB5Gdj87bV6R
         dEpl3G8pFD6/YuvLxSP+alo33pgsW8YZyKEZEJTVNUcbZK//E4ZO4Ym0V9bHxLdt2w9w
         fstMs80bbVThkuaT+3DGpJF9dmw9UVNGs0sLUh4kDelHd5p//uSGppxBdYvWodndL7R8
         z6/w==
X-Gm-Message-State: AOAM533gIWacJunWuwjwJ0TESwLi7wVmBOnDt9inHZCWqnNF/yDwoGU/
        VhZKSXfxGRy5ZbmEg80a8oEay2riuR63LQ==
X-Google-Smtp-Source: ABdhPJwIjO8xp/dvf9JomOm42+Q8PaW8sYT3HuqxADmdxewi3oSE1DP0agTbTwF/5mswjs1cax6W2g==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr33811289edd.116.1618304912670;
        Tue, 13 Apr 2021 02:08:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 28sm8918318edw.82.2021.04.13.02.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:08:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] api docs: document that BUG() emits a trace2 error event
Date:   Tue, 13 Apr 2021 11:08:21 +0200
Message-Id: <patch-3.3-982f72345f1-20210413T090603Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com> <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
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
2.31.1.645.g989d83ea6a6

