Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62DCC4320A
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE29660F10
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhHDF33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhHDF3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 01:29:18 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA6C0617A0
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 22:29:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so710652wmq.2
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 22:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=88u1gqyIE4EdznEVgM37Y1fW50MvyDeUEsu/DYjSZE0=;
        b=WcejsJTL7XdnMkuPKXeUC3O+TtMclKjtVUHfci4/PvhMdzN4HVY7aU164s4LwTfsTI
         D6CkLKNBRI40vlwtsGG6k15Nw3RWW8fTSBVzRtqJlOb5ShIzbOIBOSrIOObNIwc0jdLO
         jLu01ySa2Tj5KVqBCIC0ytwOc9rt9AH/l/YzTuUmPsiLrPfhahpcTvt2ydI/kdrrdOLX
         hinhYaBROrc2jBUjh6xASPjf5t8PtQiOaZFn/HTokL4CngyE4Og3wUamXmeQlGq0aAs4
         mJ9ZOELLF/2rfqvf81CLUYz/s94n+XQcwst+foGA5liUURu06ELrTNsoMI063Y/Nx8Hm
         sAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=88u1gqyIE4EdznEVgM37Y1fW50MvyDeUEsu/DYjSZE0=;
        b=O6mLPU1rKDEUDQmVf175nCk8cLyxbH2hv+4kY/U27rhMrjq5b7OGKlCFag55vMcuru
         iaIN24yAg7Qd4GgrQ5PT99tt8gB2tjgFBYroFqDmnRXJfOItFZlxH5qmstZfJ/pswpZo
         1qiWq6UV098AquDnx9jEh9OSpURH3jADIlzUldNpAMHarffxsx1asgP9LtKuvatue4Ma
         v/NUoJmGCjaxODaHE5svEcq5O2jqNpK3YXKi4GgT1ROn1ML2ePui7CPepRTnQab6vaiX
         JfEDqn/ijAgdIj/VnUwdKWZGX6KCsKb29Kj3W9ACRC7Cd1XC35dQklKnqRfuAP9rVYlm
         jveg==
X-Gm-Message-State: AOAM530CbM0mGOnoDVwpAJU3+K0W0aSFqL6qocu5jXSRLz61gFuw7jvl
        W+mV63HkQYTs9x8R3Amphsfohnu7pkY=
X-Google-Smtp-Source: ABdhPJznxNmOpZe7byOSkT1fUm5GcFYX5GB0Uv5BSkehL+geTkVDlugYOJlLzTalxBFKO3RHax6dbg==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr7930849wml.187.1628054943827;
        Tue, 03 Aug 2021 22:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m27sm1043737wrh.34.2021.08.03.22.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:29:03 -0700 (PDT)
Message-Id: <4a78ac53424525d7099867d5a4377b8afb9bf18f.1628054936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
        <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 05:28:55 +0000
Subject: [PATCH v2 10/10] Update error message and code comment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There were two locations in the code that referred to 'merge-recursive'
but which were also applicable to 'merge-ort'.  Update them to more
general wording.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 2 +-
 sequencer.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index a8a843b1f54..d7b14bf4a7f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -738,7 +738,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		for (x = 0; x < xopts_nr; x++)
 			if (parse_merge_opt(&o, xopts[x]))
-				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
+				die(_("unknown strategy option: -X%s"), xopts[x]);
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..a4e5c43fcf2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2065,7 +2065,7 @@ static int do_pick_commit(struct repository *r,
 		/*
 		 * We do not intend to commit immediately.  We just want to
 		 * merge the differences in, so let's compute the tree
-		 * that represents the "current" state for merge-recursive
+		 * that represents the "current" state for the merge machinery
 		 * to work on.
 		 */
 		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
-- 
gitgitgadget
