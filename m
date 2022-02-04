Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E1C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 01:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353229AbiBDBKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 20:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiBDBKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 20:10:33 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B6CC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 17:10:33 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v14-20020a170902e8ce00b0014b48e8e498so2180945plg.2
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 17:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3XWsXh6s8rZcIH0Yoy9ZwNRrsd0Df6UoSxtRuKAjcWw=;
        b=CKi1H+EUGlY/HTQ4ZrKkJNEWHC54yENvJs2T99H3RX9uGeYRthv/5TApdaiWetH+xF
         ijTvQ8LZRhQ4Yw5bHIDZWg8RY3hIrFri8isXT40jYWCFVECBlGzi3Y2wWXHOyyW8GJGy
         d8h8g4QAxlC04krRKO5rFPYunjGlVQBmPc7ViToW2tePDDUtMRJJ/bHXQcl3rmTvn2/m
         JvP7vL0juKwdHbmRooEwaMyy7FVgSYU55bQVMRh8OnEUbUgL8HxNvmi0/keiPkItpukO
         W/POeyy3kCObLzs8i96Cn3LrmKvVzZliYCb+wTE8YgV7+XaR8fL0gQeczF2HIoV/DBZz
         yERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3XWsXh6s8rZcIH0Yoy9ZwNRrsd0Df6UoSxtRuKAjcWw=;
        b=SSnv5YMGaQIfx/Nk84w31AdFlEleelVe+edjw8XYXRXmQQBByx8OUT72PSSlxEKG+f
         pPAnYdHcmRiiX5I09JR2DT8btxEy7wYWvHtF9TveMzWCttobTbrhwEY55MrGppwENBxA
         gV7yZfyYzrBXVSaMBF1zh4e6yXXamU+/lpsX4AF6Ws94vxH15+INn7fPv9QXike0elEW
         esVJBQ3+Tl79a1Cyu4E3do3hMqrh9uczvuT11TXvq2qAxCmQzQgI1hRPDnyy0XVsZhSj
         uexmHTpqzmbraYCLubXd6us2WrYE0xa1EIPi6NmraXNWQZP4HkXvgYNjpxELN1OB1MvQ
         Gy/g==
X-Gm-Message-State: AOAM532wLD3x6EJAB7JYcfM1OpOO5kG9vbNl0hW44sXxoAvwc5hTl+7H
        LVoaLiTs8/J9qK6pEF/fisFjBGXF8p6Wt4BHRpc97IvOG5dOdoVpwCczeQ6HsJf6+vuW+l5/eDt
        I+KwrwcMpCfMpaZ6FEm1w6yAgFOqSvg9/DMVQL6dqBtzbJ8ESNtPMk7F+2OPQG8k=
X-Google-Smtp-Source: ABdhPJwFD29AXtC97m0FqtlDW2XvwLuCxW2hesIgMR1XCmaheocSyL52tNqgdB+rUapHT6cMWhs+Zrn1yBfOdQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:244e:: with SMTP id
 l14mr528606pls.148.1643937032618; Thu, 03 Feb 2022 17:10:32 -0800 (PST)
Date:   Thu, 03 Feb 2022 17:10:21 -0800
In-Reply-To: <20220129000446.99261-6-chooglen@google.com>
Message-Id: <kl6lwnibzbb6.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220124204442.39353-1-chooglen@google.com> <20220129000446.99261-1-chooglen@google.com>
 <20220129000446.99261-6-chooglen@google.com>
Subject: Re: [PATCH v8 5/6] branch: add --recurse-submodules option for branch creation
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I tested this series some more and found a silly bug.
Let me know if I should just send v9 instead.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

Subject: [PATCH] submodule-config.c: remove accidental pointer reuse

List entries allocated by traverse_tree_submodules() are sharing the
.name_entry pointer, but each of them needs their own pointer. Fix this.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule-config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule-config.c b/submodule-config.c
index 24b8d1a700..c9f54bc72d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -757,7 +757,8 @@ static void traverse_tree_submodules(struct repository *r,
 		if (S_ISGITLINK(name_entry->mode) &&
 		    is_tree_submodule_active(r, root_tree, tree_path)) {
 			st_entry = xmalloc(sizeof(*st_entry));
-			st_entry->name_entry = name_entry;
+			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
+			*st_entry->name_entry = *name_entry;
 			st_entry->submodule =
 				submodule_from_path(r, root_tree, tree_path);
 			st_entry->repo = xmalloc(sizeof(*st_entry->repo));
-- 
2.35.0.263.gb82422642f-goog
