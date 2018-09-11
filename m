Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ACCC1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeILEvr (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:47 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43775 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeILEvr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:47 -0400
Received: by mail-ua1-f74.google.com with SMTP id g19-v6so44929uah.10
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aePnPx2YqOtLYlyVK5CDLEc/HmVD9vFEee9X8pOHmKg=;
        b=Ixc9w42ODD7xJvAPXWWh8II5kLBEq/e/Izh7XRrSv6DtvUxM9b4JrAetLD0GzWaV6n
         olExrq9UiDod1fxtor7jTrrpdXGVoDW2m99a+Ekhq8xMjeJAZJ3kZbbxiOduEmbPgtRQ
         QnWQGttZyczqPdxfQ+EKnXhmbOiufSRe4grQ2TGUKdvIElZ91yVsC+KCXwwG61JaaiRv
         HOVWKR+JvOAyFZobOYrDX62AtXQB/HyVjWH2o0vjjbh2hIKQNpIkrEIBuTa+7xmwYGxO
         jFH80BE2/uh2b2UQPgN5+u+HeZO+SKz9djaK3pcInXzY3PnVd3r4HrGfAz6NNu6CuMsp
         Bkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aePnPx2YqOtLYlyVK5CDLEc/HmVD9vFEee9X8pOHmKg=;
        b=dlKUVS22khuSfBoPa3bzFxVYwau1bUx3WjWztebeiN/3C5pGy4umVzvW4UWiXl5K8X
         pFTMEfjtR0x5MOEuZR8xIydqkgE/XCCWHDoDsPnLDJNGJme4YItIgMlp0OfShXV/3+Ka
         mLnigrOwDe5zcl5pi830wRh6VXuUV1aQRwPlq5Mw6vpY0mfP8L056cmQKg/AWXYWtOnl
         T7qfI5g4mCKB3DxRdSjS3DjYf56OWcRHYINYHAQtYI1TiYRBpTlDVhw+pPzz9JnUTTKv
         Ovrwn+4t6/5RNfw+FSSugNukFJ8VSzf9w/7DL4Ei5HxCxDzLMwMZd+nM5DLovBK/KEUU
         WojQ==
X-Gm-Message-State: APzg51CwqohISAjfOqy1e4qTCCm9GmmAJAXFwjjMIZ4aCLZ2bGQznfPb
        /2j5eRB42swF93u05zMUsIAbZTm4XcOY9otCrrEFltnJGglLkIZVWX1Rg0Fz1e/ydPVeZOwu2nZ
        r15tQprGgjVFdJ//cVqFzRTsWZmoQpWOr+4jwFZRFWUlVlgnMLpJ8SOjYwf+/
X-Google-Smtp-Source: ANB0VdaN31jOj4K020MQfineqCvZJfVjZKFHCIt8oOS+r1SfQ208u4ZZMfCc6EPYOIPNyyL2QjjTdGKrYKM3
X-Received: by 2002:a67:3b17:: with SMTP id i23-v6mr2981324vsa.10.1536709807967;
 Tue, 11 Sep 2018 16:50:07 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:46 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 4/9] submodule.c: sort changed_submodule_names before
 searching it
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can string_list_insert() to maintain sorted-ness of the
list as we find new items, or we can string_list_append() to
build an unsorted list and sort it at the end just once.

To pick which one is more appropriate, we notice the fact
that we discover new items more or less in the already
sorted order.  That makes "append then sort" more
appropriate.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index d29dfa3d1f5..c6eff7699f3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1256,7 +1256,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
-			    !unsorted_string_list_lookup(
+			    !string_list_lookup(
 					&changed_submodule_names,
 					submodule->name))
 				continue;
@@ -1350,6 +1350,7 @@ int fetch_populated_submodules(struct repository *r,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	calculate_changed_submodule_paths();
+	string_list_sort(&changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
-- 
2.19.0.397.gdd90340f6a-goog

