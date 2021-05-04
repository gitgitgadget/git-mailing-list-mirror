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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB74C43461
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 590AF61168
	for <git@archiver.kernel.org>; Tue,  4 May 2021 02:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEDCNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 22:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhEDCNU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 22:13:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF89C061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 19:12:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so7599892wrr.2
        for <git@vger.kernel.org>; Mon, 03 May 2021 19:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xXgdDHvUd75yXjM8blIM7wuwHKtZQ9KdEC4eYenxuok=;
        b=n5BlTY+KZFRf66WaNeTe+igI0CJB1vNqjZ94avX7RZrhgPVHmghPU7iDjal56zNr5l
         ec0lrDFtxDBKMugFQrNe/GMmLhsgSlkMlUhidUpWC79AETRBabqeM0FdfFFShLmtLpd+
         vulm0Qo6VRhPQ1E00Kyc3d4bCuECbBXe8J86tQ0nXH6N0ToulJ7LGDMC3J/0E9xapjoC
         OP89FKpf1tHxAzLM3jH7AZCGjWB3DA9bUZRoubv4mFS3iJZ/FkLiKDMEjFN4DJGGAmJc
         IWz8Oxb/p64X4B9lxe1Rdy5yohZj3m40N1a5YuyTA4vJlHrbtStWGjVQW4Ky4GEo6C/N
         J2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xXgdDHvUd75yXjM8blIM7wuwHKtZQ9KdEC4eYenxuok=;
        b=o2X5BYBPb7k+ty7qx1luU+v8kmhkUafzd86MXV9ZM6Hg3iTFDfS+x4xxK/2o2CVv+L
         PKOEYMIMr6Ytjbmw3VbFe1pmUjBxAw83BH6aWUeSx4Z4bt41RbtSv5NG7mgysfyw68Sc
         L+ELLPbyhP/99+lNeKo6oT8SEwwOEWAD6szQuzVvT0SjIvEb9uTfwYsWvYck9jsrqs65
         FqD9Gm08h4vYAWtoiJUnjNXefGSoZMeo5EL3MmMqb6md/mi8YYGmVeeeppHWC215t9pB
         1XaDlojYTQh7t1o+Mfxwby38nZrI/h9bVHMml9PzNWDcg9mvH8tkGcRJEaG01TMon9uJ
         cmog==
X-Gm-Message-State: AOAM530SAgwGL5aKaqpZ7shO1t3+9PfoHXnmGDNmCEqcOxtF5sIRtlMD
        +/DloR6/gR12gPfJz9X7q2A2xjXuAcE=
X-Google-Smtp-Source: ABdhPJy6DKDmQ0k3bL+Cx0Nc0TsMi6UBkopgVq3iE4m2ogLaFgeVJ+3Nh/p3TBaF9pcYTBKgFyA9kg==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr15653425wrv.372.1620094344109;
        Mon, 03 May 2021 19:12:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12sm14137241wrx.17.2021.05.03.19.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 19:12:23 -0700 (PDT)
Message-Id: <7dc273d458ea4e2b64706dcb9ce043abd0983b65.1620094339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
        <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 May 2021 02:12:09 +0000
Subject: [PATCH v2 03/13] fast-rebase: change assert() to BUG()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

assert() can succinctly document expectations for the code, and do so in
a way that may be useful to future folks trying to refactor the code and
change basic assumptions; it allows them to more quickly find some
places where their violations of previous assumptions trips things up.

Unfortunately, assert() can surround a function call with important
side-effects, which is a huge mistake since some users will compile with
assertions disabled.  I've had to debug such mistakes before in other
codebases, so I should know better.  Luckily, this was only in test
code, but it's still very embarrassing.  Change an assert() to an if
(...) BUG (...).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/helper/test-fast-rebase.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 373212256a66..39fb7f41e8c1 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -124,7 +124,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	assert(oideq(&onto->object.oid, &head));
 
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-	assert(repo_read_index(the_repository) >= 0);
+	if (repo_read_index(the_repository) < 0)
+		BUG("Could not read index");
 
 	repo_init_revisions(the_repository, &revs, NULL);
 	revs.verbose_header = 1;
-- 
gitgitgadget

