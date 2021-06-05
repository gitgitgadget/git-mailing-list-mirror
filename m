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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB5AC4743E
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371AA61261
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 01:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFEBaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFEBaI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 21:30:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F884C061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 18:28:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f17so6342881wmf.2
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=JLlhQoEy9So11Amo3g12a/AGIv6L+VzqigZfGgKunFTwhqMQ++r09kTMUIH/h4X4aS
         E2pieqSRu3O000hCNiEuXYSW0QHSV5Q4Ea0l1J7pfbrccVhEk8xgMsqp5G1mL5eYQFoD
         fD1Dv2F/IZPmRsR3+/HvBXkBufRiRKOo2m2iEpZNa1h7A1QSM3tKTfPVbW1KDSjaTb+Z
         DbRUQwU3z1LxqOs9XgGCESyhw6uezc9qRKMssq6xWC9iYq43Shvax4O444obtjtlTwZP
         FMU2j8F8/5O99XIwa+icXSbLPh3ut3Bm8uqmxhrOshfHF82N2y8WHrX0kgAAcHqQgNFJ
         YsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WaNi0PNToLyqrzeralRfEUb73qsmawlAv79BHtK3meU=;
        b=DBN+H3zYxNy4NZEZH570u57Wb85F0QWhbB7NvkMh4xWPv/aZaSU1uaiCs7fwd5sTmQ
         STF79rOMP9M7NrmbDuN0E+izGcmBSwFyI3wzwbJ6y521s9cH+TxTeYGczTSw/xcg351j
         keJyf6q6Bbr1gs9i9PPShetXvkdRj59L+jLlyn6Y5SYgPlM7fZFUhWJiL8Aw7WK1QkN7
         Ce6mXQdes7UuejT5D4EOXNKXPB5wW0IibjWd1gOvfRwWCTk3lSc29BbJN43nq2PeSxkN
         evk2Hqv1nWNhWEDSu+gDhyDPjRie+nS/xT0hTiPa6YXRhaGsI7oUhgmTPohgvoo9Je8h
         Mi/g==
X-Gm-Message-State: AOAM532kyukkW6CeyDVPf/GTtDDK7cKrgM4kWjsB8s1ddQuZu6EBYE2f
        FjSyXgC2Xd1vMlWkEsSHuiD+6Pyw6es=
X-Google-Smtp-Source: ABdhPJyBNCALc7+cogVc3yZrD9Zxx9iPMux4BY0tV3+AbsUM4fR3XaBRoTChpXtXePKgP0u0ZEO1rg==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr5932004wme.141.1622856487125;
        Fri, 04 Jun 2021 18:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm6149714wri.68.2021.06.04.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:28:06 -0700 (PDT)
Message-Id: <ad9b451d6823f7158a2b58a82682e0c862a1ef6b.1622856485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.969.git.1622856485.gitgitgadget@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Jun 2021 01:28:00 +0000
Subject: [PATCH 1/5] promisor-remote: output trace2 statistics for number of
 objects fetched
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

