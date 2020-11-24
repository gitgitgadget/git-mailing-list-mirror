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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410DC63798
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A0C02087D
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 13:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLkZjJnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgKXNap (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 08:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388060AbgKXNan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 08:30:43 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2AC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:42 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k3so19300485otp.12
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+BoELlIO2Np/7X0XEhnINPzKgRHlCgI89Vir8ImGdC4=;
        b=XLkZjJnQQj8ZD26Ij61HBACOpL8tjiWKRCoTSPMMreEczvMa/+11v81tmA6H0MPiAX
         O4gSzOrRja4diEnw2g3nUP7YayYs+9eyUKPtvZuWR9s7fu0iGfbuEZ2uwopJz38TvJbv
         OUTAc4jK1Bft/jwZoN1/7HsidxF6tjkgY+DzjKHCXX3M3aCcvmzhl5wtMnpDFWveG74A
         F3Hqy31lUwgRuqNb/pv1/zW9W5SYIRA2vpZMbkrGyVnAhEtCTw1zRsfSTc1K+YbPvJzP
         VrF9OnRwNV7GNI5uiGX7Vl+N6HRY1miOgrIrJ25Yr0Ec/SEEjoSKzp9xlX4oSRf2K9DC
         QNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+BoELlIO2Np/7X0XEhnINPzKgRHlCgI89Vir8ImGdC4=;
        b=kpHV55invwv/guQP7knPhPQZd/Og6ji+hWIqG02nenUvjickGziOwdPIhHpxV4rmC8
         kebDPq11CNadTGPBAzs7HpUGyUsS18FeWvLnHOiwW98SMokcl9tCbFRVHZfsfR7Di9SS
         UyMEOznxkhCJy+7fNl9Fb3+Ljtlf6v//BtwL1B3LicBTo+a1bL3eTSufEE0Lm0Gk3fts
         udrt/qz0cR4LUBfY8h7pFmfHYrQgKGziyT562QeZYtlB/sl1lvuBhpE83TJPaiQRWtQR
         Q5D7vaV6/2Bo7IJHUaR0+aIOA14nhnuKJY/AtAy64I12UrQ1Q3IiCKx08DayPONjlulU
         8b8A==
X-Gm-Message-State: AOAM531uSTUdHM3wWlS5vFhiBxLf0kW0VF75IRccVwlzOMGuzNganTri
        AFTVILsKQEiXs1k4CUP+JlgviuMlnj4+rw==
X-Google-Smtp-Source: ABdhPJx57xrQ31qknPW989yFsmFenTbHZZfx9d38olUG+LZ6UpIdAOjsUM2mO7mgohDhW//JordGHg==
X-Received: by 2002:a9d:336:: with SMTP id 51mr3432266otv.29.1606224641400;
        Tue, 24 Nov 2020 05:30:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s193sm9501273oos.21.2020.11.24.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 05:30:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] pull: refactor fast-forward check
Date:   Tue, 24 Nov 2020 07:30:32 -0600
Message-Id: <20201124133037.89949-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133037.89949-1-felipe.contreras@gmail.com>
References: <20201124133037.89949-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This way we will be able to do the check unconditionally (merge or
rebase).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 17aa63cd35..e2de0d4c91 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -906,6 +906,20 @@ static int run_rebase(const struct object_id *curr_head,
 	return ret;
 }
 
+static int get_can_ff(struct object_id *orig_head, struct object_id *orig_merge_head)
+{
+	int ret;
+	struct commit_list *list = NULL;
+	struct commit *merge_head, *head;
+
+	head = lookup_commit_reference(the_repository, orig_head);
+	commit_list_insert(head, &list);
+	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
+	ret = repo_is_descendant_of(the_repository, merge_head, list);
+	free_commit_list(list);
+	return ret;
+}
+
 int cmd_pull(int argc, const char **argv, const char *prefix)
 {
 	const char *repo, **refspecs;
@@ -1016,22 +1030,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
-			struct commit_list *list = NULL;
-			struct commit *merge_head, *head;
-
-			head = lookup_commit_reference(the_repository,
-						       &orig_head);
-			commit_list_insert(head, &list);
-			merge_head = lookup_commit_reference(the_repository,
-							     &merge_heads.oid[0]);
-			if (repo_is_descendant_of(the_repository,
-						  merge_head, list)) {
+			if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
 				/* we can fast-forward this without invoking rebase */
 				opt_ff = "--ff-only";
 				ran_ff = 1;
 				ret = run_merge();
 			}
-			free_commit_list(list);
 		}
 		if (!ran_ff)
 			ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
-- 
2.29.2

