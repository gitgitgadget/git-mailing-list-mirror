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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F5C43462
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D899C610A2
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 17:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhDJRRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 13:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhDJRRh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 13:17:37 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DDBC06138C
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a1so10205463ljp.2
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fphA7Cp+Mv/DrXHrgICQamnofaFLQMa9hKIvHULv1cI=;
        b=NJ4WIVNHNZFZtJ0GIIU/UhFiBXw3sRpJoQNW/DjCF6UlCwI1a6np04sX8A1gNBs6kT
         ZfzoZHAlpnLrSWWrn/w229qdXqrqvOgtMmGEEbRjX8+UqdjbEx0qKt3h4WUAgYbeEzr7
         p97FXUi0ndzeiA3yh+7NRAN21tHR1F8hUkkr5UjRnhtZvUskvcNa+AuIc7wxKouxnhiz
         aIQaEfdWhRMxj+LuU7GpeEbRcaCAAoKfl0FXecc1zMxw0fsfIjylkWzQWKMU+IRTP+Ol
         iF1SdaDo5EmuDwcMk+a4a38ejuqpWixiQ2bT9Rh4wJCAQ9/IqpT0WiIstAXM16mVMfYD
         SibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fphA7Cp+Mv/DrXHrgICQamnofaFLQMa9hKIvHULv1cI=;
        b=icdbi7x+v5Mvd4/Nv88L3Jan8JcfezUYLqGrVCkxqLcmvGtfJvD8Ui4cwhBy36goO1
         HFJfFKzuaVDsL1mooK0cIQjDCd/3c7Ymryu8Yw2gv7IzfPPwUe0mtovRIYVFspegdIg4
         hid41gIPVNOr+dbD6yz5vFeaV5i4bg2772qMNodwE6MK0IDnteKI2GAFwQnOTLNH3nRr
         L9tO6vpjej6/gMtJQALJJOxxsB/9yn8NESJI3bAmJ6rZLZlUeu8Jg3K8jcje+e537FlX
         M2zod0bcLZoujkcEv5OIkQyZmIbSpziNpjoymoqzf8NooBo97f5Ih6HvsoiF5dvMCxuf
         fqqQ==
X-Gm-Message-State: AOAM532q0TKS+OQbQtxyQ7YhVft3Rbmo6v7lZ2/ZLRNCXJI9YNLWfd3r
        iZR87bggNpsWgqKzCy3m2hfzT3KCiF0=
X-Google-Smtp-Source: ABdhPJyzdgHK/bPfYIOh9+OIfmNUtnPGvmqD5b6QBX7m7Ja9Y0gib4bOobGqfIPlIBCcgPaThpJteQ==
X-Received: by 2002:a2e:9184:: with SMTP id f4mr5264803ljg.144.1618075040403;
        Sat, 10 Apr 2021 10:17:20 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z7sm1336543ljo.64.2021.04.10.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:17:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v1 3/5] diff-merges: adapt -m to enable default diff format
Date:   Sat, 10 Apr 2021 20:16:55 +0300
Message-Id: <20210410171657.20159-4-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210410171657.20159-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210410171657.20159-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let -m option (and --diff-merges=m) enable the default format instead
of "separate", to be able to tune it with log.diffMerges option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 diff-merges.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff-merges.c b/diff-merges.c
index 9918b6ac55e4..a02f39828336 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -34,10 +34,10 @@ static void set_m(struct rev_info *revs)
 {
 	/*
 	 * To "diff-index", "-m" means "match missing", and to the "log"
-	 * family of commands, it means "show full diff for merges". Set
+	 * family of commands, it means "show default diff for merges". Set
 	 * both fields appropriately.
 	 */
-	set_separate(revs);
+	set_to_default(revs);
 	revs->match_missing = 1;
 }
 
@@ -61,13 +61,13 @@ static diff_merges_setup_func_t func_by_opt(const char *optarg)
 		return suppress;
 	if (!strcmp(optarg, "1") || !strcmp(optarg, "first-parent"))
 		return set_first_parent;
-	else if (!strcmp(optarg, "m") || !strcmp(optarg, "separate"))
+	else if (!strcmp(optarg, "separate"))
 		return set_separate;
 	else if (!strcmp(optarg, "c") || !strcmp(optarg, "combined"))
 		return set_combined;
 	else if (!strcmp(optarg, "cc") || !strcmp(optarg, "dense-combined"))
 		return set_dense_combined;
-	else if (!strcmp(optarg, "default"))
+	else if (!strcmp(optarg, "m") || !strcmp(optarg, "default"))
 		return set_to_default;
 	return NULL;
 }
-- 
2.25.1

