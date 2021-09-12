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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20295C433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CC1610A3
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhILARY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhILARW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95203C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d21so786443wra.12
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkqemqG3cBjPTjtLRJ208voEVSZCzeHv7kV3xWaedt8=;
        b=lm7I+LmzZjZwltXJEcQGndeeSn4V3aiipht7TYDaOBu8/GH2xJUaSnYbb9KzaY7eSZ
         b53d6FYya4lTP9Yxdsd2wpuZ89Bb4JCel4Q7RD5mDmFnQAoxC974oMHVphOWXCQMxjJn
         LO3bLiOHWO21T88HZYrFg2itlgGQuXASDOZl6+PNRhMu5aCXeZOtQStY3dwuXmYT06F+
         6xSMWHk2FsdZFe+URNySsJMKknvlFPvrkvyYVT8sYZx8iH02P/o4DAvg8LL6UhldAm5+
         JLqpjO72IFyFiKYJEi9XDejex+BAcKdCFxDyVFi0iYaSOrPi31dJbkWY6W5Z56VxOfvj
         ZRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkqemqG3cBjPTjtLRJ208voEVSZCzeHv7kV3xWaedt8=;
        b=WeUMa7V4vZJt4SMc1lyduCj/P7W9I3hhu11wIugIAOhR2M4HrSBE9JUvmLu5MmmHLs
         RUZVJjI5/KCBTGDAJS+Fww15hMPTfx2+QKy7yZCFj7Wq7qao7o83EklgbBTkaraH6kPS
         G7PCMCjhJrrb+ITXXjsYDIcznzucspAO5sOOEeS0HGgBCqzEfxHTdRSxuSXc63Ca0GcO
         Z21jng7HAfAQWViRG7T1mYDQmvPCx8YTSvzWk4GnTBVyRf4razIjeb+oqIBKhLK3a3wf
         ZY+Zas0rg/sdmP7taTZ+SYKbmw4+lo5OhyeqUe1D98NK3bchk2P9Bo9vUqXjb/5N/BhT
         lfRw==
X-Gm-Message-State: AOAM532DwuET0AXkHS8yn53sz98qrO/LwyZMh9uoc8xABPHVPtNPSVdi
        0EroVlMcYkssBvTgLnEPyMNhx4SmSxq89g==
X-Google-Smtp-Source: ABdhPJzOsRY02p2uXL8Qx9wt6qZ6JCH3GzrX677tuXussL++sDBZDdfrvEElrZh77bFNVlQ7cZ0iUA==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr5087570wru.414.1631405766871;
        Sat, 11 Sep 2021 17:16:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] pack-objects: pass "struct strvec *" instead of int/char ** pair
Date:   Sun, 12 Sep 2021 02:15:50 +0200
Message-Id: <patch-v2-2.7-7f59a58ed97-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit, prepare for the "nr" member of "struct
strvec" changing from an "int" to a "size_t".

In this case we end up passing the "nr" to setup_revisions(), which
expects to take an argc/argv pair passed to main(), so we can't change
its type.

But we can defer the conversion until that point. Let's continue to
pass the "struct strvec *" down into instead of "unwrapping" it in
cases where the only source of the "int/char **" pair is a "struct
strvec".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/pack-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ec8503563a6..1902c0b6776 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3701,7 +3701,7 @@ static void mark_bitmap_preferred_tips(void)
 	}
 }
 
-static void get_object_list(int ac, const char **av)
+static void get_object_list(struct strvec *rp)
 {
 	struct rev_info revs;
 	struct setup_revision_opt s_r_opt = {
@@ -3713,7 +3713,7 @@ static void get_object_list(int ac, const char **av)
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, &s_r_opt);
+	setup_revisions(rp->nr, rp->v, &revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
@@ -4138,7 +4138,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	} else if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
-		get_object_list(rp.nr, rp.v);
+		get_object_list(&rp);
 		strvec_clear(&rp);
 	}
 	cleanup_preferred_base();
-- 
2.33.0.998.ga4d44345d43

