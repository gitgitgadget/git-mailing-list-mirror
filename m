Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45041F597
	for <e@80x24.org>; Mon, 30 Jul 2018 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbeG3VYY (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:24:24 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:38750 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeG3VYY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:24:24 -0400
Received: by mail-oi0-f74.google.com with SMTP id t138-v6so11759682oih.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=nmAFQXHMYtUqfP1R2OPFt7oswcrkHaD98FaH/ox6QZQ=;
        b=qoxUBD2/pSfmtjs+7w7ZCrvtDaJ8MHDAFotK7rDgWE6xPC9OEI9utZlCmI8YnXvZG1
         P7uxmMMHAXn0j2gT0MXlNRyJ8NAtLzoBuX52HPMJk2VIL+SPtJqtv0heYBAghr8Nli4k
         l5CgUhScjl4vdjbiBxnmCyjTod9eg7nlO7I9MlICJ8w2dfdugVF8O5G4rYquv/zUs10X
         nPRnZ/SJA66Zsf8Up9kVbppKlKDJUqHUP7F0DipleFlPgT33XF937xkf0Ieetuau4O6I
         4Ddif6p63ycoWu4z6SI+XDZXTc9+DvY/AnWUu032G4gEeaBGETkzs2EZmHVpCY9m2LE3
         fs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=nmAFQXHMYtUqfP1R2OPFt7oswcrkHaD98FaH/ox6QZQ=;
        b=TkSx+WINKpZ1jLxD29/qENBLPIN08mwXHjXiE9FiOT94c0j3Qq1im306eNIgARgnbk
         NeB+sl7KDr2qVOHdcbcenJCEl2LEm8pTdYaasdXhlNfcdPZyAgfPjCsvWZyQ6sSFNVxs
         VFUP4j0UW/zN0sdSssvEihXac41ljVeB6waCLOtz46/B0xqr3hps4B0RJBoLlweDNhz1
         ZsTmwj3zq3AiB7fFWeeudIBeT9jQdEnAa8J5MhVZhSLj3hNUKE2gvyByYeFt66udYBJf
         iP0OopMjuxVX/z971ryEr96V3WRVcMG1SErAQGpVnySbR+bmnZsxw5li+M8tPI6NMbes
         U7sQ==
X-Gm-Message-State: AOUpUlE0qmNy6NLwdoqiyQHChD6sdIheI2KsdUmZo/FJA+MC23ek2v/Q
        5cwMsBU0TQICtceyNI2rE1BfA0aoKuP3
X-Google-Smtp-Source: AAOMgpeALCnLl4iGJHXA5KDMsRGZDC0Yik8wnhXngeSvnDuPtMGYOClloFAToYIe+Ern1bfC/+sY1ko3UJKz
MIME-Version: 1.0
X-Received: by 2002:aca:d416:: with SMTP id l22-v6mr11496757oig.22.1532980072014;
 Mon, 30 Jul 2018 12:47:52 -0700 (PDT)
Date:   Mon, 30 Jul 2018 12:47:31 -0700
In-Reply-To: <20180730194731.220191-1-sbeller@google.com>
Message-Id: <20180730194731.220191-3-sbeller@google.com>
References: <CACsJy8Cx7u5YtK6sPJ=HbAOUBXCrP7VOgMyoQ58SB6q_s4N7Gg@mail.gmail.com>
 <20180730194731.220191-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 2/2] refs: switch for_each_replace_ref back to use a ref_store
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, mhagger@alum.mit.edu,
        sbeller@google.com, stolee@gmail.com, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This effectively reverts commit 0d296c57ae (refs: allow for_each_replace_ref
to handle arbitrary repositories, 2018-04-11) and 60ce76d3581 (refs: add
repository argument to for_each_replace_ref, 2018-04-11).

The repository argument is not any special from the ref-store's point
of life.  If you need a repository (for e.g. lookup_commit or friends),
you'll have to pass it through the callback cookie, whether directly or
as part of a struct tailored to your purpose.

So let's go back to the clean API, just requiring a ref_store as an
argument.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/replace.c | 2 +-
 refs.c            | 4 ++--
 refs.h            | 2 +-
 replace-object.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index deabda21012..52dc371eafc 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -87,7 +87,7 @@ static int list_replace_refs(const char *pattern, const char *format)
 			     "valid formats are 'short', 'medium' and 'long'\n",
 			     format);
 
-	for_each_replace_ref(the_repository, show_reference, (void *)&data);
+	for_each_replace_ref(show_reference, (void *)&data);
 
 	return 0;
 }
diff --git a/refs.c b/refs.c
index 08fb5a99148..2d713499125 100644
--- a/refs.c
+++ b/refs.c
@@ -1441,9 +1441,9 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(r),
+	return do_for_each_ref(get_main_ref_store(the_repository),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
diff --git a/refs.h b/refs.h
index cc2fb4c68c0..48d5ffd2082 100644
--- a/refs.h
+++ b/refs.h
@@ -307,7 +307,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
diff --git a/replace-object.c b/replace-object.c
index e99fcd1ff6e..ee3374ab59b 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -41,7 +41,7 @@ static void prepare_replace_object(struct repository *r)
 		xmalloc(sizeof(*r->objects->replace_map));
 	oidmap_init(r->objects->replace_map, 0);
 
-	for_each_replace_ref(r, register_replace_ref, r);
+	for_each_replace_ref(register_replace_ref, r);
 }
 
 /* We allow "recursive" replacement. Only within reason, though */
-- 
2.18.0.132.g195c49a2227

