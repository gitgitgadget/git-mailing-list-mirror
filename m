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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD3C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A49061260
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhEaTeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhEaTed (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C523C061760
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so11969112otp.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rM4o5LYGmIaS5Qh2mpF1UAeKj6J8HLsjfYpcVhBPbk=;
        b=MqR7Jxu7/YT2RjWDYq3D7LOHL3b55g4HXUXOUA6TPBTnPxedacDVfOjR7sBPzc/Bod
         IvmlJ1MVwUMqN90cvrKeeH8z+7xvGyUq3uAjSDB8k/2LGxVJabweyLNEaz/iWq3jGoXl
         znyjFPrvr5luCWxHwPEwwe43vAJzT3PPStOzeDDyUJjk7hSZnVUW57ViRIcLl3edWP4V
         XZAFLPG8FyDlE7GD9qHAiD06AAVXPP9U6wN+4zeyo+yvkbjuMz+im291nM1r7hAIqYJE
         KEZjk1szYv96q47gflyHzfijpSUMH3gw3SEnRNB8JKpTmC21HHjZz5F1sD/HXLe6ELEW
         gyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rM4o5LYGmIaS5Qh2mpF1UAeKj6J8HLsjfYpcVhBPbk=;
        b=LkRNSbgP7VoWWpVH2AbXzFGNEVj8GKns4BriCVKsMv4LLf+UhDA3sk+rNj/1gq2K7Y
         9sjY3J/8/+O+F5WtyRW53dEoJi1o4m6b0zWfkjK1sIvKP0qs66/a1zaT9EzcmMPVdh8B
         6MyFbBOP6EL3D9NZmomIb6Q3CGin+BJQZnR3foo1Al3H0VjrP0fDfVOZJeQUc8vmZVIT
         EDw7i4z5KCsdt4LnrqKy0iKWB1oWYCjqzA9GQxFVHVnMbzOvwI/M2F6ClxM1w+PBndm5
         EEz41RVAdiE8Mi2o66ilSWU80pqp/WYuOliFKXpVvWCxVUROcBZBhfH6s8pIjFWnKs3K
         KaPA==
X-Gm-Message-State: AOAM532mUgjqb76xtc+nVr2+02lsKTziMeSOmTef1Ejm0f7vokVhI9yU
        tPyfjRSoGQpqcV22BaEgbx0RdH2fqxkrnA==
X-Google-Smtp-Source: ABdhPJyc0VY9etvLfrjNHl6aSQeN0VeL9LdAY4v190VuN9CJDUiPwHCUzXTjS8tYIa3lxPpVxNSwPQ==
X-Received: by 2002:a9d:7a56:: with SMTP id z22mr18423765otm.47.1622489572560;
        Mon, 31 May 2021 12:32:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id 1sm1784854otg.40.2021.05.31.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 7/7] doc: push: explain default=simple correctly
Date:   Mon, 31 May 2021 14:32:37 -0500
Message-Id: <20210531193237.216726-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the code has been simplified and it's clear what it's
actually doing, update the documentation to reflect that.

Namely; the simple mode only barfs when working on a centralized
workflow, and there's no configured upstream branch with the same name.

Cc: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config/push.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index f2667b2689..632033638c 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -24,15 +24,14 @@ push.default::
 
 * `tracking` - This is a deprecated synonym for `upstream`.
 
-* `simple` - in centralized workflow, work like `upstream` with an
-  added safety to refuse to push if the upstream branch's name is
-  different from the local one.
+* `simple` - pushes the current branch with the same name on the remote.
 +
-When pushing to a remote that is different from the remote you normally
-pull from, work as `current`.  This is the safest option and is suited
-for beginners.
+If you are working on a centralized workflow (pushing to the same repository you
+pull from, which is typically `origin`), then you need to configure an upstream
+branch with the same name.
 +
-This mode has become the default in Git 2.0.
+This mode is the default since Git 2.0, and is the safest option suited for
+beginners.
 
 * `matching` - push all branches having the same name on both ends.
   This makes the repository you are pushing to remember the set of
-- 
2.32.0.rc0

