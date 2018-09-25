Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C488E1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIZB5S (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:18 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:44617 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:18 -0400
Received: by mail-ot1-f74.google.com with SMTP id v62-v6so27953637ota.11
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MazBY761I0QXmSzjxhMEG0YAD7M94SZQLpZC0Ra4T8A=;
        b=ipOz00xKCZKRQFlmMaZQAWFPWwARz1usFX7A0CLfCB5Vby4w06rpd8CtM59TSw3WXS
         CrL8wov56fSNydn9o7yQBEV6YowPTuWUkpZ+HTZsTKv6HUjbSpQc+u7fisYEWKSh9PAC
         bHyP9SysnXt3YCi5fEfq0iM0fV0Y7du01NenJ2jfcu8Fr19lTDT6nUtunyObhdR+Y/Xf
         Arx8GCSuzLFac+XNrPN8JeuRy25mmxr6OjaIgVhQaQVX7VOcui9T1Bl3NfPtVixUNG9R
         FYvKur6larOncVQTfp3ixnJgFZUONS1Q7iH/mIoEDsOYlF8VpL1b2kX+DMcTkm2jg++m
         eoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MazBY761I0QXmSzjxhMEG0YAD7M94SZQLpZC0Ra4T8A=;
        b=RZ0SBdPcQbHgDRMVyjo0V+3Sii1fgXerzSc8EJczz2ZOtfMHZ5uiXIILpkrc4FmzAR
         tis+U4+6nOnZWvjDT2xvFEo5gK+bZAu169gyBVJS6kFhiOAq9G0VLLl4Mi3p5o+DS3PP
         hS1V6b4NnFnRMXWe3M/1kLrqy/bmD3QAO9YH4/suMtMJ9rDuPbY35wJBvIPfIhyLac01
         wkyn+UBChJEjcjecgjXa0wTohnANmdsrZo8uJCQnFFpX8VRbXIf08H6uzLqoSpUrRTpT
         2Pa6ZWs2vspin7LSaJVite58CUaKhjlFcqJJ33HrGq/RFHjdspMY0HQG3KXHtIdRwjCv
         tPkQ==
X-Gm-Message-State: ABuFfojxT0z1E48Vx0rrKAjN5gsPV2o9u8Cq5zbq/faosPWEtPRlzDWx
        mcHbDYuxGUJ9TojIbmYaE+lGHGOnmR3ELPpKqr1MNVQ0LlFN7EFfRUQyhIhsbScYu5ohMmefrNe
        UAXgPnBEFhiw1V3Lg4mHaw6L397cBY6+gP5z464W6JEgdTJwgMRUW7vh92wOr
X-Google-Smtp-Source: ACcGV63yCHWy4IxpO6LO67y38jzIdhfgqA3m89j+c/IktZlW1pHgxopbBijBRLIbvpsnB7Lil409f8tEUCl5
X-Received: by 2002:aca:ce05:: with SMTP id e5-v6mr3054554oig.9.1537904889977;
 Tue, 25 Sep 2018 12:48:09 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:49 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 3/9] submodule.c: sort changed_submodule_names before
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
index 0de9e2800ad..22c64bd8559 100644
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
2.19.0.605.g01d371f741-goog

