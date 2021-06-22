Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAED9C48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A016261108
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhFVIHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhFVIHA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:07:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D175C061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a11so22501284wrt.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=MiFBgzMzD5zGUTcakBbF6Gptwyx6u4Tncgu3VbOzprib3Ev47nuIBhRHDJ3VB/JVnt
         QjSXgzV2wguLLNdKi10iRjOLNgITYzEgz5f5YfNYvu0pCCDj5O8ryvqrkHxy3IykcsR2
         BfyutSkVNh6TG/MrHZ3VFBOJR1Q+OUKzuuRz5KNQkiZA6Rs3zm70gcRLlmFBm9YrtX0F
         ZXEDhITQJ20udGUAancIiCtixQPCnIx6QKewKtFFW126/lH6xi6hvjtgiBVP546z0IQl
         E/s/H9U0KTaByhd3C5P+JXrC8Bg1q0YfKgWCtBtixJ0Yj/ChagysiRmuEipk5L3bok/g
         oGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=Hp5oPaF8/2jpEHqzc1DYbyM8V7lR7HJxB8g3bLzwWaUBwP7y0XXDRpd8VkDJpRv2WJ
         Zi2UGuYV2u+DEOT2qP5aR5wAvIlEqntNm4Dd9VLZDLScKg53/ZWqGvn+9PKCYhhXhR44
         quSiJ0RTFxp5mLYb4ehHjeo56ngepdNmIzQx77LEZD8dPjH94JljgHoJbNc6BRiGOPHm
         T7vhR3F9y6rMl/97/9rJvlVDMRaKiwhM7QcLM2aPYURoI6+ub7hGH9sd6ReCwiuJUW2x
         JGs12cH2CTi+Z+8/kqj7G43IYuhL/HAXIxoRSsu9h0z1nlXTNhrj+CxPSM3tinwBJNNT
         +UUQ==
X-Gm-Message-State: AOAM531/So6zlWgA6Ee5KSziwOMZQGhJPZtcZx5itPwoIqbSSLInOAOI
        5ztOuu3UTeoOfsN4IdiGbmkjEueD7Dg=
X-Google-Smtp-Source: ABdhPJwpMjPJcf0q6pfb5qAufdF+R2qpHW/z/z9bpUUn3Zw6BfFGfTz7WHbRFUHI9321lPymRcoxOQ==
X-Received: by 2002:adf:b354:: with SMTP id k20mr3056955wrd.136.1624349083784;
        Tue, 22 Jun 2021 01:04:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d4sm1494632wmd.42.2021.06.22.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 01:04:43 -0700 (PDT)
Message-Id: <04f5ebdabe147b6652c5487ad2a440ba7b7389d5.1624349082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
        <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 08:04:37 +0000
Subject: [PATCH v3 1/5] promisor-remote: output trace2 statistics for number
 of objects fetched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 promisor-remote.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index da3f2ca2615e..d465377d7d32 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -12,7 +12,8 @@ void set_repository_format_partial_clone(char *partial_clone)
 	repository_format_partial_clone = xstrdup_or_null(partial_clone);
 }
 
-static int fetch_objects(const char *remote_name,
+static int fetch_objects(struct repository *repo,
+			 const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
 {
@@ -30,6 +31,8 @@ static int fetch_objects(const char *remote_name,
 		die(_("promisor-remote: unable to fork off fetch subprocess"));
 	child_in = xfdopen(child.in, "w");
 
+	trace2_data_intmax("promisor", repo, "fetch_count", oid_nr);
+
 	for (i = 0; i < oid_nr; i++) {
 		if (fputs(oid_to_hex(&oids[i]), child_in) < 0)
 			die_errno(_("promisor-remote: could not write to fetch subprocess"));
@@ -238,7 +241,7 @@ int promisor_remote_get_direct(struct repository *repo,
 	promisor_remote_init();
 
 	for (r = promisors; r; r = r->next) {
-		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
+		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
 			if (remaining_nr == 1)
 				continue;
 			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
-- 
gitgitgadget

