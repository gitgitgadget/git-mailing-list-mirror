Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9378C07E9C
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E1613D3
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhGILJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhGILJF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 07:09:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05541C0613E5
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 04:06:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso8826179wmh.4
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 04:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bl5vpgO0StejHxCXebJzTyc0cDL+doDztpEgk4TVGQ=;
        b=Hse4onRKRI01LP9/nK526DpeZ+7D34BX22EMiByNxG7hNX87hwf+8Hz4zmMJgvIEa3
         HpB9wxfs1S8iPWUx2lHIH5NQ7vEqMgSXs9yF64VoL0/a/EfOb9OlS2ePSOKXrHyfnkW1
         ZrnEPre3YUdgQaM/yDgrui6XiZDwXjxw7EpnbOvuNR4bGXzEAhhGhmb8u72w/ISmTMTw
         V1GHzwnEbFD7b0tKPBRyN/SBfX2qoxfq2TOjw10s57f3FYVlsD8Tg14U+p98shiMX+Sp
         ohrSSM4y9Uz/RZYRUaup+MxHqgm/Kd+olWbyiwJKQ6iD0bk+a+UBzMaPiPsCZmOKhLs1
         mfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bl5vpgO0StejHxCXebJzTyc0cDL+doDztpEgk4TVGQ=;
        b=PdzLyIHcg9wJY4qJ0gYtatjY+RHvbku0ogCKCAIKyiHphh9FzOQu09SHInm1kUVvfH
         2YpSnEKo1QeG7E94AXNCdaNXScgzekC99VV3EOx2MY1a6XP10iP1QLcAZfX8mHUsCx4x
         GyBS4lvCHwCW+SZ5qxSvpOXoXpMi70ofYWXSKoIkhQyhfY9nC5QLpgtpfBB3Bnm0L4xQ
         c47UllUbZ4+rJY0aMetBtePfCKjNkTKM18+XktVQBJ1GiBoIPEv7Lc4BrD43zywMxghM
         xozZLOQGCGNul6HbvQOYjuWjiL9dBE5GEQdSiYceeMkkGtZnr1ZhkVCmdLYsl+GoiveW
         53jQ==
X-Gm-Message-State: AOAM531sITmbBmQNrcoRQ2pZHmesKAeBe69NiIFgZbPXGmWPEx8OXATw
        PwF7yU+AMT8UxwOXYEiX3rZEDR22BArB/A==
X-Google-Smtp-Source: ABdhPJxSu2cQzZpG4y4QPcf3NzvuDY4Xfl3EMbgbV3P/YhDqippWl9I53Z0YEIvlBbc8nnZE2AF70A==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr5634080wml.135.1625828780464;
        Fri, 09 Jul 2021 04:06:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a4sm4978167wru.55.2021.07.09.04.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 04:06:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/5] upload-pack: run is_repository_shallow() before setup_revisions()
Date:   Fri,  9 Jul 2021 13:06:12 +0200
Message-Id: <patch-1.5-8b2872227c5-20210709T105851Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210621T150651Z-avarab@gmail.com> <cover-0.5-00000000000-20210709T105850Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the is_repository_shallow() added in b790e0f67cd (upload-pack:
send shallow info over stdin to pack-objects, 2014-03-11) to above
setup_revisions().

Running is_repository_shallow() before setup_revisions() doesn't
matter now, but in subsequent commits we'll make the code that
followed setup_revisions() happen inside a callback in that
function. This isolated change documents that re-arranging this part
of the code is OK in isolation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df49f656b96..3639d0379ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3774,11 +3774,12 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	setup_revisions(ac, av, &revs, &s_r_opt);
+
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-- 
2.32.0.636.g43e71d69cff

