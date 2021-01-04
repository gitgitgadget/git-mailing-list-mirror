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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB670C43332
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDB22184D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 03:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbhADDKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 22:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbhADDKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 22:10:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF27C0617A0
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 19:09:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a12so30752869wrv.8
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 19:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=RWzNeO0RUBCbiAHqidiz31YNJN86Cus3A4MuiXII+/s=;
        b=eKuHLEIRFCc5SragLNPXI62mZUc6Z2tQcCyH5C95C9KlnFXYJZqZkF3gb4Ds738Tv6
         Sf85CK4DegXfMAtS+KwCnhDfKKUzyFZMoeEkrBr27DVqOUP0HSESaM7NUKApr8j+Tr9v
         zt+syXKhTfv38hqJEjsQxW1XmgEjREj6MHnGggDw14wX0/ENeK34qERu+9UwMkMUEgWk
         C0CkRbL4sRBbNSXhZxMsris6gRzQf9IeqtbRw1RiS/lhz2y77U/0mXUVGANWCfwnroPv
         3cDx9Hcj8z4ia4+QHE040ryTNWDjAAxh4Z38D2Uo9C4DNe1arAcW9mxW/43D8uTEMrBJ
         xaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=RWzNeO0RUBCbiAHqidiz31YNJN86Cus3A4MuiXII+/s=;
        b=huOb2sdlqtpMx6R/ZeGsaDDmkKcROGaBq1g1KNeayHAje0rdh2BMxv/V+jDzZ50FVi
         sCR8bL//1pVhg90aLTQzmz/fReC5qYyqsPrfIkR8H/SVTPrMbtZWVELrUzCmW8/n4Iga
         ouj/BXF9CU7v9EVUw1yu9Wf7Z4cbCZYmlM9RLfEOxUScrU3GNXBi4F1X00xyiOICQd0q
         wyifdTg/ERfMKZn4weqeN9GXrg7eW4qKkJexfjHsI/h7rO9St0kLLz9gvb38PkmK/NmX
         SOrVZmjXk1U8iKFbs56pnm5aNG6Or4CcoEOeLx0suhLQAvw5ucHmRdd5aXkDKbKCXwqS
         BgXA==
X-Gm-Message-State: AOAM5326Q5rqVtRq7NrEyM1oxlG06DNqL0qze0xm5rxpzOQTpwKXYVHy
        bcPJg1GRBfVF8nOvFBFNEGz2PKdmwy0=
X-Google-Smtp-Source: ABdhPJyxrBIPuB7HGoMSgR3Md0tiKYNTSEQTZ6Ljs0tNf3UOUiMX98gzMXwgnw+4Tp56/pNwkypxKA==
X-Received: by 2002:adf:e348:: with SMTP id n8mr79153975wrj.148.1609729767649;
        Sun, 03 Jan 2021 19:09:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm86588934wrq.1.2021.01.03.19.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 19:09:27 -0800 (PST)
Message-Id: <72edd7bb4278a8ce6823752a3142b14a05bbea58.1609729758.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jan 2021 03:09:18 +0000
Subject: [PATCH v2 9/9] cache-tree: speed up consecutive path comparisons
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change reduced time spent in strlen() while comparing
consecutive paths in verify_cache(), but we can do better. The
conditional checks the existence of a directory separator at the correct
location, but only after doing a string comparison. Swap the order to be
logically equivalent but perform fewer string comparisons.

To test the effect on performance, I used a repository with over three
million paths in the index. I then ran the following command on repeat:

  git -c index.threads=1 commit --amend --allow-empty --no-edit

Here are the measurements over 10 runs after a 5-run warmup:

  Benchmark #1: v2.30.0
    Time (mean ± σ):     854.5 ms ±  18.2 ms
    Range (min … max):   825.0 ms … 892.8 ms

  Benchmark #2: Previous change
    Time (mean ± σ):     833.2 ms ±  10.3 ms
    Range (min … max):   815.8 ms … 849.7 ms

  Benchmark #3: This change
    Time (mean ± σ):     815.5 ms ±  18.1 ms
    Range (min … max):   795.4 ms … 849.5 ms

This change is 2% faster than the previous change and 5% faster than
v2.30.0.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 4274de75bac..3f1a8d4f1b7 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -191,8 +191,8 @@ static int verify_cache(struct cache_entry **cache,
 		const char *next_name = next_ce->name;
 		int this_len = ce_namelen(this_ce);
 		if (this_len < ce_namelen(next_ce) &&
-		    strncmp(this_name, next_name, this_len) == 0 &&
-		    next_name[this_len] == '/') {
+		    next_name[this_len] == '/' &&
+		    strncmp(this_name, next_name, this_len) == 0) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
-- 
gitgitgadget
