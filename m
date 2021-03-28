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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E01DC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3216196C
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhC1NQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1NP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:15:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44429C0613B2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso5324821wmi.0
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2L27Q6bYosgxfkAcwT1/u8U4X6FMWT9xBYDT6nNOlck=;
        b=M0dGFtIaNY0FiyPAxx/esPeXhKMZU/eopVWJskNA4YFpyEImprvldU38JvPeC9GdUb
         vn+n+kv4REbdBk6gF6GNN1EAfez8a07tF+JoJ3Nr1TVCTxAMuewJdTbc9aeLrnGD5Htr
         bdien+uq4OUXeONjdm2Vyy77x+thPMHxjYRmXuQzh3hWLJ0Ph9k4yEaQ7SdaUdPg6C+f
         SvF+k+TGFeyhvbBit0iRaCePE4WsCO0CYLVkCFez64HXn3Djz9J5/A58rVrexGOQyEwe
         /yEiXmmTas60OQrjyJ8UjkaDvq92TGwZcvfLNxJiT3R5wk1cEdamLquwgnUM7fyYOauR
         mWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2L27Q6bYosgxfkAcwT1/u8U4X6FMWT9xBYDT6nNOlck=;
        b=iRbCV9OmwVXhQ9iYesT/wgdDZGhz7EpVxP8DSeH6k7mH5NSdukpNePAMo66oKFS9LQ
         XCr2y6qYPWfZgYn8iByM8pDzHMfrqUsklg7DJ963xcSVvUMLUxoahb/1hSG9MHtDu9sx
         77UUhKWgDCUjEDibDYgUIgccAOQEAeEivpJCOWan1ARbRY0kiyxBeFkI7TtCF3UwY/p7
         Ml1fvoX0IvbphtDYoW4loKWbn6V8t9RU1zIyNAzMPeGQlFOSSZU11OaqLMJx/AZJbMs2
         q5MFxpDqr6nXqr9LBfKaHMCbcMVGj9NKVzFsM0Q7mAbcq6KxIoXZ8WxVS6M6c+LuOOox
         qA8w==
X-Gm-Message-State: AOAM532t0lqca8zzFEige3ddmmgQTgBePjQboFHU/YQff+KvETI2kdKn
        gTiBzkpYoi6kO8kWnealJQGu/qDEuiLGrw==
X-Google-Smtp-Source: ABdhPJz6rX2uLC1xzWviF0POYv8WcrHOKXzc22u8YRkKWNv0TVnpJeVg1E3VY7teazWPsVEZuwtxUA==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr20291253wmc.119.1616937355691;
        Sun, 28 Mar 2021 06:15:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/19] fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
Date:   Sun, 28 Mar 2021 15:15:34 +0200
Message-Id: <patch-02.20-b17c982293e-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the definitions of FSCK_OPTIONS_{DEFAULT,STRICT} to use
designated initializers. This allows us to omit those fields that
aren't initialized to zero or NULL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsck.h b/fsck.h
index f70d11c5594..73e8b9f3e4e 100644
--- a/fsck.h
+++ b/fsck.h
@@ -43,8 +43,14 @@ struct fsck_options {
 	kh_oid_map_t *object_names;
 };
 
-#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT }
-#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT }
+#define FSCK_OPTIONS_DEFAULT { \
+	.skiplist = OIDSET_INIT, \
+	.error_func = fsck_error_function \
+}
+#define FSCK_OPTIONS_STRICT { \
+	.strict = 1, \
+	.error_func = fsck_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.31.1.445.g087790d4945

