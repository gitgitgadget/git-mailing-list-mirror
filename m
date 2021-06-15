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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1EC48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAAF60FE4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 22:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFOWn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhFOWn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 18:43:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3529C06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m18so343251wrv.2
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 15:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=ZOJ4BC2IH6ogvS64fDu+FOAgEWITsb0R53daOGCk9cNQ6JnW670l5kPyStqp/T3dA3
         OdSCoAyYFknGbjnzIn1aJpqfo/jDtQqWVB09lBevm2hH7OIPj2DdCjVMawRDr5ILnqDN
         JG12gmSre51Sfz1wUIKCH45E/V9Bk3RxQ6/FyDMoiaFlAgY1WFMi9FA5I9q2IwcUr+LI
         DudZ+DVx6dLCtTxNrPsFLTNlgX7RV/1w2ylGbK7Mee6k44DcI6vtCDv7iXpq133TUzPG
         eVrkC3hrFvT9ehZr4yEnHTQECQET13CWRnH4t3cyonjkFTphHThgfMauJ8c/PCcwc6wR
         hI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=FJfhbvTREOJI62b/RxiFf2W7wrFm2f8poLFQxH4CVib4voYvZItt5KoeA3s5KU2DFN
         KLW9ZH+wiEazbGgC7mAkiFKkuxCuxe5gP23PzFg8B/dkcVL9qYtr3XGcZAsQSeeZYOLa
         mNH3ZtSw6vyecz9Wjr2/t3rK5ci6qAaWjOZ0QDMGhC2IGbJ+PL8Wmpx5oo6jZni7jYJH
         WuI7fI5hSup48lp8pGs+h1xq3/JV2+Gz1Lv8J1440rjntOsiqLdJ38mEdIM57axgvZGi
         DfEtjFy19F4omCErUAPp3slYlMHlMbt8qe7wF0ZoWGYYLuEqkSMOcEhYhcR4c0zU54p4
         PZFQ==
X-Gm-Message-State: AOAM532k9/N90tRjHuz7rVt6lGdhVCNOV5JYjxWQ4YS68DLI7HmCvYrJ
        CwfsyifJjrs70Rt3ke3LQ1yWR3fscwY=
X-Google-Smtp-Source: ABdhPJzgvkyek47jPNAxLvWXkyRdH53IB+bTAvv06tiHU+9tmqmJdQNN5X0enT3ArSg4hI8MomhNOQ==
X-Received: by 2002:a5d:648a:: with SMTP id o10mr1546611wri.274.1623796909684;
        Tue, 15 Jun 2021 15:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm218226wrx.59.2021.06.15.15.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:41:49 -0700 (PDT)
Message-Id: <04f5ebdabe147b6652c5487ad2a440ba7b7389d5.1623796907.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
        <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 22:41:42 +0000
Subject: [PATCH v2 1/5] promisor-remote: output trace2 statistics for number
 of objects fetched
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
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

