Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B57C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D70761158
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 11:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhDOLDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhDOLDL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 07:03:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB131C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:02:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y204so10845965wmg.2
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=b56D6O/8uIzpRjGZZs2kYE9LLqONcb5jftDEdfyGsa8=;
        b=c/XpKK74Vs7VvZs771mBAUhyuzGuGeushHjTOWNh1uyiEQJ6SWKJd2TccX/QoCCF5f
         6pW4x5BTD8X/3FaP/4wK3Y/7afqWO0Th5l92dov8W/7ycGWGeYsgPMPJYWLMoh/DNwbS
         3wR4/KUbvaQGFPr5MNzRWzNeKGGyjD78U4vB2m+mS5J8uHzbJor2nmI0TS5KCOGeCMLq
         9QOnhmxTB14RhO3KazuNGuRmuO8eG1ae+auLbLUVO6UXoHa9utyuAW5hAbHAKgi1QNWN
         2CqeqXY+p7duR9Oad1ShdZaDwl2Ib3LXLdWeoeIyC4NoqiFjnIpkUfBFqdy02u1g4iGw
         1ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b56D6O/8uIzpRjGZZs2kYE9LLqONcb5jftDEdfyGsa8=;
        b=b0JZkpBEFFgaogIn48CBEG7M57AN1LDSnbKSL4/WDFquZFN2W0Ze2roIDMCSbHDNBe
         3f/qL9R2yNrNAXayWRdkCmbA1ytwlTLQ6/5UQNbFotxrUBbF0jpp9VBpNmVzg1aU7xF7
         TdurwegSgCj5IRbsvvV9tZ01xTd543fpBTvIBcn3VJpDVns4PcoacXVQ1GuBW6a9jEhU
         vF2OPJTrDvMMo3FmoRIcWR6soUNLULlymNu8vYhltqg2PUjFxcSgmOASoHF1yTP4fMyQ
         2nSkYdQAKOwlrxFiruCLKHfeqSqwbnHh48144neJC+XDYBdxxF1T7x5b2OXx0Ie5iHx/
         6PfQ==
X-Gm-Message-State: AOAM5300AgMFYwcP9Zg+JvQAvkYP7slxk1eiXNb6Htrvm4g77c5U34fu
        Kvms+6cIWJbxtcrTJqSVvXHBtupVZC8=
X-Google-Smtp-Source: ABdhPJz50QNzb1/2Qcu9YbLtQqZCoNURxmpC6rKB2xkDbQw9hQ2tTVVfxyYPScZt00s6n5QLxKdEcg==
X-Received: by 2002:a1c:7fcd:: with SMTP id a196mr2588763wmd.180.1618484567731;
        Thu, 15 Apr 2021 04:02:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm2378665wrt.19.2021.04.15.04.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:02:47 -0700 (PDT)
Message-Id: <pull.1006.git.git.1618484566164.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Apr 2021 11:02:45 +0000
Subject: [PATCH] refs: ref_iterator_peel returns boolean, rather than
 peel_status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Before, the cached ref_iterator would return peel_object() output directly. This
led to spurious differences in the GIT_TRACE_REFS output, depending on the ref
storage backend active.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: ref_iterator_peel returns boolean, rather than peel_status
    
    Before, the cached ref_iterator would return peel_object() output
    directly. This led to spurious differences in the GIT_TRACE_REFS output,
    depending ref storage backend.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1006%2Fhanwen%2Fpeel_return-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1006/hanwen/peel_return-v1
Pull-Request: https://github.com/git/git/pull/1006

 refs.c               | 2 +-
 refs/ref-cache.c     | 2 +-
 refs/refs-internal.h | 3 +++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 261fd82beb98..8873854a44fb 100644
--- a/refs.c
+++ b/refs.c
@@ -2010,7 +2010,7 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	     oideq(current_ref_iter->oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
 
-	return peel_object(base, peeled);
+	return !!peel_object(base, peeled);
 }
 
 int refs_create_symref(struct ref_store *refs,
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 46f1e5428433..703a12959e1f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -491,7 +491,7 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
-	return peel_object(ref_iterator->oid, peeled);
+	return !!peel_object(ref_iterator->oid, peeled);
 }
 
 static int cache_ref_iterator_abort(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 467f4b3c936d..546a6b965dcc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -453,6 +453,9 @@ void base_ref_iterator_free(struct ref_iterator *iter);
  */
 typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 
+/*
+ * Peels the current ref, returning 0 for success.
+ */
 typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
 				 struct object_id *peeled);
 

base-commit: 54a391711554ed41b4b0792cfef004abc74893bd
-- 
gitgitgadget
